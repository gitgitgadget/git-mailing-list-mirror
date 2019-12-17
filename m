Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7B9C2D0C8
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 08:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAAA20717
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 08:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loLYwhVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfLQIdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:33:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34960 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfLQIdL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 03:33:11 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so2066028wmb.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 00:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sqxNEw8ilVxiG62S4qwlyQfL+8v0yl/Qz0PXBvDTWVI=;
        b=loLYwhVSpP/1RF5cHqIZ2Ibj91XsT8snSzrWbaISEa8DqQGM+ww59orcYkHpSQyYVP
         ZHQnAdPT6YVu/+xCT6ZjrCegMtYB5GaeOcTjdLT9RYc8M/vdC7ET7vrWatVJ1AnURJbH
         839a6hc3DevqIe37+vNp+N2w2b+J1Hk299iHbhDRBZw3eHGtmecFP9N/F9Ou7NvA4DOF
         zMUJhhTxTUJYLPRnH78G+BMWwppaGJIHAUMFODk2wu2tFQ2rJtG79VBzqkgcba13VtfJ
         HQ24+a7vyDcVPZjhzINyH6K6wbh/7+ZCGwjGOa+vz9sL3ZWyWRq8L6yCAX6TRyiOzGfc
         NvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sqxNEw8ilVxiG62S4qwlyQfL+8v0yl/Qz0PXBvDTWVI=;
        b=Yiv1vnPJQzI5Q8/b4zX5292Ghtpv8vVy3E+q0HGnpdpCdCp/KWhyikQIQkzoetWiBx
         taQbzM4vOIHwO57b8evMVAcMBMurLWM5EEbpWenTibJgrc61M3m0P/wDqF0ovlT2tgcy
         FADMqmv5XEvRpsQfwRXtEq0MIUFM2eop+dfS9khdaudxwiD+HbCkba3CuUGXuOrY9yGo
         mNqYFt1yKn41VrDishSJOQfLyhYRIE4B1+rzRvc5rlbFzaqiUG+QXvfZIaeJbwy9N3eI
         of+2mGeDbi2ZM9LF99eo9ApDy7Q2MGLuYqDyudJ2sNfly4Bu/BCSyAwDlsS1OZGbtESo
         vOHQ==
X-Gm-Message-State: APjAAAXzUiQHT0gvhXgJTIDv8O0ejy7mwg/ctR+Ejy/EtATEinPFiydJ
        V2OpTp/6fyB3uA9K+42bFo+lKI1y
X-Google-Smtp-Source: APXvYqy9hwqHjLq98FZSHrxWnZ9fOGs4Jy5CHPio33IgkbimCLsglV72FbXIbnTKuw4Nq1Ajoyt2Aw==
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr4020426wma.24.1576571589040;
        Tue, 17 Dec 2019 00:33:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm24479604wrl.17.2019.12.17.00.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 00:33:08 -0800 (PST)
Message-Id: <61d303d8bdd3287996a1037982d0d27ded295ec0.1576571586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
References: <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
        <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Dec 2019 08:33:04 +0000
Subject: [PATCH v3 1/3] t3011: demonstrate directory traversal failures
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     blees@dcon.de, gitster@pobox.com, kyle@kyleam.com,
        sxlijin@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Add several tests demonstrating directory traversal failures of various
sorts in dir.c (and one similar looking test that turns out to be a
git_fnmatch bug).  A lot of these tests look like near duplicates of
each other, but an optimization path in dir.c to pre-descend into a
common prefix and the specialized treatment of trailing slashes in dir.c
mean the tiny differences are sometimes important and potentially cause
different codepaths to be explored.

Of the 7 failing tests, 2 are new to git-2.24.0 (tweaked by side effects
of the en/clean-nested-with-ignored-topic); the other 5 also failed
under git-2.23.0 and earlier.

The old failing tests can be traced down to the common prefix
optimization in dir.c handling paths differently than
read_directory_recursive() and treat_path() would, due to incomplete
duplication of logic into treat_leading_path() and having that
function call treat_one_path() rather than treat_path().  Fixing
that problem would require restructuring treat_path() and its full
call hierarchy to stop taking a dirent; see
   https://lore.kernel.org/git/xmqqzhfshsk2.fsf@gitster-ct.c.googlers.com/
and the thread surrounding it for details.

For now, simply document the breakages.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 ...common-prefixes-and-directory-traversal.sh | 209 ++++++++++++++++++
 1 file changed, 209 insertions(+)
 create mode 100755 t/t3011-common-prefixes-and-directory-traversal.sh

diff --git a/t/t3011-common-prefixes-and-directory-traversal.sh b/t/t3011-common-prefixes-and-directory-traversal.sh
new file mode 100755
index 0000000000..54f80c62b8
--- /dev/null
+++ b/t/t3011-common-prefixes-and-directory-traversal.sh
@@ -0,0 +1,209 @@
+#!/bin/sh
+
+test_description='directory traversal handling, especially with common prefixes'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit hello &&
+
+	>empty &&
+	mkdir untracked_dir &&
+	>untracked_dir/empty &&
+	git init untracked_repo &&
+	>untracked_repo/empty &&
+
+	cat <<-EOF >.gitignore &&
+	ignored
+	an_ignored_dir/
+	EOF
+	mkdir an_ignored_dir &&
+	mkdir an_untracked_dir &&
+	>an_ignored_dir/ignored &&
+	>an_ignored_dir/untracked &&
+	>an_untracked_dir/ignored &&
+	>an_untracked_dir/untracked
+'
+
+test_expect_success 'git ls-files -o shows the right entries' '
+	cat <<-EOF >expect &&
+	.gitignore
+	actual
+	an_ignored_dir/ignored
+	an_ignored_dir/untracked
+	an_untracked_dir/ignored
+	an_untracked_dir/untracked
+	empty
+	expect
+	untracked_dir/empty
+	untracked_repo/
+	EOF
+	git ls-files -o >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files -o --exclude-standard shows the right entries' '
+	cat <<-EOF >expect &&
+	.gitignore
+	actual
+	an_untracked_dir/untracked
+	empty
+	expect
+	untracked_dir/empty
+	untracked_repo/
+	EOF
+	git ls-files -o --exclude-standard >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files -o untracked_dir recurses' '
+	echo untracked_dir/empty >expect &&
+	git ls-files -o untracked_dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files -o untracked_dir/ recurses' '
+	echo untracked_dir/empty >expect &&
+	git ls-files -o untracked_dir/ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files -o --directory untracked_dir does not recurse' '
+	echo untracked_dir/ >expect &&
+	git ls-files -o --directory untracked_dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'git ls-files -o --directory untracked_dir/ does not recurse' '
+	echo untracked_dir/ >expect &&
+	git ls-files -o --directory untracked_dir/ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files -o untracked_repo does not recurse' '
+	echo untracked_repo/ >expect &&
+	git ls-files -o untracked_repo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'git ls-files -o untracked_repo/ does not recurse' '
+	echo untracked_repo/ >expect &&
+	git ls-files -o untracked_repo/ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'git ls-files -o untracked_dir untracked_repo recurses into untracked_dir only' '
+	cat <<-EOF >expect &&
+	untracked_dir/empty
+	untracked_repo/
+	EOF
+	git ls-files -o untracked_dir untracked_repo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files -o untracked_dir/ untracked_repo/ recurses into untracked_dir only' '
+	cat <<-EOF >expect &&
+	untracked_dir/empty
+	untracked_repo/
+	EOF
+	git ls-files -o untracked_dir/ untracked_repo/ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'git ls-files -o --directory untracked_dir untracked_repo does not recurse' '
+	cat <<-EOF >expect &&
+	untracked_dir/
+	untracked_repo/
+	EOF
+	git ls-files -o --directory untracked_dir untracked_repo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files -o --directory untracked_dir/ untracked_repo/ does not recurse' '
+	cat <<-EOF >expect &&
+	untracked_dir/
+	untracked_repo/
+	EOF
+	git ls-files -o --directory untracked_dir/ untracked_repo/ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files -o .git shows nothing' '
+	git ls-files -o .git >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_failure 'git ls-files -o .git/ shows nothing' '
+	git ls-files -o .git/ >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success FUNNYNAMES 'git ls-files -o untracked_* recurses appropriately' '
+	mkdir "untracked_*" &&
+	>"untracked_*/empty" &&
+
+	cat <<-EOF >expect &&
+	untracked_*/empty
+	untracked_dir/empty
+	untracked_repo/
+	EOF
+	git ls-files -o "untracked_*" >actual &&
+	test_cmp expect actual
+'
+
+# It turns out fill_directory returns the right paths, but ls-files' post-call
+# filtering in show_dir_entry() via calling dir_path_match() which ends up
+# in git_fnmatch() has logic for PATHSPEC_ONESTAR that assumes the pathspec
+# must match the full path; it doesn't check it for matching a leading
+# directory.
+test_expect_failure FUNNYNAMES 'git ls-files -o untracked_*/ recurses appropriately' '
+	cat <<-EOF >expect &&
+	untracked_*/empty
+	untracked_dir/empty
+	untracked_repo/
+	EOF
+	git ls-files -o "untracked_*/" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success FUNNYNAMES 'git ls-files -o --directory untracked_* does not recurse' '
+	cat <<-EOF >expect &&
+	untracked_*/
+	untracked_dir/
+	untracked_repo/
+	EOF
+	git ls-files -o --directory "untracked_*" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success FUNNYNAMES 'git ls-files -o --directory untracked_*/ does not recurse' '
+	cat <<-EOF >expect &&
+	untracked_*/
+	untracked_dir/
+	untracked_repo/
+	EOF
+	git ls-files -o --directory "untracked_*/" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files -o consistent between one or two dirs' '
+	git ls-files -o --exclude-standard an_ignored_dir/ an_untracked_dir/ >tmp &&
+	! grep ^an_ignored_dir/ tmp >expect &&
+	git ls-files -o --exclude-standard an_ignored_dir/ >actual &&
+	test_cmp expect actual
+'
+
+# ls-files doesn't have a way to request showing both untracked and ignored
+# files at the same time, so use `git status --ignored`
+test_expect_failure 'git status --ignored shows same files under dir with or without pathspec' '
+	cat <<-EOF >expect &&
+	?? an_untracked_dir/
+	!! an_untracked_dir/ignored
+	EOF
+	git status --porcelain --ignored >output &&
+	grep an_untracked_dir output >expect &&
+	git status --porcelain --ignored an_untracked_dir/ >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
gitgitgadget

