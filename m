Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06C7C49EA5
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 17:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEE5961C2F
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 17:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhFZRHs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 13:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhFZRHr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 13:07:47 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357F1C061766
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 10:05:25 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a13so14377839wrf.10
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x2RmhhlrifJJogdSHWJkjQBMbdntxcLjvbsGph67WvQ=;
        b=JKT6QZklQHmFgIGSjwbwEYglS9VQ5nAiJuygSHBQBVn5i10KptwaKEcathpH+HXNJ5
         NEfInQq41y25yQreB7/3tBGHEPhKxYGwfVk/vx2ryQrKx+EOL0QoQnt+WHTZDWoHiyVa
         bTsVh3eDWtMsdOKseaHzgm4nEJ4OjtVmMNwjfElAQ8edEGLfvPqOG6lPBlpcfbrTdSbh
         f/hhVsGW7b+l3fIInZfrLfKdcADe4Ga/T58f2yt9RUlalPXj2F78/rOMHUNbl1hvTQjA
         yS9LZkotuhq2UAK6awqzubuqBKkoHbXiACkzCmCAFYfIQ/1gAiHrjCGz0hhe5hsAjujf
         f4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x2RmhhlrifJJogdSHWJkjQBMbdntxcLjvbsGph67WvQ=;
        b=bs/r4OtN8/fNWppozJyJrerqJ/0OfwGTFXGz9qe2RnrqMGlQWacA7WrO97Hq52mA/1
         DauDZ0z9i/iP1P3ByF0GJgz4haowDO3fRMvXPiqWJoCUN6smLyGxaRZczC4LWKvIJ42X
         0VvP37ejuQ7ZTtXKhpAYpWrRcumrPige40xTI4sL6JVHDYH57BcTMHKXk43AEuUNVQPW
         NHyC9mFdFS+Zm5jrySv658+RaTPilm1D6XuImpN5s6Knu7IiSGoBmFzH+e5Vzv+V4irU
         YnoTLP6PW0a5vljYJsd+6MVN6udTVE9o/LFU68hKTchIPKP825xO5fxoXOXWkKhDBlck
         PD3A==
X-Gm-Message-State: AOAM531fSglUB7HQPaJCcTIN/N5MYjCdiqxZuSwyaFLAhm1+gkbgNqrC
        rNClOckZ1tgRVU/G33VwkqqP/Fu4ltI=
X-Google-Smtp-Source: ABdhPJzJmMXdaNgYYJsmz25RU4QdSAHgQY1YBGFx1w/meS6uuK69vQm7fqmTVAoz1gzDHwkRFSYuvQ==
X-Received: by 2002:a5d:65cc:: with SMTP id e12mr17726441wrw.354.1624727123783;
        Sat, 26 Jun 2021 10:05:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g15sm8984138wri.75.2021.06.26.10.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 10:05:23 -0700 (PDT)
Message-Id: <d3572e8bc85e4c7a33094f5da71957c2e59fd7f4.1624727121.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1039.git.git.1624727121.gitgitgadget@gmail.com>
References: <pull.1039.git.git.1624727121.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Jun 2021 17:05:19 +0000
Subject: [PATCH 1/3] t6423: test directory renames causing rename-to-self
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
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
 t/t6423-merge-rename-directories.sh | 117 ++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index be84d22419d..2a2ab907338 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5024,6 +5024,123 @@ test_expect_failure '12h: renaming a file within a renamed directory' '
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
 ###########################################################################
 # SECTION 13: Checking informational and conflict messages
 #
-- 
gitgitgadget

