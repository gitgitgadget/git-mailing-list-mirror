Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E03C77B7C
	for <git@archiver.kernel.org>; Tue,  9 May 2023 17:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbjEIRys (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 13:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbjEIRyj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 13:54:39 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A13A421C
        for <git@vger.kernel.org>; Tue,  9 May 2023 10:54:23 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3063b5f32aaso4045209f8f.2
        for <git@vger.kernel.org>; Tue, 09 May 2023 10:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683654861; x=1686246861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7sUL9Rbse8ARE6oigiLs8Aj1rGwtgFanknKU4QcTLs=;
        b=UEVWBn5OvDYZqDDwDc19ubOD8D/b5vVYy4yolGxpUQm9yTa99XkNSBI5/jb/GwkrPW
         KPDb9YeJy/qUlmaJDqplfX9gRMk3Cri2PrB9mKdMk3ncXUkmPuA7qogGRyy4wSLLejgR
         U5wJvST0mbHiITokdCJkH4Dh/lnhOuhaaglyOMXe5p4MaMOV1OnJbs4BqUErxQS8VBf3
         Y+S3P6DyQ0WxVbLnjYgvM/IeA9t8pQTddtmd26QNuqKdDNq8kzOItWg79C9s7bIehXAl
         wlmGiGMf4DsEvr05UZA7CPMJJqdAZRwY1ue1m9H/UkH5Q+P24kajgo/T60q0s8c31AQM
         wtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683654861; x=1686246861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7sUL9Rbse8ARE6oigiLs8Aj1rGwtgFanknKU4QcTLs=;
        b=HDrZlyGZCXbw2p+4uLAgppYelYPaBl2RxyPxnSwXLZmUllVlwbxRysuAqecN849NQa
         Cden//T8lABM/fKAbRkRkHDlPKulH4JOX1vgDEJzrgPRmv7LJh0ERf+6X1pBnbtaGwtN
         NRbldj7O2f+gsnrHbePrDH6Lsj7aT7rFurl3OGCrihkLa8Q9ar31EH1YlfZcTEaLE7Ng
         ppB9yjNn+ddcFiKvzjl/b36zLjASSAOj8un4w68WW544oacv7eEUZH2AKCKFC2pJI5IB
         Lg1fa1+2Y6cAm6+XPfI66Wf6S5EkazalqOnSAS+/xPwB1Ga6t7givfN0eyI7dvQnhHe+
         qgIg==
X-Gm-Message-State: AC+VfDzL2ukpaRizm9uI/+DP/crPMBKKCVlxdDYQHTolJg8VHwRF1Q2p
        nbHBhfVb0gAIQqjeNIpnsuVpvYbNyaY=
X-Google-Smtp-Source: ACHHUZ6xGELCcx2oYyMWAisfJ0oSbfgDdvAwUSMBvTVWGgTEtckSg+PtOtghdnzfll4tCrXIqctshA==
X-Received: by 2002:adf:e2c3:0:b0:307:9b66:f512 with SMTP id d3-20020adfe2c3000000b003079b66f512mr4039291wrj.19.1683654860957;
        Tue, 09 May 2023 10:54:20 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:df87:46e2:83de:c1fa])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003f42314832fsm8584435wml.18.2023.05.09.10.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 10:54:20 -0700 (PDT)
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
Subject: [PATCH v2 09/15] replay: remove HEAD related sanity check
Date:   Tue,  9 May 2023 19:53:41 +0200
Message-ID: <20230509175347.1714141-10-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.1.491.gbdd8a3b3e1
In-Reply-To: <20230509175347.1714141-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230509175347.1714141-1-christian.couder@gmail.com>
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
index ccbef6552a..6437633724 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -121,7 +121,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct commit *onto;
 	const char *onto_name = NULL;
 	struct commit *last_commit = NULL, *last_picked_commit = NULL;
-	struct object_id head;
 	struct lock_file lock = LOCK_INIT;
 	struct strvec rev_walk_args = STRVEC_INIT;
 	struct rev_info revs;
@@ -160,11 +159,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
@@ -236,7 +230,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			    oid_to_hex(&last_picked_commit->object.oid));
 		if (update_ref(reflog_msg.buf, "HEAD",
 			       &last_commit->object.oid,
-			       &head,
+			       &onto->object.oid,
 			       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
 			error(_("could not update %s"), argv[2]);
 			die("Failed to update %s", argv[2]);
-- 
2.40.1.491.gdff9a222ea

