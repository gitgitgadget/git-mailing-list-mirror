Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DF7C7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 10:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbjFBK3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 06:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbjFBK2L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 06:28:11 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD6410D2
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 03:26:32 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so2482002e87.2
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 03:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685701565; x=1688293565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoyNNzaApwgD4JT070uWEaEAB0u+J2m/o9l9+cvhSns=;
        b=iPfOk5d9XeiDdTMZVesx3iy90TMpKY4sT1D5TuGxwGRqRxwrCubvOd7/cWIg1NhlTT
         4CODQUIn9MIUjOGCVsRIX32OkhKxQsiamoxTINCf9JmKOkiAtY8PPQtv7wmcqvDqOoNP
         Vp9d8D6BbRxChF/Zml3O/QYC4EfCSJi895Zmy1GNDIqOvAmsc+UbKsiefPblslvA89d6
         CmpVHx4SbHKYKSpraUVoYJ7O/EmWygK7Ox5NU9M1fHh+9FYlKCrHKOl5HfXYr1evfE9k
         VuA+SC4t3HfSc/fDL8hENIBnWi6uh95k6rA1jKAwYOE0nRTovNfBCNmbEqWGSaLhUQoz
         ruiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701565; x=1688293565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoyNNzaApwgD4JT070uWEaEAB0u+J2m/o9l9+cvhSns=;
        b=Ez7pmvH8tFm/zYJDEdc/lkSnIqWco2V0LZ+ISqOuJUqUvWu/CA3MXc0jzwKEwZajFc
         m+cV4V+b6RhubeuvFaO9l/i0WV1TttEOO3GL7sO1dJOvJqKkqqqfu4BqhfFeKSGXDMvG
         3ULzS0XEThjvndpYMJP+kqss9KK7a3RFFpEFIrDPOcm5zSi2UzsJmG7lemewsxSzwqSG
         r1S3VRC3Q/TiiqVJGOBoNx/Yg9IPx2HGE3sRxwI7SC8Pzfq0pZiX3QmX7ZnFwRhopO1c
         KcEgliR8A+SuPaILLao+0RToeyeXcHtBHskCEHedj+0srrTSKdemXIE57efsPfk/EEms
         sV2g==
X-Gm-Message-State: AC+VfDzzJrkuilRcy8RjkrkCDCu2rHWgg6+mCSIAlUmDDZXZo4HqSNnF
        +BAgCvhTDovjSo0lTZeRgaSOTvbNnttFyQ==
X-Google-Smtp-Source: ACHHUZ5LNtLlDQlY1JIZdyg3h1VXm/obGcbD1GLihKfeYWeHIeW/WScJiRhRIlgUk7J8jyyG8yWlEg==
X-Received: by 2002:ac2:4e71:0:b0:4f0:181:5a14 with SMTP id y17-20020ac24e71000000b004f001815a14mr1657697lfs.21.1685701564758;
        Fri, 02 Jun 2023 03:26:04 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:1169:70dc:520b:5de9:c23d:7cde])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c029200b003f601a31ca2sm1468035wmk.33.2023.06.02.03.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:26:04 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 09/15] replay: remove HEAD related sanity check
Date:   Fri,  2 Jun 2023 12:25:27 +0200
Message-ID: <20230602102533.876905-10-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.15.ga6d88fc8f0
In-Reply-To: <20230602102533.876905-1-christian.couder@gmail.com>
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We want replay to be a command that can be used on the server side on
any branch, not just the current one, so we are going to stop updating
HEAD in a future commit.

A "sanity check" that makes sure we are replaying the current branch
doesn't make sense anymore. Let's remove it.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 2ad0835c06..3b86fe140f 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -122,7 +122,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct commit *onto;
 	const char *onto_name = NULL;
 	struct commit *last_commit = NULL, *last_picked_commit = NULL;
-	struct object_id head;
 	struct lock_file lock = LOCK_INIT;
 	struct strvec rev_walk_args = STRVEC_INIT;
 	struct rev_info revs;
@@ -161,11 +160,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	onto = peel_committish(onto_name);
 	strbuf_addf(&branch_name, "refs/heads/%s", argv[2]);
 
-	/* Sanity check */
-	if (repo_get_oid(the_repository, "HEAD", &head))
-		die(_("Cannot read HEAD"));
-	assert(oideq(&onto->object.oid, &head));
-
 	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
 	if (repo_read_index(the_repository) < 0)
 		BUG("Could not read index");
@@ -237,7 +231,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			    oid_to_hex(&last_picked_commit->object.oid));
 		if (update_ref(reflog_msg.buf, "HEAD",
 			       &last_commit->object.oid,
-			       &head,
+			       &onto->object.oid,
 			       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
 			error(_("could not update %s"), argv[2]);
 			die("Failed to update %s", argv[2]);
-- 
2.41.0.15.ga6d88fc8f0

