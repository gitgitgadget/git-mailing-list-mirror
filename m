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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71BAC433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75FD964EDD
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbhBXTyU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbhBXTxV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:53:21 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213D4C0617AA
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:04 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t15so3022328wrx.13
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=144Eodcd+A9WrB2tmeZVO93cvJvYYmqQn5GkjRq1+a8=;
        b=enNd6E6org3bwhQy/I/oxH24icx46laFz7nEgtQNcH4H8Aw3o6kNGmJT7gLseD0vuy
         n/F8hrRHgx8blRB948jv5CU2sPf/0aeFfnN2/8BfC7EglP6TgXx/npXcz3OoXryINmU0
         LTM0HRTD45NpodjNQC/g3H5tpSiiC9UZLC9yLhhT+eoKbCXTCUhQQd0sNAQllJg8v8gR
         YI/bDVZPH5/DjI3zzodp9tM3ttdfi/Q6M5bFoVzv8g899siof7L6X5cvzDQ3SJJvKYXa
         +pDBTW/za0nDKAM3s5wELxG5M7C1IAx3i5wdSisb/NIMJtRXMAyqnL3WY+ifn2/7Fazy
         YAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=144Eodcd+A9WrB2tmeZVO93cvJvYYmqQn5GkjRq1+a8=;
        b=Ym9wM/7TPF9DxtHgnrlLJPDStrKQqb1rlrnBZJDsCky+dXLPCQIx3Na+tlgUk9CZcA
         LiCcvwwkyVT89nCaA8PH0Y9c5RrnPw6IyzUcBTYmNSrqkjqbJhpOPhfhW0T+cAgbVc/r
         l6ynlK4Kmze25n/iWVM2THuKW8BxpN7ws8dZzNLnludwxEMoyVLYMMuBk8gSXU49UoCm
         oRXUQlO1Pe7g9psuBZavqGa8Gw2xkgQtUhYHFk0m5icZJ9awqLmSy98O/6Qo7+IoD4/Y
         NUKC23u7oghdMjgezN2VntIHHPQBTvgRxUeQzJEMpeNHY9PoyTXb+b/wbG+2WMAi75BB
         PPhg==
X-Gm-Message-State: AOAM532SRqV7o7P6qGeOdREJA7K+lpVoX52vwU4I7Tr1SUa2FpEMdvv3
        RKYAmjM9cEE4MIsW428fMaO6k4or8XlodA==
X-Google-Smtp-Source: ABdhPJzAcFTj88Gn2MzrcZMpaCtc+QWMEQULVnbRtEhsMaFOY5MU00338Rol5RhVDtWyklVEjIgIsg==
X-Received: by 2002:a5d:6706:: with SMTP id o6mr25784584wru.235.1614196321699;
        Wed, 24 Feb 2021 11:52:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:01 -0800 (PST)
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
Subject: [PATCH v3 11/35] userdiff tests: match full hunk headers
Date:   Wed, 24 Feb 2021 20:51:05 +0100
Message-Id: <20210224195129.4004-12-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in the test framework for userdiff added in
bfa7d01413 (t4018: an infrastructure to test hunk headers,
2014-03-21).

The testing infrastructure added in that change went overboard with
simplifying the tests, to the point where we lost test coverage.

Before that we'd been able to test the full context line, or ever
since the feature was originally added in f258475a6e (Per-path
attribute based hunk header selection., 2007-07-06).

After bfa7d01413 all we cared about was whether "RIGHT" appeared on
the line. We thus lost the information about whether or not "RIGHT"
was extracted from the line for the hunk header, or the line appeared
in full (or other subset of the line).

Let's bring back coverage for that by extending the custom test syntax
here to understand "t4018" control lines, we grep those out before
doing the add/diff, and understand "t4018 header: " lines to declare
the full context line we're expecting.

Now when we have failures we'll benefit from the full test_cmp output,
instead of just getting a non-zero exit code from "grep".

The "sed -n -e" here was originally a single 's/^.*@@\( \|$\)//p'
pattern, but the '\( \|$\)' part had portability issues on OSX and
AIX.

The one-off addition of headers here to the test files was done by
instrumenting the test itself:

    grep '@@ .* @@.*RIGHT' actual >header.right &&
    sed 's/^@@.*@@ //' header.right >$i.header.small &&
    mv \"$TEST_DIRECTORY\"/t4018/$i tmp &&
    printf 't4018 header: ' >\"$TEST_DIRECTORY\"/t4018/$i &&
    cat $i.header.small >> \"$TEST_DIRECTORY\"/t4018/$i &&
    cat tmp >>\"$TEST_DIRECTORY\"/t4018/$i

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh                   | 27 +++++++++++++---------
 t/t4018/README                             | 25 ++++++++++++--------
 t/t4018/bash-arithmetic-function           |  1 +
 t/t4018/bash-bashism-style-compact         |  1 +
 t/t4018/bash-bashism-style-function        |  1 +
 t/t4018/bash-bashism-style-whitespace      |  1 +
 t/t4018/bash-conditional-function          |  1 +
 t/t4018/bash-missing-parentheses           |  1 +
 t/t4018/bash-mixed-style-compact           |  1 +
 t/t4018/bash-mixed-style-function          |  1 +
 t/t4018/bash-nested-functions              |  1 +
 t/t4018/bash-other-characters              |  1 +
 t/t4018/bash-posix-style-compact           |  1 +
 t/t4018/bash-posix-style-function          |  1 +
 t/t4018/bash-posix-style-whitespace        |  1 +
 t/t4018/bash-subshell-function             |  1 +
 t/t4018/bash-trailing-comment              |  1 +
 t/t4018/cpp-c++-function                   |  1 +
 t/t4018/cpp-class-constructor              |  1 +
 t/t4018/cpp-class-constructor-mem-init     |  1 +
 t/t4018/cpp-class-definition               |  1 +
 t/t4018/cpp-class-definition-derived       |  1 +
 t/t4018/cpp-class-destructor               |  1 +
 t/t4018/cpp-function-returning-global-type |  1 +
 t/t4018/cpp-function-returning-nested      |  1 +
 t/t4018/cpp-function-returning-pointer     |  1 +
 t/t4018/cpp-function-returning-reference   |  1 +
 t/t4018/cpp-gnu-style-function             |  1 +
 t/t4018/cpp-namespace-definition           |  1 +
 t/t4018/cpp-operator-definition            |  1 +
 t/t4018/cpp-skip-access-specifiers         |  1 +
 t/t4018/cpp-skip-comment-block             |  1 +
 t/t4018/cpp-skip-labels                    |  1 +
 t/t4018/cpp-struct-definition              |  1 +
 t/t4018/cpp-struct-single-line             |  1 +
 t/t4018/cpp-template-function-definition   |  1 +
 t/t4018/cpp-union-definition               |  1 +
 t/t4018/cpp-void-c-function                |  1 +
 t/t4018/css-attribute-value-selector       |  1 +
 t/t4018/css-block-level-@-statements       |  1 +
 t/t4018/css-brace-in-col-1                 |  1 +
 t/t4018/css-class-selector                 |  1 +
 t/t4018/css-colon-eol                      |  1 +
 t/t4018/css-colon-selector                 |  1 +
 t/t4018/css-common                         |  1 +
 t/t4018/css-id-selector                    |  1 +
 t/t4018/css-long-selector-list             |  1 +
 t/t4018/css-prop-sans-indent               |  1 +
 t/t4018/css-root-selector                  |  1 +
 t/t4018/css-short-selector-list            |  1 +
 t/t4018/css-trailing-space                 |  1 +
 t/t4018/custom1-pattern                    |  1 +
 t/t4018/custom2-match-to-end-of-line       |  1 +
 t/t4018/custom3-alternation-in-pattern     |  1 +
 t/t4018/dts-labels                         |  1 +
 t/t4018/dts-node-unitless                  |  1 +
 t/t4018/dts-nodes                          |  1 +
 t/t4018/dts-nodes-boolean-prop             |  1 +
 t/t4018/dts-nodes-comment1                 |  1 +
 t/t4018/dts-nodes-comment2                 |  1 +
 t/t4018/dts-nodes-multiline-prop           |  1 +
 t/t4018/dts-reference                      |  1 +
 t/t4018/dts-root                           |  1 +
 t/t4018/dts-root-comment                   |  1 +
 t/t4018/elixir-do-not-pick-end             |  1 +
 t/t4018/elixir-ex-unit-test                |  1 +
 t/t4018/elixir-function                    |  1 +
 t/t4018/elixir-macro                       |  1 +
 t/t4018/elixir-module                      |  1 +
 t/t4018/elixir-module-func                 |  1 +
 t/t4018/elixir-nested-module               |  1 +
 t/t4018/elixir-private-function            |  1 +
 t/t4018/elixir-protocol                    |  1 +
 t/t4018/elixir-protocol-implementation     |  1 +
 t/t4018/fortran-block-data                 |  1 +
 t/t4018/fortran-comment                    |  1 +
 t/t4018/fortran-comment-keyword            |  1 +
 t/t4018/fortran-comment-legacy             |  1 +
 t/t4018/fortran-comment-legacy-star        |  1 +
 t/t4018/fortran-external-function          |  1 +
 t/t4018/fortran-external-subroutine        |  1 +
 t/t4018/fortran-module                     |  1 +
 t/t4018/fortran-module-procedure           |  1 +
 t/t4018/fortran-program                    |  1 +
 t/t4018/fountain-scene                     |  1 +
 t/t4018/golang-complex-function            |  1 +
 t/t4018/golang-func                        |  1 +
 t/t4018/golang-interface                   |  1 +
 t/t4018/golang-long-func                   |  1 +
 t/t4018/golang-struct                      |  1 +
 t/t4018/java-class-member-function         |  1 +
 t/t4018/markdown-heading-indented          |  1 +
 t/t4018/markdown-heading-non-headings      |  1 +
 t/t4018/matlab-class-definition            |  1 +
 t/t4018/matlab-function                    |  1 +
 t/t4018/matlab-octave-section-1            |  1 +
 t/t4018/matlab-octave-section-2            |  1 +
 t/t4018/matlab-section                     |  1 +
 t/t4018/perl-skip-end-of-heredoc           |  1 +
 t/t4018/perl-skip-forward-decl             |  1 +
 t/t4018/perl-skip-sub-in-pod               |  1 +
 t/t4018/perl-sub-definition                |  1 +
 t/t4018/perl-sub-definition-kr-brace       |  1 +
 t/t4018/php-abstract-class                 |  1 +
 t/t4018/php-abstract-method                |  1 +
 t/t4018/php-class                          |  1 +
 t/t4018/php-final-class                    |  1 +
 t/t4018/php-final-method                   |  1 +
 t/t4018/php-function                       |  1 +
 t/t4018/php-interface                      |  1 +
 t/t4018/php-method                         |  1 +
 t/t4018/php-trait                          |  1 +
 t/t4018/python-async-def                   |  1 +
 t/t4018/python-class                       |  1 +
 t/t4018/python-def                         |  1 +
 t/t4018/python-indented-async-def          |  1 +
 t/t4018/python-indented-class              |  1 +
 t/t4018/python-indented-def                |  1 +
 t/t4018/rust-fn                            |  1 +
 t/t4018/rust-impl                          |  1 +
 t/t4018/rust-macro-rules                   |  1 +
 t/t4018/rust-struct                        |  1 +
 t/t4018/rust-trait                         |  1 +
 123 files changed, 153 insertions(+), 20 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 9aec9f8e6de..15dcbe735ca 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -70,16 +70,20 @@ test_expect_success 'setup hunk header tests' '
 		echo "$i-* diff=$i"
 	done > .gitattributes &&
 
-	# add all test files to the index
-	(
-		cd "$TEST_DIRECTORY"/t4018 &&
-		git --git-dir="$TRASH_DIRECTORY/.git" add .
-	) &&
-
-	# place modified files in the worktree
-	for i in $(git ls-files)
+	cp -R "$TEST_DIRECTORY"/t4018 . &&
+	git init t4018 &&
+	git -C t4018 add . &&
+
+	for i in $(git -C t4018 ls-files)
 	do
-		sed -e "s/ChangeMe/IWasChanged/" <"$TEST_DIRECTORY/t4018/$i" >"$i" || return 1
+		grep -v "^t4018" "t4018/$i" >"t4018/$i.content" &&
+		sed -n -e "s/^t4018 header: //p" <"t4018/$i" >"t4018/$i.header" &&
+		cp "t4018/$i.content" "$i" &&
+
+		# add test file to the index
+		git add "$i" &&
+		# place modified file in the worktree
+		sed -e "s/ChangeMe/IWasChanged/" <"t4018/$i.content" >"$i" || return 1
 	done
 '
 
@@ -87,8 +91,9 @@ test_expect_success 'setup hunk header tests' '
 for i in $(git ls-files)
 do
 	test_expect_success "hunk header: $i" "
-		git diff -U1 $i >actual &&
-		grep '@@ .* @@.*RIGHT' actual
+		git diff -U1 $i >diff &&
+		sed -n -e 's/^.*@@$//p' -e 's/^.*@@ //p' <diff >ctx &&
+		test_cmp t4018/$i.header ctx
 	"
 done
 
diff --git a/t/t4018/README b/t/t4018/README
index 2d25b2b4fc9..0a246bbc10e 100644
--- a/t/t4018/README
+++ b/t/t4018/README
@@ -1,15 +1,22 @@
-How to write RIGHT test cases
-=============================
+t4018 header: description of the test.
+How to write test cases
+=======================
+
+Create test cases called "LANG-whatever" in this directory, where
+"LANG" is e.g. the userdiff driver name, where "whatever" is a brief
+description of the test.
 
 Insert the word "ChangeMe" (exactly this form) at a distance of
 at least two lines from the line that must appear in the hunk header.
 
-The text that must appear in the hunk header must contain the word
-"right", but in all upper-case, like in the title above.
+Any line starting with "t4018" is a control line for the test:
 
-This text is a bit twisted and out of order, but it is itself a
-test case for the default hunk header pattern. Know what you are doing
-if you change it.
+ - The "t4018 header:" line above specifies what text must appear in
+   the hunk header. We strip away the starting "@@ [...] @@" part of
+   the line for ease of not having to hardcode the line numbers and
+   offsets.
 
-BTW, this tests that the head line goes to the hunk header, not the line
-of equal signs.
+In many of the test cases the header line includes the token "RIGHT",
+this used to be part of the test syntax, but isn't anymore. Now we
+care about the "t4018 header:" line, not whatever line contains a
+"RIGHT" token.
diff --git a/t/t4018/bash-arithmetic-function b/t/t4018/bash-arithmetic-function
index c0b276cb50f..f5609bf49eb 100644
--- a/t/t4018/bash-arithmetic-function
+++ b/t/t4018/bash-arithmetic-function
@@ -1,3 +1,4 @@
+t4018 header: RIGHT()
 RIGHT() ((
 
     ChangeMe = "$x" + "$y"
diff --git a/t/t4018/bash-bashism-style-compact b/t/t4018/bash-bashism-style-compact
index 1ca3126f611..42611aad166 100644
--- a/t/t4018/bash-bashism-style-compact
+++ b/t/t4018/bash-bashism-style-compact
@@ -1,3 +1,4 @@
+t4018 header: function RIGHT {
 function RIGHT {
     function InvalidSyntax{
         :
diff --git a/t/t4018/bash-bashism-style-function b/t/t4018/bash-bashism-style-function
index f1de4fa831c..823b13a463b 100644
--- a/t/t4018/bash-bashism-style-function
+++ b/t/t4018/bash-bashism-style-function
@@ -1,3 +1,4 @@
+t4018 header: function RIGHT {
 function RIGHT {
     :
     echo 'ChangeMe'
diff --git a/t/t4018/bash-bashism-style-whitespace b/t/t4018/bash-bashism-style-whitespace
index ade85dd3a50..4f1add4a4e5 100644
--- a/t/t4018/bash-bashism-style-whitespace
+++ b/t/t4018/bash-bashism-style-whitespace
@@ -1,3 +1,4 @@
+t4018 header: function 	RIGHT 	( 	) 	{
 	 function 	RIGHT 	( 	) 	{
 
 	    ChangeMe
diff --git a/t/t4018/bash-conditional-function b/t/t4018/bash-conditional-function
index c5949e829ba..1e71a71a320 100644
--- a/t/t4018/bash-conditional-function
+++ b/t/t4018/bash-conditional-function
@@ -1,3 +1,4 @@
+t4018 header: RIGHT()
 RIGHT() [[ \
 
     "$a" > "$ChangeMe"
diff --git a/t/t4018/bash-missing-parentheses b/t/t4018/bash-missing-parentheses
index 8c8a05dd7ab..9233042d91f 100644
--- a/t/t4018/bash-missing-parentheses
+++ b/t/t4018/bash-missing-parentheses
@@ -1,3 +1,4 @@
+t4018 header: function RIGHT {
 function RIGHT {
     functionInvalidSyntax {
         :
diff --git a/t/t4018/bash-mixed-style-compact b/t/t4018/bash-mixed-style-compact
index d9364cba671..0f93c2be55a 100644
--- a/t/t4018/bash-mixed-style-compact
+++ b/t/t4018/bash-mixed-style-compact
@@ -1,3 +1,4 @@
+t4018 header: function RIGHT(){
 function RIGHT(){
     :
     echo 'ChangeMe'
diff --git a/t/t4018/bash-mixed-style-function b/t/t4018/bash-mixed-style-function
index 555f9b24667..b3024cdc6dc 100644
--- a/t/t4018/bash-mixed-style-function
+++ b/t/t4018/bash-mixed-style-function
@@ -1,3 +1,4 @@
+t4018 header: function RIGHT() {
 function RIGHT() {
 
     ChangeMe
diff --git a/t/t4018/bash-nested-functions b/t/t4018/bash-nested-functions
index 2c9237ead42..1eee6b9a830 100644
--- a/t/t4018/bash-nested-functions
+++ b/t/t4018/bash-nested-functions
@@ -1,3 +1,4 @@
+t4018 header: RIGHT()
 outer() {
     RIGHT() {
         :
diff --git a/t/t4018/bash-other-characters b/t/t4018/bash-other-characters
index a3f390d525d..02fa1ec822d 100644
--- a/t/t4018/bash-other-characters
+++ b/t/t4018/bash-other-characters
@@ -1,3 +1,4 @@
+t4018 header: _RIGHT_0n()
 _RIGHT_0n() {
 
     ChangeMe
diff --git a/t/t4018/bash-posix-style-compact b/t/t4018/bash-posix-style-compact
index 045bd2029b7..7ba61dea663 100644
--- a/t/t4018/bash-posix-style-compact
+++ b/t/t4018/bash-posix-style-compact
@@ -1,3 +1,4 @@
+t4018 header: RIGHT()
 RIGHT(){
 
     ChangeMe
diff --git a/t/t4018/bash-posix-style-function b/t/t4018/bash-posix-style-function
index a4d144856e9..8566c3f3838 100644
--- a/t/t4018/bash-posix-style-function
+++ b/t/t4018/bash-posix-style-function
@@ -1,3 +1,4 @@
+t4018 header: RIGHT()
 RIGHT() {
 
     ChangeMe
diff --git a/t/t4018/bash-posix-style-whitespace b/t/t4018/bash-posix-style-whitespace
index 4d984f0aa4d..dcc06da3f67 100644
--- a/t/t4018/bash-posix-style-whitespace
+++ b/t/t4018/bash-posix-style-whitespace
@@ -1,3 +1,4 @@
+t4018 header: RIGHT 	( 	)
 	 RIGHT 	( 	) 	{
 
 	    ChangeMe
diff --git a/t/t4018/bash-subshell-function b/t/t4018/bash-subshell-function
index 80baa09484e..f6b188679a2 100644
--- a/t/t4018/bash-subshell-function
+++ b/t/t4018/bash-subshell-function
@@ -1,3 +1,4 @@
+t4018 header: RIGHT()
 RIGHT() (
 
     ChangeMe=2
diff --git a/t/t4018/bash-trailing-comment b/t/t4018/bash-trailing-comment
index f1edbeda319..16ba9701f3f 100644
--- a/t/t4018/bash-trailing-comment
+++ b/t/t4018/bash-trailing-comment
@@ -1,3 +1,4 @@
+t4018 header: RIGHT()
 RIGHT() { # Comment
 
     ChangeMe
diff --git a/t/t4018/cpp-c++-function b/t/t4018/cpp-c++-function
index 9ee6bbef557..316ad0eb34f 100644
--- a/t/t4018/cpp-c++-function
+++ b/t/t4018/cpp-c++-function
@@ -1,3 +1,4 @@
+t4018 header: Item RIGHT::DoSomething( Args with_spaces )
 Item RIGHT::DoSomething( Args with_spaces )
 {
 	ChangeMe;
diff --git a/t/t4018/cpp-class-constructor b/t/t4018/cpp-class-constructor
index ec4f115c250..38552023f00 100644
--- a/t/t4018/cpp-class-constructor
+++ b/t/t4018/cpp-class-constructor
@@ -1,3 +1,4 @@
+t4018 header: Item::Item(int RIGHT)
 Item::Item(int RIGHT)
 {
 	ChangeMe;
diff --git a/t/t4018/cpp-class-constructor-mem-init b/t/t4018/cpp-class-constructor-mem-init
index 49a69f37e16..dc48c12ac25 100644
--- a/t/t4018/cpp-class-constructor-mem-init
+++ b/t/t4018/cpp-class-constructor-mem-init
@@ -1,3 +1,4 @@
+t4018 header: Item::Item(int RIGHT) :
 Item::Item(int RIGHT) :
 	member(0)
 {
diff --git a/t/t4018/cpp-class-definition b/t/t4018/cpp-class-definition
index 11b61da3b75..1f258c8f980 100644
--- a/t/t4018/cpp-class-definition
+++ b/t/t4018/cpp-class-definition
@@ -1,3 +1,4 @@
+t4018 header: class RIGHT
 class RIGHT
 {
 	int ChangeMe;
diff --git a/t/t4018/cpp-class-definition-derived b/t/t4018/cpp-class-definition-derived
index 3b98cd09ab5..1e5ec3b4837 100644
--- a/t/t4018/cpp-class-definition-derived
+++ b/t/t4018/cpp-class-definition-derived
@@ -1,3 +1,4 @@
+t4018 header: class RIGHT :
 class RIGHT :
 	public Baseclass
 {
diff --git a/t/t4018/cpp-class-destructor b/t/t4018/cpp-class-destructor
index 54876650965..a06a37169ad 100644
--- a/t/t4018/cpp-class-destructor
+++ b/t/t4018/cpp-class-destructor
@@ -1,3 +1,4 @@
+t4018 header: RIGHT::~RIGHT()
 RIGHT::~RIGHT()
 {
 	ChangeMe;
diff --git a/t/t4018/cpp-function-returning-global-type b/t/t4018/cpp-function-returning-global-type
index 1084d5990ef..9bb8f57474f 100644
--- a/t/t4018/cpp-function-returning-global-type
+++ b/t/t4018/cpp-function-returning-global-type
@@ -1,3 +1,4 @@
+t4018 header: ::Item get::it::RIGHT()
 ::Item get::it::RIGHT()
 {
 	ChangeMe;
diff --git a/t/t4018/cpp-function-returning-nested b/t/t4018/cpp-function-returning-nested
index d9750aa61a5..3a35a39816a 100644
--- a/t/t4018/cpp-function-returning-nested
+++ b/t/t4018/cpp-function-returning-nested
@@ -1,3 +1,4 @@
+t4018 header: get::Item get::it::RIGHT()
 get::Item get::it::RIGHT()
 {
 	ChangeMe;
diff --git a/t/t4018/cpp-function-returning-pointer b/t/t4018/cpp-function-returning-pointer
index ef15657ea8f..9890c5488db 100644
--- a/t/t4018/cpp-function-returning-pointer
+++ b/t/t4018/cpp-function-returning-pointer
@@ -1,3 +1,4 @@
+t4018 header: const char *get_it_RIGHT(char *ptr)
 const char *get_it_RIGHT(char *ptr)
 {
 	ChangeMe;
diff --git a/t/t4018/cpp-function-returning-reference b/t/t4018/cpp-function-returning-reference
index 01b051df701..7147ab9a74d 100644
--- a/t/t4018/cpp-function-returning-reference
+++ b/t/t4018/cpp-function-returning-reference
@@ -1,3 +1,4 @@
+t4018 header: string& get::it::RIGHT(char *ptr)
 string& get::it::RIGHT(char *ptr)
 {
 	ChangeMe;
diff --git a/t/t4018/cpp-gnu-style-function b/t/t4018/cpp-gnu-style-function
index 08c7c7565ae..91e243f3869 100644
--- a/t/t4018/cpp-gnu-style-function
+++ b/t/t4018/cpp-gnu-style-function
@@ -1,3 +1,4 @@
+t4018 header: RIGHT(int arg)
 const char *
 RIGHT(int arg)
 {
diff --git a/t/t4018/cpp-namespace-definition b/t/t4018/cpp-namespace-definition
index 6749980241c..bd32988b3f9 100644
--- a/t/t4018/cpp-namespace-definition
+++ b/t/t4018/cpp-namespace-definition
@@ -1,3 +1,4 @@
+t4018 header: namespace RIGHT
 namespace RIGHT
 {
 	ChangeMe;
diff --git a/t/t4018/cpp-operator-definition b/t/t4018/cpp-operator-definition
index 1acd8271592..7e8ba945281 100644
--- a/t/t4018/cpp-operator-definition
+++ b/t/t4018/cpp-operator-definition
@@ -1,3 +1,4 @@
+t4018 header: Value operator+(Value LEFT, Value RIGHT)
 Value operator+(Value LEFT, Value RIGHT)
 {
 	ChangeMe;
diff --git a/t/t4018/cpp-skip-access-specifiers b/t/t4018/cpp-skip-access-specifiers
index 4d4a9dbb9db..d61c86d3703 100644
--- a/t/t4018/cpp-skip-access-specifiers
+++ b/t/t4018/cpp-skip-access-specifiers
@@ -1,3 +1,4 @@
+t4018 header: class RIGHT : public Baseclass
 class RIGHT : public Baseclass
 {
 public:
diff --git a/t/t4018/cpp-skip-comment-block b/t/t4018/cpp-skip-comment-block
index 3800b9967a5..ea4d9c25911 100644
--- a/t/t4018/cpp-skip-comment-block
+++ b/t/t4018/cpp-skip-comment-block
@@ -1,3 +1,4 @@
+t4018 header: struct item RIGHT(int i)
 struct item RIGHT(int i)
 // Do not
 // pick up
diff --git a/t/t4018/cpp-skip-labels b/t/t4018/cpp-skip-labels
index b9c10aba225..cf508647281 100644
--- a/t/t4018/cpp-skip-labels
+++ b/t/t4018/cpp-skip-labels
@@ -1,3 +1,4 @@
+t4018 header: void RIGHT (void)
 void RIGHT (void)
 {
 repeat:		// C++ comment
diff --git a/t/t4018/cpp-struct-definition b/t/t4018/cpp-struct-definition
index 521c59fd151..a0f9a16204d 100644
--- a/t/t4018/cpp-struct-definition
+++ b/t/t4018/cpp-struct-definition
@@ -1,3 +1,4 @@
+t4018 header: struct RIGHT {
 struct RIGHT {
 	unsigned
 	/* this bit field looks like a label and should not be picked up */
diff --git a/t/t4018/cpp-struct-single-line b/t/t4018/cpp-struct-single-line
index a0de5fb800f..0d2378a320a 100644
--- a/t/t4018/cpp-struct-single-line
+++ b/t/t4018/cpp-struct-single-line
@@ -1,3 +1,4 @@
+t4018 header: struct RIGHT_iterator_tag {};
 void wrong()
 {
 }
diff --git a/t/t4018/cpp-template-function-definition b/t/t4018/cpp-template-function-definition
index 0cdf5ba5bd4..f1ea1e54f5a 100644
--- a/t/t4018/cpp-template-function-definition
+++ b/t/t4018/cpp-template-function-definition
@@ -1,3 +1,4 @@
+t4018 header: template<class T> int RIGHT(T arg)
 template<class T> int RIGHT(T arg)
 {
 	ChangeMe;
diff --git a/t/t4018/cpp-union-definition b/t/t4018/cpp-union-definition
index 7ec94df6973..6c00ab3b430 100644
--- a/t/t4018/cpp-union-definition
+++ b/t/t4018/cpp-union-definition
@@ -1,3 +1,4 @@
+t4018 header: union RIGHT {
 union RIGHT {
 	double v;
 	int ChangeMe;
diff --git a/t/t4018/cpp-void-c-function b/t/t4018/cpp-void-c-function
index 153081e872c..08765096c96 100644
--- a/t/t4018/cpp-void-c-function
+++ b/t/t4018/cpp-void-c-function
@@ -1,3 +1,4 @@
+t4018 header: void RIGHT (void)
 void RIGHT (void)
 {
 	ChangeMe;
diff --git a/t/t4018/css-attribute-value-selector b/t/t4018/css-attribute-value-selector
index 918256b20c5..8fe8429eb02 100644
--- a/t/t4018/css-attribute-value-selector
+++ b/t/t4018/css-attribute-value-selector
@@ -1,3 +1,4 @@
+t4018 header: [class*="RIGHT"] {
 [class*="RIGHT"] {
     background : #000;
     border : 10px ChangeMe #C6C6C6;
diff --git a/t/t4018/css-block-level-@-statements b/t/t4018/css-block-level-@-statements
index d6755f2f3db..0ea1b9eb37c 100644
--- a/t/t4018/css-block-level-@-statements
+++ b/t/t4018/css-block-level-@-statements
@@ -1,3 +1,4 @@
+t4018 header: @keyframes RIGHT {
 @keyframes RIGHT {
     from {
         background : #000;
diff --git a/t/t4018/css-brace-in-col-1 b/t/t4018/css-brace-in-col-1
index 7831577506a..8bc58ce7098 100644
--- a/t/t4018/css-brace-in-col-1
+++ b/t/t4018/css-brace-in-col-1
@@ -1,3 +1,4 @@
+t4018 header: RIGHT label.control-label
 RIGHT label.control-label
 {
     margin-top: 10px!important;
diff --git a/t/t4018/css-class-selector b/t/t4018/css-class-selector
index f790a0062f4..9b7a2b80e72 100644
--- a/t/t4018/css-class-selector
+++ b/t/t4018/css-class-selector
@@ -1,3 +1,4 @@
+t4018 header: .RIGHT {
 .RIGHT {
     background : #000;
     border : 10px ChangeMe #C6C6C6;
diff --git a/t/t4018/css-colon-eol b/t/t4018/css-colon-eol
index 5a30553d291..665c9f6af5b 100644
--- a/t/t4018/css-colon-eol
+++ b/t/t4018/css-colon-eol
@@ -1,3 +1,4 @@
+t4018 header: RIGHT h1 {
 RIGHT h1 {
 color:
 ChangeMe;
diff --git a/t/t4018/css-colon-selector b/t/t4018/css-colon-selector
index c6d71fb42de..dd0e897155f 100644
--- a/t/t4018/css-colon-selector
+++ b/t/t4018/css-colon-selector
@@ -1,3 +1,4 @@
+t4018 header: RIGHT a:hover {
 RIGHT a:hover {
     margin-top:
     10px!important;
diff --git a/t/t4018/css-common b/t/t4018/css-common
index 84ed754b33b..8351eac792b 100644
--- a/t/t4018/css-common
+++ b/t/t4018/css-common
@@ -1,3 +1,4 @@
+t4018 header: RIGHT label.control-label {
 RIGHT label.control-label {
     margin-top: 10px!important;
     border : 10px ChangeMe #C6C6C6;
diff --git a/t/t4018/css-id-selector b/t/t4018/css-id-selector
index 17c5111052d..2a4351a4f0b 100644
--- a/t/t4018/css-id-selector
+++ b/t/t4018/css-id-selector
@@ -1,3 +1,4 @@
+t4018 header: #RIGHT {
 #RIGHT {
     background : #000;
     border : 10px ChangeMe #C6C6C6;
diff --git a/t/t4018/css-long-selector-list b/t/t4018/css-long-selector-list
index 7ccd25d9ed6..e5fba459290 100644
--- a/t/t4018/css-long-selector-list
+++ b/t/t4018/css-long-selector-list
@@ -1,3 +1,4 @@
+t4018 header: div ul#RIGHT {
 p.header,
 label.control-label,
 div ul#RIGHT {
diff --git a/t/t4018/css-prop-sans-indent b/t/t4018/css-prop-sans-indent
index a9e3c86b3c9..8ca742c91f8 100644
--- a/t/t4018/css-prop-sans-indent
+++ b/t/t4018/css-prop-sans-indent
@@ -1,3 +1,4 @@
+t4018 header: RIGHT, label.control-label {
 RIGHT, label.control-label {
 margin-top: 10px!important;
 padding: 0;
diff --git a/t/t4018/css-root-selector b/t/t4018/css-root-selector
index 22b958e3694..327d7630649 100644
--- a/t/t4018/css-root-selector
+++ b/t/t4018/css-root-selector
@@ -1,3 +1,4 @@
+t4018 header: :RIGHT {
 :RIGHT {
     background : #000;
     border : 10px ChangeMe #C6C6C6;
diff --git a/t/t4018/css-short-selector-list b/t/t4018/css-short-selector-list
index 6a0bdee336b..8a8937a5bd8 100644
--- a/t/t4018/css-short-selector-list
+++ b/t/t4018/css-short-selector-list
@@ -1,3 +1,4 @@
+t4018 header: label.control, div ul#RIGHT {
 label.control, div ul#RIGHT {
     margin-top: 10px!important;
     border : 10px ChangeMe #C6C6C6;
diff --git a/t/t4018/css-trailing-space b/t/t4018/css-trailing-space
index 32b5606c70f..68956baab70 100644
--- a/t/t4018/css-trailing-space
+++ b/t/t4018/css-trailing-space
@@ -1,3 +1,4 @@
+t4018 header: RIGHT label.control-label {
 RIGHT label.control-label {
     margin:10px;   
     padding:10px;
diff --git a/t/t4018/custom1-pattern b/t/t4018/custom1-pattern
index e8fd59f884d..37a3422384b 100644
--- a/t/t4018/custom1-pattern
+++ b/t/t4018/custom1-pattern
@@ -1,3 +1,4 @@
+t4018 header: int special, RIGHT;
 public class Beer
 {
 	int special, RIGHT;
diff --git a/t/t4018/custom2-match-to-end-of-line b/t/t4018/custom2-match-to-end-of-line
index f88ac318b79..4800bb1c568 100644
--- a/t/t4018/custom2-match-to-end-of-line
+++ b/t/t4018/custom2-match-to-end-of-line
@@ -1,3 +1,4 @@
+t4018 header: RIGHT_Beer
 public class RIGHT_Beer
 {
 	int special;
diff --git a/t/t4018/custom3-alternation-in-pattern b/t/t4018/custom3-alternation-in-pattern
index 5f3769c64fc..bf7df3d9a73 100644
--- a/t/t4018/custom3-alternation-in-pattern
+++ b/t/t4018/custom3-alternation-in-pattern
@@ -1,3 +1,4 @@
+t4018 header: public static void main(String RIGHT[])
 public class Beer
 {
 	int special;
diff --git a/t/t4018/dts-labels b/t/t4018/dts-labels
index b21ef8737bb..6b907dcdedf 100644
--- a/t/t4018/dts-labels
+++ b/t/t4018/dts-labels
@@ -1,3 +1,4 @@
+t4018 header: label2: RIGHT {
 / {
 	label_1: node1@ff00 {
 		label2: RIGHT {
diff --git a/t/t4018/dts-node-unitless b/t/t4018/dts-node-unitless
index c5287d91416..990730ef6f4 100644
--- a/t/t4018/dts-node-unitless
+++ b/t/t4018/dts-node-unitless
@@ -1,3 +1,4 @@
+t4018 header: RIGHT {
 / {
 	label_1: node1 {
 		RIGHT {
diff --git a/t/t4018/dts-nodes b/t/t4018/dts-nodes
index 5a4334bb164..4bcebc85e60 100644
--- a/t/t4018/dts-nodes
+++ b/t/t4018/dts-nodes
@@ -1,3 +1,4 @@
+t4018 header: RIGHT@deadf00,4000 {
 / {
 	label_1: node1@ff00 {
 		RIGHT@deadf00,4000 {
diff --git a/t/t4018/dts-nodes-boolean-prop b/t/t4018/dts-nodes-boolean-prop
index afc6b5b404e..404cab6f0e1 100644
--- a/t/t4018/dts-nodes-boolean-prop
+++ b/t/t4018/dts-nodes-boolean-prop
@@ -1,3 +1,4 @@
+t4018 header: RIGHT@deadf00,4000 {
 / {
 	label_1: node1@ff00 {
 		RIGHT@deadf00,4000 {
diff --git a/t/t4018/dts-nodes-comment1 b/t/t4018/dts-nodes-comment1
index 559dfce9b30..2e5cea26818 100644
--- a/t/t4018/dts-nodes-comment1
+++ b/t/t4018/dts-nodes-comment1
@@ -1,3 +1,4 @@
+t4018 header: RIGHT@deadf00,4000 /* &a comment */ {
 / {
 	label_1: node1@ff00 {
 		RIGHT@deadf00,4000 /* &a comment */ {
diff --git a/t/t4018/dts-nodes-comment2 b/t/t4018/dts-nodes-comment2
index 27e9718b31c..f6cc3177958 100644
--- a/t/t4018/dts-nodes-comment2
+++ b/t/t4018/dts-nodes-comment2
@@ -1,3 +1,4 @@
+t4018 header: RIGHT@deadf00,4000 { /* a trailing comment */
 / {
 	label_1: node1@ff00 {
 		RIGHT@deadf00,4000 { /* a trailing comment */ 
diff --git a/t/t4018/dts-nodes-multiline-prop b/t/t4018/dts-nodes-multiline-prop
index 072d58b69dc..ac07b404975 100644
--- a/t/t4018/dts-nodes-multiline-prop
+++ b/t/t4018/dts-nodes-multiline-prop
@@ -1,3 +1,4 @@
+t4018 header: RIGHT@deadf00,4000 {
 / {
 	label_1: node1@ff00 {
 		RIGHT@deadf00,4000 {
diff --git a/t/t4018/dts-reference b/t/t4018/dts-reference
index 8f0c87d8637..bf141229e93 100644
--- a/t/t4018/dts-reference
+++ b/t/t4018/dts-reference
@@ -1,3 +1,4 @@
+t4018 header: &RIGHT {
 &label_1 {
 	TEST = <455>;
 };
diff --git a/t/t4018/dts-root b/t/t4018/dts-root
index 4353b8220c9..4105b0bb48a 100644
--- a/t/t4018/dts-root
+++ b/t/t4018/dts-root
@@ -1,3 +1,4 @@
+t4018 header: / { RIGHT /* Technically just supposed to be a slash and brace */
 / { RIGHT /* Technically just supposed to be a slash and brace */
 	#size-cells = <1>;
 
diff --git a/t/t4018/dts-root-comment b/t/t4018/dts-root-comment
index 333a625c700..cdf2cee98db 100644
--- a/t/t4018/dts-root-comment
+++ b/t/t4018/dts-root-comment
@@ -1,3 +1,4 @@
+t4018 header: / { RIGHT /* Technically just supposed to be a slash and brace */
 / { RIGHT /* Technically just supposed to be a slash and brace */
 	#size-cells = <1>;
 
diff --git a/t/t4018/elixir-do-not-pick-end b/t/t4018/elixir-do-not-pick-end
index fae08ba7e8c..cf861f81e9a 100644
--- a/t/t4018/elixir-do-not-pick-end
+++ b/t/t4018/elixir-do-not-pick-end
@@ -1,3 +1,4 @@
+t4018 header: defmodule RIGHT do
 defmodule RIGHT do
 end
 #
diff --git a/t/t4018/elixir-ex-unit-test b/t/t4018/elixir-ex-unit-test
index 0560a2b6971..469f1a03b71 100644
--- a/t/t4018/elixir-ex-unit-test
+++ b/t/t4018/elixir-ex-unit-test
@@ -1,3 +1,4 @@
+t4018 header: test "RIGHT" do
 defmodule Test do
   test "RIGHT" do
     assert true == true
diff --git a/t/t4018/elixir-function b/t/t4018/elixir-function
index d452f495a7e..139a4e1da8e 100644
--- a/t/t4018/elixir-function
+++ b/t/t4018/elixir-function
@@ -1,3 +1,4 @@
+t4018 header: def function(RIGHT, arg) do
 def function(RIGHT, arg) do
   # comment
   # comment
diff --git a/t/t4018/elixir-macro b/t/t4018/elixir-macro
index 4f925e9ad46..0b0f7d721bb 100644
--- a/t/t4018/elixir-macro
+++ b/t/t4018/elixir-macro
@@ -1,3 +1,4 @@
+t4018 header: defmacro foo(RIGHT) do
 defmacro foo(RIGHT) do
   # Code
   # Code
diff --git a/t/t4018/elixir-module b/t/t4018/elixir-module
index 91a4e7aa200..a4773f4abae 100644
--- a/t/t4018/elixir-module
+++ b/t/t4018/elixir-module
@@ -1,3 +1,4 @@
+t4018 header: defmodule RIGHT do
 defmodule RIGHT do
   @moduledoc """
   Foo bar
diff --git a/t/t4018/elixir-module-func b/t/t4018/elixir-module-func
index c9910d06751..138493829b6 100644
--- a/t/t4018/elixir-module-func
+++ b/t/t4018/elixir-module-func
@@ -1,3 +1,4 @@
+t4018 header: def fun(RIGHT) do
 defmodule Foo do
   def fun(RIGHT) do
      # Code
diff --git a/t/t4018/elixir-nested-module b/t/t4018/elixir-nested-module
index 771ebc5c42a..296990dd2db 100644
--- a/t/t4018/elixir-nested-module
+++ b/t/t4018/elixir-nested-module
@@ -1,3 +1,4 @@
+t4018 header: defmodule MyApp.RIGHT do
 defmodule MyApp.RIGHT do
   @moduledoc """
   Foo bar
diff --git a/t/t4018/elixir-private-function b/t/t4018/elixir-private-function
index 1aabe33b7a9..94428e775b5 100644
--- a/t/t4018/elixir-private-function
+++ b/t/t4018/elixir-private-function
@@ -1,3 +1,4 @@
+t4018 header: defp function(RIGHT, arg) do
 defp function(RIGHT, arg) do
   # comment
   # comment
diff --git a/t/t4018/elixir-protocol b/t/t4018/elixir-protocol
index 7d9173691e3..1f1dc8cb199 100644
--- a/t/t4018/elixir-protocol
+++ b/t/t4018/elixir-protocol
@@ -1,3 +1,4 @@
+t4018 header: defprotocol RIGHT do
 defprotocol RIGHT do
   @doc """
   Calculates the size (and not the length!) of a data structure
diff --git a/t/t4018/elixir-protocol-implementation b/t/t4018/elixir-protocol-implementation
index f9234bbfc48..973226206d7 100644
--- a/t/t4018/elixir-protocol-implementation
+++ b/t/t4018/elixir-protocol-implementation
@@ -1,3 +1,4 @@
+t4018 header: defimpl RIGHT do
 defimpl RIGHT do
   # Docs
   # Docs
diff --git a/t/t4018/fortran-block-data b/t/t4018/fortran-block-data
index 63d4e21d0ad..eb0a77afade 100644
--- a/t/t4018/fortran-block-data
+++ b/t/t4018/fortran-block-data
@@ -1,3 +1,4 @@
+t4018 header: BLOCK DATA RIGHT
        BLOCK DATA RIGHT
        
        COMMON /B/ C, ChangeMe
diff --git a/t/t4018/fortran-comment b/t/t4018/fortran-comment
index 7b10d176588..e5e82331ebc 100644
--- a/t/t4018/fortran-comment
+++ b/t/t4018/fortran-comment
@@ -1,3 +1,4 @@
+t4018 header: subroutine RIGHT
       module a
 
       contains
diff --git a/t/t4018/fortran-comment-keyword b/t/t4018/fortran-comment-keyword
index e9206a53799..143aff89d73 100644
--- a/t/t4018/fortran-comment-keyword
+++ b/t/t4018/fortran-comment-keyword
@@ -1,3 +1,4 @@
+t4018 header: subroutine RIGHT (funcA, funcB)
       module a
 
       contains
diff --git a/t/t4018/fortran-comment-legacy b/t/t4018/fortran-comment-legacy
index 53cd062c1e5..edbac0b4148 100644
--- a/t/t4018/fortran-comment-legacy
+++ b/t/t4018/fortran-comment-legacy
@@ -1,3 +1,4 @@
+t4018 header: subroutine RIGHT
       module a
 
       contains
diff --git a/t/t4018/fortran-comment-legacy-star b/t/t4018/fortran-comment-legacy-star
index 2cbcdc3d8ab..be918f7b030 100644
--- a/t/t4018/fortran-comment-legacy-star
+++ b/t/t4018/fortran-comment-legacy-star
@@ -1,3 +1,4 @@
+t4018 header: subroutine RIGHT
       module a
 
       contains
diff --git a/t/t4018/fortran-external-function b/t/t4018/fortran-external-function
index 5a2d85d3aa4..ea4d8bcedc4 100644
--- a/t/t4018/fortran-external-function
+++ b/t/t4018/fortran-external-function
@@ -1,3 +1,4 @@
+t4018 header: function RIGHT(a, b) result(c)
 function RIGHT(a, b) result(c)
 
 integer, intent(in) :: ChangeMe
diff --git a/t/t4018/fortran-external-subroutine b/t/t4018/fortran-external-subroutine
index 4ce85fea132..9f662dd26b4 100644
--- a/t/t4018/fortran-external-subroutine
+++ b/t/t4018/fortran-external-subroutine
@@ -1,3 +1,4 @@
+t4018 header: subroutine RIGHT
 subroutine RIGHT
 
 real ChangeMe
diff --git a/t/t4018/fortran-module b/t/t4018/fortran-module
index c4b737dac3f..1882b3cd338 100644
--- a/t/t4018/fortran-module
+++ b/t/t4018/fortran-module
@@ -1,3 +1,4 @@
+t4018 header: module RIGHT
 module RIGHT
 
 use ChangeMe
diff --git a/t/t4018/fortran-module-procedure b/t/t4018/fortran-module-procedure
index 1ce6d854c22..51d368ba9be 100644
--- a/t/t4018/fortran-module-procedure
+++ b/t/t4018/fortran-module-procedure
@@ -1,3 +1,4 @@
+t4018 header: module RIGHT
  module RIGHT
 
    implicit none
diff --git a/t/t4018/fortran-program b/t/t4018/fortran-program
index 4616895e4b5..1c84e1ff0f8 100644
--- a/t/t4018/fortran-program
+++ b/t/t4018/fortran-program
@@ -1,3 +1,4 @@
+t4018 header: program RIGHT
 program RIGHT
 
 call ChangeMe
diff --git a/t/t4018/fountain-scene b/t/t4018/fountain-scene
index 6b3257d6803..2ffcf799087 100644
--- a/t/t4018/fountain-scene
+++ b/t/t4018/fountain-scene
@@ -1,3 +1,4 @@
+t4018 header: EXT. STREET RIGHT OUTSIDE - DAY
 EXT. STREET RIGHT OUTSIDE - DAY
 
 CHARACTER
diff --git a/t/t4018/golang-complex-function b/t/t4018/golang-complex-function
index e057dcefed6..0574ba912e6 100644
--- a/t/t4018/golang-complex-function
+++ b/t/t4018/golang-complex-function
@@ -1,3 +1,4 @@
+t4018 header: func (t *Test) RIGHT(a Type) (Type, error) {
 type Test struct {
 	a Type
 }
diff --git a/t/t4018/golang-func b/t/t4018/golang-func
index 8e9c9ac7c3f..0472cfd9798 100644
--- a/t/t4018/golang-func
+++ b/t/t4018/golang-func
@@ -1,3 +1,4 @@
+t4018 header: func RIGHT() {
 func RIGHT() {
 	a := 5
 	b := ChangeMe
diff --git a/t/t4018/golang-interface b/t/t4018/golang-interface
index 553bedec962..3160a1d4524 100644
--- a/t/t4018/golang-interface
+++ b/t/t4018/golang-interface
@@ -1,3 +1,4 @@
+t4018 header: type RIGHT interface {
 type RIGHT interface {
 	a() Type
 	b() ChangeMe
diff --git a/t/t4018/golang-long-func b/t/t4018/golang-long-func
index ac3a77b5c41..de83aaafca5 100644
--- a/t/t4018/golang-long-func
+++ b/t/t4018/golang-long-func
@@ -1,3 +1,4 @@
+t4018 header: func RIGHT(aVeryVeryVeryLongVariableName AVeryVeryVeryLongType,
 func RIGHT(aVeryVeryVeryLongVariableName AVeryVeryVeryLongType,
 	anotherLongVariableName AnotherLongType) {
 	a := 5
diff --git a/t/t4018/golang-struct b/t/t4018/golang-struct
index 5deda77feec..fc8022537b2 100644
--- a/t/t4018/golang-struct
+++ b/t/t4018/golang-struct
@@ -1,3 +1,4 @@
+t4018 header: type RIGHT struct {
 type RIGHT struct {
 	a Type
 	b ChangeMe
diff --git a/t/t4018/java-class-member-function b/t/t4018/java-class-member-function
index 298bc7a71b2..df77bd71f79 100644
--- a/t/t4018/java-class-member-function
+++ b/t/t4018/java-class-member-function
@@ -1,3 +1,4 @@
+t4018 header: public static void main(String RIGHT[])
 public class Beer
 {
 	int special;
diff --git a/t/t4018/markdown-heading-indented b/t/t4018/markdown-heading-indented
index 1991c2bd456..e68801c7c06 100644
--- a/t/t4018/markdown-heading-indented
+++ b/t/t4018/markdown-heading-indented
@@ -1,3 +1,4 @@
+t4018 header:    ### RIGHT
 Indented headings are allowed, as long as the indent is no more than 3 spaces.
 
    ### RIGHT
diff --git a/t/t4018/markdown-heading-non-headings b/t/t4018/markdown-heading-non-headings
index c479c1a3f1e..00d677ebe95 100644
--- a/t/t4018/markdown-heading-non-headings
+++ b/t/t4018/markdown-heading-non-headings
@@ -1,3 +1,4 @@
+t4018 header: # RIGHT
 Headings can be right next to other lines of the file:
 # RIGHT
 Indents of four or more spaces make a code block:
diff --git a/t/t4018/matlab-class-definition b/t/t4018/matlab-class-definition
index 84daedfb4e5..86b48eebe0a 100644
--- a/t/t4018/matlab-class-definition
+++ b/t/t4018/matlab-class-definition
@@ -1,3 +1,4 @@
+t4018 header: classdef RIGHT
 classdef RIGHT
     properties
         ChangeMe
diff --git a/t/t4018/matlab-function b/t/t4018/matlab-function
index 897a9b13ff4..9a93efffb99 100644
--- a/t/t4018/matlab-function
+++ b/t/t4018/matlab-function
@@ -1,3 +1,4 @@
+t4018 header: function y = RIGHT()
 function y = RIGHT()
 x = 5;
 y = ChangeMe + x;
diff --git a/t/t4018/matlab-octave-section-1 b/t/t4018/matlab-octave-section-1
index 3bb6c4670e2..b896cb07ff1 100644
--- a/t/t4018/matlab-octave-section-1
+++ b/t/t4018/matlab-octave-section-1
@@ -1,3 +1,4 @@
+t4018 header: %%% RIGHT section
 %%% RIGHT section
 # this is octave script
 ChangeMe = 1;
diff --git a/t/t4018/matlab-octave-section-2 b/t/t4018/matlab-octave-section-2
index ab2980f7f29..4e75942678f 100644
--- a/t/t4018/matlab-octave-section-2
+++ b/t/t4018/matlab-octave-section-2
@@ -1,3 +1,4 @@
+t4018 header: ## RIGHT section
 ## RIGHT section
 # this is octave script
 ChangeMe = 1;
diff --git a/t/t4018/matlab-section b/t/t4018/matlab-section
index 5ea59a5de00..6b45ae20009 100644
--- a/t/t4018/matlab-section
+++ b/t/t4018/matlab-section
@@ -1,3 +1,4 @@
+t4018 header: %% RIGHT section
 %% RIGHT section
 % this is understood by both matlab and octave
 ChangeMe = 1;
diff --git a/t/t4018/perl-skip-end-of-heredoc b/t/t4018/perl-skip-end-of-heredoc
index c22d39b2567..8f90cca7314 100644
--- a/t/t4018/perl-skip-end-of-heredoc
+++ b/t/t4018/perl-skip-end-of-heredoc
@@ -1,3 +1,4 @@
+t4018 header: sub RIGHTwithheredocument {
 sub RIGHTwithheredocument {
 	print <<"EOF"
 decoy here-doc
diff --git a/t/t4018/perl-skip-forward-decl b/t/t4018/perl-skip-forward-decl
index a98cb8bdad0..ff1f6d14735 100644
--- a/t/t4018/perl-skip-forward-decl
+++ b/t/t4018/perl-skip-forward-decl
@@ -1,3 +1,4 @@
+t4018 header: package RIGHT;
 package RIGHT;
 
 use strict;
diff --git a/t/t4018/perl-skip-sub-in-pod b/t/t4018/perl-skip-sub-in-pod
index e39f02462e2..ff1c65b28fc 100644
--- a/t/t4018/perl-skip-sub-in-pod
+++ b/t/t4018/perl-skip-sub-in-pod
@@ -1,3 +1,4 @@
+t4018 header: =head1 SYNOPSIS_RIGHT
 =head1 NAME
 
 Beer - subroutine to output fragment of a drinking song
diff --git a/t/t4018/perl-sub-definition b/t/t4018/perl-sub-definition
index a507d1f6452..22e16ad5363 100644
--- a/t/t4018/perl-sub-definition
+++ b/t/t4018/perl-sub-definition
@@ -1,3 +1,4 @@
+t4018 header: sub RIGHT {
 sub RIGHT {
 	my ($n) = @_;
 	print "ChangeMe";
diff --git a/t/t4018/perl-sub-definition-kr-brace b/t/t4018/perl-sub-definition-kr-brace
index 330b3df1142..6c94e6a62dd 100644
--- a/t/t4018/perl-sub-definition-kr-brace
+++ b/t/t4018/perl-sub-definition-kr-brace
@@ -1,3 +1,4 @@
+t4018 header: sub RIGHT
 sub RIGHT
 {
 	print "ChangeMe\n";
diff --git a/t/t4018/php-abstract-class b/t/t4018/php-abstract-class
index 5213e124946..fbc97843c6b 100644
--- a/t/t4018/php-abstract-class
+++ b/t/t4018/php-abstract-class
@@ -1,3 +1,4 @@
+t4018 header: abstract class RIGHT
 abstract class RIGHT
 {
     const FOO = 'ChangeMe';
diff --git a/t/t4018/php-abstract-method b/t/t4018/php-abstract-method
index ce215df75a4..22f5120d3b7 100644
--- a/t/t4018/php-abstract-method
+++ b/t/t4018/php-abstract-method
@@ -1,3 +1,4 @@
+t4018 header: abstract public function RIGHT(): ?string
 abstract class Klass
 {
     abstract public function RIGHT(): ?string
diff --git a/t/t4018/php-class b/t/t4018/php-class
index 7785b6303c7..42456cda768 100644
--- a/t/t4018/php-class
+++ b/t/t4018/php-class
@@ -1,3 +1,4 @@
+t4018 header: class RIGHT
 class RIGHT
 {
     const FOO = 'ChangeMe';
diff --git a/t/t4018/php-final-class b/t/t4018/php-final-class
index 69f57105529..ccf2d28a2d8 100644
--- a/t/t4018/php-final-class
+++ b/t/t4018/php-final-class
@@ -1,3 +1,4 @@
+t4018 header: final class RIGHT
 final class RIGHT
 {
     const FOO = 'ChangeMe';
diff --git a/t/t4018/php-final-method b/t/t4018/php-final-method
index 537fb8ad9ae..55107faef98 100644
--- a/t/t4018/php-final-method
+++ b/t/t4018/php-final-method
@@ -1,3 +1,4 @@
+t4018 header: final public function RIGHT(): string
 class Klass
 {
     final public function RIGHT(): string
diff --git a/t/t4018/php-function b/t/t4018/php-function
index 35717c51c3b..f021285e385 100644
--- a/t/t4018/php-function
+++ b/t/t4018/php-function
@@ -1,3 +1,4 @@
+t4018 header: function RIGHT()
 function RIGHT()
 {
     return 'ChangeMe';
diff --git a/t/t4018/php-interface b/t/t4018/php-interface
index 86b49ad5d9e..ef48244eaa8 100644
--- a/t/t4018/php-interface
+++ b/t/t4018/php-interface
@@ -1,3 +1,4 @@
+t4018 header: interface RIGHT
 interface RIGHT
 {
     public function foo($ChangeMe);
diff --git a/t/t4018/php-method b/t/t4018/php-method
index 03af1a6d9d7..cbc171a99b9 100644
--- a/t/t4018/php-method
+++ b/t/t4018/php-method
@@ -1,3 +1,4 @@
+t4018 header: public static function RIGHT()
 class Klass
 {
     public static function RIGHT()
diff --git a/t/t4018/php-trait b/t/t4018/php-trait
index 65b8c82a616..cba65191d39 100644
--- a/t/t4018/php-trait
+++ b/t/t4018/php-trait
@@ -1,3 +1,4 @@
+t4018 header: trait RIGHT
 trait RIGHT
 {
     public function foo($ChangeMe)
diff --git a/t/t4018/python-async-def b/t/t4018/python-async-def
index 87640e03d21..facfaeef373 100644
--- a/t/t4018/python-async-def
+++ b/t/t4018/python-async-def
@@ -1,3 +1,4 @@
+t4018 header: async def RIGHT(pi: int = 3.14):
 async def RIGHT(pi: int = 3.14):
     while True:
         break
diff --git a/t/t4018/python-class b/t/t4018/python-class
index ba9e741430f..87153873b4f 100644
--- a/t/t4018/python-class
+++ b/t/t4018/python-class
@@ -1,3 +1,4 @@
+t4018 header: class RIGHT(int, str):
 class RIGHT(int, str):
     # comment
     # another comment
diff --git a/t/t4018/python-def b/t/t4018/python-def
index e50b31b0ad5..08fb9a6b4ec 100644
--- a/t/t4018/python-def
+++ b/t/t4018/python-def
@@ -1,3 +1,4 @@
+t4018 header: def RIGHT(pi: int = 3.14):
 def RIGHT(pi: int = 3.14):
     while True:
         break
diff --git a/t/t4018/python-indented-async-def b/t/t4018/python-indented-async-def
index f5d03258af4..f604d08028f 100644
--- a/t/t4018/python-indented-async-def
+++ b/t/t4018/python-indented-async-def
@@ -1,3 +1,4 @@
+t4018 header: async def RIGHT(self, x: int):
 class Foo:
     async def RIGHT(self, x: int):
         return [
diff --git a/t/t4018/python-indented-class b/t/t4018/python-indented-class
index 19b4f35c4ca..65c07f74f6f 100644
--- a/t/t4018/python-indented-class
+++ b/t/t4018/python-indented-class
@@ -1,3 +1,4 @@
+t4018 header: class RIGHT:
 if TYPE_CHECKING:
     class RIGHT:
         # comment
diff --git a/t/t4018/python-indented-def b/t/t4018/python-indented-def
index 208fbadd2be..be87764e31b 100644
--- a/t/t4018/python-indented-def
+++ b/t/t4018/python-indented-def
@@ -1,3 +1,4 @@
+t4018 header: def RIGHT(self, x: int):
 class Foo:
     def RIGHT(self, x: int):
         return [
diff --git a/t/t4018/rust-fn b/t/t4018/rust-fn
index cbe02155f11..939b131ea80 100644
--- a/t/t4018/rust-fn
+++ b/t/t4018/rust-fn
@@ -1,3 +1,4 @@
+t4018 header: pub(self) fn RIGHT<T>(x: &[T]) where T: Debug {
 pub(self) fn RIGHT<T>(x: &[T]) where T: Debug {
     let _ = x;
     // a comment
diff --git a/t/t4018/rust-impl b/t/t4018/rust-impl
index 09df3cd93b2..1f798a43d38 100644
--- a/t/t4018/rust-impl
+++ b/t/t4018/rust-impl
@@ -1,3 +1,4 @@
+t4018 header: impl<'a, T: AsRef<[u8]>>  std::RIGHT for Git<'a> {
 impl<'a, T: AsRef<[u8]>>  std::RIGHT for Git<'a> {
 
     pub fn ChangeMe(&self) -> () {
diff --git a/t/t4018/rust-macro-rules b/t/t4018/rust-macro-rules
index ec610c5b62b..3990daf0e90 100644
--- a/t/t4018/rust-macro-rules
+++ b/t/t4018/rust-macro-rules
@@ -1,3 +1,4 @@
+t4018 header: macro_rules! RIGHT {
 macro_rules! RIGHT {
     () => {
         // a comment
diff --git a/t/t4018/rust-struct b/t/t4018/rust-struct
index 76aff1c0d8e..8c901a437cb 100644
--- a/t/t4018/rust-struct
+++ b/t/t4018/rust-struct
@@ -1,3 +1,4 @@
+t4018 header: pub(super) struct RIGHT<'a> {
 #[derive(Debug)]
 pub(super) struct RIGHT<'a> {
     name: &'a str,
diff --git a/t/t4018/rust-trait b/t/t4018/rust-trait
index ea397f09ed1..4cc9714e8f0 100644
--- a/t/t4018/rust-trait
+++ b/t/t4018/rust-trait
@@ -1,3 +1,4 @@
+t4018 header: unsafe trait RIGHT<T> {
 unsafe trait RIGHT<T> {
     fn len(&self) -> u32;
     fn ChangeMe(&self, n: u32) -> T;
-- 
2.30.0.284.gd98b1dd5eaa7

