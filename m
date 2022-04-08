Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF40C433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 11:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbiDHLQQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 07:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiDHLQP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 07:16:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A16F3632F
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 04:14:11 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r3so119823edi.8
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 04:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=2WEoZke/tYhQR5CtCxzlATqmntZz9x4y8b4q/w6kYRU=;
        b=WLF638lc7k5xvmiFfFV4viPjY3WMLGPzyAILS7VLIjkGVBNzqqKiUKmmZAA+RLIwUa
         4ZNdCI9wAUS1avuzdmu+VOtEUzJE2u2iewoF1cSg6cI3Lm96y0UoPiJ9qwGfMRA113vx
         rUw0pztDutnG6mAWlBKwcgFUGo2j3HH/wGrNvKJOVYCIQ1rJXvzw8yXWlEQ/x/D29QjH
         +Hes3UNSJs5Upc0keSZY53IbG1sXR2sIpdWs1HXW4xmZ2Ajk9idsK2mK/CBwBSUCvquL
         JpNcUgr7GrE1uAcQ/GQaqPq/ffBjPmffqpCXNU0/XMAAVm8LvFvmmD5I4WUQiEQgkfXR
         havA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=2WEoZke/tYhQR5CtCxzlATqmntZz9x4y8b4q/w6kYRU=;
        b=11i2gywEEZKlsJkJzt2xKrrRIKErMNyHptyO93/+FGm47smkUqM+eL4DKtNIjtq0wj
         RmUO8+yPFdHcW0+XpkDniG5+3y1qKPwkRsRMOwzuv7Ro4m9CTIdo1ULb93jmNGGNgH/P
         4bSmhJqcFDRBGJOUapwvY6DMn2jUlSj/1ekQ7/R7817FXtb+watLVJd/agKC7Lud1Yp8
         1TdpJ5DFAYmSvkwK+X0GYOvCEzn/qD+w8pEpztVOvdccRFc8e4x1/ph4YNRE6iBr2Bv6
         xguAzATySqlZEI0a6xg5qKC0DojrvJh2agb7LSshrFvIgjHPbsO5GMR7CbZJTq2jAYwr
         LbHQ==
X-Gm-Message-State: AOAM5325OY/eeWHDdfvuyLoJFJstdSXP8hPuWBMTovgkpZck0rliTXPT
        jilXuxD67adSNnlRqGTxa/g=
X-Google-Smtp-Source: ABdhPJxsqDxWRTcuckrfvfS/9ZcQm11QKXAIj4QRT82lM6r3lRHsRehP4TWRUsfqZILmsDNjwhUDAA==
X-Received: by 2002:a05:6402:2553:b0:41c:debb:e4ac with SMTP id l19-20020a056402255300b0041cdebbe4acmr18729352edb.352.1649416449577;
        Fri, 08 Apr 2022 04:14:09 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b7-20020a170906708700b006da8440d642sm8692501ejk.113.2022.04.08.04.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 04:14:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ncmZ6-001JIh-Ab;
        Fri, 08 Apr 2022 13:14:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org,
        Lessley Dennington <lessleydennington@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] t9902: split test to run on appropriate systems
Date:   Fri, 08 Apr 2022 12:56:30 +0200
References: <20220408095353.11183-1-adam@dinwoodie.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220408095353.11183-1-adam@dinwoodie.org>
Message-ID: <220408.86v8vjbzen.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 08 2022, Adam Dinwoodie wrote:

> The "FUNNYNAMES" test prerequisite passes on Cygwin, as the Cygwin
> file system interface has a workaround for the underlying operating
> system's lack of support for tabs, newlines or quotes.  However, it does
> not add support for backslash, which is treated as a directory
> separator, meaning one of the tests added by 48803821b1 ("completion:
> handle unusual characters for sparse-checkout", 2022-02-07) will fail on
> Cygwin.
>
> To avoid this failure while still getting maximal test coverage, split
> that test into two: test handling of paths that include tabs on anything
> that has the FUNNYNAMES prerequisite, but skip testing handling of paths
> that include backslashes unless both FUNNYNAMES is set and the system is
> not Cygwin.
>
> It might be nice to have more granularity than "FUNNYNAMES" and its
> sibling "FUNNIERNAMES" provide, so that tests could be run based on
> specific individual characters supported by the file system being
> tested, but that seems like it would make the prerequisite checks in
> this area much more verbose for very little gain.

For getting the release out the door this seems like a sensible isolated
fix, but I don't see why we wouldn't get more granularity here,
i.e. something like the below.

I converted all the straightforward cases, where these tests were either
a bit misleading, or we'd actually skip testing on some systems
needlessly e.g. if they supported \t in a name but not \n.

This leaves only 8 remaining cases of FUNNYNAMES, all of those similarly
seem like subtle potential issues. I.e. we're creating files with
characters like "?" or "*" in the name.

But the prerequisite never checks for that, we're just implicitly
assuming that a FS that can do [\t\n"] an also do [*?+] or whatever.

In the case of the "rm" test we'd unconditionally create a file with a
space in its name, but then conditional on FUNNYNAMES remove it.

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index e74a318ac33..7714fc4852f 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -17,12 +17,7 @@ test_expect_success 'Initialize test directory' '
 	git commit -m "add normal files"
 '
 
-if test_have_prereq !FUNNYNAMES
-then
-	say 'Your filesystem does not allow tabs in filenames.'
-fi
-
-test_expect_success FUNNYNAMES 'add files with funny names' '
+test_expect_success FS_NAME_TAB,FS_NAME_NEWLINE 'add files with funny names' '
 	touch -- "tab	embedded" "newline${LF}embedded" &&
 	git add -- "tab	embedded" "newline${LF}embedded" &&
 	git commit -m "add files with tabs and newlines"
@@ -94,8 +89,12 @@ test_expect_success 'Test that "git rm -- -q" succeeds (remove a file that looks
 	git rm -- -q
 '
 
-test_expect_success FUNNYNAMES 'Test that "git rm -f" succeeds with embedded space, tab, or newline characters.' '
-	git rm -f "space embedded" "tab	embedded" "newline${LF}embedded"
+test_expect_success FS_NAME_TAB,FS_NAME_NEWLINE 'Test that "git rm -f" succeeds with embedded tab or newline characters.' '
+	git rm -f "tab	embedded" "newline${LF}embedded"
+'
+
+test_expect_success 'Test that "git rm -f" succeeds with embedded space.' '
+	git rm -f "space embedded"
 '
 
 test_expect_success SANITY 'Test that "git rm -f" fails if its rm fails' '
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 9a292bac70c..5dbe688ab10 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -482,7 +482,7 @@ test_expect_success '--combined-all-paths and --cc' '
 	test_cmp expect actual
 '
 
-test_expect_success FUNNYNAMES 'setup for --combined-all-paths with funny names' '
+test_expect_success FS_NAME_TAB 'setup for --combined-all-paths with funny names' '
 	git branch side1d &&
 	git branch side2d &&
 	git checkout side1d &&
@@ -507,7 +507,7 @@ test_expect_success FUNNYNAMES 'setup for --combined-all-paths with funny names'
 	head=$(git rev-parse HEAD)
 '
 
-test_expect_success FUNNYNAMES '--combined-all-paths and --raw and funny names' '
+test_expect_success FS_NAME_TAB '--combined-all-paths and --raw and funny names' '
 	cat <<-EOF >expect &&
 	::100644 100644 100644 $side1df $side2df $headf RR	"file\twith\ttabs"	"i\tam\ttabbed"	"fickle\tnaming"
 	EOF
@@ -516,13 +516,13 @@ test_expect_success FUNNYNAMES '--combined-all-paths and --raw and funny names'
 	test_cmp expect actual
 '
 
-test_expect_success FUNNYNAMES '--combined-all-paths and --raw -and -z and funny names' '
+test_expect_success FS_NAME_TAB '--combined-all-paths and --raw -and -z and funny names' '
 	printf "$head\0::100644 100644 100644 $side1df $side2df $headf RR\0file\twith\ttabs\0i\tam\ttabbed\0fickle\tnaming\0" >expect &&
 	git diff-tree -c -M --raw --combined-all-paths -z HEAD >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success FUNNYNAMES '--combined-all-paths and --cc and funny names' '
+test_expect_success FS_NAME_TAB '--combined-all-paths and --cc and funny names' '
 	cat <<-\EOF >expect &&
 	--- "a/file\twith\ttabs"
 	--- "a/i\tam\ttabbed"
diff --git a/t/t4135-apply-weird-filenames.sh b/t/t4135-apply-weird-filenames.sh
index 6bc3fb97a75..582666c691b 100755
--- a/t/t4135-apply-weird-filenames.sh
+++ b/t/t4135-apply-weird-filenames.sh
@@ -53,9 +53,9 @@ try_filename() {
 
 try_filename 'plain'            'postimage.txt'
 try_filename 'with spaces'      'post image.txt'
-try_filename 'with tab'         'post	image.txt' FUNNYNAMES
+try_filename 'with tab'         'post	image.txt' FS_NAME_TAB
 try_filename 'with backslash'   'post\image.txt' BSLASHPSPEC
-try_filename 'with quote'       '"postimage".txt' FUNNYNAMES success failure success
+try_filename 'with quote'       '"postimage".txt' FS_NAME_QUOTE success failure success
 
 test_expect_success 'whitespace-damaged traditional patch' '
 	echo postimage >expected &&
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 69356011713..5b880552a05 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -82,7 +82,7 @@ test_expect_success setup '
 	# Still a no-op.
 	function dummy() {}
 	EOF
-	if test_have_prereq FUNNYNAMES
+	if test_have_prereq FS_NAME_QUOTE
 	then
 		echo unusual >"\"unusual\" pathname" &&
 		echo unusual >"t/nested \"unusual\" pathname"
@@ -525,7 +525,7 @@ do
 		test_cmp expected actual
 	'
 
-	test_expect_success FUNNYNAMES "grep $L should quote unusual pathnames" '
+	test_expect_success FS_NAME_QUOTE "grep $L should quote unusual pathnames" '
 		cat >expected <<-EOF &&
 		${HC}"\"unusual\" pathname":unusual
 		${HC}"t/nested \"unusual\" pathname":unusual
@@ -534,7 +534,7 @@ do
 		test_cmp expected actual
 	'
 
-	test_expect_success FUNNYNAMES "grep $L in subdir should quote unusual relative pathnames" '
+	test_expect_success FS_NAME_QUOTE "grep $L in subdir should quote unusual relative pathnames" '
 		cat >expected <<-EOF &&
 		${HC}"nested \"unusual\" pathname":unusual
 		EOF
@@ -545,7 +545,7 @@ do
 		test_cmp expected actual
 	'
 
-	test_expect_success FUNNYNAMES "grep -z $L with unusual pathnames" '
+	test_expect_success FS_NAME_QUOTE "grep -z $L with unusual pathnames" '
 		cat >expected <<-EOF &&
 		${HC}"unusual" pathname:unusual
 		${HC}t/nested "unusual" pathname:unusual
@@ -555,7 +555,7 @@ do
 		test_cmp expected actual-replace-null
 	'
 
-	test_expect_success FUNNYNAMES "grep -z $L in subdir with unusual relative pathnames" '
+	test_expect_success FS_NAME_QUOTE "grep -z $L in subdir with unusual relative pathnames" '
 		cat >expected <<-EOF &&
 		${HC}nested "unusual" pathname:unusual
 		EOF
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index bbd513bab0f..014f822a089 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -66,11 +66,11 @@ test_expect_success 'prompt - unborn branch' '
 	test_cmp expected "$actual"
 '
 
-if test_have_prereq !FUNNYNAMES; then
+if test_have_prereq !FS_NAME_NEWLINE; then
 	say 'Your filesystem does not allow newlines in filenames.'
 fi
 
-test_expect_success FUNNYNAMES 'prompt - with newline in path' '
+test_expect_success FS_NAME_NEWLINE 'prompt - with newline in path' '
     repo_with_newline="repo
 with
 newline" &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 531cef097db..3b2fcd8afdf 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1700,20 +1700,29 @@ test_lazy_prereq CASE_INSENSITIVE_FS '
 	test "$(cat CamelCase)" != good
 '
 
-test_lazy_prereq FUNNYNAMES '
-	test_have_prereq !MINGW &&
-	touch -- \
-		"FUNNYNAMES tab	embedded" \
-		"FUNNYNAMES \"quote embedded\"" \
-		"FUNNYNAMES newline
+test_lazy_prereq FS_NAME_TAB '
+	touch -- "FUNNYNAMES tab	embedded" 2>/dev/null &&
+	rm -- "FUNNYNAMES tab	embedded"  2>/dev/null
+'
+test_lazy_prereq FS_NAME_QUOTE '
+	touch -- "FUNNYNAMES \"quote embedded\"" 2>/dev/null &&
+	rm -- "FUNNYNAMES \"quote embedded\""  2>/dev/null
+'
+test_lazy_prereq FS_NAME_NEWLINE '
+	touch -- "FUNNYNAMES newline
 embedded" 2>/dev/null &&
-	rm -- \
-		"FUNNYNAMES tab	embedded" \
-		"FUNNYNAMES \"quote embedded\"" \
-		"FUNNYNAMES newline
+	rm -- "FUNNYNAMES newline
 embedded" 2>/dev/null
 '
 
+# Please use a more specific FS_NAME_* check if possible.
+test_lazy_prereq FUNNYNAMES '
+	test_have_prereq !MINGW &&
+	test_have_prereq FS_NAME_TAB &&
+	test_have_prereq FS_NAME_QUOTE &&
+	test_have_prereq FS_NAME_NEWLINE
+'
+
 test_lazy_prereq UTF8_NFD_TO_NFC '
 	# check whether FS converts nfd unicode to nfc
 	auml=$(printf "\303\244")
