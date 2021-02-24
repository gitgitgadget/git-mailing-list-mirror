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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FEEC433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A40D564F03
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbhBXTwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhBXTwe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:52:34 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDC6C061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:51:54 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n4so1467829wmq.3
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aZM+XPG0dkYzkhioArq40kjTxoOcw7ADDNSri32xkmE=;
        b=SsBIHGt+mdxvwmhy5P+oT64Dqopg7HY6VnoIAAtAwtwd7pwK/ASj+KQNSDX5m2/CBl
         9cTIzNiWJOTlz8Fkrhm8m29p7aFKahCmjID86yp5/Gj7xR4VKEgrMetn0EFjbDRNp7aa
         y89kj0VXrWCen4l636EMW8zXmjIu48jhDNowKL54RX812wo6sZSJv42zT5eyeZnqnqTv
         qJk7gVd60zs3BzpaH2W36A8BzYt553PcHWg7amQ+7iHe84WxUCDIAtKZ7LXbkFVVlgZO
         e+VVL5zM30Rz9XANiDiHTVVp6Ix+iV3cAXHiIapirSG1OnUBu5BOycyMw2hTz/IACZnK
         7k1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aZM+XPG0dkYzkhioArq40kjTxoOcw7ADDNSri32xkmE=;
        b=ZDpEyRYq9cvxL2rF4SD5ayonEQ2N4hOwYR/pmoCJIsMKB+VZaeKdVw8ryHwg7pe1Gh
         M4Xz3vr0/W3Ou04zA/TVSiQxKohB+ZZ+BZrjmQtTbqIrMeqRM4aFjYJBSOqeqixnQDiX
         Jc6nPoIh5WWIdA/LYGmWjyRxRAYmfyf3x7DrjTlURk4w/iiccL9G2KdbRm7tOhQBu82a
         FuMi2zLVHhPlZv/cmLcaDm8n9PiNDBTFOD4IHTkSjXHa7pAKdzfk4mNXZRl4kSZcHKF0
         mat8lgYJ1se3sIlAyrKfKXMP08njRTEkQHg8RODeeOssaPw+PXw0FIzTkKp+81sRm3ys
         GY9A==
X-Gm-Message-State: AOAM531V4g+OwfmxHbeYZEn1/eGq53m2E6UNKjuWJzxzKnigxSfhBBaK
        lTKa0AN4TRzR59ZqKzgetjxwKOW/sqz/PA==
X-Google-Smtp-Source: ABdhPJxSsO3cl0A8WqC568Z0YrwItfV8BKvS6rW6cpWe1A5Uo7FQYFlgXk1A1rqt6iSQ6CBxEnq/CA==
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr5242611wmy.120.1614196312270;
        Wed, 24 Feb 2021 11:51:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:51:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/35] 20210215154427.32693-1-avarab@gmail.com
Date:   Wed, 24 Feb 2021 20:50:54 +0100
Message-Id: <20210224195129.4004-1-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Addresses feedback on v2. Since Junio & Johannes expressed a desire to
keep the existing test scheme in t4018/* it's still there, but it's
also possible to add *.sh tests in that directory to use the more
familiar test framework used elsewhere in the test suite.

The tests added here make use of it to e.g. supply custom -U<n>
arguments, set config before the tests etc.

I also improved that existing test support so you can have N tests in
one file with (mostly) the existing test syntax. See the "userdiff
tests: add a test with multiple tests in a LANG file" patch.

Range-diff below.

Ævar Arnfjörð Bjarmason (35):
  userdiff: refactor away the parse_bool() function
  userdiff style: re-order drivers in alphabetical order
  userdiff style: declare patterns with consistent style
  userdiff style: normalize pascal regex declaration
  userdiff: add and use for_each_userdiff_driver()
  userdiff tests: explicitly test "default" pattern
  userdiff tests: list builtin drivers via test-tool
  userdiff: remove support for "broken" tests
  blame tests: don't rely on t/t4018/ directory
  blame tests: simplify userdiff driver test
  userdiff tests: match full hunk headers
  userdiff tests: change setup loop to individual test setup
  userdiff tests: factor out test_diff_funcname() logic
  userdiff tests: add alternative hunk header test infrastructure
  userdiff tests: add a test with multiple tests in a LANG file
  userdiff tests: do config teardown in test_diff_funcname()
  userdiff tests: move custom patterns into one test file
  userdiff tests: remove hack for "RIGHT" token
  userdiff tests: do not do compile tests on "custom" pattern
  userdiff tests: assert that new built-in drivers have tests
  userdiff tests + docs: document & test "diff.<driver>.x?funcname"
  gitattributes doc: reword discussion of built-in userdiff patterns
  userdiff tests: move perl tests to perl.sh
  userdiff tests: move away from "RIGHT" in perl.sh
  gitattributes doc: document multi-line userdiff patterns
  userdiff tests: switch to -U0 by default
  userdiff tests: remove "funcname" from custom3 test
  userdiff tests: assert empty hunk header context on -U<large>
  userdiff tests: test for a bug in 1dbf0c0ad6c
  userdiff golang: simplify and correct matching regex
  userdiff golang: don't over-match intented constructs
  userdiff golang: add a rule to match "package"
  userdiff golang: match multi-line "const" and "import"
  userdiff tests: add basic test for ada
  userdiff tests: add basic test for ruby

 Documentation/config/diff.txt              |  11 ++
 Documentation/gitattributes.txt            |  46 ++++-
 Makefile                                   |   1 +
 t/annotate-tests.sh                        |  34 ++--
 t/helper/test-tool.c                       |   1 +
 t/helper/test-tool.h                       |   1 +
 t/helper/test-userdiff.c                   |  31 ++++
 t/t4018-diff-funcname.sh                   | 180 +++++++++++++-------
 t/t4018/README                             |  69 ++++++--
 t/t4018/ada.sh                             |  37 ++++
 t/t4018/bash-arithmetic-function           |   1 +
 t/t4018/bash-bashism-style-compact         |   1 +
 t/t4018/bash-bashism-style-function        |   1 +
 t/t4018/bash-bashism-style-whitespace      |   1 +
 t/t4018/bash-conditional-function          |   1 +
 t/t4018/bash-missing-parentheses           |   1 +
 t/t4018/bash-mixed-style-compact           |   1 +
 t/t4018/bash-mixed-style-function          |   1 +
 t/t4018/bash-nested-functions              |   1 +
 t/t4018/bash-other-characters              |   1 +
 t/t4018/bash-posix-style-compact           |   1 +
 t/t4018/bash-posix-style-function          |   1 +
 t/t4018/bash-posix-style-whitespace        |   1 +
 t/t4018/bash-subshell-function             |   1 +
 t/t4018/bash-trailing-comment              |   1 +
 t/t4018/cpp-c++-function                   |   1 +
 t/t4018/cpp-class-constructor              |   1 +
 t/t4018/cpp-class-constructor-mem-init     |   1 +
 t/t4018/cpp-class-definition               |   1 +
 t/t4018/cpp-class-definition-derived       |   1 +
 t/t4018/cpp-class-destructor               |   1 +
 t/t4018/cpp-function-returning-global-type |   1 +
 t/t4018/cpp-function-returning-nested      |   1 +
 t/t4018/cpp-function-returning-pointer     |   1 +
 t/t4018/cpp-function-returning-reference   |   1 +
 t/t4018/cpp-gnu-style-function             |   1 +
 t/t4018/cpp-namespace-definition           |   1 +
 t/t4018/cpp-operator-definition            |   1 +
 t/t4018/cpp-skip-access-specifiers         |   1 +
 t/t4018/cpp-skip-comment-block             |   1 +
 t/t4018/cpp-skip-labels                    |   1 +
 t/t4018/cpp-struct-definition              |   1 +
 t/t4018/cpp-struct-single-line             |   1 +
 t/t4018/cpp-template-function-definition   |   1 +
 t/t4018/cpp-union-definition               |   1 +
 t/t4018/cpp-void-c-function                |   1 +
 t/t4018/css-attribute-value-selector       |   1 +
 t/t4018/css-block-level-@-statements       |   1 +
 t/t4018/css-brace-in-col-1                 |   1 +
 t/t4018/css-class-selector                 |   1 +
 t/t4018/css-colon-eol                      |   1 +
 t/t4018/css-colon-selector                 |   1 +
 t/t4018/css-common                         |   1 +
 t/t4018/css-id-selector                    |   1 +
 t/t4018/css-long-selector-list             |   1 +
 t/t4018/css-prop-sans-indent               |   1 +
 t/t4018/css-root-selector                  |   1 +
 t/t4018/css-short-selector-list            |   1 +
 t/t4018/css-trailing-space                 |   1 +
 t/t4018/custom.sh                          | 183 ++++++++++++++++++++
 t/t4018/custom1-pattern                    |  17 --
 t/t4018/custom2-match-to-end-of-line       |   8 -
 t/t4018/custom3-alternation-in-pattern     |  17 --
 t/t4018/dts-labels                         |   1 +
 t/t4018/dts-node-unitless                  |   1 +
 t/t4018/dts-nodes                          |   1 +
 t/t4018/dts-nodes-boolean-prop             |   1 +
 t/t4018/dts-nodes-comment1                 |   1 +
 t/t4018/dts-nodes-comment2                 |   1 +
 t/t4018/dts-nodes-multiline-prop           |   1 +
 t/t4018/dts-reference                      |   1 +
 t/t4018/dts-root                           |   1 +
 t/t4018/dts-root-comment                   |   1 +
 t/t4018/elixir-do-not-pick-end             |   1 +
 t/t4018/elixir-ex-unit-test                |   1 +
 t/t4018/elixir-function                    |   1 +
 t/t4018/elixir-macro                       |   1 +
 t/t4018/elixir-module                      |   1 +
 t/t4018/elixir-module-func                 |   1 +
 t/t4018/elixir-nested-module               |   1 +
 t/t4018/elixir-private-function            |   1 +
 t/t4018/elixir-protocol                    |   1 +
 t/t4018/elixir-protocol-implementation     |   1 +
 t/t4018/fortran-block-data                 |   1 +
 t/t4018/fortran-comment                    |   1 +
 t/t4018/fortran-comment-keyword            |   1 +
 t/t4018/fortran-comment-legacy             |   1 +
 t/t4018/fortran-comment-legacy-star        |   1 +
 t/t4018/fortran-external-function          |   1 +
 t/t4018/fortran-external-subroutine        |   1 +
 t/t4018/fortran-module                     |   1 +
 t/t4018/fortran-module-procedure           |   1 +
 t/t4018/fortran-program                    |   1 +
 t/t4018/fountain-scene                     |   1 +
 t/t4018/golang                             | 148 ++++++++++++++++
 t/t4018/golang-complex-function            |   8 -
 t/t4018/golang-func                        |   4 -
 t/t4018/golang-interface                   |   4 -
 t/t4018/golang-long-func                   |   5 -
 t/t4018/golang-struct                      |   4 -
 t/t4018/java-class-member-function         |   1 +
 t/t4018/markdown-heading-indented          |   1 +
 t/t4018/markdown-heading-non-headings      |   1 +
 t/t4018/matlab-class-definition            |   1 +
 t/t4018/matlab-function                    |   1 +
 t/t4018/matlab-octave-section-1            |   1 +
 t/t4018/matlab-octave-section-2            |   1 +
 t/t4018/matlab-section                     |   1 +
 t/t4018/perl-skip-end-of-heredoc           |   8 -
 t/t4018/perl-skip-forward-decl             |  10 --
 t/t4018/perl-skip-sub-in-pod               |  18 --
 t/t4018/perl-sub-definition                |   4 -
 t/t4018/perl-sub-definition-kr-brace       |   4 -
 t/t4018/perl.sh                            |  93 +++++++++++
 t/t4018/php-abstract-class                 |   1 +
 t/t4018/php-abstract-method                |   1 +
 t/t4018/php-class                          |   1 +
 t/t4018/php-final-class                    |   1 +
 t/t4018/php-final-method                   |   1 +
 t/t4018/php-function                       |   1 +
 t/t4018/php-interface                      |   1 +
 t/t4018/php-method                         |   1 +
 t/t4018/php-trait                          |   1 +
 t/t4018/python-async-def                   |   1 +
 t/t4018/python-class                       |   1 +
 t/t4018/python-def                         |   1 +
 t/t4018/python-indented-async-def          |   1 +
 t/t4018/python-indented-class              |   1 +
 t/t4018/python-indented-def                |   1 +
 t/t4018/ruby.sh                            |  58 +++++++
 t/t4018/rust-fn                            |   1 +
 t/t4018/rust-impl                          |   1 +
 t/t4018/rust-macro-rules                   |   1 +
 t/t4018/rust-struct                        |   1 +
 t/t4018/rust-trait                         |   1 +
 userdiff.c                                 | 186 +++++++++++++--------
 userdiff.h                                 |  15 ++
 137 files changed, 1036 insertions(+), 277 deletions(-)
 create mode 100644 t/helper/test-userdiff.c
 create mode 100755 t/t4018/ada.sh
 create mode 100755 t/t4018/custom.sh
 delete mode 100644 t/t4018/custom1-pattern
 delete mode 100644 t/t4018/custom2-match-to-end-of-line
 delete mode 100644 t/t4018/custom3-alternation-in-pattern
 create mode 100644 t/t4018/golang
 delete mode 100644 t/t4018/golang-complex-function
 delete mode 100644 t/t4018/golang-func
 delete mode 100644 t/t4018/golang-interface
 delete mode 100644 t/t4018/golang-long-func
 delete mode 100644 t/t4018/golang-struct
 delete mode 100644 t/t4018/perl-skip-end-of-heredoc
 delete mode 100644 t/t4018/perl-skip-forward-decl
 delete mode 100644 t/t4018/perl-skip-sub-in-pod
 delete mode 100644 t/t4018/perl-sub-definition
 delete mode 100644 t/t4018/perl-sub-definition-kr-brace
 create mode 100755 t/t4018/perl.sh
 create mode 100755 t/t4018/ruby.sh

Range-diff:
 1:  305fc646d0d =  1:  0be132b05e2 userdiff: refactor away the parse_bool() function
 2:  989438c46ae =  2:  d1e00a739ac userdiff style: re-order drivers in alphabetical order
 3:  4c48e5532ce =  3:  b99bd158d45 userdiff style: declare patterns with consistent style
 4:  f41fa5b316f =  4:  9ce6d47021c userdiff style: normalize pascal regex declaration
 5:  0875d5205c1 =  5:  369fbdcee83 userdiff: add and use for_each_userdiff_driver()
 6:  638247d04d5 =  6:  70d62a97211 userdiff tests: explicitly test "default" pattern
 7:  219043a4881 !  7:  792421a2f8b userdiff tests: list builtin drivers via test-tool
    @@ t/helper/test-userdiff.c (new)
     +static int driver_cb(struct userdiff_driver *driver,
     +		     enum userdiff_driver_type type, void *priv)
     +{
    -+	puts(driver->name);
    ++	if (driver->funcname.pattern)
    ++		puts(driver->name);
     +	return 0;
     +}
     +
    @@ t/t4018-diff-funcname.sh: test_description='Test custom diff function name patte
      . ./test-lib.sh
      
      test_expect_success 'setup' '
    -+	builtin_drivers=$(test-tool userdiff list-builtin-drivers) &&
    -+	test -n "$builtin_drivers" &&
    ++	# Make sure additions to builtin_drivers are sorted
    ++	test_when_finished "rm builtin-drivers.sorted" &&
    ++	test-tool userdiff list-builtin-drivers >builtin-drivers &&
    ++	test_file_not_empty builtin-drivers &&
    ++	sort <builtin-drivers >builtin-drivers.sorted &&
    ++	test_cmp builtin-drivers.sorted builtin-drivers &&
     +
      	# a non-trivial custom pattern
      	git config diff.custom1.funcname "!static
    @@ t/t4018-diff-funcname.sh: test_expect_success 'setup' '
     -	rust
     -	tex
     -	default
    -+	$builtin_drivers
    ++	$(cat builtin-drivers)
      	custom1
      	custom2
      	custom3
 8:  eb66160aac7 =  8:  9081e2a152e userdiff: remove support for "broken" tests
 9:  c6c54039e27 <  -:  ----------- userdiff tests: match full hunk headers
10:  1c6ddf96f61 !  9:  d3652f95d5e blame tests: don't rely on t/t4018/ directory
    @@ Commit message
         with userdiff driver, 2020-11-01) so that the blame tests don't rely
         on stealing the contents of "t/t4018/fortran-external-function".
     
    -    I'm about to refactor that directory to delete that file, just moving
    -    the relevant test file here inline is the easiest solution, and I
    -    think also the most readable.
    +    I'm about to change that file in a subsequent commit. Just moving the
    +    relevant test file here inline is the easiest solution, and I think
    +    also the most readable.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
11:  8a883d87990 ! 10:  35d12779ea1 blame tests: simplify userdiff driver test
    @@ Commit message
         added in 999cfc4f45 (test-lib functions: add --author support to
         test_commit, 2021-01-12).
     
    -    We also did not need the full fortran-external-function content, let's
    +    We also did not need the full fortran-external-function content. Let's
         cut it down to just the important parts, and further modify it to
         demonstrate that the fortran-specific userdiff function is in effect
    -    by adding "WRONG" lines surrounding the "RIGHT" one.
    +    by adding "DO NOT MATCH ..." and "AS THE ..." lines surrounding the
    +    "RIGHT" one. This is to check that we're using the userdiff "fortran"
    +    driver, as opposed to the default driver.
     
         The test also left behind a .gitattributes files, let's clean it up
         with "test_when_finished".
    @@ t/annotate-tests.sh: test_expect_success 'blame -L ^:RE (absolute: end-of-file)'
     -	cat >$fortran_file <<-\EOF &&
     +test_expect_success 'blame -L :funcname with userdiff driver' '
     +	cat >file.template <<-\EOF &&
    -+	def WRONG begin end
    ++	DO NOT MATCH THIS LINE
      	function RIGHT(a, b) result(c)
    -+	int WRONG(void) {}
    ++	AS THE DEFAULT DRIVER WOULD
      
      	integer, intent(in) :: ChangeMe
     -	integer, intent(in) :: b
    @@ t/annotate-tests.sh: test_expect_success 'blame -L ^:RE (absolute: end-of-file)'
     +	echo "$fortran_file diff=fortran" >.gitattributes &&
     +
     +	test_commit --author "A <A@test.git>" \
    -+		"add" $fortran_file \
    ++		"add" "$fortran_file" \
     +		"$(cat file.template)" &&
     +	test_commit --author "B <B@test.git>" \
    -+		"change" $fortran_file \
    ++		"change" "$fortran_file" \
     +		"$(cat file.template | sed -e s/ChangeMe/IWasChanged/)" &&
    -+	check_count -f $fortran_file -L:RIGHT A 3 B 1
    ++	check_count -f "$fortran_file" -L:RIGHT A 3 B 1
      '
      
      test_expect_success 'setup incremental' '
12:  e56a7a6b5f4 <  -:  ----------- userdiff tests: rewrite hunk header test infrastructure
 -:  ----------- > 11:  4bd8a0daa25 userdiff tests: match full hunk headers
 -:  ----------- > 12:  d2d74476f2a userdiff tests: change setup loop to individual test setup
21:  9a18506aff8 ! 13:  8db95a69924 userdiff tests: factor out test_diff_funcname() logic
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t4018-diff-funcname.sh ##
    -@@ t/t4018-diff-funcname.sh: test_expect_success 'last regexp must not be negated' '
    - 	test_i18ngrep ": Last expression must not be negated:" msg
    +@@ t/t4018-diff-funcname.sh: test_expect_success 'setup hunk header tests' '
    + 	git -C t4018 add .
      '
      
     +do_change_me () {
    @@ t/t4018-diff-funcname.sh: test_expect_success 'last regexp must not be negated'
     +	sed -n -e "s/^.*@@$//p" -e "s/^.*@@ //p" <$file
     +}
     +
    - test_diff_funcname () {
    - 	desc=$1
    - 	cat <&8 >arg.header &&
    -@@ t/t4018-diff-funcname.sh: test_diff_funcname () {
    - 		cp arg.test "$what" &&
    - 		cp arg.header expected &&
    - 		git add "$what" &&
    --		sed -e "s/ChangeMe/IWasChanged/" <"$what" >tmp &&
    --		mv tmp "$what"
    -+		do_change_me "$what"
    - 	' &&
    + # check each individual file
    + for i in $(git -C t4018 ls-files)
    + do
    +@@ t/t4018-diff-funcname.sh: do
      
    - 	test_expect_success "$desc" '
    - 		git diff -U1 "$what" >diff &&
    --		sed -n -e "s/^.*@@$//p" -e "s/^.*@@ //p" <diff >actual &&
    -+		last_diff_context_line diff >actual &&
    - 		test_cmp expected actual
    - 	' &&
    + 		# add test file to the index
    + 		git add \"$i\" &&
    +-		# place modified file in the worktree
    +-		sed -e 's/ChangeMe/IWasChanged/' <\"t4018/$i.content\" >\"$i\"
    ++		do_change_me \"$i\"
    + 	"
      
    + 	test_expect_success "hunk header: $i" "
    + 		git diff -U1 $i >diff &&
    +-		sed -n -e 's/^.*@@$//p' -e 's/^.*@@ //p' <diff >ctx &&
    ++		last_diff_context_line diff >ctx &&
    + 		test_cmp t4018/$i.header ctx
    + 	"
    + done
 -:  ----------- > 14:  e64a00d020e userdiff tests: add alternative hunk header test infrastructure
 -:  ----------- > 15:  3dab65bf394 userdiff tests: add a test with multiple tests in a LANG file
13:  84d20a7cd0c ! 16:  6eff13d01d3 userdiff tests: do config teardown in test_diff_funcname()
    @@ Commit message
      ## t/t4018-diff-funcname.sh ##
     @@ t/t4018-diff-funcname.sh: test_diff_funcname () {
      		git diff -U1 "$what" >diff &&
    - 		sed -n -e "s/^.*@@$//p" -e "s/^.*@@ //p" <diff >actual &&
    + 		last_diff_context_line diff >actual &&
      		test_cmp expected actual
     +	' &&
     +
14:  70fc9fa565b ! 17:  48f15aed4e4 userdiff tests: move custom patterns into one test file
    @@ Commit message
     
      ## t/t4018-diff-funcname.sh ##
     @@ t/t4018-diff-funcname.sh: test_expect_success 'setup' '
    - 	builtin_drivers=$(test-tool userdiff list-builtin-drivers) &&
    - 	test -n "$builtin_drivers" &&
    + 	sort <builtin-drivers >builtin-drivers.sorted &&
    + 	test_cmp builtin-drivers.sorted builtin-drivers &&
      
     -	# a non-trivial custom pattern
     -	git config diff.custom1.funcname "!static
    @@ t/t4018-diff-funcname.sh: test_expect_success 'setup' '
     @@ t/t4018-diff-funcname.sh: test_expect_success 'setup' '
      
      diffpatterns="
    - 	$builtin_drivers
    + 	$(cat builtin-drivers)
     -	custom1
     -	custom2
     -	custom3
15:  8539d6d464e = 18:  11556fe0967 userdiff tests: remove hack for "RIGHT" token
16:  121e5d6dfaf ! 19:  1b96e89843c userdiff tests: do not do compile tests on "custom" pattern
    @@ t/t4018-diff-funcname.sh: test_expect_success 'setup' '
      '
      
     -diffpatterns="
    --	$builtin_drivers
    +-	$(cat builtin-drivers)
     -	custom
     -"
     -
     -for p in $diffpatterns
    -+for p in $builtin_drivers
    ++for p in $(cat builtin-drivers)
      do
      	test_expect_success "builtin $p pattern compiles" '
      		echo "*.java diff=$p" >.gitattributes &&
    -@@ t/t4018-diff-funcname.sh: test_diff_funcname () {
    - 	'
    - }
    +@@ t/t4018-diff-funcname.sh: test_expect_success 'last regexp must not be negated' '
    + 	test_i18ngrep ": Last expression must not be negated:" msg
    + '
      
    --for what in $diffpatterns
    -+for what in $builtin_drivers custom
    - do
    - 	test="$TEST_DIRECTORY/t4018/$what.sh"
    - 	if ! test -e "$test"
    ++diffpatterns="
    ++	$(cat builtin-drivers)
    ++	custom
    ++"
    ++
    + test_expect_success 'setup hunk header tests' '
    + 	for i in $diffpatterns
    + 	do
 -:  ----------- > 20:  d3cbfc4354d userdiff tests: assert that new built-in drivers have tests
17:  451b7ae453d = 21:  fd6c51ac6db userdiff tests + docs: document & test "diff.<driver>.x?funcname"
18:  5a402bb9bf1 = 22:  43d818be785 gitattributes doc: reword discussion of built-in userdiff patterns
 -:  ----------- > 23:  37d54d77755 userdiff tests: move perl tests to perl.sh
 -:  ----------- > 24:  b6f4f613857 userdiff tests: move away from "RIGHT" in perl.sh
19:  a3badb1a3ee ! 25:  a39ba8e2545 gitattributes doc: document multi-line userdiff patterns
    @@ Documentation/gitattributes.txt: backslashes; the pattern above picks a line tha
     -There are built-in patterns shipped as part of git itself. A more
     -advanced version of the `tex` pattern discussed above is one of them.
     +Multiple patterns can be supplied by listing them one per line
    -+separated by `\n`. They will be matched one at a time from left to
    -+right. Do not supply a trailing "\n" for the last pattern. E.g.:
    ++separated by `\n`. They will be matched one line at a time, e.g.:
     +
     +------------------------
     +[diff "perl"]
     +	xfuncname = "!^=head\n^[^ ]+.*"
     +------------------------
     +
    -+Patterns in in a list of multiple that begin with "!" are negated. A
    -+matching negated pattern will cause the matched line to be
    ++Patterns in a list of multiple patterns that begin with "!" are
    ++negated. A matching negated pattern will cause the matched line to be
     +skipped. Use it to skip a later pattern that would otherwise match. It
     +is an error if one or more negated patterns aren't followed by a
     +non-negated pattern.
    @@ Documentation/gitattributes.txt: backslashes; the pattern above picks a line tha
     +construct that will match a literal "!" without "!" being the first
     +character on that line, such as "[!]".
     +
    ++If the last pattern in a list of multiple patterns ends with "\n" it
    ++will be interpreted as an empty pattern, and will match the first
    ++empty line. It's almost always a logic error to provide a list of
    ++multiple patterns ending with "\n", but it's permitted in case you
    ++genuinely want to match an empty line.
    ++
     +If the pattern contains a `$1` capture it will be used instead of the
     +entire matching line (`$0`) to display the hunk header. This can be
     +used e.g. to strip whitespace from the beginning of the line, or to
    @@ t/t4018/custom.sh: ChangeMe
     +foo
     +EOF_HUNK
     +sub foo;
    ++
     +=head1
    ++
    ++ChangeMe
    ++
    ++EOF_TEST
    ++
    ++test_expect_success 'custom: multiple patterns ending with \n' '
    ++	git config diff.custom.xfuncname "!^=head
    ++^sub ([^;]+)
    ++"
    ++'
    ++
    ++test_diff_funcname 'custom: multiple patterns ending with \n' \
    ++	8<<\EOF_HUNK 9<<\EOF_TEST
    ++
    ++EOF_HUNK
    ++sub foo;
    ++
    ++=head1
    ++
     +ChangeMe
     +
     +EOF_TEST
     
      ## t/t4018/perl.sh ##
    -@@ t/t4018/perl.sh: sub RIGHT
    +@@ t/t4018/perl.sh: sub asub
      	print "ChangeMe\n";
      }
      EOF_TEST
    @@ t/t4018/perl.sh: sub RIGHT
     +EOF_HUNK
     +sub foo;
     +=head1
    -+ChangeMe
     +
    ++ChangeMe
     +EOF_TEST
 -:  ----------- > 26:  27394c6c2a4 userdiff tests: switch to -U0 by default
20:  1b46726e85f = 27:  91ab863a298 userdiff tests: remove "funcname" from custom3 test
22:  24548fb680e <  -:  ----------- userdiff tests: test hunk headers on accumulated files
23:  48f00a59d5e <  -:  ----------- userdiff tests: test hunk header selection with -U0
24:  05a01990c9c ! 28:  b68133ce5f7 userdiff tests: assert empty hunk header context on -U<large>
    @@ Commit message
     
         Assert the existing behavior that under -U<large> we'll show no hunk
         header context, where <large> takes us past the potential hunk header
    -    we'd have extracted. I'm just picking a number over nine thousand as a
    -    really large number we're unlikely to exceed in these tests.
    +    we'd have extracted.
    +
    +    I'm just picking a number over nine thousand as a really large number
    +    we're unlikely to exceed in these tests.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/t4018-diff-funcname.sh: test_diff_funcname () {
      		test_cmp expected actual
      	' &&
      
    -+	test_expect_success "$desc -U9001 (accumulated)" '
    -+		git diff -U9001 "$what".acc >diff &&
    -+		last_diff_context_line diff >actual.lines &&
    -+		tail -n 1 actual.lines >actual &&
    ++	test_expect_success "$desc -U9001" '
    ++		git diff -U9001 "$what" >diff &&
    ++		last_diff_context_line diff >actual &&
     +		echo >blank &&
     +		test_cmp blank actual
     +	' &&
25:  3d2f42d7041 <  -:  ----------- userdiff: match "package" in diff=golang
 -:  ----------- > 29:  9f3a7ca788b userdiff tests: test for a bug in 1dbf0c0ad6c
 -:  ----------- > 30:  43ee24e554b userdiff golang: simplify and correct matching regex
 -:  ----------- > 31:  70a2e7ca70b userdiff golang: don't over-match intented constructs
 -:  ----------- > 32:  6b942cd651b userdiff golang: add a rule to match "package"
 -:  ----------- > 33:  f45d35387d9 userdiff golang: match multi-line "const" and "import"
26:  b2e16ade06c ! 34:  c67c3e160f3 userdiff tests: add basic test for ada
    @@ Commit message
         1. https://rosettacode.org/wiki/99_bottles_of_beer#Ada
         2. https://en.wikibooks.org/wiki/Ada_Programming/Tasking
     
    + ## t/t4018-diff-funcname.sh ##
    +@@ t/t4018-diff-funcname.sh: test_expect_success 'setup' '
    + 	# Do not add anything to this list. New built-in drivers should have
    + 	# tests
    + 	cat >drivers-no-tests <<-\EOF &&
    +-	ada
    + 	bibtex
    + 	csharp
    + 	html
    +
      ## t/t4018/ada.sh (new) ##
     @@
     +#!/bin/sh
27:  826b6f4d6ae ! 35:  e2aedd738ef userdiff tests: add basic test for ruby
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## t/t4018-diff-funcname.sh ##
    +@@ t/t4018-diff-funcname.sh: test_expect_success 'setup' '
    + 	html
    + 	objc
    + 	pascal
    +-	ruby
    + 	tex
    + 	EOF
    + 
    +
      ## t/t4018/ruby.sh (new) ##
     @@
     +#!/bin/sh
    @@ t/t4018/ruby.sh (new)
     +EOF_TEST
     +
     +test_diff_funcname 'ruby: picks first "class/module/def" before changed context' \
    -+	"class Two" \
    ++	'-U1' \
     +	8<<\EOF_HUNK 9<<\EOF_TEST
     +class One
     +EOF_HUNK
-- 
2.30.0.284.gd98b1dd5eaa7

