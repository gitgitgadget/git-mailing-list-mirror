Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6E0C433FE
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 06:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbhLMGcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 01:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbhLMGcA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 01:32:00 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D19CC06173F
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:00 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id p65so17396935iof.3
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GK02UCuwR4lVt8dksekV0yRcVjCUg5ZVJU88r2THo/4=;
        b=ovjRX0FIsaBTwQrxWAZUQqsdNMSAOzo1SKwTPO34MptmJJuYrxivWXzZGs7fV/83TT
         BuasXlsxwf30gCmCmsApjgKlNASgAxENNWPcYhDMbPIsovG2AjAggtydxLSV1IFddlSk
         hwZskYlafpgT0YjPY1fX+qpsQKYeXqSc3io2/V29C/tuQ8YTvvrOiCyCwaXAxabpU2Tb
         YhZJ/5L0VOaoQKCYh1aDV153Eti3voc91LuNGv8+TKo9y/XyXc3rMH/cuNSo9qespinF
         NpWK70ZJdR2AyvbFTZRfThpnCvc2tqhJhixcaz0ZwNaLpv83SL1KUncqCtg1WczoKyqX
         ZnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GK02UCuwR4lVt8dksekV0yRcVjCUg5ZVJU88r2THo/4=;
        b=PcYrWuOp4kDVoy5Gr0SgIBwfh9xFVJrFswEwN379qJhG4BYiO9Ki3WDlIt3cL09rEr
         GHNM66Kx0npg5LAlmot6KNaXcaPAL1XNowNglLu6VU4r+3OCgbWe0db3zXBycX3vgQa9
         8SVK8NIEEoHHPjncroc71jrFcUf1AnFZZ6765jSailEJPBM8uHjK9nhO145OKHUjd0ZR
         tlN14FPw2HiL4eBwL/ejSTLq8E+nrqBHPqVpZva7bDV5QnihdsgjRym76rWlLtaNxHfT
         mpD5gMNvuq+7jV0GXjTmkFfaz+b3ySbCsybrAvfToa7PZsKi/tgGBsBJjqi7RxrMn+Y+
         Aw7g==
X-Gm-Message-State: AOAM530sHINBQWTrftRd6rFQCzgPDyLgM3/CCQPbmExCw4999Xw5GKFy
        5vPZHfLwII4TzTvlwVeKbzt5GbY1FD7YlA==
X-Google-Smtp-Source: ABdhPJwCpKJhhMqc+9AT7lz4+LZivqVXlTYMmCwI7TcRg/av2BJgulNYb7fL0WIO9+qy6zm+f0LyGg==
X-Received: by 2002:a02:6d41:: with SMTP id e1mr30742410jaf.74.1639377119634;
        Sun, 12 Dec 2021 22:31:59 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id f10sm7305408ils.13.2021.12.12.22.31.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 22:31:59 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 02/15] t/chainlint/*.test: fix invalid test cases due to mixing quote types
Date:   Mon, 13 Dec 2021 01:30:46 -0500
Message-Id: <20211213063059.19424-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.397.gfae76fe5da
In-Reply-To: <20211213063059.19424-1-sunshine@sunshineco.com>
References: <20211213063059.19424-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The chainlint self-test code snippets are supposed to represent the body
of a test_expect_success() or test_expect_failure(), yet the contents of
a few tests would have caused the shell to report syntax errors had they
been real test bodies due to the mix of single- and double-quotes.
Although chainlint.sed, with its simplistic heuristics, is blind to this
problem, a future more robust chainlint implementation might not have
such a limitation. Therefore, stop mixing quote types haphazardly in
those tests and unify quoting throughout. While at it, drop chunks of
tests which merely repeat what is already tested elsewhere but with
alternative quotes.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint/broken-chain.test               |  2 +-
 t/chainlint/case.test                       |  6 +++---
 t/chainlint/complex-if-in-cuddled-loop.test |  2 +-
 t/chainlint/cuddled-if-then-else.test       |  2 +-
 t/chainlint/cuddled-loop.test               |  2 +-
 t/chainlint/for-loop.test                   |  8 ++++----
 t/chainlint/here-doc.expect                 |  2 --
 t/chainlint/here-doc.test                   |  7 -------
 t/chainlint/if-in-loop.test                 |  6 +++---
 t/chainlint/if-then-else.test               | 14 +++++++-------
 t/chainlint/loop-in-if.test                 |  6 +++---
 t/chainlint/multi-line-string.expect        |  8 +-------
 t/chainlint/multi-line-string.test          | 16 ++--------------
 t/chainlint/nested-subshell-comment.test    |  2 +-
 t/chainlint/pipe.test                       |  2 +-
 t/chainlint/subshell-here-doc.expect        |  1 -
 t/chainlint/subshell-here-doc.test          |  6 +-----
 t/chainlint/t7900-subtree.expect            |  4 ++--
 t/chainlint/t7900-subtree.test              |  4 ++--
 t/chainlint/while-loop.test                 |  8 ++++----
 20 files changed, 38 insertions(+), 70 deletions(-)

diff --git a/t/chainlint/broken-chain.test b/t/chainlint/broken-chain.test
index 3cc67b65d0..2a44aa73b7 100644
--- a/t/chainlint/broken-chain.test
+++ b/t/chainlint/broken-chain.test
@@ -1,6 +1,6 @@
 (
 	foo &&
-# LINT: missing "&&" from 'bar'
+# LINT: missing "&&" from "bar"
 	bar
 	baz &&
 # LINT: final statement before closing ")" legitimately lacks "&&"
diff --git a/t/chainlint/case.test b/t/chainlint/case.test
index 5ef6ff7db5..4cb086bf87 100644
--- a/t/chainlint/case.test
+++ b/t/chainlint/case.test
@@ -1,5 +1,5 @@
 (
-# LINT: "...)" arms in 'case' not misinterpreted as subshell-closing ")"
+# LINT: "...)" arms in "case" not misinterpreted as subshell-closing ")"
 	case "$x" in
 	x) foo ;;
 	*) bar ;;
@@ -7,7 +7,7 @@
 	foobar
 ) &&
 (
-# LINT: missing "&&" on 'esac'
+# LINT: missing "&&" on "esac"
 	case "$x" in
 	x) foo ;;
 	*) bar ;;
@@ -15,7 +15,7 @@
 	foobar
 ) &&
 (
-# LINT: "...)" arm in one-liner 'case' not misinterpreted as closing ")"
+# LINT: "...)" arm in one-liner "case" not misinterpreted as closing ")"
 	case "$x" in 1) true;; esac &&
 # LINT: same but missing "&&"
 	case "$y" in 2) false;; esac
diff --git a/t/chainlint/complex-if-in-cuddled-loop.test b/t/chainlint/complex-if-in-cuddled-loop.test
index 571bbd85cd..5efeda58b2 100644
--- a/t/chainlint/complex-if-in-cuddled-loop.test
+++ b/t/chainlint/complex-if-in-cuddled-loop.test
@@ -1,4 +1,4 @@
-# LINT: 'for' loop cuddled with "(" and ")" and nested 'if' with complex
+# LINT: "for" loop cuddled with "(" and ")" and nested "if" with complex
 # LINT: multi-line condition; indented with spaces, not tabs
 (for i in a b c; do
    if test "$(echo $(waffle bat))" = "eleventeen" &&
diff --git a/t/chainlint/cuddled-if-then-else.test b/t/chainlint/cuddled-if-then-else.test
index eed774a9d6..7c53f4efe3 100644
--- a/t/chainlint/cuddled-if-then-else.test
+++ b/t/chainlint/cuddled-if-then-else.test
@@ -1,4 +1,4 @@
-# LINT: 'if' cuddled with "(" and ")"; indented with spaces, not tabs
+# LINT: "if" cuddled with "(" and ")"; indented with spaces, not tabs
 (if test -z ""; then
     echo empty
  else
diff --git a/t/chainlint/cuddled-loop.test b/t/chainlint/cuddled-loop.test
index a841d781f0..3c2a62f751 100644
--- a/t/chainlint/cuddled-loop.test
+++ b/t/chainlint/cuddled-loop.test
@@ -1,4 +1,4 @@
-# LINT: 'while' loop cuddled with "(" and ")", with embedded (allowed)
+# LINT: "while" loop cuddled with "(" and ")", with embedded (allowed)
 # LINT: "|| exit {n}" to exit loop early, and using redirection "<" to feed
 # LINT: loop; indented with spaces, not tabs
 ( while read x
diff --git a/t/chainlint/for-loop.test b/t/chainlint/for-loop.test
index 7db76262bc..6cb3428158 100644
--- a/t/chainlint/for-loop.test
+++ b/t/chainlint/for-loop.test
@@ -1,17 +1,17 @@
 (
-# LINT: 'for', 'do', 'done' do not need "&&"
+# LINT: "for", "do", "done" do not need "&&"
 	for i in a b c
 	do
-# LINT: missing "&&" on 'echo'
+# LINT: missing "&&" on "echo"
 		echo $i
 # LINT: last statement of while does not need "&&"
 		cat <<-\EOF
 		bar
 		EOF
-# LINT: missing "&&" on 'done'
+# LINT: missing "&&" on "done"
 	done
 
-# LINT: 'do' on same line as 'for'
+# LINT: "do" on same line as "for"
 	for i in a b c; do
 		echo $i &&
 		cat $i
diff --git a/t/chainlint/here-doc.expect b/t/chainlint/here-doc.expect
index 534b065e38..8449eb2e02 100644
--- a/t/chainlint/here-doc.expect
+++ b/t/chainlint/here-doc.expect
@@ -2,8 +2,6 @@ boodle wobba        gorgo snoot        wafta snurb &&
 
 cat >foo &&
 
-cat >bar &&
-
 cat >boo &&
 
 horticulture
diff --git a/t/chainlint/here-doc.test b/t/chainlint/here-doc.test
index ad4ce8afd9..3f5f92cad3 100644
--- a/t/chainlint/here-doc.test
+++ b/t/chainlint/here-doc.test
@@ -14,13 +14,6 @@ boz
 woz
 Arbitrary_Tag_42
 
-# LINT: swallow 'quoted' here-doc
-cat <<'FUMP' >bar &&
-snoz
-boz
-woz
-FUMP
-
 # LINT: swallow "quoted" here-doc
 cat <<"zump" >boo &&
 snoz
diff --git a/t/chainlint/if-in-loop.test b/t/chainlint/if-in-loop.test
index daf22da164..f0cf19cfad 100644
--- a/t/chainlint/if-in-loop.test
+++ b/t/chainlint/if-in-loop.test
@@ -3,13 +3,13 @@
 	do
 		if false
 		then
-# LINT: missing "&&" on 'echo'
+# LINT: missing "&&" on "echo"
 			echo "err"
 			exit 1
-# LINT: missing "&&" on 'fi'
+# LINT: missing "&&" on "fi"
 		fi
 		foo
-# LINT: missing "&&" on 'done'
+# LINT: missing "&&" on "done"
 	done
 	bar
 )
diff --git a/t/chainlint/if-then-else.test b/t/chainlint/if-then-else.test
index d2b03ca6b4..2055336c2b 100644
--- a/t/chainlint/if-then-else.test
+++ b/t/chainlint/if-then-else.test
@@ -1,27 +1,27 @@
 (
-# LINT: 'if', 'then', 'elif', 'else', 'fi' do not need "&&"
+# LINT: "if", "then", "elif", "else", "fi" do not need "&&"
 	if test -n ""
 	then
-# LINT: missing "&&" on 'echo'
+# LINT: missing "&&" on "echo"
 		echo very
-# LINT: last statement before 'elif' does not need "&&"
+# LINT: last statement before "elif" does not need "&&"
 		echo empty
 	elif test -z ""
 	then
-# LINT: last statement before 'else' does not need "&&"
+# LINT: last statement before "else" does not need "&&"
 		echo foo
 	else
 		echo foo &&
-# LINT: last statement before 'fi' does not need "&&"
+# LINT: last statement before "fi" does not need "&&"
 		cat <<-\EOF
 		bar
 		EOF
-# LINT: missing "&&" on 'fi'
+# LINT: missing "&&" on "fi"
 	fi
 	echo poodle
 ) &&
 (
-# LINT: 'then' on same line as 'if'
+# LINT: "then" on same line as "if"
 	if test -n ""; then
 		echo very &&
 		echo empty
diff --git a/t/chainlint/loop-in-if.test b/t/chainlint/loop-in-if.test
index 93e8ba8e4d..dfcc3f98fb 100644
--- a/t/chainlint/loop-in-if.test
+++ b/t/chainlint/loop-in-if.test
@@ -3,13 +3,13 @@
 	then
 		while true
 		do
-# LINT: missing "&&" on 'echo'
+# LINT: missing "&&" on "echo"
 			echo "pop"
 			echo "glup"
-# LINT: missing "&&" on 'done'
+# LINT: missing "&&" on "done"
 		done
 		foo
-# LINT: missing "&&" on 'fi'
+# LINT: missing "&&" on "fi"
 	fi
 	bar
 )
diff --git a/t/chainlint/multi-line-string.expect b/t/chainlint/multi-line-string.expect
index 170cb59993..2829516495 100644
--- a/t/chainlint/multi-line-string.expect
+++ b/t/chainlint/multi-line-string.expect
@@ -1,15 +1,9 @@
 (
 	x="line 1		line 2		line 3" &&
-?!AMP?!	y='line 1		line2'
+?!AMP?!	y="line 1		line2"
 	foobar
 >) &&
-(
-	echo "there's nothing to see here" &&
-	exit
->) &&
 (
 	echo "xyz" "abc		def		ghi" &&
-	echo 'xyz' 'abc		def		ghi' &&
-	echo 'xyz' "abc		def		ghi" &&
 	barfoo
 >)
diff --git a/t/chainlint/multi-line-string.test b/t/chainlint/multi-line-string.test
index 287ab89705..4a0af2107d 100644
--- a/t/chainlint/multi-line-string.test
+++ b/t/chainlint/multi-line-string.test
@@ -3,25 +3,13 @@
 		line 2
 		line 3" &&
 # LINT: missing "&&" on assignment
-	y='line 1
-		line2'
+	y="line 1
+		line2"
 	foobar
 ) &&
-(
-# LINT: apostrophe (in a contraction) within string not misinterpreted as
-# LINT: starting multi-line single-quoted string
-	echo "there's nothing to see here" &&
-	exit
-) &&
 (
 	echo "xyz" "abc
 		def
 		ghi" &&
-	echo 'xyz' 'abc
-		def
-		ghi' &&
-	echo 'xyz' "abc
-		def
-		ghi" &&
 	barfoo
 )
diff --git a/t/chainlint/nested-subshell-comment.test b/t/chainlint/nested-subshell-comment.test
index 0ff136ab3c..0215cdb192 100644
--- a/t/chainlint/nested-subshell-comment.test
+++ b/t/chainlint/nested-subshell-comment.test
@@ -7,7 +7,7 @@
 		# minor numbers of cows (or do they?)
 		baz &&
 		snaff
-# LINT: missing "&&" on ')'
+# LINT: missing "&&" on ")"
 	)
 	fuzzy
 )
diff --git a/t/chainlint/pipe.test b/t/chainlint/pipe.test
index e6af4de916..dd82534c66 100644
--- a/t/chainlint/pipe.test
+++ b/t/chainlint/pipe.test
@@ -4,7 +4,7 @@
 	bar |
 	baz &&
 
-# LINT: final line of pipe sequence ('cow') lacking "&&"
+# LINT: final line of pipe sequence ("cow") lacking "&&"
 	fish |
 	cow
 
diff --git a/t/chainlint/subshell-here-doc.expect b/t/chainlint/subshell-here-doc.expect
index 74723e7340..7e057aee42 100644
--- a/t/chainlint/subshell-here-doc.expect
+++ b/t/chainlint/subshell-here-doc.expect
@@ -5,7 +5,6 @@
 >) &&
 (
 	cat >bup &&
-	cat >bup2 &&
 	cat >bup3 &&
 	meep
 >)
diff --git a/t/chainlint/subshell-here-doc.test b/t/chainlint/subshell-here-doc.test
index 0cce907ba8..d40eb65583 100644
--- a/t/chainlint/subshell-here-doc.test
+++ b/t/chainlint/subshell-here-doc.test
@@ -8,7 +8,7 @@
 	nevermore...
 	EOF
 
-# LINT: missing "&&" on 'cat'
+# LINT: missing "&&" on "cat"
 	cat <<EOF >bip
 	fish fly high
 EOF
@@ -27,10 +27,6 @@ EOF
 	glink
 	FIZZ
 	ARBITRARY
-	cat <<-'ARBITRARY2' >bup2 &&
-	glink
-	FIZZ
-	ARBITRARY2
 	cat <<-"ARBITRARY3" >bup3 &&
 	glink
 	FIZZ
diff --git a/t/chainlint/t7900-subtree.expect b/t/chainlint/t7900-subtree.expect
index c9913429e6..f769244ef6 100644
--- a/t/chainlint/t7900-subtree.expect
+++ b/t/chainlint/t7900-subtree.expect
@@ -1,9 +1,9 @@
 (
 	chks="sub1sub2sub3sub4" &&
-	chks_sub=$(cat | sed 's,^,sub dir/,'
+	chks_sub=$(cat | sed "s,^,sub dir/,"
 >>) &&
 	chkms="main-sub1main-sub2main-sub3main-sub4" &&
-	chkms_sub=$(cat | sed 's,^,sub dir/,'
+	chkms_sub=$(cat | sed "s,^,sub dir/,"
 >>) &&
 	subfiles=$(git ls-files) &&
 	check_equal "$subfiles" "$chkms$chks"
diff --git a/t/chainlint/t7900-subtree.test b/t/chainlint/t7900-subtree.test
index 277d8358df..02f3129232 100644
--- a/t/chainlint/t7900-subtree.test
+++ b/t/chainlint/t7900-subtree.test
@@ -3,7 +3,7 @@
 sub2
 sub3
 sub4" &&
-	chks_sub=$(cat <<TXT | sed 's,^,sub dir/,'
+	chks_sub=$(cat <<TXT | sed "s,^,sub dir/,"
 $chks
 TXT
 ) &&
@@ -11,7 +11,7 @@ TXT
 main-sub2
 main-sub3
 main-sub4" &&
-	chkms_sub=$(cat <<TXT | sed 's,^,sub dir/,'
+	chkms_sub=$(cat <<TXT | sed "s,^,sub dir/,"
 $chkms
 TXT
 ) &&
diff --git a/t/chainlint/while-loop.test b/t/chainlint/while-loop.test
index f1df085bf0..d09fb016e4 100644
--- a/t/chainlint/while-loop.test
+++ b/t/chainlint/while-loop.test
@@ -1,17 +1,17 @@
 (
-# LINT: 'while, 'do', 'done' do not need "&&"
+# LINT: "while", "do", "done" do not need "&&"
 	while true
 	do
-# LINT: missing "&&" on 'echo'
+# LINT: missing "&&" on "echo"
 		echo foo
 # LINT: last statement of while does not need "&&"
 		cat <<-\EOF
 		bar
 		EOF
-# LINT: missing "&&" on 'done'
+# LINT: missing "&&" on "done"
 	done
 
-# LINT: 'do' on same line as 'while'
+# LINT: "do" on same line as "while"
 	while true; do
 		echo foo &&
 		cat bar
-- 
2.34.1.397.gfae76fe5da

