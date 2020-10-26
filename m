Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4466C2D0A3
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C225222D9
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2VoeyjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782032AbgJZR6G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 13:58:06 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33356 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782200AbgJZR6E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 13:58:04 -0400
Received: by mail-pj1-f68.google.com with SMTP id k8so1955908pjd.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 10:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zoa9QQG0xIqYuMLY6i6hvhx4x7mcZ+rzeFn824RzSv8=;
        b=H2VoeyjAHlpPMvBW+mb+4c5nb7PaP4izR/BoEBQKUN8DuT5/ZwQsHSU2lz9NLIgv4w
         Nsq8DuLWQZ1wQhtzOBZfDzspF/1jo6shCUlQuegAkt/jfowcGiekckqZEG5z2nQ49GiQ
         zvQUCZSXoLght1+y7uNQlBHwlATtKh2jDYNqXdxFCpTNLwQVw5p8kpZDNEF49P/ldOsr
         kWjuZDsbecHdg1TAxpOMFS1U+i6lFO0cKGMAZDGkB6HvVxRH1QR6WFzS6xa+lZkZUpg3
         ZMkO5T02smagsIa1FKTAgnuBgCMXzHTYVUnNNQLD7a2VJm54MZJDK6nGRz0hKi8PQhR5
         t5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zoa9QQG0xIqYuMLY6i6hvhx4x7mcZ+rzeFn824RzSv8=;
        b=SnFDwNpJPNm+VKk9QGPw/TWEsuQlIH1syQw2iJkzKjWN+k4N2SvBObBUtoL/kpk12H
         K8a8NZS9klhL57ez6Hcr6U2gpNPf1DvoRIEJWrbRoiK9WbgrUDk8bIx2zz/cmdEUEll8
         b7zZBwRhrllOfb7wTlUhSAiEHQQNf925DBDYutkOTWhoET7+P3+dKN7RhL85JIWaFdW8
         mUHGda8vnSYEjAoUmDI+DhtDi1H/4NstTD5d/cCXQntcmbjZ6IVFUdbPiZcVw2BGXy5V
         syM8GmY8dpCAtCffKL6rou9csgxjLham2IsM6YctcMaYCN0PU8H69vBuF/M+yw6sTRUx
         fjzA==
X-Gm-Message-State: AOAM530Iq3CmX9YAxUzs8CLi3bPyoYDMWKtUB0fHSkRk853SjC+0WW8J
        V+1nRtxJHuYPSxAzKvvAa+XCzKDdBrzwaw==
X-Google-Smtp-Source: ABdhPJz4sSOp/2hDPXl1W77u6b/vN0XPfwHlfBQUdfSfv+qOxa81sFYzXAcRZ6ROaeNEK9OyBcsU1g==
X-Received: by 2002:a17:90a:f698:: with SMTP id cl24mr17307249pjb.59.1603735082026;
        Mon, 26 Oct 2020 10:58:02 -0700 (PDT)
Received: from localhost.localdomain ([42.108.201.34])
        by smtp.gmail.com with ESMTPSA id 16sm13772264pjf.36.2020.10.26.10.57.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 10:58:01 -0700 (PDT)
From:   Sangeeta Jain <sangunb09@gmail.com>
To:     git@vger.kernel.org
Cc:     Sangeeta Jain <sangunb09@gmail.com>, phillip.wood123@gmail.com,
        kaartic.sivaraam@gmail.com, gitster@pobox.com,
        sunshine@sunshineco.com
Subject: [Outreachy][PATCH v6] diff: do not show submodule with untracked files as "-dirty"
Date:   Mon, 26 Oct 2020 23:27:42 +0530
Message-Id: <20201026175742.33356-1-sangunb09@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git diff reports a submodule directory as -dirty even when there are
only untracked files in the submodule directory. This is inconsistent
with what `git describe --dirty` says when run in the submodule
directory in that state.

Make `--ignore-submodules=untracked` the default for `git diff` when
there is no configuration variable or command line option, so that the
command would not give '-dirty' suffix to a submodule whose working
tree has untracked files, to make it consistent with `git
describe --dirty` that is run in the submodule working tree.

Signed-off-by: Sangeeta Jain <sangunb09@gmail.com>
---
 diff.c                                       |   3 +
 diff.h                                       |   1 +
 submodule.c                                  |   3 +
 t/t3701-add-interactive.sh                   |   5 +
 t/t4027-diff-submodule.sh                    |  12 ++-
 t/t4041-diff-submodule-option.sh             |  16 +--
 t/t4060-diff-submodule-option-diff-format.sh |  16 +--
 t/t7064-wtstatus-pv2.sh                      |  52 ++++++++++
 t/t7506-status-submodule.sh                  | 102 ++++++++++++++++---
 9 files changed, 180 insertions(+), 30 deletions(-)

diff --git a/diff.c b/diff.c
index 2bb2f8f57e..5d69c2bb1c 100644
--- a/diff.c
+++ b/diff.c
@@ -4585,6 +4585,9 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
 		DIFF_XDL_SET(options, INDENT_HEURISTIC);
 
 	options->orderfile = diff_order_file_cfg;
+	
+	if (!options->flags.ignore_submodule_set)
+		handle_ignore_submodules_arg(options, "untracked");
 
 	if (diff_no_prefix) {
 		options->a_prefix = options->b_prefix = "";
diff --git a/diff.h b/diff.h
index 11de52e9e9..1e18e6b1c3 100644
--- a/diff.h
+++ b/diff.h
@@ -178,6 +178,7 @@ struct diff_flags {
 	unsigned diff_from_contents;
 	unsigned dirty_submodules;
 	unsigned ignore_untracked_in_submodules;
+	unsigned ignore_submodule_set;
 	unsigned ignore_dirty_submodules;
 	unsigned override_submodule_config;
 	unsigned dirstat_by_line;
diff --git a/submodule.c b/submodule.c
index b3bb59f066..afeb754079 100644
--- a/submodule.c
+++ b/submodule.c
@@ -420,6 +420,7 @@ const char *submodule_strategy_to_string(const struct submodule_update_strategy
 void handle_ignore_submodules_arg(struct diff_options *diffopt,
 				  const char *arg)
 {
+	diffopt->flags.ignore_submodule_set = 1;
 	diffopt->flags.ignore_submodules = 0;
 	diffopt->flags.ignore_untracked_in_submodules = 0;
 	diffopt->flags.ignore_dirty_submodules = 0;
@@ -1678,6 +1679,8 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	strvec_pushl(&cp.args, "status", "--porcelain=2", NULL);
 	if (ignore_untracked)
 		strvec_push(&cp.args, "-uno");
+	else
+		strvec_push(&cp.args, "--ignore-submodules=none");
 
 	prepare_submodule_repo_env(&cp.env_array);
 	cp.git_cmd = 1;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index ca04fac417..9104d1946d 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -765,6 +765,11 @@ test_expect_success 'setup different kinds of dirty submodules' '
 	cat >expected <<-\EOF &&
 	dirty-both-ways
 	dirty-head
+	EOF
+	git -C for-submodules diff-files --name-only --ignore-submodules=none >actual &&
+	cat >expected <<-\EOF &&
+	dirty-both-ways
+	dirty-head
 	dirty-otherwise
 	EOF
 	test_cmp expected actual &&
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index d7145ccca4..894a11b224 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -93,6 +93,14 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked)' '
 	) &&
 	git diff HEAD >actual &&
 	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subtip $subprev &&
+	test_cmp expect.body actual.body
+'
+
+test_expect_success 'git diff HEAD with dirty submodule (untracked) (none ignored)' '
+	test_config diff.ignoreSubmodules none &&
+	git diff HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
 	expect_from_to >expect.body $subtip $subprev-dirty &&
 	test_cmp expect.body actual.body
 '
@@ -168,13 +176,13 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)'
 		git clean -qfdx &&
 		>cruft
 	) &&
-	git diff HEAD >actual &&
+	git diff --ignore-submodules=none HEAD >actual &&
 	sed -e "1,/^@@/d" actual >actual.body &&
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual.body &&
 	git diff --ignore-submodules=all HEAD >actual2 &&
 	test_must_be_empty actual2 &&
-	git diff --ignore-submodules=untracked HEAD >actual3 &&
+	git diff HEAD >actual3 &&
 	test_must_be_empty actual3 &&
 	git diff --ignore-submodules=dirty HEAD >actual4 &&
 	test_must_be_empty actual4
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index f852136585..bb368b685d 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -262,7 +262,7 @@ test_expect_success 'submodule is up to date' '
 
 test_expect_success 'submodule contains untracked content' '
 	echo new > sm1/new-file &&
-	git diff-index -p --submodule=log HEAD >actual &&
+	git diff-index -p --submodule=log HEAD --ignore-submodules=none >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	EOF
@@ -270,7 +270,7 @@ test_expect_success 'submodule contains untracked content' '
 '
 
 test_expect_success 'submodule contains untracked content (untracked ignored)' '
-	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
+	git diff-index -p --submodule=log HEAD >actual &&
 	test_must_be_empty actual
 '
 
@@ -286,7 +286,7 @@ test_expect_success 'submodule contains untracked content (all ignored)' '
 
 test_expect_success 'submodule contains untracked and modified content' '
 	echo new > sm1/foo6 &&
-	git diff-index -p --submodule=log HEAD >actual &&
+	git diff-index -p --submodule=log HEAD --ignore-submodules=none >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	Submodule sm1 contains modified content
@@ -296,7 +296,7 @@ test_expect_success 'submodule contains untracked and modified content' '
 
 test_expect_success 'submodule contains untracked and modified content (untracked ignored)' '
 	echo new > sm1/foo6 &&
-	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
+	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains modified content
 	EOF
@@ -337,7 +337,7 @@ test_expect_success 'submodule is modified' '
 
 test_expect_success 'modified submodule contains untracked content' '
 	echo new > sm1/new-file &&
-	git diff-index -p --submodule=log HEAD >actual &&
+	git diff-index -p  --ignore-submodules=none --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	Submodule sm1 $head6..$head8:
@@ -347,7 +347,7 @@ test_expect_success 'modified submodule contains untracked content' '
 '
 
 test_expect_success 'modified submodule contains untracked content (untracked ignored)' '
-	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
+	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head6..$head8:
 	  > change
@@ -371,7 +371,7 @@ test_expect_success 'modified submodule contains untracked content (all ignored)
 
 test_expect_success 'modified submodule contains untracked and modified content' '
 	echo modification >> sm1/foo6 &&
-	git diff-index -p --submodule=log HEAD >actual &&
+	git diff-index -p --ignore-submodules=none --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	Submodule sm1 contains modified content
@@ -383,7 +383,7 @@ test_expect_success 'modified submodule contains untracked and modified content'
 
 test_expect_success 'modified submodule contains untracked and modified content (untracked ignored)' '
 	echo modification >> sm1/foo6 &&
-	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
+	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains modified content
 	Submodule sm1 $head6..$head8:
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index fc8229c726..dc7b242697 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -409,7 +409,7 @@ test_expect_success 'submodule is up to date' '
 
 test_expect_success 'submodule contains untracked content' '
 	echo new > sm1/new-file &&
-	git diff-index -p --submodule=diff HEAD >actual &&
+	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	EOF
@@ -417,7 +417,7 @@ test_expect_success 'submodule contains untracked content' '
 '
 
 test_expect_success 'submodule contains untracked content (untracked ignored)' '
-	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
+	git diff-index -p --submodule=diff HEAD >actual &&
 	test_must_be_empty actual
 '
 
@@ -433,7 +433,7 @@ test_expect_success 'submodule contains untracked content (all ignored)' '
 
 test_expect_success 'submodule contains untracked and modified content' '
 	echo new > sm1/foo6 &&
-	git diff-index -p --submodule=diff HEAD >actual &&
+	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	Submodule sm1 contains modified content
@@ -451,7 +451,7 @@ test_expect_success 'submodule contains untracked and modified content' '
 # NOT OK
 test_expect_success 'submodule contains untracked and modified content (untracked ignored)' '
 	echo new > sm1/foo6 &&
-	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
+	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains modified content
 	diff --git a/sm1/foo6 b/sm1/foo6
@@ -512,7 +512,7 @@ test_expect_success 'submodule is modified' '
 
 test_expect_success 'modified submodule contains untracked content' '
 	echo new > sm1/new-file &&
-	git diff-index -p --submodule=diff HEAD >actual &&
+	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	Submodule sm1 $head7..$head8:
@@ -528,7 +528,7 @@ test_expect_success 'modified submodule contains untracked content' '
 '
 
 test_expect_success 'modified submodule contains untracked content (untracked ignored)' '
-	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
+	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head7..$head8:
 	diff --git a/sm1/foo6 b/sm1/foo6
@@ -564,7 +564,7 @@ test_expect_success 'modified submodule contains untracked content (all ignored)
 
 test_expect_success 'modified submodule contains untracked and modified content' '
 	echo modification >> sm1/foo6 &&
-	git diff-index -p --submodule=diff HEAD >actual &&
+	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	Submodule sm1 contains modified content
@@ -583,7 +583,7 @@ test_expect_success 'modified submodule contains untracked and modified content'
 
 test_expect_success 'modified submodule contains untracked and modified content (untracked ignored)' '
 	echo modification >> sm1/foo6 &&
-	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
+	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains modified content
 	Submodule sm1 $head7..$head8:
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index 537787e598..78cd86be3a 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -503,6 +503,31 @@ test_expect_success 'untracked changes in added submodule (AM S..U)' '
 		1 AM S..U 000000 160000 160000 $ZERO_OID $HSUB sub1
 		EOF
 
+		git status --porcelain=v2 --branch --untracked-files=all --ignore-submodules=none >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'untracked changes in added submodule (A. S...) (untracked ignored)' '
+	(	cd super_repo &&
+		## create untracked file in the submodule.
+		(	cd sub1 &&
+			echo "xxxx" >file_in_sub
+		) &&
+
+		HMOD=$(git hash-object -t blob -- .gitmodules) &&
+		HSUP=$(git rev-parse HEAD) &&
+		HSUB=$HSUP &&
+
+		cat >expect <<-EOF &&
+		# branch.oid $HSUP
+		# branch.head master
+		# branch.upstream origin/master
+		# branch.ab +0 -0
+		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
+		1 A. S... 000000 160000 160000 $ZERO_OID $HSUB sub1
+		EOF
+
 		git status --porcelain=v2 --branch --untracked-files=all >actual &&
 		test_cmp expect actual
 	)
@@ -582,6 +607,33 @@ test_expect_success 'staged and untracked changes in added submodule (AM S.MU)'
 		1 AM S.MU 000000 160000 160000 $ZERO_OID $HSUB sub1
 		EOF
 
+		git status --porcelain=v2 --branch --untracked-files=all --ignore-submodules=none >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'staged and untracked changes in added submodule (AM S.M.) (untracked ignored)' '
+	(	cd super_repo &&
+		(	cd sub1 &&
+			## stage new changes in tracked file.
+			git add file_in_sub &&
+			## create new untracked file.
+			echo "yyyy" >>another_file_in_sub
+		) &&
+
+		HMOD=$(git hash-object -t blob -- .gitmodules) &&
+		HSUP=$(git rev-parse HEAD) &&
+		HSUB=$HSUP &&
+
+		cat >expect <<-EOF &&
+		# branch.oid $HSUP
+		# branch.head master
+		# branch.upstream origin/master
+		# branch.ab +0 -0
+		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
+		1 AM S.M. 000000 160000 160000 $ZERO_OID $HSUB sub1
+		EOF
+
 		git status --porcelain=v2 --branch --untracked-files=all >actual &&
 		test_cmp expect actual
 	)
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 3fcb44767f..72da00a962 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -94,36 +94,60 @@ test_expect_success 'status with added file in submodule (short)' '
 test_expect_success 'status with untracked file in submodule' '
 	(cd sub && git reset --hard) &&
 	echo "content" >sub/new-file &&
-	git status >output &&
+	git status --ignore-submodules=none >output &&
 	test_i18ngrep "modified:   sub (untracked content)" output
 '
 
+test_expect_success 'status with untracked file in submodule (untracked ignored)' '
+	(cd sub && git reset --hard) &&
+	echo "content" >sub/new-file &&
+	git status >output &&
+	test_i18ngrep "^nothing to commit" output
+'
+
 test_expect_success 'status -uno with untracked file in submodule' '
 	git status -uno >output &&
 	test_i18ngrep "^nothing to commit" output
 '
 
 test_expect_success 'status with untracked file in submodule (porcelain)' '
-	git status --porcelain >output &&
+	git status --porcelain --ignore-submodules=none >output &&
 	diff output - <<-\EOF
 	 M sub
 	EOF
 '
 
+test_expect_success 'status with untracked file in submodule (porcelain) (untracked ignored)' '
+	git status --porcelain >output &&
+	test_must_be_empty output
+'
+
 test_expect_success 'status with untracked file in submodule (short)' '
-	git status --short >output &&
+	git status --short --ignore-submodules=none >output &&
 	diff output - <<-\EOF
 	 ? sub
 	EOF
 '
 
+test_expect_success 'status with untracked file in submodule (short) (untracked ignored)' '
+	git status --short >output &&
+	test_must_be_empty output
+'
+
 test_expect_success 'status with added and untracked file in submodule' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	echo "content" >sub/new-file &&
-	git status >output &&
+	git status --ignore-submodules=none >output &&
 	test_i18ngrep "modified:   sub (modified content, untracked content)" output
 '
 
+test_expect_success 'status with added and untracked file in submodule (untracked ignored)' '
+	(cd sub && git reset --hard && echo >foo && git add foo) &&
+	echo "content" >sub/new-file &&
+	git status >output &&
+	test_i18ngrep "modified:   sub (modified content)" output
+'
+
 test_expect_success 'status with added and untracked file in submodule (porcelain)' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	echo "content" >sub/new-file &&
@@ -168,10 +192,17 @@ test_expect_success 'status with added file in modified submodule (porcelain)' '
 test_expect_success 'status with untracked file in modified submodule' '
 	(cd sub && git reset --hard) &&
 	echo "content" >sub/new-file &&
-	git status >output &&
+	git status --ignore-submodules=none >output &&
 	test_i18ngrep "modified:   sub (new commits, untracked content)" output
 '
 
+test_expect_success 'status with untracked file in modified submodule (untracked ignored)' '
+	(cd sub && git reset --hard) &&
+	echo "content" >sub/new-file &&
+	git status >output &&
+	test_i18ngrep "modified:   sub (new commits)" output
+'
+
 test_expect_success 'status with untracked file in modified submodule (porcelain)' '
 	git status --porcelain >output &&
 	diff output - <<-\EOF
@@ -182,10 +213,17 @@ test_expect_success 'status with untracked file in modified submodule (porcelain
 test_expect_success 'status with added and untracked file in modified submodule' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	echo "content" >sub/new-file &&
-	git status >output &&
+	git status --ignore-submodules=none >output &&
 	test_i18ngrep "modified:   sub (new commits, modified content, untracked content)" output
 '
 
+test_expect_success 'status with added and untracked file in modified submodule (untracked ignored)' '
+	(cd sub && git reset --hard && echo >foo && git add foo) &&
+	echo "content" >sub/new-file &&
+	git status >output &&
+	test_i18ngrep "modified:   sub (new commits, modified content)" output
+'
+
 test_expect_success 'status with added and untracked file in modified submodule (porcelain)' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	echo "content" >sub/new-file &&
@@ -349,7 +387,7 @@ test_expect_success 'setup superproject with untracked file in nested submodule'
 '
 
 test_expect_success 'status with untracked file in nested submodule (porcelain)' '
-	git -C super status --porcelain >output &&
+	git -C super status --porcelain --ignore-submodules=none >output &&
 	diff output - <<-\EOF
 	 M sub1
 	 M sub2
@@ -357,8 +395,13 @@ test_expect_success 'status with untracked file in nested submodule (porcelain)'
 	EOF
 '
 
+test_expect_success 'status with untracked file in nested submodule (porcelain) (untracked ignored)' '
+	git -C super status --porcelain >output &&
+	test_must_be_empty output
+'
+
 test_expect_success 'status with untracked file in nested submodule (porcelain=2)' '
-	git -C super status --porcelain=2 >output &&
+	git -C super status --porcelain=2 --ignore-submodules=none >output &&
 	sanitize_output output &&
 	diff output - <<-\EOF
 	1 .M S..U 160000 160000 160000 HASH HASH sub1
@@ -367,8 +410,13 @@ test_expect_success 'status with untracked file in nested submodule (porcelain=2
 	EOF
 '
 
+test_expect_success 'status with untracked file in nested submodule (porcelain=2) (untracked ignored)' '
+	git -C super status --porcelain=2 >output &&
+	test_must_be_empty output
+'
+
 test_expect_success 'status with untracked file in nested submodule (short)' '
-	git -C super status --short >output &&
+	git -C super status --short --ignore-submodules=none >output &&
 	diff output - <<-\EOF
 	 ? sub1
 	 ? sub2
@@ -376,13 +424,18 @@ test_expect_success 'status with untracked file in nested submodule (short)' '
 	EOF
 '
 
+test_expect_success 'status with untracked file in nested submodule (short) (untracked ignored)' '
+	git -C super status --short >output &&
+	test_must_be_empty output
+'
+
 test_expect_success 'setup superproject with modified file in nested submodule' '
 	git -C super/sub1/sub2 add file &&
 	git -C super/sub2 add file
 '
 
 test_expect_success 'status with added file in nested submodule (porcelain)' '
-	git -C super status --porcelain >output &&
+	git -C super status --porcelain --ignore-submodules=none >output &&
 	diff output - <<-\EOF
 	 M sub1
 	 M sub2
@@ -390,8 +443,16 @@ test_expect_success 'status with added file in nested submodule (porcelain)' '
 	EOF
 '
 
+test_expect_success 'status with added file in nested submodule (porcelain) (untracked ignored)' '
+	git -C super status --porcelain >output &&
+	diff output - <<-\EOF
+	 M sub1
+	 M sub2
+	EOF
+'
+
 test_expect_success 'status with added file in nested submodule (porcelain=2)' '
-	git -C super status --porcelain=2 >output &&
+	git -C super status --porcelain=2 --ignore-submodules=none >output &&
 	sanitize_output output &&
 	diff output - <<-\EOF
 	1 .M S.M. 160000 160000 160000 HASH HASH sub1
@@ -400,8 +461,17 @@ test_expect_success 'status with added file in nested submodule (porcelain=2)' '
 	EOF
 '
 
+test_expect_success 'status with added file in nested submodule (porcelain=2) (untracked ignored)' '
+	git -C super status --porcelain=2 >output &&
+	sanitize_output output &&
+	diff output - <<-\EOF
+	1 .M S.M. 160000 160000 160000 HASH HASH sub1
+	1 .M S.M. 160000 160000 160000 HASH HASH sub2
+	EOF
+'
+
 test_expect_success 'status with added file in nested submodule (short)' '
-	git -C super status --short >output &&
+	git -C super status --short --ignore-submodules=none >output &&
 	diff output - <<-\EOF
 	 m sub1
 	 m sub2
@@ -409,4 +479,12 @@ test_expect_success 'status with added file in nested submodule (short)' '
 	EOF
 '
 
+test_expect_success 'status with added file in nested submodule (short) (untracked ignored)' '
+	git -C super status --short >output &&
+	diff output - <<-\EOF
+	 m sub1
+	 m sub2
+	EOF
+'
+
 test_done
-- 
2.21.1 (Apple Git-122.3)

