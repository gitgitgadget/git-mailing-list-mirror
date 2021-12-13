Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAC4C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 06:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhLMGc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 01:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbhLMGcU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 01:32:20 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39428C0698C5
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:10 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id a11so14109008ilj.6
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O8Ez1BvzXJtluEwIyI2ASZiFObjiY0yXIEqHMO+W82s=;
        b=MQX5mK1lgJZ2WsvbcVERQiFcUeNhFbWY6CFE88Ka8sf2ajy+d6DQpPQHTRS/vJTisP
         YCAfXDP9FNJae6jOo7hUm5Q4EaBNbBFwfLuSyU4hxFAS4dTjZwj/34G8CXLk18+Ifgft
         r7OuVKJ9rnF0+tkyka8xiHJ9pK82yuvDsj0FjnUzPVx0o77pt5rBLxU8A8BuutazLV/+
         Cso2unRi4z4Y6DdroObyNIZcJ8NeXmpdBXR0fCPKtu87SrMi1fqJ9aTbYOsyIvdPmOqm
         XVf19XfDqZ6o1QRsTQvqx5lwmQ5lCLnLK9JvyVglp1kY3GipwjgXxZeppFK/QM9gYk2c
         ELEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=O8Ez1BvzXJtluEwIyI2ASZiFObjiY0yXIEqHMO+W82s=;
        b=b8S1+2dJ8q7sUWQ9LHkRf/MFNIBEvPUflTxE2SOjwlPNQDwW8JqrFUS3NcSPEiTWpM
         Zt3N9y3ll6ZwWvWRAUas8jCiuqKvuX0khmtmNDQdusMXO9Ie8CU6XjJMwitz2uHXEwtJ
         xyW/iYqvYcBsO01xmJoF4/Z9hi8sdNLieifqEFh54Wu2czzM4GU+6Fv88CrRbXk+Q2Rz
         HazZd2b+UnQfozE5VER3Fc8PTuPgwFnyO6aZcz+j0Ax829rSh7GUA+NrKG5EbyX2Hj9z
         7W/0OY4kU8j/hCX4JVWel3iiMXGILAtDxr9LN2nGsnxx/I9Xjd8w5GlhKwlngCulWcT5
         36yA==
X-Gm-Message-State: AOAM5330UQNui/Z47B4lYmQrrwN16lM4M4YJycb16WiU399dUxdgUlYb
        6fcZ1Vi3TOlOg4viJA268yOE7V8inuuWcA==
X-Google-Smtp-Source: ABdhPJzVVFsgQj6/+fijI0MywWhdp9deXtL43+GkAFMOrJ4QGacWrMTQaj4d8IFxzOhmg14sbTrwJw==
X-Received: by 2002:a92:1a0f:: with SMTP id a15mr5749867ila.49.1639377129284;
        Sun, 12 Dec 2021 22:32:09 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id f10sm7305408ils.13.2021.12.12.22.32.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 22:32:09 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 15/15] chainlint.sed: stop splitting "(..." into separate lines "(" and "..."
Date:   Mon, 13 Dec 2021 01:30:59 -0500
Message-Id: <20211213063059.19424-16-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.397.gfae76fe5da
In-Reply-To: <20211213063059.19424-1-sunshine@sunshineco.com>
References: <20211213063059.19424-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Because `sed` is line-oriented, for ease of implementation, when
chainlint.sed encounters an opening subshell in which the first command
is cuddled with the "(", it splits the line into two lines: one
containing only "(", and the other containing whatever follows "(".
This allows chainlint.sed to get by with a single set of regular
expressions for matching shell statements rather than having to
duplicate each expression (one set for matching non-cuddled statements,
and one set for matching cuddled statements).

However, although syntactically and semantically immaterial, this
transformation has no value to test authors and might even confuse them
into thinking that the linter is misbehaving by inserting (whitespace)
line-noise into the shell code it is validating. Moreover, it also
allows an implementation detail of chainlint.sed to seep into the
chainlint self-test "expect" files, which potentially makes it difficult
to reuse the self-tests should a more capable chainlint ever be
developed.

To address these concerns, stop splitting cuddled "(..." into two lines.

Note that, as an implementation artifact, due to sed's line-oriented
nature, this change inserts a blank line at output time just before the
"(..." line is emitted. It would be possible to suppress this blank line
but doing so would add a fair bit of complexity to chainlint.sed.
Therefore, rather than suppressing the extra blank line, the Makefile's
`check-chainlint` target which runs the chainlint self-tests is instead
modified to ignore blank lines when comparing chainlint output against
the self-test "expect" output. This is a reasonable compromise for two
reasons. First, the purpose of the chainlint self-tests is to verify
that the ?!AMP?! annotations are being correctly added; precise
whitespace is immaterial. Second, by necessity, chainlint.sed itself
already throws away all blank lines within subshells since, when
checking for a broken &&-chain, it needs to check the final _statement_
in a subshell, not the final _line_ (which might be blank), thus it has
never made any attempt to precisely reproduce blank lines in its output.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/Makefile                                    |  4 +-
 t/chainlint.sed                               | 38 ++++++++++++-------
 .../close-nested-and-parent-together.expect   |  3 +-
 t/chainlint/complex-if-in-cuddled-loop.expect |  3 +-
 t/chainlint/cuddled-if-then-else.expect       |  3 +-
 t/chainlint/cuddled-loop.expect               |  3 +-
 t/chainlint/cuddled.expect                    | 12 ++----
 t/chainlint/inline-comment.expect             |  3 +-
 t/chainlint/semicolon.expect                  |  3 +-
 9 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index f4ae40be46..46cd5fc527 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -72,8 +72,8 @@ clean-chainlint:
 check-chainlint:
 	@mkdir -p '$(CHAINLINTTMP_SQ)' && \
 	sed -e '/^# LINT: /d' $(patsubst %,chainlint/%.test,$(CHAINLINTTESTS)) >'$(CHAINLINTTMP_SQ)'/tests && \
-	cat $(patsubst %,chainlint/%.expect,$(CHAINLINTTESTS)) >'$(CHAINLINTTMP_SQ)'/expect && \
-	$(CHAINLINT) '$(CHAINLINTTMP_SQ)'/tests >'$(CHAINLINTTMP_SQ)'/actual && \
+	sed -e '/^[ 	]*$$/d' $(patsubst %,chainlint/%.expect,$(CHAINLINTTESTS)) >'$(CHAINLINTTMP_SQ)'/expect && \
+	$(CHAINLINT) '$(CHAINLINTTMP_SQ)'/tests | grep -v '^[	]*$$' >'$(CHAINLINTTMP_SQ)'/actual && \
 	diff -u '$(CHAINLINTTMP_SQ)'/expect '$(CHAINLINTTMP_SQ)'/actual
 
 test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax \
diff --git a/t/chainlint.sed b/t/chainlint.sed
index b1505ef2cd..dc4ce37cb5 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -131,11 +131,15 @@ b
 	h
 	bnextln
 }
-# "(..." line -- split off and stash "(", then process "..." as its own line
+# "(..." line -- "(" opening subshell cuddled with command; temporarily replace
+# "(" with sentinel "^" and process the line as if "(" had been seen solo on
+# the preceding line; this temporary replacement prevents several rules from
+# accidentally thinking "(" introduces a nested subshell; "^" is changed back
+# to "(" at output time
 x
-s/.*/(/
+s/.*//
 x
-s/(//
+s/(/^/
 bslurp
 
 :nextln
@@ -168,12 +172,12 @@ s/.*\n//
 	/"[^"]*#[^"]*"/!s/[ 	]#.*$//
 }
 # one-liner "case ... esac"
-/^[ 	]*case[ 	]*..*esac/bchkchn
+/^[ 	^]*case[ 	]*..*esac/bchkchn
 # multi-line "case ... esac"
-/^[ 	]*case[ 	]..*[ 	]in/bcase
+/^[ 	^]*case[ 	]..*[ 	]in/bcase
 # multi-line "for ... done" or "while ... done"
-/^[ 	]*for[ 	]..*[ 	]in/bcont
-/^[ 	]*while[ 	]/bcont
+/^[ 	^]*for[ 	]..*[ 	]in/bcont
+/^[ 	^]*while[ 	]/bcont
 /^[ 	]*do[ 	]/bcont
 /^[ 	]*do[ 	]*$/bcont
 /;[ 	]*do/bcont
@@ -184,7 +188,7 @@ s/.*\n//
 /||[ 	]*exit[ 	]/bcont
 /||[ 	]*exit[ 	]*$/bcont
 # multi-line "if...elsif...else...fi"
-/^[ 	]*if[ 	]/bcont
+/^[ 	^]*if[ 	]/bcont
 /^[ 	]*then[ 	]/bcont
 /^[ 	]*then[ 	]*$/bcont
 /;[ 	]*then/bcont
@@ -197,15 +201,15 @@ s/.*\n//
 /^[ 	]*fi[ 	]*[<>|]/bdone
 /^[ 	]*fi[ 	]*)/bdone
 # nested one-liner "(...) &&"
-/^[ 	]*(.*)[ 	]*&&[ 	]*$/bchkchn
+/^[ 	^]*(.*)[ 	]*&&[ 	]*$/bchkchn
 # nested one-liner "(...)"
-/^[ 	]*(.*)[ 	]*$/bchkchn
+/^[ 	^]*(.*)[ 	]*$/bchkchn
 # nested one-liner "(...) >x" (or "2>x" or "<x" or "|x")
-/^[ 	]*(.*)[ 	]*[0-9]*[<>|]/bchkchn
+/^[ 	^]*(.*)[ 	]*[0-9]*[<>|]/bchkchn
 # nested multi-line "(...\n...)"
-/^[ 	]*(/bnest
+/^[ 	^]*(/bnest
 # multi-line "{...\n...}"
-/^[ 	]*{/bblock
+/^[ 	^]*{/bblock
 # closing ")" on own line -- exit subshell
 /^[ 	]*)/bclssolo
 # "$((...))" -- arithmetic expansion; not closing ")"
@@ -237,6 +241,7 @@ s/.*\n//
 :cont
 # retrieve and print previous line
 x
+s/^\([ 	]*\)^/\1(/
 s/?!HERE?!/<</g
 n
 bslurp
@@ -292,6 +297,7 @@ bfolded
 # found "case ... in" -- pass through untouched
 :case
 x
+s/^\([ 	]*\)^/\1(/
 s/?!HERE?!/<</g
 n
 :cascom
@@ -326,6 +332,7 @@ bchkchn
 :nest
 x
 :nstslrp
+s/^\([ 	]*\)^/\1(/
 s/?!HERE?!/<</g
 n
 :nstcom
@@ -354,6 +361,7 @@ bchkchn
 # found multi-line "{...\n...}" block -- pass through untouched
 :block
 x
+s/^\([ 	]*\)^/\1(/
 s/?!HERE?!/<</g
 n
 :blkcom
@@ -371,17 +379,21 @@ bblock
 :clssolo
 x
 s/\( ?!AMP?!\)* ?!AMP?!$//
+s/^\([ 	]*\)^/\1(/
 s/?!HERE?!/<</g
 p
 x
+s/^\([ 	]*\)^/\1(/
 s/?!HERE?!/<</g
 b
 
 # found closing "...)" -- exit subshell loop
 :close
 x
+s/^\([ 	]*\)^/\1(/
 s/?!HERE?!/<</g
 p
 x
+s/^\([ 	]*\)^/\1(/
 s/?!HERE?!/<</g
 b
diff --git a/t/chainlint/close-nested-and-parent-together.expect b/t/chainlint/close-nested-and-parent-together.expect
index 5ef509eb49..72d482f76d 100644
--- a/t/chainlint/close-nested-and-parent-together.expect
+++ b/t/chainlint/close-nested-and-parent-together.expect
@@ -1,4 +1,3 @@
-(
-cd foo &&
+(cd foo &&
 	(bar &&
 		baz))
diff --git a/t/chainlint/complex-if-in-cuddled-loop.expect b/t/chainlint/complex-if-in-cuddled-loop.expect
index b8aa626ed0..2fca183409 100644
--- a/t/chainlint/complex-if-in-cuddled-loop.expect
+++ b/t/chainlint/complex-if-in-cuddled-loop.expect
@@ -1,5 +1,4 @@
-(
-for i in a b c; do
+(for i in a b c; do
    if test "$(echo $(waffle bat))" = "eleventeen" &&
      test "$x" = "$y"; then
      :
diff --git a/t/chainlint/cuddled-if-then-else.expect b/t/chainlint/cuddled-if-then-else.expect
index 4e089b087a..1d8ed58c49 100644
--- a/t/chainlint/cuddled-if-then-else.expect
+++ b/t/chainlint/cuddled-if-then-else.expect
@@ -1,5 +1,4 @@
-(
-if test -z ""; then
+(if test -z ""; then
     echo empty
  else
     echo bizzy
diff --git a/t/chainlint/cuddled-loop.expect b/t/chainlint/cuddled-loop.expect
index 7932303763..9cf260708e 100644
--- a/t/chainlint/cuddled-loop.expect
+++ b/t/chainlint/cuddled-loop.expect
@@ -1,5 +1,4 @@
-(
- while read x
+( while read x
   do foobar bop || exit 1
   done <file ) &&
 outside subshell
diff --git a/t/chainlint/cuddled.expect b/t/chainlint/cuddled.expect
index 773476adc8..c3e0be4047 100644
--- a/t/chainlint/cuddled.expect
+++ b/t/chainlint/cuddled.expect
@@ -1,10 +1,8 @@
-(
-cd foo &&
+(cd foo &&
 	bar
 ) &&
 
-(
-cd foo ?!AMP?!
+(cd foo ?!AMP?!
 	bar
 ) &&
 
@@ -12,10 +10,8 @@ cd foo ?!AMP?!
 	cd foo &&
 	bar) &&
 
-(
-cd foo &&
+(cd foo &&
 	bar) &&
 
-(
-cd foo ?!AMP?!
+(cd foo ?!AMP?!
 	bar)
diff --git a/t/chainlint/inline-comment.expect b/t/chainlint/inline-comment.expect
index f6b42757d2..dd0dace077 100644
--- a/t/chainlint/inline-comment.expect
+++ b/t/chainlint/inline-comment.expect
@@ -4,6 +4,5 @@
 	flibble "not a # comment"
 ) &&
 
-(
-cd foo &&
+(cd foo &&
 	flibble "not a # comment")
diff --git a/t/chainlint/semicolon.expect b/t/chainlint/semicolon.expect
index 05141a96cf..ed0b3707ae 100644
--- a/t/chainlint/semicolon.expect
+++ b/t/chainlint/semicolon.expect
@@ -13,8 +13,7 @@
 (
 	foo;
 ) &&
-(
-cd foo &&
+(cd foo &&
 	for i in a b c; do
 		echo;
 	done)
-- 
2.34.1.397.gfae76fe5da

