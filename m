Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6243C433FE
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 06:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhLMGcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 01:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhLMGcD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 01:32:03 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8418EC06173F
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:03 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id a11so14108851ilj.6
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X9okeRDwg8rHkftnFvnqxe2lmDgknjfg00e+p16vEf8=;
        b=h9xf24tuoLgY2BpQz1+dWTdcM3j8MkE7DYqYwrnENkBf3W15qZLFfy/4zbRi0hXj9j
         Qi6VxXMW//QugXi882G4GllI5KHp3rBVCLwQVW6Vaq6yqJ2sYamTLrvCISMdaF0YsZ3f
         A6zzAHCap+fnQzAEPztIGoK0mU0TuZ1EFiBt/yHeNraf+FnG6G/kptMI+gGTxvnR49RC
         GSDbEh1wFjdrYRhwWdCtogSterND0QsSYrW64t9i4yo2Dul4gSqrIWyRie60JKpVnbET
         wXdJVglQx6VvMWyOHjYInX2gDCjQowKAfmYawTjh/uScgZuqeHt4sJhww83nbmTz/E0t
         EN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=X9okeRDwg8rHkftnFvnqxe2lmDgknjfg00e+p16vEf8=;
        b=FnLVgjn5Y7nZF2jm2Dj6rdYGVbDCfkX9eEYlEyk8Kkgw7oP3l/S4FIKwr6m+W3gdGY
         aKQNfFHgc11MgcqT6vUtvkxm83sNle4UKYlrwj6sjrM3yRUE0hrhVZPvSGQGr/oIhTWF
         6bgJ2PA1HYtiNfui3uOVpCP+NTJk1s5JEHXF/2YPRgYz0PsFOXhcwccYf7ESga2XKAWb
         VEkFq2VPwMy+MKediyEPxjjxezpofS/d6Nb8qC7nRgf1yp6hbYMnVbmPep/8dnq0j5sU
         WKtXaVt1HZTl4Su+B8SNvAvT98kIMVBznDjLlZevra8ip0w4QLd45VTXb2lx1SHweR4V
         vmVg==
X-Gm-Message-State: AOAM533qJZC21rT137+cF/V4PLRBywfcogrkFCGbX6kJ2F93t2NtVUW0
        HhhpzTAwgwXzafeQHGhbmUsqu6a+YSRPbg==
X-Google-Smtp-Source: ABdhPJyiAHCtPR7HnagY9IE3JZtpuhEdKXDN8G79gQjHFmVsG0jmV9ga0qb/Vq7a2JJj6DQjjA0IvA==
X-Received: by 2002:a05:6e02:1d0e:: with SMTP id i14mr24554ila.306.1639377122537;
        Sun, 12 Dec 2021 22:32:02 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id f10sm7305408ils.13.2021.12.12.22.32.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 22:32:02 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 06/15] chainlint.sed: improve ?!AMP?! placement accuracy
Date:   Mon, 13 Dec 2021 01:30:50 -0500
Message-Id: <20211213063059.19424-7-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.397.gfae76fe5da
In-Reply-To: <20211213063059.19424-1-sunshine@sunshineco.com>
References: <20211213063059.19424-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When chainlint.sed detects a broken &&-chain, it places an ?!AMP?!
annotation at the beginning of the line. However, this is an unusual
location for programmers accustomed to error messages (from compilers,
for instance) indicating the exact point of the problem. Therefore,
relocate the ?!AMP?! annotation to the end of the line in order to
better direct the programmer's attention to the source of the problem.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.sed                                      | 8 ++++----
 t/chainlint/arithmetic-expansion.expect              | 2 +-
 t/chainlint/block.expect                             | 2 +-
 t/chainlint/broken-chain.expect                      | 2 +-
 t/chainlint/case.expect                              | 4 ++--
 t/chainlint/command-substitution.expect              | 2 +-
 t/chainlint/cuddled.expect                           | 4 ++--
 t/chainlint/for-loop.expect                          | 4 ++--
 t/chainlint/here-doc-multi-line-command-subst.expect | 2 +-
 t/chainlint/here-doc-multi-line-string.expect        | 2 +-
 t/chainlint/if-in-loop.expect                        | 6 +++---
 t/chainlint/if-then-else.expect                      | 4 ++--
 t/chainlint/inline-comment.expect                    | 2 +-
 t/chainlint/loop-in-if.expect                        | 6 +++---
 t/chainlint/multi-line-string.expect                 | 2 +-
 t/chainlint/nested-cuddled-subshell.expect           | 6 +++---
 t/chainlint/nested-here-doc.expect                   | 2 +-
 t/chainlint/nested-subshell-comment.expect           | 2 +-
 t/chainlint/pipe.expect                              | 2 +-
 t/chainlint/semicolon.expect                         | 2 +-
 t/chainlint/subshell-here-doc.expect                 | 2 +-
 t/chainlint/subshell-one-liner.expect                | 4 ++--
 t/chainlint/while-loop.expect                        | 4 ++--
 23 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/t/chainlint.sed b/t/chainlint.sed
index 8a25c5b855..883a2b307c 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -236,7 +236,7 @@ s/.*\n//
 # line ends with pipe "...|" -- valid; not missing "&&"
 /|[ 	]*$/bcont
 # missing end-of-line "&&" -- mark suspect
-/&&[ 	]*$/!s/^/?!AMP?!/
+/&&[ 	]*$/!s/$/ ?!AMP?!/
 :cont
 # retrieve and print previous line
 x
@@ -303,7 +303,7 @@ bcase
 # that line legitimately lacks "&&"
 :else
 x
-s/?!AMP?!//
+s/ ?!AMP?!$//
 x
 bcont
 
@@ -311,7 +311,7 @@ bcont
 # "suspect" from final contained line since that line legitimately lacks "&&"
 :done
 x
-s/?!AMP?!//
+s/ ?!AMP?!$//
 x
 # is 'done' or 'fi' cuddled with ")" to close subshell?
 /done.*)/bclose
@@ -354,7 +354,7 @@ bblock
 # since that line legitimately lacks "&&" and exit subshell loop
 :clssolo
 x
-s/?!AMP?!//
+s/ ?!AMP?!$//
 p
 x
 s/^/>/
diff --git a/t/chainlint/arithmetic-expansion.expect b/t/chainlint/arithmetic-expansion.expect
index 09457d3196..56cd5b69f5 100644
--- a/t/chainlint/arithmetic-expansion.expect
+++ b/t/chainlint/arithmetic-expansion.expect
@@ -4,6 +4,6 @@
 	baz
 >) &&
 (
-?!AMP?!	bar=$((42 + 1))
+	bar=$((42 + 1)) ?!AMP?!
 	baz
 >)
diff --git a/t/chainlint/block.expect b/t/chainlint/block.expect
index fed7e89ae8..6333237cb2 100644
--- a/t/chainlint/block.expect
+++ b/t/chainlint/block.expect
@@ -7,6 +7,6 @@
 	bar &&
 	{
 		echo c
-?!AMP?!	}
+	} ?!AMP?!
 	baz
 >)
diff --git a/t/chainlint/broken-chain.expect b/t/chainlint/broken-chain.expect
index 55b0f42a53..0960a8c7c0 100644
--- a/t/chainlint/broken-chain.expect
+++ b/t/chainlint/broken-chain.expect
@@ -1,6 +1,6 @@
 (
 	foo &&
-?!AMP?!	bar
+	bar ?!AMP?!
 	baz &&
 	wop
 >)
diff --git a/t/chainlint/case.expect b/t/chainlint/case.expect
index 41f121fbbf..a4b92d4613 100644
--- a/t/chainlint/case.expect
+++ b/t/chainlint/case.expect
@@ -9,11 +9,11 @@
 	case "$x" in
 	x) foo ;;
 	*) bar ;;
-?!AMP?!	esac
+	esac ?!AMP?!
 	foobar
 >) &&
 (
 	case "$x" in 1) true;; esac &&
-?!AMP?!	case "$y" in 2) false;; esac
+	case "$y" in 2) false;; esac ?!AMP?!
 	foobar
 >)
diff --git a/t/chainlint/command-substitution.expect b/t/chainlint/command-substitution.expect
index ad4118e537..f276067b7b 100644
--- a/t/chainlint/command-substitution.expect
+++ b/t/chainlint/command-substitution.expect
@@ -4,6 +4,6 @@
 	baz
 >) &&
 (
-?!AMP?!	bar=$(gobble blocks)
+	bar=$(gobble blocks) ?!AMP?!
 	baz
 >)
diff --git a/t/chainlint/cuddled.expect b/t/chainlint/cuddled.expect
index b506d46221..b6c4ed90a9 100644
--- a/t/chainlint/cuddled.expect
+++ b/t/chainlint/cuddled.expect
@@ -4,7 +4,7 @@ cd foo &&
 >) &&
 
 (
-?!AMP?!cd foo
+cd foo ?!AMP?!
 	bar
 >) &&
 
@@ -17,5 +17,5 @@ cd foo &&
 >	bar) &&
 
 (
-?!AMP?!cd foo
+cd foo ?!AMP?!
 >	bar)
diff --git a/t/chainlint/for-loop.expect b/t/chainlint/for-loop.expect
index c33cf56ee7..dc209e21bd 100644
--- a/t/chainlint/for-loop.expect
+++ b/t/chainlint/for-loop.expect
@@ -1,9 +1,9 @@
 (
 	for i in a b c
 	do
-?!AMP?!		echo $i
+		echo $i ?!AMP?!
 		cat
-?!AMP?!	done
+	done ?!AMP?!
 	for i in a b c; do
 		echo $i &&
 		cat $i
diff --git a/t/chainlint/here-doc-multi-line-command-subst.expect b/t/chainlint/here-doc-multi-line-command-subst.expect
index e5fb752d2f..3a35bb014c 100644
--- a/t/chainlint/here-doc-multi-line-command-subst.expect
+++ b/t/chainlint/here-doc-multi-line-command-subst.expect
@@ -1,5 +1,5 @@
 (
 	x=$(bobble &&
-?!AMP?!>>		wiffle)
+>>		wiffle) ?!AMP?!
 	echo $x
 >)
diff --git a/t/chainlint/here-doc-multi-line-string.expect b/t/chainlint/here-doc-multi-line-string.expect
index 32038a070c..a3b9a5472d 100644
--- a/t/chainlint/here-doc-multi-line-string.expect
+++ b/t/chainlint/here-doc-multi-line-string.expect
@@ -1,4 +1,4 @@
 (
-?!AMP?!	cat && echo "multi-line	string"
+	cat && echo "multi-line	string" ?!AMP?!
 	bap
 >)
diff --git a/t/chainlint/if-in-loop.expect b/t/chainlint/if-in-loop.expect
index 03d3ceb22d..7d91837269 100644
--- a/t/chainlint/if-in-loop.expect
+++ b/t/chainlint/if-in-loop.expect
@@ -3,10 +3,10 @@
 	do
 		if false
 		then
-?!AMP?!			echo "err"
+			echo "err" ?!AMP?!
 			exit 1
-?!AMP?!		fi
+		fi ?!AMP?!
 		foo
-?!AMP?!	done
+	done ?!AMP?!
 	bar
 >)
diff --git a/t/chainlint/if-then-else.expect b/t/chainlint/if-then-else.expect
index a80f5e6c75..3055d5606c 100644
--- a/t/chainlint/if-then-else.expect
+++ b/t/chainlint/if-then-else.expect
@@ -1,7 +1,7 @@
 (
 	if test -n ""
 	then
-?!AMP?!		echo very
+		echo very ?!AMP?!
 		echo empty
 	elif test -z ""
 	then
@@ -9,7 +9,7 @@
 	else
 		echo foo &&
 		cat
-?!AMP?!	fi
+	fi ?!AMP?!
 	echo poodle
 >) &&
 (
diff --git a/t/chainlint/inline-comment.expect b/t/chainlint/inline-comment.expect
index fc9f250ac4..3d655a32b0 100644
--- a/t/chainlint/inline-comment.expect
+++ b/t/chainlint/inline-comment.expect
@@ -1,6 +1,6 @@
 (
 	foobar &&
-?!AMP?!	barfoo
+	barfoo ?!AMP?!
 	flibble "not a # comment"
 >) &&
 
diff --git a/t/chainlint/loop-in-if.expect b/t/chainlint/loop-in-if.expect
index 088e622c31..cebd3ae95e 100644
--- a/t/chainlint/loop-in-if.expect
+++ b/t/chainlint/loop-in-if.expect
@@ -3,10 +3,10 @@
 	then
 		while true
 		do
-?!AMP?!			echo "pop"
+			echo "pop" ?!AMP?!
 			echo "glup"
-?!AMP?!		done
+		done ?!AMP?!
 		foo
-?!AMP?!	fi
+	fi ?!AMP?!
 	bar
 >)
diff --git a/t/chainlint/multi-line-string.expect b/t/chainlint/multi-line-string.expect
index 2829516495..f1be2baf0a 100644
--- a/t/chainlint/multi-line-string.expect
+++ b/t/chainlint/multi-line-string.expect
@@ -1,6 +1,6 @@
 (
 	x="line 1		line 2		line 3" &&
-?!AMP?!	y="line 1		line2"
+	y="line 1		line2" ?!AMP?!
 	foobar
 >) &&
 (
diff --git a/t/chainlint/nested-cuddled-subshell.expect b/t/chainlint/nested-cuddled-subshell.expect
index c2a59ffc33..aa522658ed 100644
--- a/t/chainlint/nested-cuddled-subshell.expect
+++ b/t/chainlint/nested-cuddled-subshell.expect
@@ -4,16 +4,16 @@
 >>	) &&
 	(cd foo &&
 		bar
-?!AMP?!>>	)
+>>	) ?!AMP?!
 	(
 		cd foo &&
 >>		bar) &&
 	(
 		cd foo &&
-?!AMP?!>>		bar)
+>>		bar) ?!AMP?!
 	(cd foo &&
 >>		bar) &&
 	(cd foo &&
-?!AMP?!>>		bar)
+>>		bar) ?!AMP?!
 	foobar
 >)
diff --git a/t/chainlint/nested-here-doc.expect b/t/chainlint/nested-here-doc.expect
index 0c9ef1cfc6..f9604d3fac 100644
--- a/t/chainlint/nested-here-doc.expect
+++ b/t/chainlint/nested-here-doc.expect
@@ -2,6 +2,6 @@ cat >foop &&
 
 (
 	cat &&
-?!AMP?!	cat
+	cat ?!AMP?!
 	foobar
 >)
diff --git a/t/chainlint/nested-subshell-comment.expect b/t/chainlint/nested-subshell-comment.expect
index 15b68d4373..925e49bae9 100644
--- a/t/chainlint/nested-subshell-comment.expect
+++ b/t/chainlint/nested-subshell-comment.expect
@@ -6,6 +6,6 @@
 		# minor numbers of cows (or do they?)
 		baz &&
 		snaff
-?!AMP?!>>	)
+>>	) ?!AMP?!
 	fuzzy
 >)
diff --git a/t/chainlint/pipe.expect b/t/chainlint/pipe.expect
index 211b901dbc..ede6bcc607 100644
--- a/t/chainlint/pipe.expect
+++ b/t/chainlint/pipe.expect
@@ -3,6 +3,6 @@
 	bar |
 	baz &&
 	fish |
-?!AMP?!	cow
+	cow ?!AMP?!
 	sunder
 >)
diff --git a/t/chainlint/semicolon.expect b/t/chainlint/semicolon.expect
index 1d79384606..ffc87bdffb 100644
--- a/t/chainlint/semicolon.expect
+++ b/t/chainlint/semicolon.expect
@@ -1,5 +1,5 @@
 (
-?!AMP?!?!SEMI?!	cat foo ; echo bar
+?!SEMI?!	cat foo ; echo bar ?!AMP?!
 ?!SEMI?!	cat foo ; echo bar
 >) &&
 (
diff --git a/t/chainlint/subshell-here-doc.expect b/t/chainlint/subshell-here-doc.expect
index 7e057aee42..9d3f25b3f5 100644
--- a/t/chainlint/subshell-here-doc.expect
+++ b/t/chainlint/subshell-here-doc.expect
@@ -1,6 +1,6 @@
 (
 	echo wobba 	       gorgo snoot 	       wafta snurb &&
-?!AMP?!	cat >bip
+	cat >bip ?!AMP?!
 	echo >bop
 >) &&
 (
diff --git a/t/chainlint/subshell-one-liner.expect b/t/chainlint/subshell-one-liner.expect
index 51162821d7..ec77aa5b95 100644
--- a/t/chainlint/subshell-one-liner.expect
+++ b/t/chainlint/subshell-one-liner.expect
@@ -8,7 +8,7 @@
 	(foo || exit 1) &&
 	(foo || exit 1) |
 	(foo || exit 1) >baz &&
-?!AMP?!	(foo && bar)
-?!AMP?!?!SEMI?!	(foo && bar; baz)
+	(foo && bar) ?!AMP?!
+?!SEMI?!	(foo && bar; baz) ?!AMP?!
 	foobar
 >)
diff --git a/t/chainlint/while-loop.expect b/t/chainlint/while-loop.expect
index 13cff2c0a5..f8b9fcf62b 100644
--- a/t/chainlint/while-loop.expect
+++ b/t/chainlint/while-loop.expect
@@ -1,9 +1,9 @@
 (
 	while true
 	do
-?!AMP?!		echo foo
+		echo foo ?!AMP?!
 		cat
-?!AMP?!	done
+	done ?!AMP?!
 	while true; do
 		echo foo &&
 		cat bar
-- 
2.34.1.397.gfae76fe5da

