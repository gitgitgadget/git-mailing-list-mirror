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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF144C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 13:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99C8060FF2
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 13:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbhHBNq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 09:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbhHBNqo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 09:46:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8663C06179A
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 06:46:32 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n11so10463619wmd.2
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 06:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pUQXYqYgIYMG6p3WpeMl3RZOc5n6vYS5WRtOZeR7yJE=;
        b=flxjDEcXcFFVH6Gt/Bo6LO3bObpVnxo6Wsf8C3ulgbgQGgnFfxZq2XhTSUK4f/v2lE
         p+FXoBjiMf+CkWNS0MoVnn0TJx0Rcc3bXPOIa4EazyYNuxC6qNl9iQrCcDyMccANWklj
         RUoVJbaexpnW61iDjr8CwucieyvlgJQ5UWHPwURECNk4umF8LJHN8KQJWIlNfHZhx7zX
         ZOXud46GzCCIhtG0MoFn9tTD2mvc1cvz8OjIblb6+VXng29tbXBtpWVs8RWUXr9TnwAP
         vSLDp9v75vRlNTj34rCYp3ZchI2qPwW2UmfIUUnOarfrsBaJLlLF9quzM/eRWUYgIZia
         cEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pUQXYqYgIYMG6p3WpeMl3RZOc5n6vYS5WRtOZeR7yJE=;
        b=Su/EWFyM+Ql32PHA5bRwjRrUk+xvEZtm2ebmC9BFvxHQuNnAbXqQHi6qU5XnCE3afA
         g9VPvrOsTMYaUUqMDr2V8sXpDWcNc/yj3IjjtTO2sTxHumxc2IHR4kIP6Like1xoMosc
         D4ycD0ImpEcyKT1QUoIsLizGmzLMrN9hKECJ15ewWQDJcCLXyIBMqHfIz5NFWNmO2Poi
         pmZUPWCz/TO0dHyTdhlbMttqRBt2IESoMUUMHJfJ+JQwQ4c5kTBNjnMGp+VTFf6RO41w
         xTSu4C8dKo1teISK5pS0fF4Rtw61UZUCrgVs7LFu3lev0vsshswtE1j6MdeZfelqy6AG
         6nfg==
X-Gm-Message-State: AOAM532G8IxKBm7hGrFIDVjid+5cSYqk3zjtYXpygTXRhLlkBgpKKerI
        pZIqpHvxSvOd7AeoQZVJfi9pEpCYukPdYw==
X-Google-Smtp-Source: ABdhPJxQyrymhEoK9LaJ686Yxk/wMEQtR7Jnw4jaASQ1N/tE2B8l2PO9kgeqsHjZrqNEgYz92PwcBQ==
X-Received: by 2002:a1c:9a93:: with SMTP id c141mr17279773wme.28.1627911990653;
        Mon, 02 Aug 2021 06:46:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b14sm11549003wrm.43.2021.08.02.06.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 06:46:30 -0700 (PDT)
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
Subject: [PATCH v2 0/3] test-lib.sh: use GIT_TEST_COLUMNS over COLUMNS
Date:   Mon,  2 Aug 2021 15:46:25 +0200
Message-Id: <cover-v2-0.3-00000000000-20210802T134610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.1070.gec115ccd780
In-Reply-To: <patch-1.1-f81f3911d5-20210726T235452Z-avarab@gmail.com>
References: <patch-1.1-f81f3911d5-20210726T235452Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A v2 which should address the comments on v1, the large search-replace
of existing COLUMN uses in the tests is now a separate step.

The below range-diff is rather confusing because the v1 1/1 is now
mostly attributed to this new split-out commit, as a result it looks
like most of the commit message is being deleted, but it's in fact
there mostly in 3/3. I just re-worded the last paragraph a bit.

Ævar Arnfjörð Bjarmason (3):
  test-lib-functions.sh: rename test_must_fail_acceptable()
  test-lib-functions.sh: add a test_with_columns function
  test-lib.sh: use GIT_TEST_COLUMNS over COLUMNS

 pager.c                       |  7 +++++++
 t/t3200-branch.sh             |  8 ++++----
 t/t4052-stat-output.sh        | 22 +++++++++++-----------
 t/t4205-log-pretty-formats.sh |  6 +++---
 t/t7004-tag.sh                |  6 +++---
 t/t7006-pager.sh              |  2 +-
 t/t7508-status.sh             |  4 ++--
 t/t9002-column.sh             | 23 ++++++++++-------------
 t/test-lib-functions.sh       | 21 ++++++++++++++++++---
 t/test-lib.sh                 | 13 +++++++++++--
 10 files changed, 70 insertions(+), 42 deletions(-)

Range-diff against v1:
-:  ----------- > 1:  739457b992f test-lib-functions.sh: rename test_must_fail_acceptable()
1:  f81f3911d52 ! 2:  36c57178c55 test-lib.sh: use GIT_TEST_COLUMNS over COLUMNS
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    test-lib.sh: use GIT_TEST_COLUMNS over COLUMNS
    +    test-lib-functions.sh: add a test_with_columns function
     
    -    In my c49a177beca (test-lib.sh: set COLUMNS=80 for --verbose
    -    repeatability, 2021-06-29) the test suite started breaking on recent
    -    versions of bash.
    +    Add a helper function to wrap patterns of "COLUMNS=N <command>" as
    +    "test_with_columns N <command>". This will be used and extended in the
    +    next commit.
     
    -    This is because it sets "shopt -s checkwinsize" starting with version
    -    5.0, furthermore it started setting COLUMNS under "shopt -s
    -    checkwinsize" for non-interactive use around version 4.3.
    -
    -    A narrow fix for that issue would be to add this just above our
    -    setting of COLUMNS in test-lib.sh:
    -
    -            shopt -u checkwinsize >/dev/null 2>&1
    -
    -    But we'd then be at the mercy of the next shell or terminal that wants
    -    to be clever about COLUMNS.
    -
    -    Let's instead solve this more thoroughly. We'll now take
    -    GIT_TEST_COLUMNS over COLUMNS, and furthermore intentionally spoil the
    -    COLUMNS variable to break any tests that rely on it being set to a
    -    sane value.
    -
    -    If something breaks because we have a codepath that's not
    -    term_columns() checking COLUMNS we'd like to know about it, the narrow
    -    "shopt -u checkwinsize" fix won't give us that.
    -
    -    The "shopt" fix won't future-poof us against other 3rd party software
    -    changes either. If that third-party software e.g. takes TIOCGWINSZ
    -    over columns on some platforms, our tests would be flaky and break
    -    there even without this change.
    -
    -    This approach does mean that any tests of ours that expected to test
    -    term_columns() behavior by setting COLUMNS will need to explicitly
    -    unset GIT_TEST_COLUMNS, or set it to the empty string. I'm doing the
    -    latter in all the tests changed here.
    -
    -    Reported-by: Fabian Stelzer <fabian.stelzer@campoint.net>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## pager.c ##
    -@@ pager.c: int term_columns(void)
    - 	term_columns_at_startup = 80;
    - 	term_columns_guessed = 1;
    - 
    -+	col_string = getenv("GIT_TEST_COLUMNS");
    -+	if (col_string && (n_cols = atoi(col_string)) > 0) {
    -+		term_columns_at_startup = n_cols;
    -+		term_columns_guessed = 0;
    -+		return term_columns_at_startup;
    -+	}
    -+
    - 	col_string = getenv("COLUMNS");
    - 	if (col_string && (n_cols = atoi(col_string)) > 0) {
    - 		term_columns_at_startup = n_cols;
    -
      ## t/t3200-branch.sh ##
     @@ t/t3200-branch.sh: test_expect_success 'git branch --list -v with --abbrev' '
      '
      
      test_expect_success 'git branch --column' '
     -	COLUMNS=81 git branch --column=column >actual &&
    -+	GIT_TEST_COLUMNS= COLUMNS=81 git branch --column=column >actual &&
    ++	test_with_columns 81 git branch --column=column >actual &&
      	cat >expect <<\EOF &&
        a/b/c   bam     foo     l     * main    n       o/p     r
        abc     bar     j/k     m/m     mb      o/o     q       topic
    @@ t/t3200-branch.sh: test_expect_success 'git branch --column with an extremely lo
      	test_when_finished "git branch -d $long" &&
      	git branch $long &&
     -	COLUMNS=80 git branch --column=column >actual &&
    -+	GIT_TEST_COLUMNS= COLUMNS=80 git branch --column=column >actual &&
    ++	test_with_columns 80 git branch --column=column >actual &&
      	cat >expect <<EOF &&
        a/b/c
        abc
    @@ t/t3200-branch.sh: EOF
      	git config column.ui column &&
      	git config column.branch "dense" &&
     -	COLUMNS=80 git branch >actual &&
    -+	GIT_TEST_COLUMNS= COLUMNS=80 git branch >actual &&
    ++	test_with_columns 80 git branch >actual &&
      	git config --unset column.branch &&
      	git config --unset column.ui &&
      	cat >expect <<\EOF &&
    @@ t/t3200-branch.sh: test_expect_success 'git branch --column -v should fail' '
      test_expect_success 'git branch -v with column.ui ignored' '
      	git config column.ui column &&
     -	COLUMNS=80 git branch -v | cut -c -8 | sed "s/ *$//" >actual &&
    -+	GIT_TEST_COLUMNS= COLUMNS=80 git branch -v | cut -c -8 | sed "s/ *$//" >actual &&
    ++	test_with_columns 80 git branch -v | cut -c -8 | sed "s/ *$//" >actual &&
      	git config --unset column.ui &&
      	cat >expect <<\EOF &&
        a/b/c
    @@ t/t4052-stat-output.sh: cat >expect72 <<'EOF'
      EOF
      test_expect_success "format-patch --cover-letter ignores COLUMNS (big change)" '
     -	COLUMNS=200 git format-patch -1 --stdout --cover-letter >output &&
    -+	GIT_TEST_COLUMNS= COLUMNS=200 git format-patch -1 --stdout --cover-letter >output &&
    ++	test_with_columns 200 git format-patch -1 --stdout --cover-letter >output &&
      	grep " | " output >actual &&
      	test_cmp expect72 actual
      '
    @@ t/t4052-stat-output.sh: EOF
      do
      	test_expect_success "$cmd $verb COLUMNS (big change)" '
     -		COLUMNS=200 git $cmd $args >output &&
    -+		GIT_TEST_COLUMNS= COLUMNS=200 git $cmd $args >output &&
    ++		test_with_columns 200 git $cmd $args >output &&
      		grep " | " output >actual &&
      		test_cmp "$expect" actual
      	'
    @@ t/t4052-stat-output.sh: do
      
      	test_expect_success "$cmd --graph $verb COLUMNS (big change)" '
     -		COLUMNS=200 git $cmd $args --graph >output &&
    -+		GIT_TEST_COLUMNS= COLUMNS=200 git $cmd $args --graph >output &&
    ++		test_with_columns 200 git $cmd $args --graph >output &&
      		grep " | " output >actual &&
      		test_cmp "$expect-graph" actual
      	'
    @@ t/t4052-stat-output.sh: EOF
      do
      	test_expect_success "$cmd $verb not enough COLUMNS (big change)" '
     -		COLUMNS=40 git $cmd $args >output &&
    -+		GIT_TEST_COLUMNS= COLUMNS=40 git $cmd $args >output &&
    ++		test_with_columns 40 git $cmd $args >output &&
      		grep " | " output >actual &&
      		test_cmp "$expect" actual
      	'
    @@ t/t4052-stat-output.sh: do
      
      	test_expect_success "$cmd --graph $verb not enough COLUMNS (big change)" '
     -		COLUMNS=40 git $cmd $args --graph >output &&
    -+		GIT_TEST_COLUMNS= COLUMNS=40 git $cmd $args --graph >output &&
    ++		test_with_columns 40 git $cmd $args --graph >output &&
      		grep " | " output >actual &&
      		test_cmp "$expect-graph" actual
      	'
    @@ t/t4052-stat-output.sh: EOF
      do
      	test_expect_success "$cmd $verb COLUMNS (long filename)" '
     -		COLUMNS=200 git $cmd $args >output &&
    -+		GIT_TEST_COLUMNS= COLUMNS=200 git $cmd $args >output &&
    ++		test_with_columns 200 git $cmd $args >output &&
      		grep " | " output >actual &&
      		test_cmp "$expect" actual
      	'
    @@ t/t4052-stat-output.sh: do
      
      	test_expect_success "$cmd --graph $verb COLUMNS (long filename)" '
     -		COLUMNS=200 git $cmd $args --graph >output &&
    -+		GIT_TEST_COLUMNS= COLUMNS=200 git $cmd $args --graph >output &&
    ++		test_with_columns 200 git $cmd $args --graph >output &&
      		grep " | " output >actual &&
      		test_cmp "$expect-graph" actual
      	'
    @@ t/t4052-stat-output.sh: while read verb expect cmd args
      	test_expect_success COLUMNS_CAN_BE_1 \
      		"$cmd $verb prefix greater than COLUMNS (big change)" '
     -		COLUMNS=1 git $cmd $args >output &&
    -+		GIT_TEST_COLUMNS= COLUMNS=1 git $cmd $args >output &&
    ++		test_with_columns 1 git $cmd $args >output &&
      		grep " | " output >actual &&
      		test_cmp "$expect" actual
      	'
    @@ t/t4052-stat-output.sh: do
      	test_expect_success COLUMNS_CAN_BE_1 \
      		"$cmd --graph $verb prefix greater than COLUMNS (big change)" '
     -		COLUMNS=1 git $cmd $args --graph >output &&
    -+		GIT_TEST_COLUMNS= COLUMNS=1 git $cmd $args --graph >output &&
    ++		test_with_columns 1 git $cmd $args --graph >output &&
      		grep " | " output >actual &&
      		test_cmp "$expect-graph" actual
      	'
    @@ t/t4052-stat-output.sh: cat >expect <<'EOF'
      test_expect_success 'merge --stat respects COLUMNS (big change)' '
      	git checkout -b branch HEAD^^ &&
     -	COLUMNS=100 git merge --stat --no-ff main^ >output &&
    -+	GIT_TEST_COLUMNS= COLUMNS=100 git merge --stat --no-ff main^ >output &&
    ++	test_with_columns 100 git merge --stat --no-ff main^ >output &&
      	grep " | " output >actual &&
      	test_cmp expect actual
      '
    @@ t/t4052-stat-output.sh: cat >expect <<'EOF'
      EOF
      test_expect_success 'merge --stat respects COLUMNS (long filename)' '
     -	COLUMNS=100 git merge --stat --no-ff main >output &&
    -+	GIT_TEST_COLUMNS= COLUMNS=100 git merge --stat --no-ff main >output &&
    ++	test_with_columns 100 git merge --stat --no-ff main >output &&
      	grep " | " output >actual &&
      	test_cmp expect actual
      '
    @@ t/t4205-log-pretty-formats.sh: test_expect_success 'left alignment formatting at
      
      test_expect_success 'left alignment formatting at the nth column' '
     -	COLUMNS=50 git log --pretty="tformat:%h %<|(-10)%s" >actual &&
    -+	GIT_TEST_COLUMNS= COLUMNS=50 git log --pretty="tformat:%h %<|(-10)%s" >actual &&
    ++	test_with_columns 50 git log --pretty="tformat:%h %<|(-10)%s" >actual &&
      	qz_to_tab_space <<-EOF >expected &&
      	$head1 message two                    Z
      	$head2 message one                    Z
    @@ t/t4205-log-pretty-formats.sh: test_expect_success 'right alignment formatting a
      
      test_expect_success 'right alignment formatting at the nth column' '
     -	COLUMNS=50 git log --pretty="tformat:%h %>|(-10)%s" >actual &&
    -+	GIT_TEST_COLUMNS= COLUMNS=50 git log --pretty="tformat:%h %>|(-10)%s" >actual &&
    ++	test_with_columns 50 git log --pretty="tformat:%h %>|(-10)%s" >actual &&
      	qz_to_tab_space <<-EOF >expected &&
      	$head1                      message two
      	$head2                      message one
    @@ t/t4205-log-pretty-formats.sh: test_expect_success 'center alignment formatting
      
      test_expect_success 'center alignment formatting at the nth column' '
     -	COLUMNS=70 git log --pretty="tformat:%h %><|(-30)%s" >actual &&
    -+	GIT_TEST_COLUMNS= COLUMNS=70 git log --pretty="tformat:%h %><|(-30)%s" >actual &&
    ++	test_with_columns 70 git log --pretty="tformat:%h %><|(-30)%s" >actual &&
      	qz_to_tab_space <<-EOF >expected &&
      	$head1           message two          Z
      	$head2           message one          Z
    @@ t/t7004-tag.sh: test_expect_success 'tag -l <pattern> -l <pattern> works, as our
      
      test_expect_success 'listing tags in column' '
     -	COLUMNS=41 git tag -l --column=row >actual &&
    -+	GIT_TEST_COLUMNS= COLUMNS=41 git tag -l --column=row >actual &&
    ++	test_with_columns 41 git tag -l --column=row >actual &&
      	cat >expected <<\EOF &&
      a1      aa1     cba     t210    t211
      v0.2.1  v1.0    v1.0.1  v1.1.3
    @@ t/t7004-tag.sh: EOF
      	test_config column.tag row &&
      	test_config column.ui dense &&
     -	COLUMNS=40 git tag -l >actual &&
    -+	GIT_TEST_COLUMNS= COLUMNS=40 git tag -l >actual &&
    ++	test_with_columns 40 git tag -l >actual &&
      	cat >expected <<\EOF &&
      a1      aa1   cba     t210    t211
      v0.2.1  v1.0  v1.0.1  v1.1.3
    @@ t/t7004-tag.sh: test_expect_success 'listing tag with -n --column should fail' '
      test_expect_success 'listing tags -n in column with column.ui ignored' '
      	test_config column.ui "row dense" &&
     -	COLUMNS=40 git tag -l -n >actual &&
    -+	GIT_TEST_COLUMNS= COLUMNS=40 git tag -l -n >actual &&
    ++	test_with_columns 40 git tag -l -n >actual &&
      	cat >expected <<\EOF &&
      a1              Foo
      aa1             Foo
    @@ t/t7006-pager.sh: test_expect_success TTY 'git tag with auto-columns ' '
      	initial  one      two      three    four     five
      	EOF
     -	test_terminal env PAGER="cat >actual" COLUMNS=80 \
    -+	test_terminal env PAGER="cat >actual" GIT_TEST_COLUMNS= COLUMNS=80 \
    ++	test_with_columns 80 test_terminal env PAGER="cat >actual" \
      		git -c column.ui=auto tag --sort=authordate &&
      	test_cmp expect actual
      '
    @@ t/t7508-status.sh: test_expect_success 'status --column' '
      #
      EOF
     -	COLUMNS=50 git -c status.displayCommentPrefix=true status --column="column dense" >output &&
    -+	GIT_TEST_COLUMNS= COLUMNS=50 git -c status.displayCommentPrefix=true status --column="column dense" >output &&
    ++	test_with_columns 50 git -c status.displayCommentPrefix=true status --column="column dense" >output &&
      	test_cmp expect output
      '
      
      test_expect_success 'status --column status.displayCommentPrefix=false' '
      	strip_comments expect &&
     -	COLUMNS=49 git -c status.displayCommentPrefix=false status --column="column dense" >output &&
    -+	GIT_TEST_COLUMNS= COLUMNS=49 git -c status.displayCommentPrefix=false status --column="column dense" >output &&
    ++	test_with_columns 49 git -c status.displayCommentPrefix=false status --column="column dense" >output &&
      	test_cmp expect output
      '
      
    @@ t/t9002-column.sh: test_expect_success '80 columns' '
      one    two    three  four   five   six    seven  eight  nine   ten    eleven
      EOF
     -	COLUMNS=80 git column --mode=column <lista >actual &&
    -+	GIT_TEST_COLUMNS= COLUMNS=80 git column --mode=column <lista >actual &&
    ++	test_with_columns 80 git column --mode=column <lista >actual &&
      	test_cmp expected actual
      '
      
    @@ t/t9002-column.sh: eleven
      
      test_expect_success COLUMNS_CAN_BE_1 'COLUMNS = 1' '
     -	COLUMNS=1 git column --mode=column <lista >actual &&
    -+	GIT_TEST_COLUMNS= COLUMNS=1 git column --mode=column <lista >actual &&
    ++	test_with_columns 1 git column --mode=column <lista >actual &&
      	test_cmp expected actual
      '
      
    @@ t/t9002-column.sh: four   ten
      six
      EOF
     -	git column --mode=column <lista >actual &&
    -+	GIT_TEST_COLUMNS= COLUMNS=20 git column --mode=column <lista >actual &&
    ++	test_with_columns 20 git column --mode=column <lista >actual &&
      	test_cmp expected actual
      '
      
    @@ t/t9002-column.sh: four   ten
      six
      EOF
     -	git column --mode=column,nodense < lista > actual &&
    -+	GIT_TEST_COLUMNS= COLUMNS=20 git column --mode=column,nodense < lista > actual &&
    ++	test_with_columns 20 git column --mode=column,nodense < lista > actual &&
      	test_cmp expected actual
      '
      
    @@ t/t9002-column.sh: two   six   ten
      four  eight
      EOF
     -	git column --mode=column,dense < lista > actual &&
    -+	GIT_TEST_COLUMNS= COLUMNS=20 git column --mode=column,dense < lista > actual &&
    ++	test_with_columns 20 git column --mode=column,dense < lista > actual &&
      	test_cmp expected actual
      '
      
    @@ t/t9002-column.sh: four    ten
      six
      EOF
     -	git column --mode=column --padding 2 <lista >actual &&
    -+	GIT_TEST_COLUMNS= COLUMNS=20 git column --mode=column --padding 2 <lista >actual &&
    ++	test_with_columns 20 git column --mode=column --padding 2 <lista >actual &&
      	test_cmp expected actual
      '
      
    @@ t/t9002-column.sh: test_expect_success '20 columns, indented' '
        six
      EOF
     -	git column --mode=column --indent="  " <lista >actual &&
    -+	GIT_TEST_COLUMNS= COLUMNS=20 git column --mode=column --indent="  " <lista >actual &&
    ++	test_with_columns 20 git column --mode=column --indent="  " <lista >actual &&
      	test_cmp expected actual
      '
      
    @@ t/t9002-column.sh: seven  eight
      eleven
      EOF
     -	git column --mode=row <lista >actual &&
    -+	GIT_TEST_COLUMNS= COLUMNS=20 git column --mode=row <lista >actual &&
    ++	test_with_columns 20 git column --mode=row <lista >actual &&
      	test_cmp expected actual
      '
      
    @@ t/t9002-column.sh: seven  eight
      eleven
      EOF
     -	git column --mode=row,nodense <lista >actual &&
    -+	GIT_TEST_COLUMNS= COLUMNS=20 git column --mode=row,nodense <lista >actual &&
    ++	test_with_columns 20 git column --mode=row,nodense <lista >actual &&
      	test_cmp expected actual
      '
      
    @@ t/t9002-column.sh: four  five   six
      ten   eleven
      EOF
     -	git column --mode=row,dense <lista >actual &&
    -+	GIT_TEST_COLUMNS= COLUMNS=20 git column --mode=row,dense <lista >actual &&
    ++	test_with_columns 20 git column --mode=row,dense <lista >actual &&
      	test_cmp expected actual
      '
      
     
    - ## t/test-lib.sh ##
    -@@ t/test-lib.sh: LANG=C
    - LC_ALL=C
    - PAGER=cat
    - TZ=UTC
    --COLUMNS=80
    --export LANG LC_ALL PAGER TZ COLUMNS
    -+export LANG LC_ALL PAGER TZ
    - EDITOR=:
    - 
    -+# For repeatability we need to set term_columns()'s idea of
    -+# columns. We do this via GIT_TEST_COLUMNS and not COLUMNS because
    -+# e.g. versions of bash >= 5.0 have "shopt -s checkwinsize" on by
    -+# default. We could do "shopt -u checkwinsize >/dev/null 2>&1" here to
    -+# fix that particular issue, but this is not shell specific, and
    -+# future-proof the tests.
    -+GIT_TEST_COLUMNS=80
    -+COLUMNS=10
    -+export GIT_TEST_COLUMNS COLUMNS
    + ## t/test-lib-functions.sh ##
    +@@ t/test-lib-functions.sh: test_region () {
    + test_readlink () {
    + 	perl -le 'print readlink($_) for @ARGV' "$@"
    + }
    ++
    ++# Test a with a given number of COLUMNS in the environment.
    ++test_with_columns () {
    ++	local columns=$1
    ++	shift
     +
    - # A call to "unset" with no arguments causes at least Solaris 10
    - # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
    - # deriving from the command substitution clustered with the other
    ++	COLUMNS=$columns "$@"
    ++}
-:  ----------- > 3:  6cbbb955e9a test-lib.sh: use GIT_TEST_COLUMNS over COLUMNS
-- 
2.32.0.1070.gec115ccd780

