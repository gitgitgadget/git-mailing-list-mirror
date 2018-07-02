Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 820921F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752879AbeGBAZE (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:25:04 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51487 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752763AbeGBAYw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:24:52 -0400
Received: by mail-it0-f66.google.com with SMTP id o5-v6so8852502itc.1
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m5mXbyIq8SFAzc1m21nnWGypHDM+0xkwPurNtADJIjU=;
        b=hiThyypxcO+AtaHiFzs4wv75TR8tEKJ3R7mmQLMaYph0zdq9b0t9X6Ze3UODTybZRG
         6obGzm8csUXKXJ1eChhVmh1mpIv7MaaOmX2Y6aut8RfjzOhscI5WmP5coeYqz8lX7evq
         ZybL2tLGMJkTCKsdc+fUE6I45KTEPV2fnAX9W7PTjdNE0rgXcGlIsxmzuaGZBxjX1Rq/
         owYOddVQdIF1Pv1OZaBKFzS2VYBp3I9PPP5nNXYIzQnpfKqinSUyIju5QxKMDgj3QE6u
         +MM9McuEBgv0xapWpHiBhbBiHgyVF7LBvxepx/kNLuu5IxdJpQzG2huyiCR5l4rysboz
         B0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=m5mXbyIq8SFAzc1m21nnWGypHDM+0xkwPurNtADJIjU=;
        b=HwuLTJlCMT3hOCcFPR/eqEw4wPnGVKwXLvghhBQwQHqCRZseEdDKS8SEQ0dou9l4Ux
         DmX+oub8/VBiUUOIPJLgMOxSchQgCvg/RjwH7ffjq8gOO7fHxpPlpXgXAKAa3NuWUIzQ
         3ytKvP3e7+lwKv4EOHuASNJC+CEa8d60DAA1L487lHDUeYtu+tCRFrLjBL966F6qNPsr
         fDsiRbLpPCuwStlbs3qYY9rOj7diwhmJfCC7EMOf6pOW/tdooeux0gV4M/0yjGYjMFAo
         7bOxbzVn1jBr9S1cRUJmQemfU8UJAMEyFq7CkgOnSvBh2SCCMbV2RxkBTRMrsgvnH7/I
         OvUQ==
X-Gm-Message-State: APt69E0YwYI67s/kdkuJ/xDBtEfg7dzEs5a2jGLITIvvpix44v5WDzfO
        UGlxRCPBop+hv+OroAyKhb5Ovg==
X-Google-Smtp-Source: AAOMgpc81STZrHg3crdIE3xzmSuGk7RhEEXMHnUSnoIzComgsvZrHwHBzCaF9T5JsNEjCvNYm8ejPQ==
X-Received: by 2002:a02:b468:: with SMTP id w37-v6mr5175025jaj.18.1530491090831;
        Sun, 01 Jul 2018 17:24:50 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.24.49
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:24:50 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 02/25] t: use test_write_lines() instead of series of 'echo' commands
Date:   Sun,  1 Jul 2018 20:23:42 -0400
Message-Id: <20180702002405.3042-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests employ a noisy subshell (with missing &&-chain) to feed
input into Git commands or files:

    (echo a; echo b; echo c) | git some-command ...

Simplify by taking advantage of test_write_lines():

    test_write_lines a b c | git some-command ...

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t0090-cache-tree.sh         |  2 +-
 t/t1008-read-tree-overlay.sh  |  2 +-
 t/t2016-checkout-patch.sh     | 24 ++++++++++----------
 t/t3404-rebase-interactive.sh |  6 ++---
 t/t3701-add-interactive.sh    | 16 +++++++-------
 t/t3904-stash-patch.sh        |  8 +++----
 t/t7105-reset-patch.sh        | 12 +++++-----
 t/t7301-clean-interactive.sh  | 41 +++++++++++++++++------------------
 t/t7501-commit.sh             |  4 ++--
 t/t7610-mergetool.sh          |  8 +++----
 10 files changed, 61 insertions(+), 62 deletions(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 0c61268fd2..28ea93f509 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -156,7 +156,7 @@ test_expect_success PERL 'commit --interactive gives cache-tree on partial commi
 		return 44;
 	}
 	EOT
-	(echo p; echo 1; echo; echo s; echo n; echo y; echo q) |
+	test_write_lines p 1 "" s n y q |
 	git commit --interactive -m foo &&
 	test_cache_tree
 '
diff --git a/t/t1008-read-tree-overlay.sh b/t/t1008-read-tree-overlay.sh
index 4c50ed955e..cf96016844 100755
--- a/t/t1008-read-tree-overlay.sh
+++ b/t/t1008-read-tree-overlay.sh
@@ -23,7 +23,7 @@ test_expect_success setup '
 
 test_expect_success 'multi-read' '
 	read_tree_must_succeed initial master side &&
-	(echo a; echo b/c) >expect &&
+	test_write_lines a b/c >expect &&
 	git ls-files >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index 9cd0ac4ba3..47aeb0b167 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -20,33 +20,33 @@ test_expect_success PERL 'setup' '
 
 test_expect_success PERL 'saying "n" does nothing' '
 	set_and_save_state dir/foo work head &&
-	(echo n; echo n) | git checkout -p &&
+	test_write_lines n n | git checkout -p &&
 	verify_saved_state bar &&
 	verify_saved_state dir/foo
 '
 
 test_expect_success PERL 'git checkout -p' '
-	(echo n; echo y) | git checkout -p &&
+	test_write_lines n y | git checkout -p &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
 
 test_expect_success PERL 'git checkout -p with staged changes' '
 	set_state dir/foo work index &&
-	(echo n; echo y) | git checkout -p &&
+	test_write_lines n y | git checkout -p &&
 	verify_saved_state bar &&
 	verify_state dir/foo index index
 '
 
 test_expect_success PERL 'git checkout -p HEAD with NO staged changes: abort' '
 	set_and_save_state dir/foo work head &&
-	(echo n; echo y; echo n) | git checkout -p HEAD &&
+	test_write_lines n y n | git checkout -p HEAD &&
 	verify_saved_state bar &&
 	verify_saved_state dir/foo
 '
 
 test_expect_success PERL 'git checkout -p HEAD with NO staged changes: apply' '
-	(echo n; echo y; echo y) | git checkout -p HEAD &&
+	test_write_lines n y y | git checkout -p HEAD &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
@@ -54,14 +54,14 @@ test_expect_success PERL 'git checkout -p HEAD with NO staged changes: apply' '
 test_expect_success PERL 'git checkout -p HEAD with change already staged' '
 	set_state dir/foo index index &&
 	# the third n is to get out in case it mistakenly does not apply
-	(echo n; echo y; echo n) | git checkout -p HEAD &&
+	test_write_lines n y n | git checkout -p HEAD &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
 
 test_expect_success PERL 'git checkout -p HEAD^' '
 	# the third n is to get out in case it mistakenly does not apply
-	(echo n; echo y; echo n) | git checkout -p HEAD^ &&
+	test_write_lines n y n | git checkout -p HEAD^ &&
 	verify_saved_state bar &&
 	verify_state dir/foo parent parent
 '
@@ -69,7 +69,7 @@ test_expect_success PERL 'git checkout -p HEAD^' '
 test_expect_success PERL 'git checkout -p handles deletion' '
 	set_state dir/foo work index &&
 	rm dir/foo &&
-	(echo n; echo y) | git checkout -p &&
+	test_write_lines n y | git checkout -p &&
 	verify_saved_state bar &&
 	verify_state dir/foo index index
 '
@@ -81,21 +81,21 @@ test_expect_success PERL 'git checkout -p handles deletion' '
 
 test_expect_success PERL 'path limiting works: dir' '
 	set_state dir/foo work head &&
-	(echo y; echo n) | git checkout -p dir &&
+	test_write_lines y n | git checkout -p dir &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
 
 test_expect_success PERL 'path limiting works: -- dir' '
 	set_state dir/foo work head &&
-	(echo y; echo n) | git checkout -p -- dir &&
+	test_write_lines y n | git checkout -p -- dir &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
 
 test_expect_success PERL 'path limiting works: HEAD^ -- dir' '
 	# the third n is to get out in case it mistakenly does not apply
-	(echo y; echo n; echo n) | git checkout -p HEAD^ -- dir &&
+	test_write_lines y n n | git checkout -p HEAD^ -- dir &&
 	verify_saved_state bar &&
 	verify_state dir/foo parent parent
 '
@@ -103,7 +103,7 @@ test_expect_success PERL 'path limiting works: HEAD^ -- dir' '
 test_expect_success PERL 'path limiting works: foo inside dir' '
 	set_state dir/foo work head &&
 	# the third n is to get out in case it mistakenly does not apply
-	(echo y; echo n; echo n) | (cd dir && git checkout -p foo) &&
+	test_write_lines y n n | (cd dir && git checkout -p foo) &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 352a52e59d..85e99aac13 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -509,7 +509,7 @@ test_expect_success 'interrupted squash works as expected' '
 	one=$(git rev-parse HEAD~3) &&
 	set_fake_editor &&
 	test_must_fail env FAKE_LINES="1 squash 3 2" git rebase -i HEAD~3 &&
-	(echo one; echo two; echo four) > conflict &&
+	test_write_lines one two four > conflict &&
 	git add conflict &&
 	test_must_fail git rebase --continue &&
 	echo resolved > conflict &&
@@ -523,10 +523,10 @@ test_expect_success 'interrupted squash works as expected (case 2)' '
 	one=$(git rev-parse HEAD~3) &&
 	set_fake_editor &&
 	test_must_fail env FAKE_LINES="3 squash 1 2" git rebase -i HEAD~3 &&
-	(echo one; echo four) > conflict &&
+	test_write_lines one four > conflict &&
 	git add conflict &&
 	test_must_fail git rebase --continue &&
-	(echo one; echo two; echo four) > conflict &&
+	test_write_lines one two four > conflict &&
 	git add conflict &&
 	test_must_fail git rebase --continue &&
 	echo resolved > conflict &&
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 3e9139dca8..609fbfdc31 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -46,13 +46,13 @@ test_expect_success 'setup expected' '
 '
 
 test_expect_success 'diff works (initial)' '
-	(echo d; echo 1) | git add -i >output &&
+	test_write_lines d 1 | git add -i >output &&
 	sed -ne "/new file/,/content/p" <output >diff &&
 	diff_cmp expected diff
 '
 test_expect_success 'revert works (initial)' '
 	git add file &&
-	(echo r; echo 1) | git add -i &&
+	test_write_lines r 1 | git add -i &&
 	git ls-files >output &&
 	! grep . output
 '
@@ -83,13 +83,13 @@ test_expect_success 'setup expected' '
 '
 
 test_expect_success 'diff works (commit)' '
-	(echo d; echo 1) | git add -i >output &&
+	test_write_lines d 1 | git add -i >output &&
 	sed -ne "/^index/,/content/p" <output >diff &&
 	diff_cmp expected diff
 '
 test_expect_success 'revert works (commit)' '
 	git add file &&
-	(echo r; echo 1) | git add -i &&
+	test_write_lines r 1 | git add -i &&
 	git add -i </dev/null >output &&
 	grep "unchanged *+3/-0 file" output
 '
@@ -102,7 +102,7 @@ test_expect_success 'setup expected' '
 
 test_expect_success 'dummy edit works' '
 	test_set_editor : &&
-	(echo e; echo a) | git add -p &&
+	test_write_lines e a | git add -p &&
 	git diff > diff &&
 	diff_cmp expected diff
 '
@@ -127,7 +127,7 @@ test_expect_success 'setup fake editor' '
 
 test_expect_success 'bad edit rejected' '
 	git reset &&
-	(echo e; echo n; echo d) | git add -p >output &&
+	test_write_lines e n d | git add -p >output &&
 	grep "hunk does not apply" output
 '
 
@@ -140,7 +140,7 @@ test_expect_success 'setup patch' '
 
 test_expect_success 'garbage edit rejected' '
 	git reset &&
-	(echo e; echo n; echo d) | git add -p >output &&
+	test_write_lines e n d | git add -p >output &&
 	grep "hunk does not apply" output
 '
 
@@ -170,7 +170,7 @@ test_expect_success 'setup expected' '
 '
 
 test_expect_success 'real edit works' '
-	(echo e; echo n; echo d) | git add -p &&
+	test_write_lines e n d | git add -p &&
 	git diff >output &&
 	diff_cmp expected output
 '
diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index 83744f8c93..9546b6f8a4 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -29,14 +29,14 @@ test_expect_success 'setup' '
 test_expect_success 'saying "n" does nothing' '
 	set_state HEAD HEADfile_work HEADfile_index &&
 	set_state dir/foo work index &&
-	(echo n; echo n; echo n) | test_must_fail git stash save -p &&
+	test_write_lines n n n | test_must_fail git stash save -p &&
 	verify_state HEAD HEADfile_work HEADfile_index &&
 	verify_saved_state bar &&
 	verify_state dir/foo work index
 '
 
 test_expect_success 'git stash -p' '
-	(echo y; echo n; echo y) | git stash save -p &&
+	test_write_lines y n y | git stash save -p &&
 	verify_state HEAD committed HEADfile_index &&
 	verify_saved_state bar &&
 	verify_state dir/foo head index &&
@@ -51,7 +51,7 @@ test_expect_success 'git stash -p --no-keep-index' '
 	set_state HEAD HEADfile_work HEADfile_index &&
 	set_state bar bar_work bar_index &&
 	set_state dir/foo work index &&
-	(echo y; echo n; echo y) | git stash save -p --no-keep-index &&
+	test_write_lines y n y | git stash save -p --no-keep-index &&
 	verify_state HEAD committed committed &&
 	verify_state bar bar_work dummy &&
 	verify_state dir/foo head head &&
@@ -66,7 +66,7 @@ test_expect_success 'git stash --no-keep-index -p' '
 	set_state HEAD HEADfile_work HEADfile_index &&
 	set_state bar bar_work bar_index &&
 	set_state dir/foo work index &&
-	(echo y; echo n; echo y) | git stash save --no-keep-index -p &&
+	test_write_lines y n y | git stash save --no-keep-index -p &&
 	verify_state HEAD committed committed &&
 	verify_state dir/foo head head &&
 	verify_state bar bar_work dummy &&
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index 98b7d7b969..bd10a96727 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -19,20 +19,20 @@ test_expect_success PERL 'setup' '
 
 test_expect_success PERL 'saying "n" does nothing' '
 	set_and_save_state dir/foo work work &&
-	(echo n; echo n) | git reset -p &&
+	test_write_lines n n | git reset -p &&
 	verify_saved_state dir/foo &&
 	verify_saved_state bar
 '
 
 test_expect_success PERL 'git reset -p' '
-	(echo n; echo y) | git reset -p >output &&
+	test_write_lines n y | git reset -p >output &&
 	verify_state dir/foo work head &&
 	verify_saved_state bar &&
 	test_i18ngrep "Unstage" output
 '
 
 test_expect_success PERL 'git reset -p HEAD^' '
-	(echo n; echo y) | git reset -p HEAD^ >output &&
+	test_write_lines n y | git reset -p HEAD^ >output &&
 	verify_state dir/foo work parent &&
 	verify_saved_state bar &&
 	test_i18ngrep "Apply" output
@@ -45,20 +45,20 @@ test_expect_success PERL 'git reset -p HEAD^' '
 
 test_expect_success PERL 'git reset -p dir' '
 	set_state dir/foo work work &&
-	(echo y; echo n) | git reset -p dir &&
+	test_write_lines y n | git reset -p dir &&
 	verify_state dir/foo work head &&
 	verify_saved_state bar
 '
 
 test_expect_success PERL 'git reset -p -- foo (inside dir)' '
 	set_state dir/foo work work &&
-	(echo y; echo n) | (cd dir && git reset -p -- foo) &&
+	test_write_lines y n | (cd dir && git reset -p -- foo) &&
 	verify_state dir/foo work head &&
 	verify_saved_state bar
 '
 
 test_expect_success PERL 'git reset -p HEAD^ -- dir' '
-	(echo y; echo n) | git reset -p HEAD^ -- dir &&
+	test_write_lines y n | git reset -p HEAD^ -- dir &&
 	verify_state dir/foo work parent &&
 	verify_saved_state bar
 '
diff --git a/t/t7301-clean-interactive.sh b/t/t7301-clean-interactive.sh
index 1bf9789c8a..a07e8b86de 100755
--- a/t/t7301-clean-interactive.sh
+++ b/t/t7301-clean-interactive.sh
@@ -107,7 +107,7 @@ test_expect_success 'git clean -id (filter all)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo f; echo "*"; echo; echo c) | \
+	test_write_lines f "*" "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -129,7 +129,7 @@ test_expect_success 'git clean -id (filter patterns)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo f; echo "part3.* *.out"; echo; echo c) | \
+	test_write_lines f "part3.* *.out" "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -151,7 +151,7 @@ test_expect_success 'git clean -id (filter patterns 2)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo f; echo "* !*.out"; echo; echo c) | \
+	test_write_lines f "* !*.out" "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -173,7 +173,7 @@ test_expect_success 'git clean -id (select - all)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo s; echo "*"; echo; echo c) | \
+	test_write_lines s "*" "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -195,7 +195,7 @@ test_expect_success 'git clean -id (select - none)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo s; echo; echo c) | \
+	test_write_lines s "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -217,7 +217,7 @@ test_expect_success 'git clean -id (select - number)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo s; echo 3; echo; echo c) | \
+	test_write_lines s 3 "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -239,7 +239,7 @@ test_expect_success 'git clean -id (select - number 2)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo s; echo 2 3; echo 5; echo; echo c) | \
+	test_write_lines s "2 3" 5 "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -261,7 +261,7 @@ test_expect_success 'git clean -id (select - number 3)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo s; echo 3,4 5; echo; echo c) | \
+	test_write_lines s "3,4 5" "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -282,7 +282,7 @@ test_expect_success 'git clean -id (select - filenames)' '
 
 	mkdir -p build docs &&
 	touch a.out foo.txt bar.txt baz.txt &&
-	(echo s; echo a.out fo ba bar; echo; echo c) | \
+	test_write_lines s "a.out fo ba bar" "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test ! -f a.out &&
@@ -298,7 +298,7 @@ test_expect_success 'git clean -id (select - range)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo s; echo 1,3-4; echo 2; echo; echo c) | \
+	test_write_lines s "1,3-4" 2 "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -320,7 +320,7 @@ test_expect_success 'git clean -id (select - range 2)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo s; echo 4- 1; echo; echo c) | \
+	test_write_lines s "4- 1" "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -342,7 +342,7 @@ test_expect_success 'git clean -id (inverse select)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo s; echo "*"; echo -5- 1 -2; echo; echo c) | \
+	test_write_lines s "*" "-5- 1 -2" "" c |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -364,7 +364,7 @@ test_expect_success 'git clean -id (ask)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo a; echo Y; echo y; echo no; echo yes; echo bad; echo) | \
+	test_write_lines a Y y no yes bad "" |
 	git clean -id &&
 	test -f Makefile &&
 	test -f README &&
@@ -386,7 +386,7 @@ test_expect_success 'git clean -id (ask - Ctrl+D)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
-	(echo a; echo Y; echo no; echo yes; echo "\04") | \
+	test_write_lines a Y no yes "\04" |
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
+	 test_write_lines f docs "*.h" "" c |
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
+	 test_write_lines s ../docs/ ../src/part3.c ../src/part4.c "" c |
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
+	 test_write_lines a Y y no yes bad "" |
 	 git clean -id ..) &&
 	test -f Makefile &&
 	test -f README &&
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 9dbbd01fc0..282ff42331 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -47,7 +47,7 @@ test_expect_success 'paths and -a do not mix' '
 test_expect_success PERL 'can use paths with --interactive' '
 	echo bong-o-bong >file &&
 	# 2: update, 1:st path, that is all, 7: quit
-	( echo 2; echo 1; echo; echo 7 ) |
+	test_write_lines 2 1 "" 7 |
 	git commit -m foo --interactive file &&
 	git reset --hard HEAD^
 '
@@ -293,7 +293,7 @@ test_expect_success PERL 'interactive add' '
 test_expect_success PERL "commit --interactive doesn't change index if editor aborts" '
 	echo zoo >file &&
 	test_must_fail git diff --exit-code >diff1 &&
-	(echo u ; echo "*" ; echo q) |
+	test_write_lines u "*" q |
 	(
 		EDITOR=: &&
 		export EDITOR &&
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 1a430b9c40..047156e9d5 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -57,18 +57,18 @@ test_expect_success 'setup' '
 
 	git checkout -b delete-base branch1 &&
 	mkdir -p a/a &&
-	(echo one; echo two; echo 3; echo 4) >a/a/file.txt &&
+	test_write_lines one two 3 4 >a/a/file.txt &&
 	git add a/a/file.txt &&
 	git commit -m"base file" &&
 	git checkout -b move-to-b delete-base &&
 	mkdir -p b/b &&
 	git mv a/a/file.txt b/b/file.txt &&
-	(echo one; echo two; echo 4) >b/b/file.txt &&
+	test_write_lines one two 4 >b/b/file.txt &&
 	git commit -a -m"move to b" &&
 	git checkout -b move-to-c delete-base &&
 	mkdir -p c/c &&
 	git mv a/a/file.txt c/c/file.txt &&
-	(echo one; echo two; echo 3) >c/c/file.txt &&
+	test_write_lines one two 3 >c/c/file.txt &&
 	git commit -a -m"move to c" &&
 
 	git checkout -b stash1 master &&
@@ -349,7 +349,7 @@ test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
 	git checkout -b test$test_count move-to-c &&
 	test_config mergetool.keepTemporaries true &&
 	test_must_fail git merge move-to-b &&
-	! (echo a; echo n) | git mergetool a/a/file.txt &&
+	! test_write_lines a n | git mergetool a/a/file.txt &&
 	test -d a/a &&
 	cat >expect <<-\EOF &&
 	file_BASE_.txt
-- 
2.18.0.203.gfac676dfb9

