Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A50FC4320A
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 13:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04CA3610FC
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 13:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbhHBNrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 09:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbhHBNqo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 09:46:44 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC753C0617A2
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 06:46:33 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id d131-20020a1c1d890000b02902516717f562so10062wmd.3
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 06:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6PB4quCLTOrjGJFrDRzYVQaN7EgCzAEe6nTkKZ+9n6g=;
        b=PETVFvkrHIvSlo9q9ZXXAiqyuC53pFkCTqtWW+2+XeKSapoDbze4t9vPKWcJaWDNEN
         JTlJd6vJyOrd5fZyp6J8QhOLFtwN92CcTGCSlPoN4DuxtX9cy+jwPc/SvLHZEcokwhyW
         +Fxq6yMd3dOKrtoMa6nE+DyT3HUoXCkBEu6j8U/Peu5oYo8bmQ5LExz2XUnC2Dks62w5
         6dJdZ8qPWLbSoF9epZLA10UQpMq0DpjffeCwBP8A2lXXSjspXvfyrCmKPRYrmhmEuKK4
         gyZddyedvWNPBcynH57zAm1yLEJ9f+xcP9is1eY/fzCm7o4vH5rp0mbA12RhCwvp2TZW
         w3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6PB4quCLTOrjGJFrDRzYVQaN7EgCzAEe6nTkKZ+9n6g=;
        b=If+FCfdy6X/E/9yiW+F8+0piVsDAshyBj9EUDBg6WjMNN8fu4a4UOUmZpKar4q7sYS
         HdJWAyCY6iBld5CFDP4UPgGEUYZYls3HTxpbBdt7az3E3bXy6rVuU5t9c8r706WTaBcF
         5VI8+qhw1DBRgHBDDNfpfaNUNrl5c0i1UK6NsT/DyK559T+cQG/mXSXdJcbHnOKta422
         4yKdq2RLZqSAfGPAHP/JUNePUECjfy/i+ucgeygjhkxcilN7P0MKD00oPShAIoP7ueB7
         k9dYnJwq7y8iOG8Nm/o2U1jbiQzXaXLeOned2rykOTg6wEOkoKnC67xgPIIcjMivHe8g
         cyTA==
X-Gm-Message-State: AOAM531dOzuLLx9MXEFH5UDjNyRAOewp5FEhW1UdPz5i6G9ARiFps35n
        ivTkE7pCnjAvPU21tqPhfzomaxyP0AZ13g==
X-Google-Smtp-Source: ABdhPJy4JM7qGVa1itcr8GXVdmJuGtWjNC2zU8h6MvSUOSZaEgIw3Cgjk+xq15aZhUkAS2dMyBSHdw==
X-Received: by 2002:a05:600c:5108:: with SMTP id o8mr4230518wms.97.1627911992198;
        Mon, 02 Aug 2021 06:46:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b14sm11549003wrm.43.2021.08.02.06.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 06:46:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/3] test-lib-functions.sh: add a test_with_columns function
Date:   Mon,  2 Aug 2021 15:46:27 +0200
Message-Id: <patch-v2-2.3-36c57178c55-20210802T134610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.1070.gec115ccd780
In-Reply-To: <cover-v2-0.3-00000000000-20210802T134610Z-avarab@gmail.com>
References: <patch-1.1-f81f3911d5-20210726T235452Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20210802T134610Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a helper function to wrap patterns of "COLUMNS=N <command>" as
"test_with_columns N <command>". This will be used and extended in the
next commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3200-branch.sh             |  8 ++++----
 t/t4052-stat-output.sh        | 22 +++++++++++-----------
 t/t4205-log-pretty-formats.sh |  6 +++---
 t/t7004-tag.sh                |  6 +++---
 t/t7006-pager.sh              |  2 +-
 t/t7508-status.sh             |  4 ++--
 t/t9002-column.sh             | 23 ++++++++++-------------
 t/test-lib-functions.sh       |  8 ++++++++
 8 files changed, 42 insertions(+), 37 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cc4b10236e2..e568156ca83 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -328,7 +328,7 @@ test_expect_success 'git branch --list -v with --abbrev' '
 '
 
 test_expect_success 'git branch --column' '
-	COLUMNS=81 git branch --column=column >actual &&
+	test_with_columns 81 git branch --column=column >actual &&
 	cat >expect <<\EOF &&
   a/b/c   bam     foo     l     * main    n       o/p     r
   abc     bar     j/k     m/m     mb      o/o     q       topic
@@ -341,7 +341,7 @@ test_expect_success 'git branch --column with an extremely long branch name' '
 	long=z$long/$long/$long/$long &&
 	test_when_finished "git branch -d $long" &&
 	git branch $long &&
-	COLUMNS=80 git branch --column=column >actual &&
+	test_with_columns 80 git branch --column=column >actual &&
 	cat >expect <<EOF &&
   a/b/c
   abc
@@ -367,7 +367,7 @@ EOF
 test_expect_success 'git branch with column.*' '
 	git config column.ui column &&
 	git config column.branch "dense" &&
-	COLUMNS=80 git branch >actual &&
+	test_with_columns 80 git branch >actual &&
 	git config --unset column.branch &&
 	git config --unset column.ui &&
 	cat >expect <<\EOF &&
@@ -383,7 +383,7 @@ test_expect_success 'git branch --column -v should fail' '
 
 test_expect_success 'git branch -v with column.ui ignored' '
 	git config column.ui column &&
-	COLUMNS=80 git branch -v | cut -c -8 | sed "s/ *$//" >actual &&
+	test_with_columns 80 git branch -v | cut -c -8 | sed "s/ *$//" >actual &&
 	git config --unset column.ui &&
 	cat >expect <<\EOF &&
   a/b/c
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 9eba436211f..3a91df50dd8 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -111,7 +111,7 @@ cat >expect72 <<'EOF'
  abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
 test_expect_success "format-patch --cover-letter ignores COLUMNS (big change)" '
-	COLUMNS=200 git format-patch -1 --stdout --cover-letter >output &&
+	test_with_columns 200 git format-patch -1 --stdout --cover-letter >output &&
 	grep " | " output >actual &&
 	test_cmp expect72 actual
 '
@@ -131,7 +131,7 @@ EOF
 while read verb expect cmd args
 do
 	test_expect_success "$cmd $verb COLUMNS (big change)" '
-		COLUMNS=200 git $cmd $args >output &&
+		test_with_columns 200 git $cmd $args >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
@@ -139,7 +139,7 @@ do
 	case "$cmd" in diff|show) continue;; esac
 
 	test_expect_success "$cmd --graph $verb COLUMNS (big change)" '
-		COLUMNS=200 git $cmd $args --graph >output &&
+		test_with_columns 200 git $cmd $args --graph >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
 	'
@@ -159,7 +159,7 @@ EOF
 while read verb expect cmd args
 do
 	test_expect_success "$cmd $verb not enough COLUMNS (big change)" '
-		COLUMNS=40 git $cmd $args >output &&
+		test_with_columns 40 git $cmd $args >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
@@ -167,7 +167,7 @@ do
 	case "$cmd" in diff|show) continue;; esac
 
 	test_expect_success "$cmd --graph $verb not enough COLUMNS (big change)" '
-		COLUMNS=40 git $cmd $args --graph >output &&
+		test_with_columns 40 git $cmd $args --graph >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
 	'
@@ -302,7 +302,7 @@ EOF
 while read verb expect cmd args
 do
 	test_expect_success "$cmd $verb COLUMNS (long filename)" '
-		COLUMNS=200 git $cmd $args >output &&
+		test_with_columns 200 git $cmd $args >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
@@ -310,7 +310,7 @@ do
 	case "$cmd" in diff|show) continue;; esac
 
 	test_expect_success "$cmd --graph $verb COLUMNS (long filename)" '
-		COLUMNS=200 git $cmd $args --graph >output &&
+		test_with_columns 200 git $cmd $args --graph >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
 	'
@@ -331,7 +331,7 @@ while read verb expect cmd args
 do
 	test_expect_success COLUMNS_CAN_BE_1 \
 		"$cmd $verb prefix greater than COLUMNS (big change)" '
-		COLUMNS=1 git $cmd $args >output &&
+		test_with_columns 1 git $cmd $args >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
@@ -340,7 +340,7 @@ do
 
 	test_expect_success COLUMNS_CAN_BE_1 \
 		"$cmd --graph $verb prefix greater than COLUMNS (big change)" '
-		COLUMNS=1 git $cmd $args --graph >output &&
+		test_with_columns 1 git $cmd $args --graph >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
 	'
@@ -356,7 +356,7 @@ cat >expect <<'EOF'
 EOF
 test_expect_success 'merge --stat respects COLUMNS (big change)' '
 	git checkout -b branch HEAD^^ &&
-	COLUMNS=100 git merge --stat --no-ff main^ >output &&
+	test_with_columns 100 git merge --stat --no-ff main^ >output &&
 	grep " | " output >actual &&
 	test_cmp expect actual
 '
@@ -365,7 +365,7 @@ cat >expect <<'EOF'
  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++++++++++++++++++++++++++++++
 EOF
 test_expect_success 'merge --stat respects COLUMNS (long filename)' '
-	COLUMNS=100 git merge --stat --no-ff main >output &&
+	test_with_columns 100 git merge --stat --no-ff main >output &&
 	grep " | " output >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 5865daa8f8d..a035f749537 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -207,7 +207,7 @@ test_expect_success 'left alignment formatting at the nth column' '
 '
 
 test_expect_success 'left alignment formatting at the nth column' '
-	COLUMNS=50 git log --pretty="tformat:%h %<|(-10)%s" >actual &&
+	test_with_columns 50 git log --pretty="tformat:%h %<|(-10)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	$head1 message two                    Z
 	$head2 message one                    Z
@@ -350,7 +350,7 @@ test_expect_success 'right alignment formatting at the nth column' '
 '
 
 test_expect_success 'right alignment formatting at the nth column' '
-	COLUMNS=50 git log --pretty="tformat:%h %>|(-10)%s" >actual &&
+	test_with_columns 50 git log --pretty="tformat:%h %>|(-10)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	$head1                      message two
 	$head2                      message one
@@ -450,7 +450,7 @@ test_expect_success 'center alignment formatting at the nth column' '
 '
 
 test_expect_success 'center alignment formatting at the nth column' '
-	COLUMNS=70 git log --pretty="tformat:%h %><|(-30)%s" >actual &&
+	test_with_columns 70 git log --pretty="tformat:%h %><|(-30)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	$head1           message two          Z
 	$head2           message one          Z
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 2f72c5c6883..e893c43d705 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -372,7 +372,7 @@ test_expect_success 'tag -l <pattern> -l <pattern> works, as our buggy documenta
 '
 
 test_expect_success 'listing tags in column' '
-	COLUMNS=41 git tag -l --column=row >actual &&
+	test_with_columns 41 git tag -l --column=row >actual &&
 	cat >expected <<\EOF &&
 a1      aa1     cba     t210    t211
 v0.2.1  v1.0    v1.0.1  v1.1.3
@@ -383,7 +383,7 @@ EOF
 test_expect_success 'listing tags in column with column.*' '
 	test_config column.tag row &&
 	test_config column.ui dense &&
-	COLUMNS=40 git tag -l >actual &&
+	test_with_columns 40 git tag -l >actual &&
 	cat >expected <<\EOF &&
 a1      aa1   cba     t210    t211
 v0.2.1  v1.0  v1.0.1  v1.1.3
@@ -397,7 +397,7 @@ test_expect_success 'listing tag with -n --column should fail' '
 
 test_expect_success 'listing tags -n in column with column.ui ignored' '
 	test_config column.ui "row dense" &&
-	COLUMNS=40 git tag -l -n >actual &&
+	test_with_columns 40 git tag -l -n >actual &&
 	cat >expected <<\EOF &&
 a1              Foo
 aa1             Foo
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 0e7cf75435e..5189699debf 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -651,7 +651,7 @@ test_expect_success TTY 'git tag with auto-columns ' '
 	cat >expect <<-\EOF &&
 	initial  one      two      three    four     five
 	EOF
-	test_terminal env PAGER="cat >actual" COLUMNS=80 \
+	test_with_columns 80 test_terminal env PAGER="cat >actual" \
 		git -c column.ui=auto tag --sort=authordate &&
 	test_cmp expect actual
 '
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 2b72451ba3e..808b8f50576 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -108,13 +108,13 @@ test_expect_success 'status --column' '
 #	dir2/modified  untracked
 #
 EOF
-	COLUMNS=50 git -c status.displayCommentPrefix=true status --column="column dense" >output &&
+	test_with_columns 50 git -c status.displayCommentPrefix=true status --column="column dense" >output &&
 	test_cmp expect output
 '
 
 test_expect_success 'status --column status.displayCommentPrefix=false' '
 	strip_comments expect &&
-	COLUMNS=49 git -c status.displayCommentPrefix=false status --column="column dense" >output &&
+	test_with_columns 49 git -c status.displayCommentPrefix=false status --column="column dense" >output &&
 	test_cmp expect output
 '
 
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
index 89983527b62..9151d69bcf1 100755
--- a/t/t9002-column.sh
+++ b/t/t9002-column.sh
@@ -46,7 +46,7 @@ test_expect_success '80 columns' '
 	cat >expected <<\EOF &&
 one    two    three  four   five   six    seven  eight  nine   ten    eleven
 EOF
-	COLUMNS=80 git column --mode=column <lista >actual &&
+	test_with_columns 80 git column --mode=column <lista >actual &&
 	test_cmp expected actual
 '
 
@@ -65,7 +65,7 @@ eleven
 EOF
 
 test_expect_success COLUMNS_CAN_BE_1 'COLUMNS = 1' '
-	COLUMNS=1 git column --mode=column <lista >actual &&
+	test_with_columns 1 git column --mode=column <lista >actual &&
 	test_cmp expected actual
 '
 
@@ -74,9 +74,6 @@ test_expect_success 'width = 1' '
 	test_cmp expected actual
 '
 
-COLUMNS=20
-export COLUMNS
-
 test_expect_success '20 columns' '
 	cat >expected <<\EOF &&
 one    seven
@@ -86,7 +83,7 @@ four   ten
 five   eleven
 six
 EOF
-	git column --mode=column <lista >actual &&
+	test_with_columns 20 git column --mode=column <lista >actual &&
 	test_cmp expected actual
 '
 
@@ -99,7 +96,7 @@ four   ten
 five   eleven
 six
 EOF
-	git column --mode=column,nodense < lista > actual &&
+	test_with_columns 20 git column --mode=column,nodense < lista > actual &&
 	test_cmp expected actual
 '
 
@@ -110,7 +107,7 @@ two   six   ten
 three seven eleven
 four  eight
 EOF
-	git column --mode=column,dense < lista > actual &&
+	test_with_columns 20 git column --mode=column,dense < lista > actual &&
 	test_cmp expected actual
 '
 
@@ -123,7 +120,7 @@ four    ten
 five    eleven
 six
 EOF
-	git column --mode=column --padding 2 <lista >actual &&
+	test_with_columns 20 git column --mode=column --padding 2 <lista >actual &&
 	test_cmp expected actual
 '
 
@@ -136,7 +133,7 @@ test_expect_success '20 columns, indented' '
   five   eleven
   six
 EOF
-	git column --mode=column --indent="  " <lista >actual &&
+	test_with_columns 20 git column --mode=column --indent="  " <lista >actual &&
 	test_cmp expected actual
 '
 
@@ -149,7 +146,7 @@ seven  eight
 nine   ten
 eleven
 EOF
-	git column --mode=row <lista >actual &&
+	test_with_columns 20 git column --mode=row <lista >actual &&
 	test_cmp expected actual
 '
 
@@ -162,7 +159,7 @@ seven  eight
 nine   ten
 eleven
 EOF
-	git column --mode=row,nodense <lista >actual &&
+	test_with_columns 20 git column --mode=row,nodense <lista >actual &&
 	test_cmp expected actual
 '
 
@@ -173,7 +170,7 @@ four  five   six
 seven eight  nine
 ten   eleven
 EOF
-	git column --mode=row,dense <lista >actual &&
+	test_with_columns 20 git column --mode=row,dense <lista >actual &&
 	test_cmp expected actual
 '
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 37da7d9a99a..536339faaa2 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1718,3 +1718,11 @@ test_region () {
 test_readlink () {
 	perl -le 'print readlink($_) for @ARGV' "$@"
 }
+
+# Test a with a given number of COLUMNS in the environment.
+test_with_columns () {
+	local columns=$1
+	shift
+
+	COLUMNS=$columns "$@"
+}
-- 
2.32.0.1070.gec115ccd780

