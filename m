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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C547C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 031D660F46
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbhGZXQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 19:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbhGZXQr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 19:16:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEF9C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:57:14 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m38-20020a05600c3b26b02902161fccabf1so584887wms.2
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KuNuq9JyWRmB5UPa/K8NeBfkiWTzsLKj+CDBJVi6ohM=;
        b=j3XRDegfVWuax5rWw+eOUK64eTSGMEsFpP8Y8itH/eK0b8LlcUg6pmepg79QYBrjUC
         ws3GcxG6RGZ9G8oLL+8y2j3p3JWN1xBLNBl1gXeNK3C/Ej0GxVHCC3ZnrlDJI0kKCz+m
         h1n+p5IPMv9QK2ouMsgEhtdihliZg5515niRdCFqqPgrwRA+PdFXoa2uuHgzQUVp4QfG
         q7RA51IQZ1j6cnoM0oI410WXvlFrjMGHW/EtBWArqeY1in29B+A/WHYn49xUfq+Ci94G
         7qToIzEDvdmwMvKiM5Qeg7i8LTy0+grhroTnHqUKd2v6zWN+fUWdzKczXTv2KXmBffXP
         tIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KuNuq9JyWRmB5UPa/K8NeBfkiWTzsLKj+CDBJVi6ohM=;
        b=p6sRIJM7hvXDn+xagL6egLP1iuFEYyJeka5htM7RZgRcQi1KI2NIjtX4CaXlARZt0G
         ogbMb3oj6KfYxqBo1Du0XDyDvfROgqrXgKnwhUjjwegKP+cc+yRW+EwiiF11m9Ig6/MT
         Xt5+Mbeo9IHShfktWEpfoCnZzgeXZs/f6QIXglSoYENZNcqAjHNUqyL++MwYEQsfZs3e
         ChPLz3gaVy5bfxxjkWLtIme1L4WuNR5uUyMjozgYzaaauzH5ZPpNeT+IYx5jtsrY2irz
         IAndBoLGuaeBM6wZ8PEwfl+mu4GZJeDcoY66PaNN7VN/CYdqFPMDm6I4OyU6kIF5Yezf
         WX4Q==
X-Gm-Message-State: AOAM53212UpaJal4h9qO7JuteDBbbJv1Sew9TwVbUtqINIMdaVVlqw7C
        wsN32IuCJO1JIFQ515VEkzoKMpP9cMvKPw==
X-Google-Smtp-Source: ABdhPJzwJfUVHKRCK/DeNk+QuItI0x5OihSR/eHxDhWFH0s/DYpMN5Dr/YrmcHdsMDZPixr7/DG91Q==
X-Received: by 2002:a05:600c:3b92:: with SMTP id n18mr19526573wms.69.1627343832588;
        Mon, 26 Jul 2021 16:57:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j2sm1350974wrp.90.2021.07.26.16.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:57:12 -0700 (PDT)
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
Subject: [PATCH] test-lib.sh: use GIT_TEST_COLUMNS over COLUMNS
Date:   Tue, 27 Jul 2021 01:57:09 +0200
Message-Id: <patch-1.1-f81f3911d5-20210726T235452Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g1a6a4b2c5f
In-Reply-To: <CAMMLpeT3bJcr7mRDpxmk32VqpAbNpN=fgPjmkcY+0zOBYruybQ@mail.gmail.com>
References: <CAMMLpeT3bJcr7mRDpxmk32VqpAbNpN=fgPjmkcY+0zOBYruybQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In my c49a177beca (test-lib.sh: set COLUMNS=80 for --verbose
repeatability, 2021-06-29) the test suite started breaking on recent
versions of bash.

This is because it sets "shopt -s checkwinsize" starting with version
5.0, furthermore it started setting COLUMNS under "shopt -s
checkwinsize" for non-interactive use around version 4.3.

A narrow fix for that issue would be to add this just above our
setting of COLUMNS in test-lib.sh:

	shopt -u checkwinsize >/dev/null 2>&1

But we'd then be at the mercy of the next shell or terminal that wants
to be clever about COLUMNS.

Let's instead solve this more thoroughly. We'll now take
GIT_TEST_COLUMNS over COLUMNS, and furthermore intentionally spoil the
COLUMNS variable to break any tests that rely on it being set to a
sane value.

If something breaks because we have a codepath that's not
term_columns() checking COLUMNS we'd like to know about it, the narrow
"shopt -u checkwinsize" fix won't give us that.

The "shopt" fix won't future-poof us against other 3rd party software
changes either. If that third-party software e.g. takes TIOCGWINSZ
over columns on some platforms, our tests would be flaky and break
there even without this change.

This approach does mean that any tests of ours that expected to test
term_columns() behavior by setting COLUMNS will need to explicitly
unset GIT_TEST_COLUMNS, or set it to the empty string. I'm doing the
latter in all the tests changed here.

Reported-by: Fabian Stelzer <fabian.stelzer@campoint.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I was able to reproduce the reported issue, turned out I just needed
to run it with my /bin/bash on debian (it uses dash for /bin/sh by
default).

I wrote this on the 22nd, had a patch queued up, and thought I'd sent
it, but evidently I did not. So here it is, finally.

 pager.c                       |  7 +++++++
 t/t3200-branch.sh             |  8 ++++----
 t/t4052-stat-output.sh        | 22 +++++++++++-----------
 t/t4205-log-pretty-formats.sh |  6 +++---
 t/t7004-tag.sh                |  6 +++---
 t/t7006-pager.sh              |  2 +-
 t/t7508-status.sh             |  4 ++--
 t/t9002-column.sh             | 23 ++++++++++-------------
 t/test-lib.sh                 | 13 +++++++++++--
 9 files changed, 52 insertions(+), 39 deletions(-)

diff --git a/pager.c b/pager.c
index 52f27a6765..cfcc6dc04b 100644
--- a/pager.c
+++ b/pager.c
@@ -165,6 +165,13 @@ int term_columns(void)
 	term_columns_at_startup = 80;
 	term_columns_guessed = 1;
 
+	col_string = getenv("GIT_TEST_COLUMNS");
+	if (col_string && (n_cols = atoi(col_string)) > 0) {
+		term_columns_at_startup = n_cols;
+		term_columns_guessed = 0;
+		return term_columns_at_startup;
+	}
+
 	col_string = getenv("COLUMNS");
 	if (col_string && (n_cols = atoi(col_string)) > 0) {
 		term_columns_at_startup = n_cols;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cc4b10236e..3e0b71a908 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -328,7 +328,7 @@ test_expect_success 'git branch --list -v with --abbrev' '
 '
 
 test_expect_success 'git branch --column' '
-	COLUMNS=81 git branch --column=column >actual &&
+	GIT_TEST_COLUMNS= COLUMNS=81 git branch --column=column >actual &&
 	cat >expect <<\EOF &&
   a/b/c   bam     foo     l     * main    n       o/p     r
   abc     bar     j/k     m/m     mb      o/o     q       topic
@@ -341,7 +341,7 @@ test_expect_success 'git branch --column with an extremely long branch name' '
 	long=z$long/$long/$long/$long &&
 	test_when_finished "git branch -d $long" &&
 	git branch $long &&
-	COLUMNS=80 git branch --column=column >actual &&
+	GIT_TEST_COLUMNS= COLUMNS=80 git branch --column=column >actual &&
 	cat >expect <<EOF &&
   a/b/c
   abc
@@ -367,7 +367,7 @@ EOF
 test_expect_success 'git branch with column.*' '
 	git config column.ui column &&
 	git config column.branch "dense" &&
-	COLUMNS=80 git branch >actual &&
+	GIT_TEST_COLUMNS= COLUMNS=80 git branch >actual &&
 	git config --unset column.branch &&
 	git config --unset column.ui &&
 	cat >expect <<\EOF &&
@@ -383,7 +383,7 @@ test_expect_success 'git branch --column -v should fail' '
 
 test_expect_success 'git branch -v with column.ui ignored' '
 	git config column.ui column &&
-	COLUMNS=80 git branch -v | cut -c -8 | sed "s/ *$//" >actual &&
+	GIT_TEST_COLUMNS= COLUMNS=80 git branch -v | cut -c -8 | sed "s/ *$//" >actual &&
 	git config --unset column.ui &&
 	cat >expect <<\EOF &&
   a/b/c
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 9eba436211..08f8615809 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -111,7 +111,7 @@ cat >expect72 <<'EOF'
  abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
 test_expect_success "format-patch --cover-letter ignores COLUMNS (big change)" '
-	COLUMNS=200 git format-patch -1 --stdout --cover-letter >output &&
+	GIT_TEST_COLUMNS= COLUMNS=200 git format-patch -1 --stdout --cover-letter >output &&
 	grep " | " output >actual &&
 	test_cmp expect72 actual
 '
@@ -131,7 +131,7 @@ EOF
 while read verb expect cmd args
 do
 	test_expect_success "$cmd $verb COLUMNS (big change)" '
-		COLUMNS=200 git $cmd $args >output &&
+		GIT_TEST_COLUMNS= COLUMNS=200 git $cmd $args >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
@@ -139,7 +139,7 @@ do
 	case "$cmd" in diff|show) continue;; esac
 
 	test_expect_success "$cmd --graph $verb COLUMNS (big change)" '
-		COLUMNS=200 git $cmd $args --graph >output &&
+		GIT_TEST_COLUMNS= COLUMNS=200 git $cmd $args --graph >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
 	'
@@ -159,7 +159,7 @@ EOF
 while read verb expect cmd args
 do
 	test_expect_success "$cmd $verb not enough COLUMNS (big change)" '
-		COLUMNS=40 git $cmd $args >output &&
+		GIT_TEST_COLUMNS= COLUMNS=40 git $cmd $args >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
@@ -167,7 +167,7 @@ do
 	case "$cmd" in diff|show) continue;; esac
 
 	test_expect_success "$cmd --graph $verb not enough COLUMNS (big change)" '
-		COLUMNS=40 git $cmd $args --graph >output &&
+		GIT_TEST_COLUMNS= COLUMNS=40 git $cmd $args --graph >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
 	'
@@ -302,7 +302,7 @@ EOF
 while read verb expect cmd args
 do
 	test_expect_success "$cmd $verb COLUMNS (long filename)" '
-		COLUMNS=200 git $cmd $args >output &&
+		GIT_TEST_COLUMNS= COLUMNS=200 git $cmd $args >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
@@ -310,7 +310,7 @@ do
 	case "$cmd" in diff|show) continue;; esac
 
 	test_expect_success "$cmd --graph $verb COLUMNS (long filename)" '
-		COLUMNS=200 git $cmd $args --graph >output &&
+		GIT_TEST_COLUMNS= COLUMNS=200 git $cmd $args --graph >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
 	'
@@ -331,7 +331,7 @@ while read verb expect cmd args
 do
 	test_expect_success COLUMNS_CAN_BE_1 \
 		"$cmd $verb prefix greater than COLUMNS (big change)" '
-		COLUMNS=1 git $cmd $args >output &&
+		GIT_TEST_COLUMNS= COLUMNS=1 git $cmd $args >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
@@ -340,7 +340,7 @@ do
 
 	test_expect_success COLUMNS_CAN_BE_1 \
 		"$cmd --graph $verb prefix greater than COLUMNS (big change)" '
-		COLUMNS=1 git $cmd $args --graph >output &&
+		GIT_TEST_COLUMNS= COLUMNS=1 git $cmd $args --graph >output &&
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
 	'
@@ -356,7 +356,7 @@ cat >expect <<'EOF'
 EOF
 test_expect_success 'merge --stat respects COLUMNS (big change)' '
 	git checkout -b branch HEAD^^ &&
-	COLUMNS=100 git merge --stat --no-ff main^ >output &&
+	GIT_TEST_COLUMNS= COLUMNS=100 git merge --stat --no-ff main^ >output &&
 	grep " | " output >actual &&
 	test_cmp expect actual
 '
@@ -365,7 +365,7 @@ cat >expect <<'EOF'
  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++++++++++++++++++++++++++++++
 EOF
 test_expect_success 'merge --stat respects COLUMNS (long filename)' '
-	COLUMNS=100 git merge --stat --no-ff main >output &&
+	GIT_TEST_COLUMNS= COLUMNS=100 git merge --stat --no-ff main >output &&
 	grep " | " output >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 5865daa8f8..6c8e1b3f1a 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -207,7 +207,7 @@ test_expect_success 'left alignment formatting at the nth column' '
 '
 
 test_expect_success 'left alignment formatting at the nth column' '
-	COLUMNS=50 git log --pretty="tformat:%h %<|(-10)%s" >actual &&
+	GIT_TEST_COLUMNS= COLUMNS=50 git log --pretty="tformat:%h %<|(-10)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	$head1 message two                    Z
 	$head2 message one                    Z
@@ -350,7 +350,7 @@ test_expect_success 'right alignment formatting at the nth column' '
 '
 
 test_expect_success 'right alignment formatting at the nth column' '
-	COLUMNS=50 git log --pretty="tformat:%h %>|(-10)%s" >actual &&
+	GIT_TEST_COLUMNS= COLUMNS=50 git log --pretty="tformat:%h %>|(-10)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	$head1                      message two
 	$head2                      message one
@@ -450,7 +450,7 @@ test_expect_success 'center alignment formatting at the nth column' '
 '
 
 test_expect_success 'center alignment formatting at the nth column' '
-	COLUMNS=70 git log --pretty="tformat:%h %><|(-30)%s" >actual &&
+	GIT_TEST_COLUMNS= COLUMNS=70 git log --pretty="tformat:%h %><|(-30)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	$head1           message two          Z
 	$head2           message one          Z
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 2f72c5c688..1c3d8cfd16 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -372,7 +372,7 @@ test_expect_success 'tag -l <pattern> -l <pattern> works, as our buggy documenta
 '
 
 test_expect_success 'listing tags in column' '
-	COLUMNS=41 git tag -l --column=row >actual &&
+	GIT_TEST_COLUMNS= COLUMNS=41 git tag -l --column=row >actual &&
 	cat >expected <<\EOF &&
 a1      aa1     cba     t210    t211
 v0.2.1  v1.0    v1.0.1  v1.1.3
@@ -383,7 +383,7 @@ EOF
 test_expect_success 'listing tags in column with column.*' '
 	test_config column.tag row &&
 	test_config column.ui dense &&
-	COLUMNS=40 git tag -l >actual &&
+	GIT_TEST_COLUMNS= COLUMNS=40 git tag -l >actual &&
 	cat >expected <<\EOF &&
 a1      aa1   cba     t210    t211
 v0.2.1  v1.0  v1.0.1  v1.1.3
@@ -397,7 +397,7 @@ test_expect_success 'listing tag with -n --column should fail' '
 
 test_expect_success 'listing tags -n in column with column.ui ignored' '
 	test_config column.ui "row dense" &&
-	COLUMNS=40 git tag -l -n >actual &&
+	GIT_TEST_COLUMNS= COLUMNS=40 git tag -l -n >actual &&
 	cat >expected <<\EOF &&
 a1              Foo
 aa1             Foo
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 0e7cf75435..1b116366a3 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -651,7 +651,7 @@ test_expect_success TTY 'git tag with auto-columns ' '
 	cat >expect <<-\EOF &&
 	initial  one      two      three    four     five
 	EOF
-	test_terminal env PAGER="cat >actual" COLUMNS=80 \
+	test_terminal env PAGER="cat >actual" GIT_TEST_COLUMNS= COLUMNS=80 \
 		git -c column.ui=auto tag --sort=authordate &&
 	test_cmp expect actual
 '
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 2b72451ba3..669a3c7150 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -108,13 +108,13 @@ test_expect_success 'status --column' '
 #	dir2/modified  untracked
 #
 EOF
-	COLUMNS=50 git -c status.displayCommentPrefix=true status --column="column dense" >output &&
+	GIT_TEST_COLUMNS= COLUMNS=50 git -c status.displayCommentPrefix=true status --column="column dense" >output &&
 	test_cmp expect output
 '
 
 test_expect_success 'status --column status.displayCommentPrefix=false' '
 	strip_comments expect &&
-	COLUMNS=49 git -c status.displayCommentPrefix=false status --column="column dense" >output &&
+	GIT_TEST_COLUMNS= COLUMNS=49 git -c status.displayCommentPrefix=false status --column="column dense" >output &&
 	test_cmp expect output
 '
 
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
index 89983527b6..50cf3e7b42 100755
--- a/t/t9002-column.sh
+++ b/t/t9002-column.sh
@@ -46,7 +46,7 @@ test_expect_success '80 columns' '
 	cat >expected <<\EOF &&
 one    two    three  four   five   six    seven  eight  nine   ten    eleven
 EOF
-	COLUMNS=80 git column --mode=column <lista >actual &&
+	GIT_TEST_COLUMNS= COLUMNS=80 git column --mode=column <lista >actual &&
 	test_cmp expected actual
 '
 
@@ -65,7 +65,7 @@ eleven
 EOF
 
 test_expect_success COLUMNS_CAN_BE_1 'COLUMNS = 1' '
-	COLUMNS=1 git column --mode=column <lista >actual &&
+	GIT_TEST_COLUMNS= COLUMNS=1 git column --mode=column <lista >actual &&
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
+	GIT_TEST_COLUMNS= COLUMNS=20 git column --mode=column <lista >actual &&
 	test_cmp expected actual
 '
 
@@ -99,7 +96,7 @@ four   ten
 five   eleven
 six
 EOF
-	git column --mode=column,nodense < lista > actual &&
+	GIT_TEST_COLUMNS= COLUMNS=20 git column --mode=column,nodense < lista > actual &&
 	test_cmp expected actual
 '
 
@@ -110,7 +107,7 @@ two   six   ten
 three seven eleven
 four  eight
 EOF
-	git column --mode=column,dense < lista > actual &&
+	GIT_TEST_COLUMNS= COLUMNS=20 git column --mode=column,dense < lista > actual &&
 	test_cmp expected actual
 '
 
@@ -123,7 +120,7 @@ four    ten
 five    eleven
 six
 EOF
-	git column --mode=column --padding 2 <lista >actual &&
+	GIT_TEST_COLUMNS= COLUMNS=20 git column --mode=column --padding 2 <lista >actual &&
 	test_cmp expected actual
 '
 
@@ -136,7 +133,7 @@ test_expect_success '20 columns, indented' '
   five   eleven
   six
 EOF
-	git column --mode=column --indent="  " <lista >actual &&
+	GIT_TEST_COLUMNS= COLUMNS=20 git column --mode=column --indent="  " <lista >actual &&
 	test_cmp expected actual
 '
 
@@ -149,7 +146,7 @@ seven  eight
 nine   ten
 eleven
 EOF
-	git column --mode=row <lista >actual &&
+	GIT_TEST_COLUMNS= COLUMNS=20 git column --mode=row <lista >actual &&
 	test_cmp expected actual
 '
 
@@ -162,7 +159,7 @@ seven  eight
 nine   ten
 eleven
 EOF
-	git column --mode=row,nodense <lista >actual &&
+	GIT_TEST_COLUMNS= COLUMNS=20 git column --mode=row,nodense <lista >actual &&
 	test_cmp expected actual
 '
 
@@ -173,7 +170,7 @@ four  five   six
 seven eight  nine
 ten   eleven
 EOF
-	git column --mode=row,dense <lista >actual &&
+	GIT_TEST_COLUMNS= COLUMNS=20 git column --mode=row,dense <lista >actual &&
 	test_cmp expected actual
 '
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9e26860544..82771643ba 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -406,10 +406,19 @@ LANG=C
 LC_ALL=C
 PAGER=cat
 TZ=UTC
-COLUMNS=80
-export LANG LC_ALL PAGER TZ COLUMNS
+export LANG LC_ALL PAGER TZ
 EDITOR=:
 
+# For repeatability we need to set term_columns()'s idea of
+# columns. We do this via GIT_TEST_COLUMNS and not COLUMNS because
+# e.g. versions of bash >= 5.0 have "shopt -s checkwinsize" on by
+# default. We could do "shopt -u checkwinsize >/dev/null 2>&1" here to
+# fix that particular issue, but this is not shell specific, and
+# future-proof the tests.
+GIT_TEST_COLUMNS=80
+COLUMNS=10
+export GIT_TEST_COLUMNS COLUMNS
+
 # A call to "unset" with no arguments causes at least Solaris 10
 # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
 # deriving from the command substitution clustered with the other
-- 
2.32.0.988.g1a6a4b2c5f

