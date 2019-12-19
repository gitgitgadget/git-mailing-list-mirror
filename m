Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66CEC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 21:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1F024679
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 21:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsvgPUoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfLSV2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:28:33 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33383 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfLSV2c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 16:28:32 -0500
Received: by mail-ed1-f68.google.com with SMTP id r21so6316359edq.0
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 13:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RjUWfqMLtbjNIPA16XEQPNcw4ayZ9uv9uVm9KQNo/JQ=;
        b=VsvgPUoODUZZ+2sHwbAIEWwiPIWjSgHNif5ONzQInZQtakDQ2JOx54WToVsPIUi8Ix
         UShDnkPs9ugR2yHFXJ1xUBzchSJICZAx1h30Je7X+VIJXG1zmXCLQIFET4yjMxFuFSXf
         WkSdpi4N5W7OTKA/BbwjUqfhxLMJcBGy1YiFf2Dj1Pd08f6VTE3+qpFKzhCjN6hP25mx
         K2bGyPdde6v2u0iqaoHou12gxsVoY8WItOayN4QjPvIArqIEgcHrOkBHIorokrltts10
         B+//iG1IsTWSBL7dHjP/GGCpD45rIjR9gRSNF0A8dxPZsYgQgHVnsm4z6Tf4k2x71IFc
         wKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RjUWfqMLtbjNIPA16XEQPNcw4ayZ9uv9uVm9KQNo/JQ=;
        b=UimJXsBDnLM5+pEtPKbSGbu5vn56pcFrHxrULMN/BDXWEVRngInF+ASAM1lsBQDzHV
         15zgENCCTIRSGSC4j8rGmg11+9tBe10A5tt3OHuiZLn5iLtDddKujn2pbelnPmGe5oVe
         5V9w0VL6qRnPi3HzhWpZ51Ws/aG4nRGPsnUjorheKZUthJzpNOiCdoy/W84VaLy/3hPu
         4mznI/NRGQsOG4VKMChP0KkxNikEj96ghvVSsenFpdZqvBo2kUOY07J31uaYP7OwG4HS
         FLMtSCcYtnqgBYZQe1dfokIZT9U2BK+MpxpQfECcyt0hIKx9BEenw2s//+FTSN/UVrFR
         5H5Q==
X-Gm-Message-State: APjAAAVoQXcxRSZo8KEzQS6Lyt6+jjDcwSEdAv2qkNxR9lS1gdM1LRTF
        XGArI1g04VG3Lrcb77Z+9fU6DCug
X-Google-Smtp-Source: APXvYqzUYJMVbb3CK3YXRxG5R0eVV8DxHWyVmT+DHoBp1FnKocSoA3u4Waf2A9UNb1WyXRZsZmVqyA==
X-Received: by 2002:a17:906:9615:: with SMTP id s21mr12112694ejx.20.1576790909294;
        Thu, 19 Dec 2019 13:28:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s19sm683911edr.55.2019.12.19.13.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 13:28:28 -0800 (PST)
Message-Id: <6d659b230239b530c90fbcc15c9a869f8d5dd5c5.1576790906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v5.git.git.1576790906.gitgitgadget@gmail.com>
References: <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
        <pull.676.v5.git.git.1576790906.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 21:28:19 +0000
Subject: [PATCH v5 1/8] t3011: demonstrate directory traversal failures
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

