Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD97C25B06
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 20:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbiHDUqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 16:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbiHDUqO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 16:46:14 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC6D6D578
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 13:46:12 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a11so490532wmq.3
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 13:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=KmzkJanP+r7zmAbvFVV+dBLWZoBVdjJr9uFqVzfdDDA=;
        b=GR61bBZxxcDXu4PVRd4S4KNTRKhNl8XxzQbyWL4GgD8Y98DKR3ZemVLmdpfQErqJZb
         YjgSCMZF+yG5OAQWH/ZwwItddAUzklA5mAcBjWvGmtfZvflMyKPA/CHwG9axAUrRG2MX
         jU4Kd7uakZb58NwSArOnat49ZViJJYVzAJYPw4hAdtgdgaAAt3t4HGZtaLVZCBpuww7F
         V751iy2o0Z5vFAM+P5DgR/uCW8T5pc9JoeOlXhOlOHV9NxpJBaplJA8LMQIEiBZ6qSI+
         7eQDKoRh2klfiQ97ymSy9EqGee7qhAlEyj6lLLwrROQ9rC2FBbMdq/nULgg2bruX5Kxb
         Lt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=KmzkJanP+r7zmAbvFVV+dBLWZoBVdjJr9uFqVzfdDDA=;
        b=fMMmAIGjqRTN+Ma3dR6R1KGhwjU5JnRvYYgi5RTU5qC45iGrF5gg9EGK5wEXqtdBr7
         gp13GE813gisPGBnutl57xCP1RkkbzQlal5ZBhKCQ5fXE7vWf+5POsZE/LuB8tfPb2Ga
         8AIXDUYMH8SENVBYE2ja+K8tQyUVa5naZCPaR+F0LDXyD4NYMYWLBtNGWJnlrnTA5cMw
         BsKVfanNBO9iHf6bQFAizH4fmTGwCJJMf1Awv2faS+UiqbOvOYHR66TlwWCbyQ4QKEAZ
         fo0bl6tTXxPeHmtSY7R1f6nlw7S6FHNPssWzvmcx6jAB2JH0og1gwszu7+oa9YNIX6FO
         biNg==
X-Gm-Message-State: ACgBeo0Mjaki9RTaiLWTxu+37h+MCLE281aMV+iKTh90tGGyQOzGN/pg
        0+YEP3NLDmyKGjPBukYjGnl8PHS//as=
X-Google-Smtp-Source: AA6agR5H/Hb3b1xWu+5vDmFcSVDkjhnSG0KojErXfmBRYq745AVvZ0PsyU6TILFmsP7cikYXbj6UWQ==
X-Received: by 2002:a05:600c:3b29:b0:3a3:1fa6:768 with SMTP id m41-20020a05600c3b2900b003a31fa60768mr2522421wms.193.1659645970332;
        Thu, 04 Aug 2022 13:46:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c384f00b003a320e6f011sm2352381wmr.1.2022.08.04.13.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 13:46:09 -0700 (PDT)
Message-Id: <255318f4dc61daef3e892a4dd5c571463985f340.1659645967.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1312.git.1659645967.gitgitgadget@gmail.com>
References: <pull.1312.git.1659645967.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Aug 2022 20:46:04 +0000
Subject: [PATCH 1/4] checkout: fix nested sparse directory diff in sparse
 index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, shaoxuan.yuan02@gmail.com,
        newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add the 'recursive' diff flag to the local changes reporting done by 'git
checkout' in 'show_local_changes()'. Without the flag enabled, unexpanded
sparse directories will not be recursed into to report the diff of each
file's contents, resulting in the reported local changes including
"modified" sparse directories.

The same issue was found and fixed for 'git status' in 2c521b0e49 (status:
fix nested sparse directory diff in sparse index, 2022-03-01)

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/checkout.c                       | 1 +
 t/t1092-sparse-checkout-compatibility.sh | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 29c74f898bf..f9d63d80b92 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -626,6 +626,7 @@ static void show_local_changes(struct object *head,
 	repo_init_revisions(the_repository, &rev, NULL);
 	rev.diffopt.flags = opts->flags;
 	rev.diffopt.output_format |= DIFF_FORMAT_NAME_STATUS;
+	rev.diffopt.flags.recursive = 1;
 	diff_setup_done(&rev.diffopt);
 	add_pending_object(&rev, head, NULL);
 	run_diff_index(&rev, 0);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 763c6cc6846..99a1425a929 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -372,6 +372,14 @@ test_expect_success 'deep changes during checkout' '
 	test_all_match git checkout base
 '
 
+test_expect_success 'checkout with modified sparse directory' '
+	init_repos &&
+
+	test_all_match git checkout rename-in-to-out -- . &&
+	test_sparse_match git sparse-checkout reapply &&
+	test_all_match git checkout base
+'
+
 test_expect_success 'add outside sparse cone' '
 	init_repos &&
 
-- 
gitgitgadget

