Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B573C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 17:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 237986147D
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 17:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhF3Rcg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 13:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbhF3Rcd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 13:32:33 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94623C061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 10:30:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u8so4600437wrq.8
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 10:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ziiVNYbu5Wtne6H/gEqGzugVUt2JJLkNpP7bgcYm64c=;
        b=FmTyJTLf0BRv6D4cgHQkwJDzYaLl3ZXdkMNiiui10Vmr+q92zGOVeZGVsVZR0bl5DX
         uP+BvKrwyn5jq7TGKjmDVTrnirbpcP32CpH5AOx2IS3NKEmfzuw+9GIHjEiYZiP64Bhw
         sZgO+J6MtIDQT15CZPiTDq/LGKtxl3koWrxIokjL0RSpexKJT/QSN2v+vCi4p77rtlqa
         lfpa5UJUX71i8qBzsfBWYhwQDJ6e8pOTUSfr/nNhiMWZlwPMxohRidmzKhXO+mt+X5aJ
         iftr2xhH1xWPklXkdrzHaW79p+yG4G42xjadf9SVItnodFifMlsmug4A3hLFjAz5qGgr
         IEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ziiVNYbu5Wtne6H/gEqGzugVUt2JJLkNpP7bgcYm64c=;
        b=kqgoIe1dPBxjURqZ03p4mi2axRtzMKmbKQ/z7vS63knSMjA52Pr7oHnU5AEl2V9RMo
         uoCFeb0B+LpuxWGh0OLw8u2XMhkMGJoARnxczbHydX3/mqpd7aOTanSeiSxQAyft095V
         PZ8fKNPRxEWnj6vqVt3l/uebtoweJBPTSB4MnlX91RYhFKkRBgoyJrWF7zHaP3Cnn0+D
         ++xgHf2ktsmmt8YprWCeYITw3hB1soIWNFukS8lOqokcpnd2xM8Y7+8B5QxdxnH4OaRZ
         7/YAQ+SwIxQv4HMf56xvM7Qoz7n+YuVa5EZ+6xIJAIODqtR/seLMgzEgkWikZa1Z0It6
         waiw==
X-Gm-Message-State: AOAM531lEbLj3icqOHTYM2yKOkwwZVypaXp5/JmLiqNvwFxVGAXfozJO
        Wt+DOksdOq6e6+2wVczBNixvU7ccB6k=
X-Google-Smtp-Source: ABdhPJx93k7k7YRghXl6RNWl2q5Lb52w5DRlw/XIMs7hwy7I3CNYHXq8GcXYvdOjL88K85y9CZBazQ==
X-Received: by 2002:a05:6000:1a41:: with SMTP id t1mr40026061wry.175.1625074203263;
        Wed, 30 Jun 2021 10:30:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t83sm5393808wmf.36.2021.06.30.10.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 10:30:02 -0700 (PDT)
Message-Id: <6e7ef18bf53a579e360e4970a6fbcc0a68a821f6.1625074200.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1039.v2.git.git.1625074200.gitgitgadget@gmail.com>
References: <pull.1039.git.git.1624727121.gitgitgadget@gmail.com>
        <pull.1039.v2.git.git.1625074200.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Jun 2021 17:29:59 +0000
Subject: [PATCH v2 2/3] merge-ort: ensure we consult df_conflict and
 path_conflicts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Path conflicts (typically rename path conflicts, e.g.
rename/rename(1to2) or rename/add/delete), and directory/file conflicts
should obviously result in files not being marked as clean in the merge.
We had a codepath where we missed consulting the path_conflict and
df_conflict flags, based on match_mask.  Granted, it requires an unusual
setup to trigger this codepath (directory rename causing rename-to-self
is the only case I can think of), but we still need to handle it.  To
make it clear that we have audited the other codepaths that do not
explicitly mention these flags, add some assertions that the flags are
not set.

Reported-by: Anders Kaseorg <andersk@mit.edu>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c                         | 6 +++++-
 t/t6423-merge-rename-directories.sh | 6 +++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index b954f7184a5..373dbac5079 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3237,7 +3237,7 @@ static void process_entry(struct merge_options *opt,
 	 *       above.
 	 */
 	if (ci->match_mask) {
-		ci->merged.clean = 1;
+		ci->merged.clean = !ci->df_conflict && !ci->path_conflict;
 		if (ci->match_mask == 6) {
 			/* stages[1] == stages[2] */
 			ci->merged.result.mode = ci->stages[1].mode;
@@ -3249,6 +3249,8 @@ static void process_entry(struct merge_options *opt,
 
 			ci->merged.result.mode = ci->stages[side].mode;
 			ci->merged.is_null = !ci->merged.result.mode;
+			if (ci->merged.is_null)
+				ci->merged.clean = 1;
 			oidcpy(&ci->merged.result.oid, &ci->stages[side].oid);
 
 			assert(othermask == 2 || othermask == 4);
@@ -3421,6 +3423,7 @@ static void process_entry(struct merge_options *opt,
 				   path)) {
 			ci->merged.is_null = 1;
 			ci->merged.clean = 1;
+			assert(!ci->df_conflict && !ci->path_conflict);
 		} else if (ci->path_conflict &&
 			   oideq(&ci->stages[0].oid, &ci->stages[side].oid)) {
 			/*
@@ -3447,6 +3450,7 @@ static void process_entry(struct merge_options *opt,
 		ci->merged.is_null = 1;
 		ci->merged.result.mode = 0;
 		oidcpy(&ci->merged.result.oid, null_oid());
+		assert(!ci->df_conflict);
 		ci->merged.clean = !ci->path_conflict;
 	}
 
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 89fe6778b94..c3968dc3642 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5058,7 +5058,7 @@ test_setup_12i () {
 	)
 }
 
-test_expect_merge_algorithm failure failure '12i: Directory rename causes rename-to-self' '
+test_expect_merge_algorithm failure success '12i: Directory rename causes rename-to-self' '
 	test_setup_12i &&
 	(
 		cd 12i &&
@@ -5116,7 +5116,7 @@ test_setup_12j () {
 	)
 }
 
-test_expect_merge_algorithm failure failure '12j: Directory rename to root causes rename-to-self' '
+test_expect_merge_algorithm failure success '12j: Directory rename to root causes rename-to-self' '
 	test_setup_12j &&
 	(
 		cd 12j &&
@@ -5174,7 +5174,7 @@ test_setup_12k () {
 	)
 }
 
-test_expect_merge_algorithm failure failure '12k: Directory rename with sibling causes rename-to-self' '
+test_expect_merge_algorithm failure success '12k: Directory rename with sibling causes rename-to-self' '
 	test_setup_12k &&
 	(
 		cd 12k &&
-- 
gitgitgadget

