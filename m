Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B5D71F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932120AbeFZHbI (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:31:08 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39661 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932083AbeFZHbE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:31:04 -0400
Received: by mail-it0-f68.google.com with SMTP id p185-v6so859032itp.4
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4MpSMQp1xl7XUsevFvcN+1ECkT2dQb8PYTBehW862OI=;
        b=foJVSjgr8+qHVQWBOy/dlTXIRzb9R3kBWv+uS64q7PYACil2Gtg74yI93HH6X0vjnA
         /xrRALjsJzjQkD8UKefsx+gev9a7InadfmstwLqaLrafh0X54HN9s3+OHgSUZQNMNj+b
         WmJml543ShkgiVkN81rEIhsKTExcFnDliQsd78mAer52scfiMON0iFdCGlZATF7hJ5Hs
         C3mi1YqfX9dFsoitTQRzuuzHD+OYKTFNt7rX/Tnm2MTFGylQz4ChS2y7OdI5AHFfspIE
         10Mc7yHO1JbqLiwjaVoqSSvjY5XfEwG3O+QjjZIkKpfxIxMWIf5BV5/t1YD6gd+ttXCy
         O+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=4MpSMQp1xl7XUsevFvcN+1ECkT2dQb8PYTBehW862OI=;
        b=seKI2vHf7TW3EgzDvKki6i3G4qkBz939cLyRPHApeRzMUrsBohk3vc/SUHO6Uh+VM9
         w0kkwOji24eI26tiqsMlJFxJ3CstDwi82aihrNqSoV5I34BWgEjMJAXCTBd5u0D5T/a1
         h7sZCqmBBfbO5DPd1IcA6JaKk/6pE6tA8aKmJRC+lFencix7gAMrGtZrMu7HbJUESwEy
         hOJsoyUjlweaYsKJwV7dfyh3jUkXdkR7v+IxSyu5HkY5FDoj0xqKNjj7yyREOP23DunB
         iL6DGVB7DKoHSR146vRRjfHilEWViEuupuFbx50JHUTjROsZ0O2WmNLgb1UI/cOjoqnp
         Mxfw==
X-Gm-Message-State: APt69E1WjeaIrSows3Bfy8NVOKQWBBfyfJltwAtz8v9sIgEmylpOoLYn
        AZVhyaU7HisCsb4+eRf6ZHQgOA==
X-Google-Smtp-Source: ADUXVKKSKBT1KowddEG5MzfibO3liUVFdQVm10C3+jdu+W0wiN2I/R6z7u2j9wbBifs8AmKZ9RBCEg==
X-Received: by 2002:a24:1405:: with SMTP id 5-v6mr505469itg.58.1529998263723;
        Tue, 26 Jun 2018 00:31:03 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.31.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:31:03 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 14/29] t: drop subshell with missing &&-chain in favor of simpler construct
Date:   Tue, 26 Jun 2018 03:29:46 -0400
Message-Id: <20180626073001.6555-15-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests employ a noisy subshell (with missing &&-chain) to feed
input into Git commands:

    (echo a; echo b; echo c) | git some-command ...

Drop the subshell in favor of a simple 'printf':

    printf "%s\n" a b c | git some-command ...

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t0090-cache-tree.sh         |  2 +-
 t/t2016-checkout-patch.sh     | 24 ++++++++++----------
 t/t3404-rebase-interactive.sh |  6 ++---
 t/t3701-add-interactive.sh    | 16 +++++++-------
 t/t3904-stash-patch.sh        |  8 +++----
 t/t7105-reset-patch.sh        | 12 +++++-----
 t/t7301-clean-interactive.sh  | 41 +++++++++++++++++------------------
 t/t7501-commit.sh             |  4 ++--
 t/t7610-mergetool.sh          |  8 +++----
 9 files changed, 60 insertions(+), 61 deletions(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 0c61268fd2..f86cc76c9d 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -156,7 +156,7 @@ test_expect_success PERL 'commit --interactive gives cache-tree on partial commi
 		return 44;
 	}
 	EOT
-	(echo p; echo 1; echo; echo s; echo n; echo y; echo q) |
+	printf "%s\n" p 1 "" s n y q |
 	git commit --interactive -m foo &&
 	test_cache_tree
 '
diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index 9cd0ac4ba3..4dcad0f4a2 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -20,33 +20,33 @@ test_expect_success PERL 'setup' '
 
 test_expect_success PERL 'saying "n" does nothing' '
 	set_and_save_state dir/foo work head &&
-	(echo n; echo n) | git checkout -p &&
+	printf "%s\n" n n | git checkout -p &&
 	verify_saved_state bar &&
 	verify_saved_state dir/foo
 '
 
 test_expect_success PERL 'git checkout -p' '
-	(echo n; echo y) | git checkout -p &&
+	printf "%s\n" n y | git checkout -p &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
 
 test_expect_success PERL 'git checkout -p with staged changes' '
 	set_state dir/foo work index &&
-	(echo n; echo y) | git checkout -p &&
+	printf "%s\n" n y | git checkout -p &&
 	verify_saved_state bar &&
 	verify_state dir/foo index index
 '
 
 test_expect_success PERL 'git checkout -p HEAD with NO staged changes: abort' '
 	set_and_save_state dir/foo work head &&
-	(echo n; echo y; echo n) | git checkout -p HEAD &&
+	printf "%s\n" n y n | git checkout -p HEAD &&
 	verify_saved_state bar &&
 	verify_saved_state dir/foo
 '
 
 test_expect_success PERL 'git checkout -p HEAD with NO staged changes: apply' '
-	(echo n; echo y; echo y) | git checkout -p HEAD &&
+	printf "%s\n" n y y | git checkout -p HEAD &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
@@ -54,14 +54,14 @@ test_expect_success PERL 'git checkout -p HEAD with NO staged changes: apply' '
 test_expect_success PERL 'git checkout -p HEAD with change already staged' '
 	set_state dir/foo index index &&
 	# the third n is to get out in case it mistakenly does not apply
-	(echo n; echo y; echo n) | git checkout -p HEAD &&
+	printf "%s\n" n y n | git checkout -p HEAD &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
 
 test_expect_success PERL 'git checkout -p HEAD^' '
 	# the third n is to get out in case it mistakenly does not apply
-	(echo n; echo y; echo n) | git checkout -p HEAD^ &&
+	printf "%s\n" n y n | git checkout -p HEAD^ &&
 	verify_saved_state bar &&
 	verify_state dir/foo parent parent
 '
@@ -69,7 +69,7 @@ test_expect_success PERL 'git checkout -p HEAD^' '
 test_expect_success PERL 'git checkout -p handles deletion' '
 	set_state dir/foo work index &&
 	rm dir/foo &&
-	(echo n; echo y) | git checkout -p &&
+	printf "%s\n" n y | git checkout -p &&
 	verify_saved_state bar &&
 	verify_state dir/foo index index
 '
@@ -81,21 +81,21 @@ test_expect_success PERL 'git checkout -p handles deletion' '
 
 test_expect_success PERL 'path limiting works: dir' '
 	set_state dir/foo work head &&
-	(echo y; echo n) | git checkout -p dir &&
+	printf "%s\n" y n | git checkout -p dir &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
 
 test_expect_success PERL 'path limiting works: -- dir' '
 	set_state dir/foo work head &&
-	(echo y; echo n) | git checkout -p -- dir &&
+	printf "%s\n" y n | git checkout -p -- dir &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
 
 test_expect_success PERL 'path limiting works: HEAD^ -- dir' '
 	# the third n is to get out in case it mistakenly does not apply
-	(echo y; echo n; echo n) | git checkout -p HEAD^ -- dir &&
+	printf "%s\n" y n n | git checkout -p HEAD^ -- dir &&
 	verify_saved_state bar &&
 	verify_state dir/foo parent parent
 '
@@ -103,7 +103,7 @@ test_expect_success PERL 'path limiting works: HEAD^ -- dir' '
 test_expect_success PERL 'path limiting works: foo inside dir' '
 	set_state dir/foo work head &&
 	# the third n is to get out in case it mistakenly does not apply
-	(echo y; echo n; echo n) | (cd dir && git checkout -p foo) &&
+	printf "%s\n" y n n | (cd dir && git checkout -p foo) &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 352a52e59d..0dea186289 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -509,7 +509,7 @@ test_expect_success 'interrupted squash works as expected' '
 	one=$(git rev-parse HEAD~3) &&
 	set_fake_editor &&
 	test_must_fail env FAKE_LINES="1 squash 3 2" git rebase -i HEAD~3 &&
-	(echo one; echo two; echo four) > conflict &&
+	printf "%s\n" one two four > conflict &&
 	git add conflict &&
 	test_must_fail git rebase --continue &&
 	echo resolved > conflict &&
@@ -523,10 +523,10 @@ test_expect_success 'interrupted squash works as expected (case 2)' '
 	one=$(git rev-parse HEAD~3) &&
 	set_fake_editor &&
 	test_must_fail env FAKE_LINES="3 squash 1 2" git rebase -i HEAD~3 &&
-	(echo one; echo four) > conflict &&
+	printf "%s\n" one four > conflict &&
 	git add conflict &&
 	test_must_fail git rebase --continue &&
-	(echo one; echo two; echo four) > conflict &&
+	printf "%s\n" one two four > conflict &&
 	git add conflict &&
 	test_must_fail git rebase --continue &&
 	echo resolved > conflict &&
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index b170fb02b8..7eec7bb3bb 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -46,13 +46,13 @@ test_expect_success 'setup expected' '
 '
 
 test_expect_success 'diff works (initial)' '
-	(echo d; echo 1) | git add -i >output &&
+	printf "%s\n" d 1 | git add -i >output &&
 	sed -ne "/new file/,/content/p" <output >diff &&
 	diff_cmp expected diff
 '
 test_expect_success 'revert works (initial)' '
 	git add file &&
-	(echo r; echo 1) | git add -i &&
+	printf "%s\n" r 1 | git add -i &&
 	git ls-files >output &&
 	! grep . output
 '
@@ -83,13 +83,13 @@ test_expect_success 'setup expected' '
 '
 
 test_expect_success 'diff works (commit)' '
-	(echo d; echo 1) | git add -i >output &&
+	printf "%s\n" d 1 | git add -i >output &&
 	sed -ne "/^index/,/content/p" <output >diff &&
 	diff_cmp expected diff
 '
 test_expect_success 'revert works (commit)' '
 	git add file &&
-	(echo r; echo 1) | git add -i &&
+	printf "%s\n" r 1 | git add -i &&
 	git add -i </dev/null >output &&
 	grep "unchanged *+3/-0 file" output
 '
@@ -102,7 +102,7 @@ test_expect_success 'setup expected' '
 
 test_expect_success 'dummy edit works' '
 	test_set_editor : &&
-	(echo e; echo a) | git add -p &&
+	printf "%s\n" e a | git add -p &&
 	git diff > diff &&
 	diff_cmp expected diff
 '
@@ -127,7 +127,7 @@ test_expect_success 'setup fake editor' '
 
 test_expect_success 'bad edit rejected' '
 	git reset &&
-	(echo e; echo n; echo d) | git add -p >output &&
+	printf "%s\n" e n d | git add -p >output &&
 	grep "hunk does not apply" output
 '
 
@@ -140,7 +140,7 @@ test_expect_success 'setup patch' '
 
 test_expect_success 'garbage edit rejected' '
 	git reset &&
-	(echo e; echo n; echo d) | git add -p >output &&
+	printf "%s\n" e n d | git add -p >output &&
 	grep "hunk does not apply" output
 '
 
@@ -170,7 +170,7 @@ test_expect_success 'setup expected' '
 '
 
 test_expect_success 'real edit works' '
-	(echo e; echo n; echo d) | git add -p &&
+	printf "%s\n" e n d | git add -p &&
 	git diff >output &&
 	diff_cmp expected output
 '
diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index 83744f8c93..f32e272786 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -29,14 +29,14 @@ test_expect_success 'setup' '
 test_expect_success 'saying "n" does nothing' '
 	set_state HEAD HEADfile_work HEADfile_index &&
 	set_state dir/foo work index &&
-	(echo n; echo n; echo n) | test_must_fail git stash save -p &&
+	printf "%s\n" n n n | test_must_fail git stash save -p &&
 	verify_state HEAD HEADfile_work HEADfile_index &&
 	verify_saved_state bar &&
 	verify_state dir/foo work index
 '
 
 test_expect_success 'git stash -p' '
-	(echo y; echo n; echo y) | git stash save -p &&
+	printf "%s\n" y n y | git stash save -p &&
 	verify_state HEAD committed HEADfile_index &&
 	verify_saved_state bar &&
 	verify_state dir/foo head index &&
@@ -51,7 +51,7 @@ test_expect_success 'git stash -p --no-keep-index' '
 	set_state HEAD HEADfile_work HEADfile_index &&
 	set_state bar bar_work bar_index &&
 	set_state dir/foo work index &&
-	(echo y; echo n; echo y) | git stash save -p --no-keep-index &&
+	printf "%s\n" y n y | git stash save -p --no-keep-index &&
 	verify_state HEAD committed committed &&
 	verify_state bar bar_work dummy &&
 	verify_state dir/foo head head &&
@@ -66,7 +66,7 @@ test_expect_success 'git stash --no-keep-index -p' '
 	set_state HEAD HEADfile_work HEADfile_index &&
 	set_state bar bar_work bar_index &&
 	set_state dir/foo work index &&
-	(echo y; echo n; echo y) | git stash save --no-keep-index -p &&
+	printf "%s\n" y n y | git stash save --no-keep-index -p &&
 	verify_state HEAD committed committed &&
 	verify_state dir/foo head head &&
 	verify_state bar bar_work dummy &&
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index 98b7d7b969..d907b6dd18 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -19,20 +19,20 @@ test_expect_success PERL 'setup' '
 
 test_expect_success PERL 'saying "n" does nothing' '
 	set_and_save_state dir/foo work work &&
-	(echo n; echo n) | git reset -p &&
+	printf "%s\n" n n | git reset -p &&
 	verify_saved_state dir/foo &&
 	verify_saved_state bar
 '
 
 test_expect_success PERL 'git reset -p' '
-	(echo n; echo y) | git reset -p >output &&
+	printf "%s\n" n y | git reset -p >output &&
 	verify_state dir/foo work head &&
 	verify_saved_state bar &&
 	test_i18ngrep "Unstage" output
 '
 
 test_expect_success PERL 'git reset -p HEAD^' '
-	(echo n; echo y) | git reset -p HEAD^ >output &&
+	printf "%s\n" n y | git reset -p HEAD^ >output &&
 	verify_state dir/foo work parent &&
 	verify_saved_state bar &&
 	test_i18ngrep "Apply" output
@@ -45,20 +45,20 @@ test_expect_success PERL 'git reset -p HEAD^' '
 
 test_expect_success PERL 'git reset -p dir' '
 	set_state dir/foo work work &&
-	(echo y; echo n) | git reset -p dir &&
+	printf "%s\n" y n | git reset -p dir &&
 	verify_state dir/foo work head &&
 	verify_saved_state bar
 '
 
 test_expect_success PERL 'git reset -p -- foo (inside dir)' '
 	set_state dir/foo work work &&
-	(echo y; echo n) | (cd dir && git reset -p -- foo) &&
+	printf "%s\n" y n | (cd dir && git reset -p -- foo) &&
 	verify_state dir/foo work head &&
 	verify_saved_state bar
 '
 
 test_expect_success PERL 'git reset -p HEAD^ -- dir' '
-	(echo y; echo n) | git reset -p HEAD^ -- dir &&
+	printf "%s\n" y n | git reset -p HEAD^ -- dir &&
 	verify_state dir/foo work parent &&
 	verify_saved_state bar
 '
diff --git a/t/t7301-clean-interactive.sh b/t/t7301-clean-interactive.sh
index 1bf9789c8a..2bc8526f59 100755
--- a/t/t7301-clean-interactive.sh
+++ b/t/t7301-clean-interactive.sh
@@ -107,7 +107,7 @@ test_expect_success 'git clean -id (filter all)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo f; echo "*"; echo; echo c) | \
+	printf "%s\n" f "*" "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -129,7 +129,7 @@ test_expect_success 'git clean -id (filter patterns)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo f; echo "part3.* *.out"; echo; echo c) | \
+	printf "%s\n" f "part3.* *.out" "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -151,7 +151,7 @@ test_expect_success 'git clean -id (filter patterns 2)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo f; echo "* !*.out"; echo; echo c) | \
+	printf "%s\n" f "* !*.out" "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -173,7 +173,7 @@ test_expect_success 'git clean -id (select - all)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo s; echo "*"; echo; echo c) | \
+	printf "%s\n" s "*" "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -195,7 +195,7 @@ test_expect_success 'git clean -id (select - none)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo s; echo; echo c) | \
+	printf "%s\n" s "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -217,7 +217,7 @@ test_expect_success 'git clean -id (select - number)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo s; echo 3; echo; echo c) | \
+	printf "%s\n" s 3 "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -239,7 +239,7 @@ test_expect_success 'git clean -id (select - number 2)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo s; echo 2 3; echo 5; echo; echo c) | \
+	printf "%s\n" s "2 3" 5 "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -261,7 +261,7 @@ test_expect_success 'git clean -id (select - number 3)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo s; echo 3,4 5; echo; echo c) | \
+	printf "%s\n" s "3,4 5" "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -282,7 +282,7 @@ test_expect_success 'git clean -id (select - filenames)' '
 
 	mkdir -p build docs &&
 	touch a.out foo.txt bar.txt baz.txt &&
-	(echo s; echo a.out fo ba bar; echo; echo c) | \
+	printf "%s\n" s "a.out fo ba bar" "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test ! -f a.out &&
@@ -298,7 +298,7 @@ test_expect_success 'git clean -id (select - range)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo s; echo 1,3-4; echo 2; echo; echo c) | \
+	printf "%s\n" s "1,3-4" 2 "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -320,7 +320,7 @@ test_expect_success 'git clean -id (select - range 2)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo s; echo 4- 1; echo; echo c) | \
+	printf "%s\n" s "4- 1" "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -342,7 +342,7 @@ test_expect_success 'git clean -id (inverse select)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo s; echo "*"; echo -5- 1 -2; echo; echo c) | \
+	printf "%s\n" s "*" "-5- 1 -2" "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -364,7 +364,7 @@ test_expect_success 'git clean -id (ask)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo a; echo Y; echo y; echo no; echo yes; echo bad; echo) | \
+	printf "%s\n" a Y y no yes bad "" |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -386,7 +386,7 @@ test_expect_success 'git clean -id (ask - Ctrl+D)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo a; echo Y; echo no; echo yes; echo "\04") | \
+	printf "%s\n" a Y no yes "\04" |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -408,8 +408,8 @@ test_expect_success 'git clean -id with prefix and path (filter)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(cd build/ && \
-	 (echo f; echo "docs"; echo "*.h"; echo ; echo c) | \
+	(cd build/ &&
+	 printf "%s\n" f docs "*.h" "" c |
 	 git clean -id ..) &&
 	test -f Makefile &&
 	test -f README &&
@@ -431,9 +431,8 @@ test_expect_success 'git clean -id with prefix and path (select by name)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(cd build/ && \
-	 (echo s; echo "../docs/"; echo "../src/part3.c"; \
-	  echo "../src/part4.c";  echo; echo c) | \
+	(cd build/ &&
+	 printf "%s\n" s ../docs/ ../src/part3.c ../src/part4.c "" c |
 	 git clean -id ..) &&
 	test -f Makefile &&
 	test -f README &&
@@ -455,8 +454,8 @@ test_expect_success 'git clean -id with prefix and path (ask)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(cd build/ && \
-	 (echo a; echo Y; echo y; echo no; echo yes; echo bad; echo) | \
+	(cd build/ &&
+	 printf "%s\n" a Y y no yes bad "" |
 	 git clean -id ..) &&
 	test -f Makefile &&
 	test -f README &&
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 9dbbd01fc0..589b6cea23 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -47,7 +47,7 @@ test_expect_success 'paths and -a do not mix' '
 test_expect_success PERL 'can use paths with --interactive' '
 	echo bong-o-bong >file &&
 	# 2: update, 1:st path, that is all, 7: quit
-	( echo 2; echo 1; echo; echo 7 ) |
+	printf "%s\n" 2 1 "" 7 |
 	git commit -m foo --interactive file &&
 	git reset --hard HEAD^
 '
@@ -293,7 +293,7 @@ test_expect_success PERL 'interactive add' '
 test_expect_success PERL "commit --interactive doesn't change index if editor aborts" '
 	echo zoo >file &&
 	test_must_fail git diff --exit-code >diff1 &&
-	(echo u ; echo "*" ; echo q) |
+	printf "%s\n" u "*" q |
 	(
 		EDITOR=: &&
 		export EDITOR &&
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 1a430b9c40..a66d038083 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -57,18 +57,18 @@ test_expect_success 'setup' '
 
 	git checkout -b delete-base branch1 &&
 	mkdir -p a/a &&
-	(echo one; echo two; echo 3; echo 4) >a/a/file.txt &&
+	printf "%s\n" one two 3 4 >a/a/file.txt &&
 	git add a/a/file.txt &&
 	git commit -m"base file" &&
 	git checkout -b move-to-b delete-base &&
 	mkdir -p b/b &&
 	git mv a/a/file.txt b/b/file.txt &&
-	(echo one; echo two; echo 4) >b/b/file.txt &&
+	printf "%s\n" one two 4 >b/b/file.txt &&
 	git commit -a -m"move to b" &&
 	git checkout -b move-to-c delete-base &&
 	mkdir -p c/c &&
 	git mv a/a/file.txt c/c/file.txt &&
-	(echo one; echo two; echo 3) >c/c/file.txt &&
+	printf "%s\n" one two 3 >c/c/file.txt &&
 	git commit -a -m"move to c" &&
 
 	git checkout -b stash1 master &&
@@ -349,7 +349,7 @@ test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
 	git checkout -b test$test_count move-to-c &&
 	test_config mergetool.keepTemporaries true &&
 	test_must_fail git merge move-to-b &&
-	! (echo a; echo n) | git mergetool a/a/file.txt &&
+	! printf "%s\n" a n | git mergetool a/a/file.txt &&
 	test -d a/a &&
 	cat >expect <<-\EOF &&
 	file_BASE_.txt
-- 
2.18.0.419.gfe4b301394

