From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] t4034 (diff --word-diff): style suggestions
Date: Tue, 11 Jan 2011 15:49:57 -0600
Message-ID: <20110111214957.GD29133@burratino>
References: <cover.1292688058.git.trast@student.ethz.ch>
 <854c8b6fa8a368bb34cc22d3fc948ae7136ed177.1292688058.git.trast@student.ethz.ch>
 <20110111214707.GA29133@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Johnson <scottj75074@yahoo.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 11 22:50:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcm6b-0003PT-Mx
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 22:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756191Ab1AKVuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 16:50:13 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65179 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621Ab1AKVuL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 16:50:11 -0500
Received: by wyb28 with SMTP id 28so20943060wyb.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 13:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=OkrrnnCAiG49B9sM4zXQ8jDhqra3e0GHdX4geVs6QwI=;
        b=csRDMu1dXzVirohIkYbuYOnA+UOkYEmexqQDY8y9Q/4DZ2RocC5nT4MPe356Sruif0
         mf4bIbnXTGwwv4ZmmuehB3vqqzjsxjiNkppcdfsOpSkW/6UKnw/4dqzIsQtMD4VPRdNu
         3xKq0AsMcglre2m0wX99sYcm+TT8A+ADv6hY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=K39CJ166FnRIHfuCsXwNKBgALDLe3P6FXL8+XP7j8A5NnpN5zz0YWEHd1SABU/O6QI
         mFcMPbxmFokS7psbwpS9vkbUw+TTbcrmBh6uTNYk9V2gjSKpiQ0uwwMdlG2PJrUQ83Mm
         hJHG63++VsoDAjYeiPXV3N18o4hN2AuYFpTFU=
Received: by 10.227.179.77 with SMTP id bp13mr105385wbb.226.1294782609407;
        Tue, 11 Jan 2011 13:50:09 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id m10sm21296060wbc.4.2011.01.11.13.50.06
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 Jan 2011 13:50:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110111214707.GA29133@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164995>

Rearrange code to be easier to browse:

 - first data
 - then functions
 - then test assertions

Mark up inline test vectors as

  cat >vector <<-\EOF
	data
	data
  EOF

for visual scannability.  Use words like "set up" for tests that set
up for other tests, to make it obvious which tests are safe to skip.
Use repeated function calls instead of a loop for the
language-specific tests, so the invocations can be easily tweaked
individually (for example if one starts to fail).

This means if you add a new subdirectory to t4034/, it will not be
automatically used.  I think that's worth it for the added
explicitness.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4034-diff-words.sh |  476 ++++++++++++++++++++++--------------------------
 1 files changed, 218 insertions(+), 258 deletions(-)

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 2647191..c3b1c48 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -4,346 +4,306 @@ test_description='word diff colors'
 
 . ./test-lib.sh
 
+cat >pre.simple <<-\EOF
+	h(4)
+
+	a = b + c
+EOF
+cat >post.simple <<-\EOF
+	h(4),hh[44]
+
+	a = b + c
+
+	aa = a
+
+	aeff = aeff * ( aaa )
+EOF
+cat >expect.letter-runs-are-words <<-\EOF
+	<BOLD>diff --git a/pre b/post<RESET>
+	<BOLD>index 330b04f..5ed8eff 100644<RESET>
+	<BOLD>--- a/pre<RESET>
+	<BOLD>+++ b/post<RESET>
+	<CYAN>@@ -1,3 +1,7 @@<RESET>
+	h(4),<GREEN>hh<RESET>[44]
+
+	a = b + c<RESET>
+
+	<GREEN>aa = a<RESET>
+
+	<GREEN>aeff = aeff * ( aaa<RESET> )
+EOF
+cat >expect.non-whitespace-is-word <<-\EOF
+	<BOLD>diff --git a/pre b/post<RESET>
+	<BOLD>index 330b04f..5ed8eff 100644<RESET>
+	<BOLD>--- a/pre<RESET>
+	<BOLD>+++ b/post<RESET>
+	<CYAN>@@ -1,3 +1,7 @@<RESET>
+	h(4)<GREEN>,hh[44]<RESET>
+
+	a = b + c<RESET>
+
+	<GREEN>aa = a<RESET>
+
+	<GREEN>aeff = aeff * ( aaa )<RESET>
+EOF
+
+word_diff () {
+	test_must_fail git diff --no-index "$@" pre post >output &&
+	test_decode_color <output >output.decrypted &&
+	test_cmp expect output.decrypted
+}
+
+test_language_driver () {
+	lang=$1
+	test_expect_success "diff driver '$lang'" '
+		cp "$TEST_DIRECTORY/t4034/'"$lang"'/pre" \
+			"$TEST_DIRECTORY/t4034/'"$lang"'/post" \
+			"$TEST_DIRECTORY/t4034/'"$lang"'/expect" . &&
+		echo "* diff='"$lang"'" >.gitattributes &&
+		word_diff --color-words
+	'
+}
+
 test_expect_success setup '
-
 	git config diff.color.old red &&
 	git config diff.color.new green &&
 	git config diff.color.func magenta
-
 '
 
-word_diff () {
-	test_must_fail git diff --no-index "$@" pre post > output &&
-	test_decode_color <output >output.decrypted &&
-	test_cmp expect output.decrypted
-}
-
-cat > pre <<\EOF
-h(4)
-
-a = b + c
-EOF
-
-cat > post <<\EOF
-h(4),hh[44]
-
-a = b + c
-
-aa = a
-
-aeff = aeff * ( aaa )
-EOF
-
-cat > expect <<\EOF
-<BOLD>diff --git a/pre b/post<RESET>
-<BOLD>index 330b04f..5ed8eff 100644<RESET>
-<BOLD>--- a/pre<RESET>
-<BOLD>+++ b/post<RESET>
-<CYAN>@@ -1,3 +1,7 @@<RESET>
-<RED>h(4)<RESET><GREEN>h(4),hh[44]<RESET>
-
-a = b + c<RESET>
-
-<GREEN>aa = a<RESET>
-
-<GREEN>aeff = aeff * ( aaa )<RESET>
-EOF
+test_expect_success 'set up pre and post with runs of whitespace' '
+	cp pre.simple pre &&
+	cp post.simple post
+'
 
 test_expect_success 'word diff with runs of whitespace' '
+	cat >expect <<-\EOF &&
+		<BOLD>diff --git a/pre b/post<RESET>
+		<BOLD>index 330b04f..5ed8eff 100644<RESET>
+		<BOLD>--- a/pre<RESET>
+		<BOLD>+++ b/post<RESET>
+		<CYAN>@@ -1,3 +1,7 @@<RESET>
+		<RED>h(4)<RESET><GREEN>h(4),hh[44]<RESET>
 
-	word_diff --color-words
+		a = b + c<RESET>
 
-'
-
-test_expect_success '--word-diff=color' '
-
-	word_diff --word-diff=color
-
-'
-
-test_expect_success '--color --word-diff=color' '
+		<GREEN>aa = a<RESET>
 
+		<GREEN>aeff = aeff * ( aaa )<RESET>
+	EOF
+	word_diff --color-words &&
+	word_diff --word-diff=color &&
 	word_diff --color --word-diff=color
-
 '
 
-sed 's/#.*$//' > expect <<EOF
-diff --git a/pre b/post
-index 330b04f..5ed8eff 100644
---- a/pre
-+++ b/post
-@@ -1,3 +1,7 @@
--h(4)
-+h(4),hh[44]
-~
- # significant space
-~
- a = b + c
-~
-~
-+aa = a
-~
-~
-+aeff = aeff * ( aaa )
-~
-EOF
-
 test_expect_success '--word-diff=porcelain' '
-
+	sed 's/#.*$//' >expect <<-\EOF &&
+		diff --git a/pre b/post
+		index 330b04f..5ed8eff 100644
+		--- a/pre
+		+++ b/post
+		@@ -1,3 +1,7 @@
+		-h(4)
+		+h(4),hh[44]
+		~
+		 # significant space
+		~
+		 a = b + c
+		~
+		~
+		+aa = a
+		~
+		~
+		+aeff = aeff * ( aaa )
+		~
+	EOF
 	word_diff --word-diff=porcelain
-
 '
 
-cat > expect <<EOF
-diff --git a/pre b/post
-index 330b04f..5ed8eff 100644
---- a/pre
-+++ b/post
-@@ -1,3 +1,7 @@
-[-h(4)-]{+h(4),hh[44]+}
-
-a = b + c
-
-{+aa = a+}
-
-{+aeff = aeff * ( aaa )+}
-EOF
-
 test_expect_success '--word-diff=plain' '
+	cat >expect <<-\EOF &&
+		diff --git a/pre b/post
+		index 330b04f..5ed8eff 100644
+		--- a/pre
+		+++ b/post
+		@@ -1,3 +1,7 @@
+		[-h(4)-]{+h(4),hh[44]+}
 
-	word_diff --word-diff=plain
+		a = b + c
 
-'
-
-test_expect_success '--word-diff=plain --no-color' '
+		{+aa = a+}
 
+		{+aeff = aeff * ( aaa )+}
+	EOF
+	word_diff --word-diff=plain &&
 	word_diff --word-diff=plain --no-color
-
 '
 
-cat > expect <<EOF
-<BOLD>diff --git a/pre b/post<RESET>
-<BOLD>index 330b04f..5ed8eff 100644<RESET>
-<BOLD>--- a/pre<RESET>
-<BOLD>+++ b/post<RESET>
-<CYAN>@@ -1,3 +1,7 @@<RESET>
-<RED>[-h(4)-]<RESET><GREEN>{+h(4),hh[44]+}<RESET>
-
-a = b + c<RESET>
-
-<GREEN>{+aa = a+}<RESET>
-
-<GREEN>{+aeff = aeff * ( aaa )+}<RESET>
-EOF
-
 test_expect_success '--word-diff=plain --color' '
+	cat >expect <<-\EOF &&
+		<BOLD>diff --git a/pre b/post<RESET>
+		<BOLD>index 330b04f..5ed8eff 100644<RESET>
+		<BOLD>--- a/pre<RESET>
+		<BOLD>+++ b/post<RESET>
+		<CYAN>@@ -1,3 +1,7 @@<RESET>
+		<RED>[-h(4)-]<RESET><GREEN>{+h(4),hh[44]+}<RESET>
 
+		a = b + c<RESET>
+
+		<GREEN>{+aa = a+}<RESET>
+
+		<GREEN>{+aeff = aeff * ( aaa )+}<RESET>
+	EOF
 	word_diff --word-diff=plain --color
-
 '
 
-cat > expect <<\EOF
-<BOLD>diff --git a/pre b/post<RESET>
-<BOLD>index 330b04f..5ed8eff 100644<RESET>
-<BOLD>--- a/pre<RESET>
-<BOLD>+++ b/post<RESET>
-<CYAN>@@ -1 +1 @@<RESET>
-<RED>h(4)<RESET><GREEN>h(4),hh[44]<RESET>
-<CYAN>@@ -3,0 +4,4 @@<RESET> <RESET><MAGENTA>a = b + c<RESET>
-
-<GREEN>aa = a<RESET>
-
-<GREEN>aeff = aeff * ( aaa )<RESET>
-EOF
-
 test_expect_success 'word diff without context' '
+	cat >expect <<-\EOF &&
+		<BOLD>diff --git a/pre b/post<RESET>
+		<BOLD>index 330b04f..5ed8eff 100644<RESET>
+		<BOLD>--- a/pre<RESET>
+		<BOLD>+++ b/post<RESET>
+		<CYAN>@@ -1 +1 @@<RESET>
+		<RED>h(4)<RESET><GREEN>h(4),hh[44]<RESET>
+		<CYAN>@@ -3,0 +4,4 @@<RESET> <RESET><MAGENTA>a = b + c<RESET>
 
+		<GREEN>aa = a<RESET>
+
+		<GREEN>aeff = aeff * ( aaa )<RESET>
+	EOF
 	word_diff --color-words --unified=0
-
 '
 
-cat > expect <<\EOF
-<BOLD>diff --git a/pre b/post<RESET>
-<BOLD>index 330b04f..5ed8eff 100644<RESET>
-<BOLD>--- a/pre<RESET>
-<BOLD>+++ b/post<RESET>
-<CYAN>@@ -1,3 +1,7 @@<RESET>
-h(4),<GREEN>hh<RESET>[44]
-
-a = b + c<RESET>
-
-<GREEN>aa = a<RESET>
-
-<GREEN>aeff = aeff * ( aaa<RESET> )
-EOF
-cp expect expect.letter-runs-are-words
-
 test_expect_success 'word diff with a regular expression' '
-
+	cp expect.letter-runs-are-words expect &&
 	word_diff --color-words="[a-z]+"
-
 '
 
-test_expect_success 'set a diff driver' '
+test_expect_success 'set up a diff driver' '
 	git config diff.testdriver.wordRegex "[^[:space:]]" &&
-	cat <<EOF > .gitattributes
-pre diff=testdriver
-post diff=testdriver
-EOF
+	cat <<-\EOF >.gitattributes
+		pre diff=testdriver
+		post diff=testdriver
+	EOF
 '
 
 test_expect_success 'option overrides .gitattributes' '
-
+	cp expect.letter-runs-are-words expect &&
 	word_diff --color-words="[a-z]+"
-
 '
 
-cat > expect <<\EOF
-<BOLD>diff --git a/pre b/post<RESET>
-<BOLD>index 330b04f..5ed8eff 100644<RESET>
-<BOLD>--- a/pre<RESET>
-<BOLD>+++ b/post<RESET>
-<CYAN>@@ -1,3 +1,7 @@<RESET>
-h(4)<GREEN>,hh[44]<RESET>
-
-a = b + c<RESET>
-
-<GREEN>aa = a<RESET>
-
-<GREEN>aeff = aeff * ( aaa )<RESET>
-EOF
-cp expect expect.non-whitespace-is-word
-
 test_expect_success 'use regex supplied by driver' '
-
+	cp expect.non-whitespace-is-word expect &&
 	word_diff --color-words
-
 '
 
-test_expect_success 'set diff.wordRegex option' '
+test_expect_success 'set up diff.wordRegex option' '
 	git config diff.wordRegex "[[:alnum:]]+"
 '
 
-cp expect.letter-runs-are-words expect
-
 test_expect_success 'command-line overrides config' '
+	cp expect.letter-runs-are-words expect &&
 	word_diff --color-words="[a-z]+"
 '
 
-cat > expect <<\EOF
-<BOLD>diff --git a/pre b/post<RESET>
-<BOLD>index 330b04f..5ed8eff 100644<RESET>
-<BOLD>--- a/pre<RESET>
-<BOLD>+++ b/post<RESET>
-<CYAN>@@ -1,3 +1,7 @@<RESET>
-h(4),<GREEN>{+hh+}<RESET>[44]
-
-a = b + c<RESET>
-
-<GREEN>{+aa = a+}<RESET>
-
-<GREEN>{+aeff = aeff * ( aaa+}<RESET> )
-EOF
-
 test_expect_success 'command-line overrides config: --word-diff-regex' '
+	cat >expect <<-\EOF &&
+		<BOLD>diff --git a/pre b/post<RESET>
+		<BOLD>index 330b04f..5ed8eff 100644<RESET>
+		<BOLD>--- a/pre<RESET>
+		<BOLD>+++ b/post<RESET>
+		<CYAN>@@ -1,3 +1,7 @@<RESET>
+		h(4),<GREEN>{+hh+}<RESET>[44]
+
+		a = b + c<RESET>
+
+		<GREEN>{+aa = a+}<RESET>
+
+		<GREEN>{+aeff = aeff * ( aaa+}<RESET> )
+	EOF
 	word_diff --color --word-diff-regex="[a-z]+"
 '
 
-cp expect.non-whitespace-is-word expect
-
 test_expect_success '.gitattributes override config' '
+	cp expect.non-whitespace-is-word expect &&
 	word_diff --color-words
 '
 
-test_expect_success 'remove diff driver regex' '
-	git config --unset diff.testdriver.wordRegex
+test_expect_success 'setup: remove diff driver regex' '
+	test_might_fail git config --unset diff.testdriver.wordRegex
 '
 
-cat > expect <<\EOF
-<BOLD>diff --git a/pre b/post<RESET>
-<BOLD>index 330b04f..5ed8eff 100644<RESET>
-<BOLD>--- a/pre<RESET>
-<BOLD>+++ b/post<RESET>
-<CYAN>@@ -1,3 +1,7 @@<RESET>
-h(4),<GREEN>hh[44<RESET>]
-
-a = b + c<RESET>
-
-<GREEN>aa = a<RESET>
-
-<GREEN>aeff = aeff * ( aaa<RESET> )
-EOF
-
 test_expect_success 'use configured regex' '
+	cat >expect <<-\EOF &&
+		<BOLD>diff --git a/pre b/post<RESET>
+		<BOLD>index 330b04f..5ed8eff 100644<RESET>
+		<BOLD>--- a/pre<RESET>
+		<BOLD>+++ b/post<RESET>
+		<CYAN>@@ -1,3 +1,7 @@<RESET>
+		h(4),<GREEN>hh[44<RESET>]
+
+		a = b + c<RESET>
+
+		<GREEN>aa = a<RESET>
+
+		<GREEN>aeff = aeff * ( aaa<RESET> )
+	EOF
 	word_diff --color-words
 '
 
-echo 'aaa (aaa)' > pre
-echo 'aaa (aaa) aaa' > post
-
-cat > expect <<\EOF
-<BOLD>diff --git a/pre b/post<RESET>
-<BOLD>index c29453b..be22f37 100644<RESET>
-<BOLD>--- a/pre<RESET>
-<BOLD>+++ b/post<RESET>
-<CYAN>@@ -1 +1 @@<RESET>
-aaa (aaa) <GREEN>aaa<RESET>
-EOF
-
 test_expect_success 'test parsing words for newline' '
-
+	echo "aaa (aaa)" >pre &&
+	echo "aaa (aaa) aaa" >post &&
+	cat >expect <<-\EOF &&
+		<BOLD>diff --git a/pre b/post<RESET>
+		<BOLD>index c29453b..be22f37 100644<RESET>
+		<BOLD>--- a/pre<RESET>
+		<BOLD>+++ b/post<RESET>
+		<CYAN>@@ -1 +1 @@<RESET>
+		aaa (aaa) <GREEN>aaa<RESET>
+	EOF
 	word_diff --color-words="a+"
-
-
 '
 
-echo '(:' > pre
-echo '(' > post
-
-cat > expect <<\EOF
-<BOLD>diff --git a/pre b/post<RESET>
-<BOLD>index 289cb9d..2d06f37 100644<RESET>
-<BOLD>--- a/pre<RESET>
-<BOLD>+++ b/post<RESET>
-<CYAN>@@ -1 +1 @@<RESET>
-(<RED>:<RESET>
-EOF
-
 test_expect_success 'test when words are only removed at the end' '
-
+	echo "(:" >pre &&
+	echo "(" >post &&
+	cat >expect <<-\EOF &&
+		<BOLD>diff --git a/pre b/post<RESET>
+		<BOLD>index 289cb9d..2d06f37 100644<RESET>
+		<BOLD>--- a/pre<RESET>
+		<BOLD>+++ b/post<RESET>
+		<CYAN>@@ -1 +1 @@<RESET>
+		(<RED>:<RESET>
+	EOF
 	word_diff --color-words=.
-
 '
 
-cat > expect <<\EOF
-diff --git a/pre b/post
-index 289cb9d..2d06f37 100644
---- a/pre
-+++ b/post
-@@ -1 +1 @@
--(:
-+(
-EOF
-
 test_expect_success '--word-diff=none' '
-
+	echo "(:" >pre &&
+	echo "(" >post &&
+	cat >expect <<-\EOF &&
+		diff --git a/pre b/post
+		index 289cb9d..2d06f37 100644
+		--- a/pre
+		+++ b/post
+		@@ -1 +1 @@
+		-(:
+		+(
+	EOF
 	word_diff --word-diff=plain --word-diff=none
-
 '
 
-word_diff_for_language () {
-	cp "$TEST_DIRECTORY/t4034/$1/pre" \
-		"$TEST_DIRECTORY/t4034/$1/post" \
-		"$TEST_DIRECTORY/t4034/$1/expect" . &&
-	echo "* diff=$1" >.gitattributes &&
-	word_diff --color-words && cp output output.$1
-}
-
-for lang_dir in $TEST_DIRECTORY/t4034/*; do
-	lang=${lang_dir#$TEST_DIRECTORY/t4034/}
-	test_expect_success "diff driver '$lang' has sane word regex" "
-		word_diff_for_language $lang
-	"
-done
+test_language_driver bibtex
+test_language_driver cpp
+test_language_driver csharp
+test_language_driver fortran
+test_language_driver html
+test_language_driver java
+test_language_driver objc
+test_language_driver pascal
+test_language_driver php
+test_language_driver python
+test_language_driver ruby
+test_language_driver tex
 
 test_done
-- 
1.7.4.rc1
