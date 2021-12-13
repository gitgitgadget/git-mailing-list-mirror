Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537FCC433FE
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 06:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhLMGcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 01:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbhLMGcH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 01:32:07 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CD6C061751
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:06 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id 15so14117898ilq.2
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QCSoY7ggtnhfI+VwdAzKV6um1gZRYM13kmApTd0s+7I=;
        b=gv3FB8x+q3BqHJjaZZ6XrtWFDMm+ZaD3U7el5k3cONIKnwo1vgwYePny9grabraQDQ
         J7NFfltOQt1viCAUXBEATXxUccGEy14Pt0laovOt/N329RQU0OPF4/yUlB3GIZdZUM+V
         PfujcsIFYlGLYI86wG3uAR+xM8GtWpNDEHMldaXpcJLSJAOaDx3/jJfRMWx6/nyPQNDH
         9JyOGRTGoHVl7Wxa9CJ9HBC/3fsXjMnZyG62W/9yoIwfn8kb2vw5kQbSKBPOOl4UM5HL
         CrL0VS4/kAma4yyhVn2i3RU4QcmJWcCfoBD5+soYvkoTCguLiY+ujGWwcsWX+dXBgdHJ
         9F4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QCSoY7ggtnhfI+VwdAzKV6um1gZRYM13kmApTd0s+7I=;
        b=kIDwmfZXVQsRfeVj/LfY/vpv4WLZt3MC2zHiWsPFbu72bHNobbMl0z6dRnT4BI7bMw
         PwBEJrvK7RiX5gcnXHloN0k86R2aOm7KKUR3W2M7lIJbbVi8De0VL1o1AUA+aj3+mYwG
         OoUC31dzX+z8TnyqRTEhirD1QIi5g50BG0f7tY061RHetwTnMgyDtiF1hK8TW5O/YmHC
         YMQTX/d/e0I8FRXeFHTt9jm4iC5yFm5MUEt4Ra02Ezjn+XTIGhdl0nD95GPM2yDQcF5D
         TIYPBNsWhG4rhrDDO1v33pM+hhOWA8uo9qLTFv5EsC2FmhJ8tPUXzBcA6+DFxn7WvYzs
         Q6SQ==
X-Gm-Message-State: AOAM533eKG78+kfvriyIkeFbzCt3B6l1TaQN9p0TFxUuotj6wBPC6KuN
        wHu25nXlijsQ8rQYQ5WqFlLCydZuCzrUuQ==
X-Google-Smtp-Source: ABdhPJyE+Z5+EEMsL8jPK5yt9Ku9Re/HPI9OHwC8ozAhsMhMgJXVt7nNgPOwe8GVzQOKjRPutW4v/A==
X-Received: by 2002:a92:ca07:: with SMTP id j7mr33510641ils.36.1639377125662;
        Sun, 12 Dec 2021 22:32:05 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id f10sm7305408ils.13.2021.12.12.22.32.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 22:32:05 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 10/15] chainlint.sed: drop subshell-closing ">" annotation
Date:   Mon, 13 Dec 2021 01:30:54 -0500
Message-Id: <20211213063059.19424-11-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.397.gfae76fe5da
In-Reply-To: <20211213063059.19424-1-sunshine@sunshineco.com>
References: <20211213063059.19424-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

chainlint.sed inserts a ">" annotation at the beginning of a line to
signal that its heuristics have identified an end-of-subshell. This was
useful as a debugging aid during development of the script, but it has
no value to test writers and might even confuse them into thinking that
the linter is misbehaving by inserting line-noise into the shell code it
is validating. Moreover, its presence also potentially makes it
difficult to reuse the chainlint self-test "expect" output should a more
capable linter ever be developed. Therefore, drop the ">" annotation.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.sed                                  |  9 ---------
 t/chainlint/arithmetic-expansion.expect          |  4 ++--
 t/chainlint/bash-array.expect                    |  4 ++--
 t/chainlint/blank-line.expect                    |  2 +-
 t/chainlint/block.expect                         |  2 +-
 t/chainlint/broken-chain.expect                  |  2 +-
 t/chainlint/case.expect                          |  6 +++---
 .../close-nested-and-parent-together.expect      |  2 +-
 t/chainlint/close-subshell.expect                | 16 ++++++++--------
 t/chainlint/command-substitution.expect          |  4 ++--
 t/chainlint/comment.expect                       |  2 +-
 t/chainlint/complex-if-in-cuddled-loop.expect    |  2 +-
 t/chainlint/cuddled-if-then-else.expect          |  2 +-
 t/chainlint/cuddled-loop.expect                  |  2 +-
 t/chainlint/cuddled.expect                       | 10 +++++-----
 t/chainlint/exit-loop.expect                     |  6 +++---
 t/chainlint/exit-subshell.expect                 |  2 +-
 t/chainlint/for-loop.expect                      |  2 +-
 t/chainlint/here-doc-close-subshell.expect       |  2 +-
 .../here-doc-multi-line-command-subst.expect     |  4 ++--
 t/chainlint/here-doc-multi-line-string.expect    |  2 +-
 t/chainlint/if-in-loop.expect                    |  2 +-
 t/chainlint/if-then-else.expect                  |  4 ++--
 t/chainlint/incomplete-line.expect               |  2 +-
 t/chainlint/inline-comment.expect                |  4 ++--
 t/chainlint/loop-in-if.expect                    |  2 +-
 ...multi-line-nested-command-substitution.expect | 10 +++++-----
 t/chainlint/multi-line-string.expect             |  4 ++--
 t/chainlint/nested-cuddled-subshell.expect       | 14 +++++++-------
 t/chainlint/nested-here-doc.expect               |  2 +-
 t/chainlint/nested-subshell-comment.expect       |  4 ++--
 t/chainlint/nested-subshell.expect               |  6 +++---
 t/chainlint/p4-filespec.expect                   |  2 +-
 t/chainlint/pipe.expect                          |  2 +-
 t/chainlint/semicolon.expect                     | 10 +++++-----
 t/chainlint/subshell-here-doc.expect             |  4 ++--
 t/chainlint/subshell-one-liner.expect            |  2 +-
 t/chainlint/t7900-subtree.expect                 |  6 +++---
 t/chainlint/while-loop.expect                    |  2 +-
 39 files changed, 80 insertions(+), 89 deletions(-)

diff --git a/t/chainlint.sed b/t/chainlint.sed
index f5fcca09ca..2689e13636 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -76,12 +76,6 @@
 # newline, thus the closing here-doc tag has been found. The closing tag line
 # and the "<...>" prefix on the target line are then discarded, leaving just
 # the target line "cat >out".
-#
-# To facilitate regression testing (and manual debugging), a ">" annotation is
-# applied to the line containing ")" which closes a subshell, ">>" to a line
-# closing a nested subshell, and ">>>" to a line closing both at once. This
-# makes it easy to detect whether the heuristics correctly identify
-# end-of-subshell.
 #------------------------------------------------------------------------------
 
 # incomplete line -- slurp up next line
@@ -337,7 +331,6 @@ n
 x
 bnstslrp
 :nstcl
-s/^/>>/
 # is it "))" which closes nested and parent subshells?
 /)[ 	]*)/bslurp
 bchkchn
@@ -357,7 +350,6 @@ x
 s/\( ?!AMP?!\)* ?!AMP?!$//
 p
 x
-s/^/>/
 b
 
 # found closing "...)" -- exit subshell loop
@@ -365,5 +357,4 @@ b
 x
 p
 x
-s/^/>/
 b
diff --git a/t/chainlint/arithmetic-expansion.expect b/t/chainlint/arithmetic-expansion.expect
index 56cd5b69f5..46ee1046af 100644
--- a/t/chainlint/arithmetic-expansion.expect
+++ b/t/chainlint/arithmetic-expansion.expect
@@ -2,8 +2,8 @@
 	foo &&
 	bar=$((42 + 1)) &&
 	baz
->) &&
+) &&
 (
 	bar=$((42 + 1)) ?!AMP?!
 	baz
->)
+)
diff --git a/t/chainlint/bash-array.expect b/t/chainlint/bash-array.expect
index c4a830d1c1..4c34eaee45 100644
--- a/t/chainlint/bash-array.expect
+++ b/t/chainlint/bash-array.expect
@@ -2,9 +2,9 @@
 	foo &&
 	bar=(gumbo stumbo wumbo) &&
 	baz
->) &&
+) &&
 (
 	foo &&
 	bar=${#bar[@]} &&
 	baz
->)
+)
diff --git a/t/chainlint/blank-line.expect b/t/chainlint/blank-line.expect
index 3be939ed38..f76fde1ffb 100644
--- a/t/chainlint/blank-line.expect
+++ b/t/chainlint/blank-line.expect
@@ -1,4 +1,4 @@
 (
 	nothing &&
 	something
->)
+)
diff --git a/t/chainlint/block.expect b/t/chainlint/block.expect
index 6333237cb2..da60257ebc 100644
--- a/t/chainlint/block.expect
+++ b/t/chainlint/block.expect
@@ -9,4 +9,4 @@
 		echo c
 	} ?!AMP?!
 	baz
->)
+)
diff --git a/t/chainlint/broken-chain.expect b/t/chainlint/broken-chain.expect
index 0960a8c7c0..cfb58fb6b9 100644
--- a/t/chainlint/broken-chain.expect
+++ b/t/chainlint/broken-chain.expect
@@ -3,4 +3,4 @@
 	bar ?!AMP?!
 	baz &&
 	wop
->)
+)
diff --git a/t/chainlint/case.expect b/t/chainlint/case.expect
index a4b92d4613..31f280d8ce 100644
--- a/t/chainlint/case.expect
+++ b/t/chainlint/case.expect
@@ -4,16 +4,16 @@
 	*) bar ;;
 	esac &&
 	foobar
->) &&
+) &&
 (
 	case "$x" in
 	x) foo ;;
 	*) bar ;;
 	esac ?!AMP?!
 	foobar
->) &&
+) &&
 (
 	case "$x" in 1) true;; esac &&
 	case "$y" in 2) false;; esac ?!AMP?!
 	foobar
->)
+)
diff --git a/t/chainlint/close-nested-and-parent-together.expect b/t/chainlint/close-nested-and-parent-together.expect
index 2a910f9d66..5ef509eb49 100644
--- a/t/chainlint/close-nested-and-parent-together.expect
+++ b/t/chainlint/close-nested-and-parent-together.expect
@@ -1,4 +1,4 @@
 (
 cd foo &&
 	(bar &&
->>>		baz))
+		baz))
diff --git a/t/chainlint/close-subshell.expect b/t/chainlint/close-subshell.expect
index 184688718a..0f87db9ae6 100644
--- a/t/chainlint/close-subshell.expect
+++ b/t/chainlint/close-subshell.expect
@@ -1,25 +1,25 @@
 (
 	foo
->) &&
+) &&
 (
 	bar
->) >out &&
+) >out &&
 (
 	baz
->) 2>err &&
+) 2>err &&
 (
 	boo
->) <input &&
+) <input &&
 (
 	bip
->) | wuzzle &&
+) | wuzzle &&
 (
 	bop
->) | fazz 	fozz &&
+) | fazz 	fozz &&
 (
 	bup
->) |
+) |
 fuzzle &&
 (
 	yop
->)
+)
diff --git a/t/chainlint/command-substitution.expect b/t/chainlint/command-substitution.expect
index f276067b7b..c72e4df9e7 100644
--- a/t/chainlint/command-substitution.expect
+++ b/t/chainlint/command-substitution.expect
@@ -2,8 +2,8 @@
 	foo &&
 	bar=$(gobble) &&
 	baz
->) &&
+) &&
 (
 	bar=$(gobble blocks) ?!AMP?!
 	baz
->)
+)
diff --git a/t/chainlint/comment.expect b/t/chainlint/comment.expect
index 3be939ed38..f76fde1ffb 100644
--- a/t/chainlint/comment.expect
+++ b/t/chainlint/comment.expect
@@ -1,4 +1,4 @@
 (
 	nothing &&
 	something
->)
+)
diff --git a/t/chainlint/complex-if-in-cuddled-loop.expect b/t/chainlint/complex-if-in-cuddled-loop.expect
index 9674b88cf2..b8aa626ed0 100644
--- a/t/chainlint/complex-if-in-cuddled-loop.expect
+++ b/t/chainlint/complex-if-in-cuddled-loop.expect
@@ -6,5 +6,5 @@ for i in a b c; do
    else
      echo >file
    fi
-> done) &&
+ done) &&
 test ! -f file
diff --git a/t/chainlint/cuddled-if-then-else.expect b/t/chainlint/cuddled-if-then-else.expect
index ab2a026fbc..4e089b087a 100644
--- a/t/chainlint/cuddled-if-then-else.expect
+++ b/t/chainlint/cuddled-if-then-else.expect
@@ -3,5 +3,5 @@ if test -z ""; then
     echo empty
  else
     echo bizzy
-> fi) &&
+ fi) &&
 echo foobar
diff --git a/t/chainlint/cuddled-loop.expect b/t/chainlint/cuddled-loop.expect
index 8c0260d7f1..7932303763 100644
--- a/t/chainlint/cuddled-loop.expect
+++ b/t/chainlint/cuddled-loop.expect
@@ -1,5 +1,5 @@
 (
  while read x
   do foobar bop || exit 1
->  done <file ) &&
+  done <file ) &&
 outside subshell
diff --git a/t/chainlint/cuddled.expect b/t/chainlint/cuddled.expect
index b6c4ed90a9..773476adc8 100644
--- a/t/chainlint/cuddled.expect
+++ b/t/chainlint/cuddled.expect
@@ -1,21 +1,21 @@
 (
 cd foo &&
 	bar
->) &&
+) &&
 
 (
 cd foo ?!AMP?!
 	bar
->) &&
+) &&
 
 (
 	cd foo &&
->	bar) &&
+	bar) &&
 
 (
 cd foo &&
->	bar) &&
+	bar) &&
 
 (
 cd foo ?!AMP?!
->	bar)
+	bar)
diff --git a/t/chainlint/exit-loop.expect b/t/chainlint/exit-loop.expect
index 84d8bdebc0..f76aa60466 100644
--- a/t/chainlint/exit-loop.expect
+++ b/t/chainlint/exit-loop.expect
@@ -5,7 +5,7 @@
 		bar &&
 		baz
 	done
->) &&
+) &&
 (
 	while true
 	do
@@ -13,7 +13,7 @@
 		bar &&
 		baz
 	done
->) &&
+) &&
 (
 	i=0 &&
 	while test $i -lt 10
@@ -21,4 +21,4 @@
 		echo $i || exit
 		i=$(($i + 1))
 	done
->)
+)
diff --git a/t/chainlint/exit-subshell.expect b/t/chainlint/exit-subshell.expect
index bf78454f74..da80339f78 100644
--- a/t/chainlint/exit-subshell.expect
+++ b/t/chainlint/exit-subshell.expect
@@ -2,4 +2,4 @@
 	foo || exit 1
 	bar &&
 	baz
->)
+)
diff --git a/t/chainlint/for-loop.expect b/t/chainlint/for-loop.expect
index dc209e21bd..b74df064c5 100644
--- a/t/chainlint/for-loop.expect
+++ b/t/chainlint/for-loop.expect
@@ -8,4 +8,4 @@
 		echo $i &&
 		cat $i
 	done
->)
+)
diff --git a/t/chainlint/here-doc-close-subshell.expect b/t/chainlint/here-doc-close-subshell.expect
index f011e335e5..e748526570 100644
--- a/t/chainlint/here-doc-close-subshell.expect
+++ b/t/chainlint/here-doc-close-subshell.expect
@@ -1,2 +1,2 @@
 (
->	cat)
+	cat)
diff --git a/t/chainlint/here-doc-multi-line-command-subst.expect b/t/chainlint/here-doc-multi-line-command-subst.expect
index 3a35bb014c..f1248f8ade 100644
--- a/t/chainlint/here-doc-multi-line-command-subst.expect
+++ b/t/chainlint/here-doc-multi-line-command-subst.expect
@@ -1,5 +1,5 @@
 (
 	x=$(bobble &&
->>		wiffle) ?!AMP?!
+		wiffle) ?!AMP?!
 	echo $x
->)
+)
diff --git a/t/chainlint/here-doc-multi-line-string.expect b/t/chainlint/here-doc-multi-line-string.expect
index a3b9a5472d..7e883b252e 100644
--- a/t/chainlint/here-doc-multi-line-string.expect
+++ b/t/chainlint/here-doc-multi-line-string.expect
@@ -1,4 +1,4 @@
 (
 	cat && echo "multi-line	string" ?!AMP?!
 	bap
->)
+)
diff --git a/t/chainlint/if-in-loop.expect b/t/chainlint/if-in-loop.expect
index 7d91837269..03b82a3e58 100644
--- a/t/chainlint/if-in-loop.expect
+++ b/t/chainlint/if-in-loop.expect
@@ -9,4 +9,4 @@
 		foo
 	done ?!AMP?!
 	bar
->)
+)
diff --git a/t/chainlint/if-then-else.expect b/t/chainlint/if-then-else.expect
index 3055d5606c..debcf7b756 100644
--- a/t/chainlint/if-then-else.expect
+++ b/t/chainlint/if-then-else.expect
@@ -11,10 +11,10 @@
 		cat
 	fi ?!AMP?!
 	echo poodle
->) &&
+) &&
 (
 	if test -n ""; then
 		echo very &&
 		echo empty
 	fi
->)
+)
diff --git a/t/chainlint/incomplete-line.expect b/t/chainlint/incomplete-line.expect
index 2f3ebabdc2..ffac8f9018 100644
--- a/t/chainlint/incomplete-line.expect
+++ b/t/chainlint/incomplete-line.expect
@@ -1,4 +1,4 @@
 line 1 line 2 line 3 line 4 &&
 (
 	line 5 	line 6 	line 7 	line 8
->)
+)
diff --git a/t/chainlint/inline-comment.expect b/t/chainlint/inline-comment.expect
index 3d655a32b0..f6b42757d2 100644
--- a/t/chainlint/inline-comment.expect
+++ b/t/chainlint/inline-comment.expect
@@ -2,8 +2,8 @@
 	foobar &&
 	barfoo ?!AMP?!
 	flibble "not a # comment"
->) &&
+) &&
 
 (
 cd foo &&
->	flibble "not a # comment")
+	flibble "not a # comment")
diff --git a/t/chainlint/loop-in-if.expect b/t/chainlint/loop-in-if.expect
index cebd3ae95e..e1be42376c 100644
--- a/t/chainlint/loop-in-if.expect
+++ b/t/chainlint/loop-in-if.expect
@@ -9,4 +9,4 @@
 		foo
 	fi ?!AMP?!
 	bar
->)
+)
diff --git a/t/chainlint/multi-line-nested-command-substitution.expect b/t/chainlint/multi-line-nested-command-substitution.expect
index 59b6c8b850..300058341b 100644
--- a/t/chainlint/multi-line-nested-command-substitution.expect
+++ b/t/chainlint/multi-line-nested-command-substitution.expect
@@ -3,16 +3,16 @@
 	x=$(
 		echo bar |
 		cat
->>	) &&
+	) &&
 	echo ok
->) |
+) |
 sort &&
 (
 	bar &&
 	x=$(echo bar |
 		cat
->>	) &&
+	) &&
 	y=$(echo baz |
->>		fip) &&
+		fip) &&
 	echo fail
->)
+)
diff --git a/t/chainlint/multi-line-string.expect b/t/chainlint/multi-line-string.expect
index f1be2baf0a..ab0dadf748 100644
--- a/t/chainlint/multi-line-string.expect
+++ b/t/chainlint/multi-line-string.expect
@@ -2,8 +2,8 @@
 	x="line 1		line 2		line 3" &&
 	y="line 1		line2" ?!AMP?!
 	foobar
->) &&
+) &&
 (
 	echo "xyz" "abc		def		ghi" &&
 	barfoo
->)
+)
diff --git a/t/chainlint/nested-cuddled-subshell.expect b/t/chainlint/nested-cuddled-subshell.expect
index aa522658ed..2a86885ee6 100644
--- a/t/chainlint/nested-cuddled-subshell.expect
+++ b/t/chainlint/nested-cuddled-subshell.expect
@@ -1,19 +1,19 @@
 (
 	(cd foo &&
 		bar
->>	) &&
+	) &&
 	(cd foo &&
 		bar
->>	) ?!AMP?!
+	) ?!AMP?!
 	(
 		cd foo &&
->>		bar) &&
+		bar) &&
 	(
 		cd foo &&
->>		bar) ?!AMP?!
+		bar) ?!AMP?!
 	(cd foo &&
->>		bar) &&
+		bar) &&
 	(cd foo &&
->>		bar) ?!AMP?!
+		bar) ?!AMP?!
 	foobar
->)
+)
diff --git a/t/chainlint/nested-here-doc.expect b/t/chainlint/nested-here-doc.expect
index f9604d3fac..2a51205d32 100644
--- a/t/chainlint/nested-here-doc.expect
+++ b/t/chainlint/nested-here-doc.expect
@@ -4,4 +4,4 @@ cat >foop &&
 	cat &&
 	cat ?!AMP?!
 	foobar
->)
+)
diff --git a/t/chainlint/nested-subshell-comment.expect b/t/chainlint/nested-subshell-comment.expect
index 925e49bae9..9138cf386d 100644
--- a/t/chainlint/nested-subshell-comment.expect
+++ b/t/chainlint/nested-subshell-comment.expect
@@ -6,6 +6,6 @@
 		# minor numbers of cows (or do they?)
 		baz &&
 		snaff
->>	) ?!AMP?!
+	) ?!AMP?!
 	fuzzy
->)
+)
diff --git a/t/chainlint/nested-subshell.expect b/t/chainlint/nested-subshell.expect
index c8165ad19e..41a48adaa2 100644
--- a/t/chainlint/nested-subshell.expect
+++ b/t/chainlint/nested-subshell.expect
@@ -3,10 +3,10 @@
 	(
 		echo a &&
 		echo b
->>	) >file &&
+	) >file &&
 	cd foo &&
 	(
 		echo a
 		echo b
->>	) >file
->)
+	) >file
+)
diff --git a/t/chainlint/p4-filespec.expect b/t/chainlint/p4-filespec.expect
index 98b3d881fd..1290fd1ff2 100644
--- a/t/chainlint/p4-filespec.expect
+++ b/t/chainlint/p4-filespec.expect
@@ -1,4 +1,4 @@
 (
 	p4 print -1 //depot/fiddle#42 >file &&
 	foobar
->)
+)
diff --git a/t/chainlint/pipe.expect b/t/chainlint/pipe.expect
index ede6bcc607..2cfc028297 100644
--- a/t/chainlint/pipe.expect
+++ b/t/chainlint/pipe.expect
@@ -5,4 +5,4 @@
 	fish |
 	cow ?!AMP?!
 	sunder
->)
+)
diff --git a/t/chainlint/semicolon.expect b/t/chainlint/semicolon.expect
index 54a08ce582..05141a96cf 100644
--- a/t/chainlint/semicolon.expect
+++ b/t/chainlint/semicolon.expect
@@ -1,20 +1,20 @@
 (
 	cat foo ; ?!AMP?! echo bar ?!AMP?!
 	cat foo ; ?!AMP?! echo bar
->) &&
+) &&
 (
 	cat foo ; ?!AMP?! echo bar &&
 	cat foo ; ?!AMP?! echo bar
->) &&
+) &&
 (
 	echo "foo; bar" &&
 	cat foo; ?!AMP?! echo bar
->) &&
+) &&
 (
 	foo;
->) &&
+) &&
 (
 cd foo &&
 	for i in a b c; do
 		echo;
->	done)
+	done)
diff --git a/t/chainlint/subshell-here-doc.expect b/t/chainlint/subshell-here-doc.expect
index 9d3f25b3f5..b7250ca753 100644
--- a/t/chainlint/subshell-here-doc.expect
+++ b/t/chainlint/subshell-here-doc.expect
@@ -2,9 +2,9 @@
 	echo wobba 	       gorgo snoot 	       wafta snurb &&
 	cat >bip ?!AMP?!
 	echo >bop
->) &&
+) &&
 (
 	cat >bup &&
 	cat >bup3 &&
 	meep
->)
+)
diff --git a/t/chainlint/subshell-one-liner.expect b/t/chainlint/subshell-one-liner.expect
index 4b44632b09..b7015361bf 100644
--- a/t/chainlint/subshell-one-liner.expect
+++ b/t/chainlint/subshell-one-liner.expect
@@ -11,4 +11,4 @@
 	(foo && bar) ?!AMP?!
 	(foo && bar; ?!AMP?! baz) ?!AMP?!
 	foobar
->)
+)
diff --git a/t/chainlint/t7900-subtree.expect b/t/chainlint/t7900-subtree.expect
index f769244ef6..215aca01c2 100644
--- a/t/chainlint/t7900-subtree.expect
+++ b/t/chainlint/t7900-subtree.expect
@@ -1,10 +1,10 @@
 (
 	chks="sub1sub2sub3sub4" &&
 	chks_sub=$(cat | sed "s,^,sub dir/,"
->>) &&
+) &&
 	chkms="main-sub1main-sub2main-sub3main-sub4" &&
 	chkms_sub=$(cat | sed "s,^,sub dir/,"
->>) &&
+) &&
 	subfiles=$(git ls-files) &&
 	check_equal "$subfiles" "$chkms$chks"
->)
+)
diff --git a/t/chainlint/while-loop.expect b/t/chainlint/while-loop.expect
index f8b9fcf62b..e2813b378e 100644
--- a/t/chainlint/while-loop.expect
+++ b/t/chainlint/while-loop.expect
@@ -8,4 +8,4 @@
 		echo foo &&
 		cat bar
 	done
->)
+)
-- 
2.34.1.397.gfae76fe5da

