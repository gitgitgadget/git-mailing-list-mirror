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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3522FC11F69
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 17:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B3261474
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 17:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhF3Rce (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 13:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbhF3Rcd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 13:32:33 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFBDC0617A8
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 10:30:04 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i94so4634666wri.4
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 10:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SHGMIZnAoter2Y2BJLFA2yhFPLjw2VrycsoaR8FA+Fw=;
        b=Ngksl4gvaKFxvB3jQOmBipYuFF9Cz5yizVvMCzZMq8saG3Leh+/1+tUX9b9qTqW/fZ
         Zqmf7iDLC8goXu997FeANwo67/vkyltP618LeJz1W7Xqp+1h+MUT0/RQK3K8NqKiqSR3
         j55IC6AZ95wiaYQQ87cVOVX/rdqrprGTZtgijC3rM8zPsekirApwmbAdnasdJQH9EFyz
         G4Fz84LcAivfD17qkACxbAi/aO2NMsK8wfG7Vj7VozI0VSo+E246swU9kUF37HtKWqEm
         Q4sv3r562QAM0eZngWY4st1BgNeBdMGO9uoJWy0Yx1a8T6Q80u0EOVnZhQkQXG/9+nnG
         8aZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SHGMIZnAoter2Y2BJLFA2yhFPLjw2VrycsoaR8FA+Fw=;
        b=XOQ9evNGuev65smragHd2J1AO7v1k5XIsuJFs6Qgv8u2sxgd0whIxeP/hgSWVKCEHI
         Op91TCXfJVZ2G9ydapSQhfCH0pHJvTDLsBjv0hzf8bq7+dXz7XjGCCmGCjC0VXvcwuRS
         hfSaPXk1RK6q0yrBMsivUeh4wD/f8SF4U+nHQ332d6k9qkjiVklnGimafzv8Cep/LR14
         nWK96iXAHaiLv1xnq0mmHX8qnpN6e+goER3EHABpuepk9U21HhI37XejqfnDGsTTOfs6
         /OuHrQwi8fT5KBNCES5u+eIYV0HAlcG2XKErGGRojpKpiKWAV28OH0DpQYN5EklRO4Db
         ZmmA==
X-Gm-Message-State: AOAM5333ng1/nndEuL5H7hRzYhhW7ghHkw6SwF2HJVwUb5QtWzjvCCjs
        1TDzbz7XlJf47//HUNwBWYBZYGTL/mY=
X-Google-Smtp-Source: ABdhPJwmlIEcOIKbrcwPCImOJN2GsBRZ0AJqmH+BFj3M/HbVLetqQKL7gH2Dq5LEaIIxTJJ6a6j34A==
X-Received: by 2002:a05:6000:2c4:: with SMTP id o4mr39558014wry.79.1625074202662;
        Wed, 30 Jun 2021 10:30:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r4sm23367753wre.84.2021.06.30.10.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 10:30:02 -0700 (PDT)
Message-Id: <86b2eaea75e5e23626c41bf61bf882591331bbef.1625074200.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1039.v2.git.git.1625074200.gitgitgadget@gmail.com>
References: <pull.1039.git.git.1624727121.gitgitgadget@gmail.com>
        <pull.1039.v2.git.git.1625074200.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Jun 2021 17:29:58 +0000
Subject: [PATCH v2 1/3] t6423: test directory renames causing rename-to-self
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

Directory rename detection can cause transitive renames, e.g. if the two
different sides of history each do one half of:
    A/file -> B/file
    B/     -> C/
then directory rename detection transitively renames to give us C/file.
Since the default for merge.directoryRenames is conflict, this results
in an error message saying it is unclear whether the file should be
placed at B/file or C/file.

What if C/ is A/, though?  In such a case, the transitive rename would
give us A/file, the original name we started with.  Logically, having
an error message with B/file vs. A/file should be fine, as should
leaving the file where it started.  But the logic in both
merge-recursive and merge-ort did not handle a case of a filename being
renamed to itself correctly; merge-recursive had two bugs, and merge-ort
had one.  Add some testcases covering such a scenario.

Based-on-testcase-by: Anders Kaseorg <andersk@mit.edu>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 175 ++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index be84d22419d..89fe6778b94 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5024,6 +5024,181 @@ test_expect_failure '12h: renaming a file within a renamed directory' '
 	)
 '
 
+# Testcase 12i, Directory rename causes rename-to-self
+#   Commit O: source/{subdir/foo, bar, baz_1}
+#   Commit A: source/{foo, bar, baz_1}
+#   Commit B: source/{subdir/{foo, bar}, baz_2}
+#   Expected: source/{foo, bar, baz_2}, with conflicts on
+#                source/bar vs. source/subdir/bar
+
+test_setup_12i () {
+	test_create_repo 12i &&
+	(
+		cd 12i &&
+
+		mkdir -p source/subdir &&
+		echo foo >source/subdir/foo &&
+		echo bar >source/bar &&
+		echo baz >source/baz &&
+		git add source &&
+		git commit -m orig &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git switch A &&
+		git mv source/subdir/foo source/foo &&
+		git commit -m A &&
+
+		git switch B &&
+		git mv source/bar source/subdir/bar &&
+		echo more baz >>source/baz &&
+		git commit -m B
+	)
+}
+
+test_expect_merge_algorithm failure failure '12i: Directory rename causes rename-to-self' '
+	test_setup_12i &&
+	(
+		cd 12i &&
+
+		git checkout A^0 &&
+
+		test_must_fail git -c merge.directoryRenames=conflict merge -s recursive B^0 &&
+
+		test_path_is_missing source/subdir &&
+		test_path_is_file source/bar &&
+		test_path_is_file source/baz &&
+
+		git ls-files | uniq >tracked &&
+		test_line_count = 3 tracked &&
+
+		git status --porcelain -uno >actual &&
+		cat >expect <<-\EOF &&
+		UU source/bar
+		 M source/baz
+		EOF
+		test_cmp expect actual
+	)
+'
+
+# Testcase 12j, Directory rename to root causes rename-to-self
+#   Commit O: {subdir/foo, bar, baz_1}
+#   Commit A: {foo, bar, baz_1}
+#   Commit B: {subdir/{foo, bar}, baz_2}
+#   Expected: {foo, bar, baz_2}, with conflicts on bar vs. subdir/bar
+
+test_setup_12j () {
+	test_create_repo 12j &&
+	(
+		cd 12j &&
+
+		mkdir -p subdir &&
+		echo foo >subdir/foo &&
+		echo bar >bar &&
+		echo baz >baz &&
+		git add . &&
+		git commit -m orig &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git switch A &&
+		git mv subdir/foo foo &&
+		git commit -m A &&
+
+		git switch B &&
+		git mv bar subdir/bar &&
+		echo more baz >>baz &&
+		git commit -m B
+	)
+}
+
+test_expect_merge_algorithm failure failure '12j: Directory rename to root causes rename-to-self' '
+	test_setup_12j &&
+	(
+		cd 12j &&
+
+		git checkout A^0 &&
+
+		test_must_fail git -c merge.directoryRenames=conflict merge -s recursive B^0 &&
+
+		test_path_is_missing subdir &&
+		test_path_is_file bar &&
+		test_path_is_file baz &&
+
+		git ls-files | uniq >tracked &&
+		test_line_count = 3 tracked &&
+
+		git status --porcelain -uno >actual &&
+		cat >expect <<-\EOF &&
+		UU bar
+		 M baz
+		EOF
+		test_cmp expect actual
+	)
+'
+
+# Testcase 12k, Directory rename with sibling causes rename-to-self
+#   Commit O: dirB/foo, dirA/{bar, baz_1}
+#   Commit A: dirA/{foo, bar, baz_1}
+#   Commit B: dirB/{foo, bar}, dirA/baz_2
+#   Expected: dirA/{foo, bar, baz_2}, with conflicts on dirA/bar vs. dirB/bar
+
+test_setup_12k () {
+	test_create_repo 12k &&
+	(
+		cd 12k &&
+
+		mkdir dirA dirB &&
+		echo foo >dirB/foo &&
+		echo bar >dirA/bar &&
+		echo baz >dirA/baz &&
+		git add . &&
+		git commit -m orig &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git switch A &&
+		git mv dirB/* dirA/ &&
+		git commit -m A &&
+
+		git switch B &&
+		git mv dirA/bar dirB/bar &&
+		echo more baz >>dirA/baz &&
+		git commit -m B
+	)
+}
+
+test_expect_merge_algorithm failure failure '12k: Directory rename with sibling causes rename-to-self' '
+	test_setup_12k &&
+	(
+		cd 12k &&
+
+		git checkout A^0 &&
+
+		test_must_fail git -c merge.directoryRenames=conflict merge -s recursive B^0 &&
+
+		test_path_is_missing dirB &&
+		test_path_is_file dirA/bar &&
+		test_path_is_file dirA/baz &&
+
+		git ls-files | uniq >tracked &&
+		test_line_count = 3 tracked &&
+
+		git status --porcelain -uno >actual &&
+		cat >expect <<-\EOF &&
+		UU dirA/bar
+		 M dirA/baz
+		EOF
+		test_cmp expect actual
+	)
+'
+
 ###########################################################################
 # SECTION 13: Checking informational and conflict messages
 #
-- 
gitgitgadget

