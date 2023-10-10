Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F40ECD80C0
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 12:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjJJMji (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjJJMj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 08:39:26 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0C3E9
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4066692ad35so52223945e9.1
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696941556; x=1697546356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQ/066jZaXiQEaVtypMMC+nnWxBzeA4apy59aTDg9VI=;
        b=G/Li4fTeLjSfiAnSRt14fhHajtCl6FXexjQpkkE1exCPClLbTz41KFH4AgmhEUbHAT
         KUYLKqFkfuvfnFJxbrSCTIRjqieDGHwzxFtGawvADd2hCT3njPwfxXCuFOy2hOTDBbTD
         o6V2YdsohV4ctLQDzcOuHYE6IXAmfAUwdQ3DCqXGajqD0pzOX/O44NpnwnuCoTg4BBht
         R3/+QJDXfCZBoUyTS5H5O1Oi1FVp4pDMWc+M+GWE0MAcISXm/89CbMbsiIPhbB1RJeMC
         ZikVlQy/DXRAb4IF+rdO5rjTpVfCYXLFFd0mtJ9a5wvRhnaRCgHsTrTusZG8bIiQDxn0
         DOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696941556; x=1697546356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQ/066jZaXiQEaVtypMMC+nnWxBzeA4apy59aTDg9VI=;
        b=Jhp2PCwD5+vOpHyTkrxSleFzhbPx0XT07iedAHNq8W1e23CTH9aurLGzw7Y7A8rt8E
         PRjs7WppHj9+yagyO1ycnz3GpRsBxnZjJLzGWgOohyPFoVW3dQKniGUIZx+bMCrAW/zL
         HWyJbMZOQlFFWiAvO//G0LEkmKLd78859kT45yf58YkoRhEQ6pozyp+GvfHoLKpoSX2Q
         UyoMDkPvlhUgqKpDeCT2dg0k08vP6EC9ZLLMpAmDN2KleHCzv6kuxQGRm4iZ6Pcf4W/w
         CMhP352sIP+Y/xsHP6u3a7WsucWV0BJ/czaJI6IaNl/otbUcDQ7IAP1kdb6RcaYWsjCn
         vqRw==
X-Gm-Message-State: AOJu0Ywy4iyA+Gdu1PEH1PlyxDsS4J3SuR+btiLVOV2Z/5q40XbXTlFL
        icRzSa5YFy7iGGi/E15fGxIEoNsDAq8jPg==
X-Google-Smtp-Source: AGHT+IFmhBovHGdzEhWvo/V56o0Xj4ahrWqfLAsAXQBvENF/69nHXnTFSRZv1Yesd/vxzlwp4CTVkw==
X-Received: by 2002:a05:600c:3502:b0:406:44e6:c00d with SMTP id h2-20020a05600c350200b0040644e6c00dmr16524133wmq.2.1696941556164;
        Tue, 10 Oct 2023 05:39:16 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:516d:299b:cbff:be05])
        by smtp.gmail.com with ESMTPSA id p15-20020a7bcc8f000000b003fee6e170f9sm14071689wma.45.2023.10.10.05.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:39:14 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Dragan Simic <dsimic@manjaro.org>,
        Linus Arver <linusa@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 09/14] replay: remove HEAD related sanity check
Date:   Tue, 10 Oct 2023 14:38:42 +0200
Message-ID: <20231010123847.2777056-10-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.339.g663cbc8ab1
In-Reply-To: <20231010123847.2777056-1-christian.couder@gmail.com>
References: <20230907092521.733746-1-christian.couder@gmail.com>
 <20231010123847.2777056-1-christian.couder@gmail.com>
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
index 08a7f68420..87fe655c6f 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -123,7 +123,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct commit *onto;
 	const char *onto_name = NULL;
 	struct commit *last_commit = NULL, *last_picked_commit = NULL;
-	struct object_id head;
 	struct lock_file lock = LOCK_INIT;
 	struct strvec rev_walk_args = STRVEC_INIT;
 	struct rev_info revs;
@@ -162,11 +161,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
@@ -238,7 +232,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			    oid_to_hex(&last_picked_commit->object.oid));
 		if (update_ref(reflog_msg.buf, "HEAD",
 			       &last_commit->object.oid,
-			       &head,
+			       &onto->object.oid,
 			       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
 			error(_("could not update %s"), argv[2]);
 			die("Failed to update %s", argv[2]);
-- 
2.42.0.339.g663cbc8ab1

