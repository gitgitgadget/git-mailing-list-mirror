Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A5FC433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhLIFPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhLIFPs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:15:48 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D3BC061D5E
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:12:15 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id m9so5409300iop.0
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xvy3fr9Lzpoxu7GoPj2W4/wWZnXVd2kMu9J4SCV2i8M=;
        b=mWyMC+5tkJq2ngd55LF1TlEnuCgp2rnYRryosnstw1ifv2+yI0PC1yMroEj887dmcP
         hCvkz0mdQwv8xWNKlqQOaxiia66T8ZQrajYwIhmm827MHXqFfiVfUYxaPZJncEglFWaG
         hNQclQhNG3dv0+CfsaABjsSrELZSM7xzIRSn0JJfzdVuj+8jinxnY1b3RPKi/gwiew6z
         KusaERwBDmHWMsMaWBpnExj/1A2oqM2spC9kNOgJ6x6OOtSSh4i0INq1mUyfrGFgZ0au
         zWa6rbYog8AOnle3Nn2WO07FWU/v/Cu9hCEXRgzyUdO0u8SzK3tPqU0nt155am1U/WSF
         GtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Xvy3fr9Lzpoxu7GoPj2W4/wWZnXVd2kMu9J4SCV2i8M=;
        b=Tu9Xq4TfXstQ8TJR8qZ5aLGE1lvkb7RlQDu9hjxQiZl/eJjYBHoZRJCHYsLW2g2dYr
         u0q361CUuTmBh3H7N+qnHVwaTyL6ep9gGje6OoJont87ZJxLRVgtL0TU49u5kn8pEBAf
         rBf2UtteDY1Dxj7QbrbmSPdNQc+Geg3kBqkKtWxaFIVsoLdF0Cv7Oz+nJ+zhwP9mkii8
         22Sw89+uuScRdw5k36QChgSJ2XJz++NceXyD/jj3GdFXyqPOHSepwYBxtoA0k1GIEzaX
         F3O4lxcQswKmHZ4JWIhlKUexSoJL8N2+8DKdLvuOaCfa/iKRTPmetVpbSYT2B4fWMUDi
         tTUg==
X-Gm-Message-State: AOAM532UzflTpZqHW52dBVpb9wWQ1eNJBsKY2GcnGd1UlVYwzTqJomLk
        mtE/mLjN6qvsKyGCtGPz2r+D2VIXej0/jw==
X-Google-Smtp-Source: ABdhPJw4Y11ozxjx1jpMVrg0esMm+fdVnuP5G2L7dGcFwMx1Z+BLOloxc7rkm9Fe2lZkl1bM2jCK8g==
X-Received: by 2002:a05:6638:35a0:: with SMTP id v32mr6055165jal.61.1639026734143;
        Wed, 08 Dec 2021 21:12:14 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id b8sm3127401iow.2.2021.12.08.21.12.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 21:12:13 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <ericsunshine@gmail.com>
Subject: [PATCH 08/19] tests: simplify construction of large blocks of text
Date:   Thu,  9 Dec 2021 00:11:04 -0500
Message-Id: <20211209051115.52629-9-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd
In-Reply-To: <20211209051115.52629-1-sunshine@sunshineco.com>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Take advantage of here-docs to create large blocks of text rather than
using a series of `echo` statements. Not only are here-docs a natural
fit for such a task, but there is less opportunity for a broken
&&-chain.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t0021-conversion.sh        |  44 ++---
 t/t4106-apply-stdin.sh       |   5 +-
 t/t5510-fetch.sh             |  10 +-
 t/t5515-fetch-merge-logic.sh |  22 +--
 t/t6406-merge-attr.sh        |   8 +-
 t/t6411-merge-filemode.sh    |   8 +-
 t/t7810-grep.sh              | 310 +++++++++++++++++------------------
 7 files changed, 205 insertions(+), 202 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 33dfc9cd56..1a1a69ad92 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -118,17 +118,17 @@ test_expect_success check '
 # If an expanded ident ever gets into the repository, we want to make sure that
 # it is collapsed before being expanded again on checkout
 test_expect_success expanded_in_repo '
-	{
-		echo "File with expanded keywords"
-		echo "\$Id\$"
-		echo "\$Id:\$"
-		echo "\$Id: 0000000000000000000000000000000000000000 \$"
-		echo "\$Id: NoSpaceAtEnd\$"
-		echo "\$Id:NoSpaceAtFront \$"
-		echo "\$Id:NoSpaceAtEitherEnd\$"
-		echo "\$Id: NoTerminatingSymbol"
-		echo "\$Id: Foreign Commit With Spaces \$"
-	} >expanded-keywords.0 &&
+	cat >expanded-keywords.0 <<-\EOF &&
+	File with expanded keywords
+	$Id$
+	$Id:$
+	$Id: 0000000000000000000000000000000000000000 $
+	$Id: NoSpaceAtEnd$
+	$Id:NoSpaceAtFront $
+	$Id:NoSpaceAtEitherEnd$
+	$Id: NoTerminatingSymbol
+	$Id: Foreign Commit With Spaces $
+	EOF
 
 	{
 		cat expanded-keywords.0 &&
@@ -139,17 +139,17 @@ test_expect_success expanded_in_repo '
 	git commit -m "File with keywords expanded" &&
 	id=$(git rev-parse --verify :expanded-keywords) &&
 
-	{
-		echo "File with expanded keywords"
-		echo "\$Id: $id \$"
-		echo "\$Id: $id \$"
-		echo "\$Id: $id \$"
-		echo "\$Id: $id \$"
-		echo "\$Id: $id \$"
-		echo "\$Id: $id \$"
-		echo "\$Id: NoTerminatingSymbol"
-		echo "\$Id: Foreign Commit With Spaces \$"
-	} >expected-output.0 &&
+	cat >expected-output.0 <<-EOF &&
+	File with expanded keywords
+	\$Id: $id \$
+	\$Id: $id \$
+	\$Id: $id \$
+	\$Id: $id \$
+	\$Id: $id \$
+	\$Id: $id \$
+	\$Id: NoTerminatingSymbol
+	\$Id: Foreign Commit With Spaces \$
+	EOF
 	{
 		cat expected-output.0 &&
 		printf "\$Id: NoTerminatingSymbolAtEOF"
diff --git a/t/t4106-apply-stdin.sh b/t/t4106-apply-stdin.sh
index 72467a1e8e..1e70810b9c 100755
--- a/t/t4106-apply-stdin.sh
+++ b/t/t4106-apply-stdin.sh
@@ -18,7 +18,10 @@ test_expect_success 'git apply --numstat - < patch' '
 '
 
 test_expect_success 'git apply --numstat - < patch patch' '
-	for i in 1 2; do echo "1	1	text"; done >expect &&
+	cat >expect <<-\EOF &&
+	1	1	text
+	1	1	text
+	EOF
 	git apply --numstat - < patch patch >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index a0faf0dd94..1892d6615a 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -40,11 +40,11 @@ test_expect_success "clone and setup child repos" '
 		git config branch.main.remote two &&
 		git config branch.main.merge refs/heads/one &&
 		mkdir -p .git/remotes &&
-		{
-			echo "URL: ../two/.git/"
-			echo "Pull: refs/heads/main:refs/heads/two"
-			echo "Pull: refs/heads/one:refs/heads/one"
-		} >.git/remotes/two
+		cat >.git/remotes/two <<-\EOF
+		URL: ../two/.git/
+		Pull: refs/heads/main:refs/heads/two
+		Pull: refs/heads/one:refs/heads/one
+		EOF
 	) &&
 	git clone . bundle &&
 	git clone . seven
diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 50f14101c5..9d440e2821 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -105,19 +105,19 @@ test_expect_success setup '
 	remotes="$remotes config-glob" &&
 
 	mkdir -p .git/remotes &&
-	{
-		echo "URL: ../.git/"
-		echo "Pull: refs/heads/main:remotes/rem/main"
-		echo "Pull: refs/heads/one:remotes/rem/one"
-		echo "Pull: two:remotes/rem/two"
-		echo "Pull: refs/heads/three:remotes/rem/three"
-	} >.git/remotes/remote-explicit &&
+	cat >.git/remotes/remote-explicit <<-\EOF &&
+	URL: ../.git/
+	Pull: refs/heads/main:remotes/rem/main
+	Pull: refs/heads/one:remotes/rem/one
+	Pull: two:remotes/rem/two
+	Pull: refs/heads/three:remotes/rem/three
+	EOF
 	remotes="$remotes remote-explicit" &&
 
-	{
-		echo "URL: ../.git/"
-		echo "Pull: refs/heads/*:refs/remotes/rem/*"
-	} >.git/remotes/remote-glob &&
+	cat >.git/remotes/remote-glob <<-\EOF &&
+	URL: ../.git/
+	Pull: refs/heads/*:refs/remotes/rem/*
+	EOF
 	remotes="$remotes remote-glob" &&
 
 	mkdir -p .git/branches &&
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index 8494645837..57e6af5eaa 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -62,10 +62,10 @@ test_expect_success setup '
 
 test_expect_success merge '
 
-	{
-		echo "binary -merge"
-		echo "union merge=union"
-	} >.gitattributes &&
+	cat >.gitattributes <<-\EOF &&
+	binary -merge
+	union merge=union
+	EOF
 
 	if git merge main
 	then
diff --git a/t/t6411-merge-filemode.sh b/t/t6411-merge-filemode.sh
index f54c915d6a..6ae2489286 100755
--- a/t/t6411-merge-filemode.sh
+++ b/t/t6411-merge-filemode.sh
@@ -51,10 +51,10 @@ test_expect_success 'set up mode change in both branches' '
 	: >file2 &&
 	git add file2 &&
 	git commit -m b2 &&
-	{
-		echo "100755 $H 2	file2"
-		echo "100644 $H 3	file2"
-	} >expect
+	cat >expect <<-EOF
+	100755 $H 2	file2
+	100644 $H 3	file2
+	EOF
 '
 
 do_both_modes () {
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 6b6423a07c..424c31c328 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -31,28 +31,28 @@ int main(int argc, const char **argv)
 EOF
 
 test_expect_success setup '
-	{
-		echo foo mmap bar
-		echo foo_mmap bar
-		echo foo_mmap bar mmap
-		echo foo mmap bar_mmap
-		echo foo_mmap bar mmap baz
-	} >file &&
-	{
-		echo Hello world
-		echo HeLLo world
-		echo Hello_world
-		echo HeLLo_world
-	} >hello_world &&
-	{
-		echo "a+b*c"
-		echo "a+bc"
-		echo "abc"
-	} >ab &&
-	{
-		echo d &&
-		echo 0
-	} >d0 &&
+	cat >file <<-\EOF &&
+	foo mmap bar
+	foo_mmap bar
+	foo_mmap bar mmap
+	foo mmap bar_mmap
+	foo_mmap bar mmap baz
+	EOF
+	cat >hello_world <<-\EOF &&
+	Hello world
+	HeLLo world
+	Hello_world
+	HeLLo_world
+	EOF
+	cat >ab <<-\EOF &&
+	a+b*c
+	a+bc
+	abc
+	EOF
+	cat >d0 <<-\EOF &&
+	d
+	0
+	EOF
 	echo vvv >v &&
 	echo ww w >w &&
 	echo x x xx x >x &&
@@ -63,13 +63,13 @@ test_expect_success setup '
 	echo vvv >t/v &&
 	mkdir t/a &&
 	echo vvv >t/a/v &&
-	{
-		echo "line without leading space1"
-		echo " line with leading space1"
-		echo " line with leading space2"
-		echo " line with leading space3"
-		echo "line without leading space2"
-	} >space &&
+	qz_to_tab_space >space <<-\EOF &&
+	line without leading space1
+	Zline with leading space1
+	Zline with leading space2
+	Zline with leading space3
+	line without leading space2
+	EOF
 	cat >hello.ps1 <<-\EOF &&
 	# No-op.
 	function dummy() {}
@@ -106,129 +106,129 @@ do
 	esac
 
 	test_expect_success "grep -w $L" '
-		{
-			echo ${HC}file:1:foo mmap bar
-			echo ${HC}file:3:foo_mmap bar mmap
-			echo ${HC}file:4:foo mmap bar_mmap
-			echo ${HC}file:5:foo_mmap bar mmap baz
-		} >expected &&
+		cat >expected <<-EOF &&
+		${HC}file:1:foo mmap bar
+		${HC}file:3:foo_mmap bar mmap
+		${HC}file:4:foo mmap bar_mmap
+		${HC}file:5:foo_mmap bar mmap baz
+		EOF
 		git -c grep.linenumber=false grep -n -w -e mmap $H >actual &&
 		test_cmp expected actual
 	'
 
 	test_expect_success "grep -w $L (with --column)" '
-		{
-			echo ${HC}file:5:foo mmap bar
-			echo ${HC}file:14:foo_mmap bar mmap
-			echo ${HC}file:5:foo mmap bar_mmap
-			echo ${HC}file:14:foo_mmap bar mmap baz
-		} >expected &&
+		cat >expected <<-EOF &&
+		${HC}file:5:foo mmap bar
+		${HC}file:14:foo_mmap bar mmap
+		${HC}file:5:foo mmap bar_mmap
+		${HC}file:14:foo_mmap bar mmap baz
+		EOF
 		git grep --column -w -e mmap $H >actual &&
 		test_cmp expected actual
 	'
 
 	test_expect_success "grep -w $L (with --column, extended OR)" '
-		{
-			echo ${HC}file:14:foo_mmap bar mmap
-			echo ${HC}file:19:foo_mmap bar mmap baz
-		} >expected &&
+		cat >expected <<-EOF &&
+		${HC}file:14:foo_mmap bar mmap
+		${HC}file:19:foo_mmap bar mmap baz
+		EOF
 		git grep --column -w -e mmap$ --or -e baz $H >actual &&
 		test_cmp expected actual
 	'
 
 	test_expect_success "grep -w $L (with --column, --invert-match)" '
-		{
-			echo ${HC}file:1:foo mmap bar
-			echo ${HC}file:1:foo_mmap bar
-			echo ${HC}file:1:foo_mmap bar mmap
-			echo ${HC}file:1:foo mmap bar_mmap
-		} >expected &&
+		cat >expected <<-EOF &&
+		${HC}file:1:foo mmap bar
+		${HC}file:1:foo_mmap bar
+		${HC}file:1:foo_mmap bar mmap
+		${HC}file:1:foo mmap bar_mmap
+		EOF
 		git grep --column --invert-match -w -e baz $H -- file >actual &&
 		test_cmp expected actual
 	'
 
 	test_expect_success "grep $L (with --column, --invert-match, extended OR)" '
-		{
-			echo ${HC}hello_world:6:HeLLo_world
-		} >expected &&
+		cat >expected <<-EOF &&
+		${HC}hello_world:6:HeLLo_world
+		EOF
 		git grep --column --invert-match -e ll --or --not -e _ $H -- hello_world \
 			>actual &&
 		test_cmp expected actual
 	'
 
 	test_expect_success "grep $L (with --column, --invert-match, extended AND)" '
-		{
-			echo ${HC}hello_world:3:Hello world
-			echo ${HC}hello_world:3:Hello_world
-			echo ${HC}hello_world:6:HeLLo_world
-		} >expected &&
+		cat >expected <<-EOF &&
+		${HC}hello_world:3:Hello world
+		${HC}hello_world:3:Hello_world
+		${HC}hello_world:6:HeLLo_world
+		EOF
 		git grep --column --invert-match --not -e _ --and --not -e ll $H -- hello_world \
 			>actual &&
 		test_cmp expected actual
 	'
 
 	test_expect_success "grep $L (with --column, double-negation)" '
-		{
-			echo ${HC}file:1:foo_mmap bar mmap baz
-		} >expected &&
+		cat >expected <<-EOF &&
+		${HC}file:1:foo_mmap bar mmap baz
+		EOF
 		git grep --column --not \( --not -e foo --or --not -e baz \) $H -- file \
 			>actual &&
 		test_cmp expected actual
 	'
 
 	test_expect_success "grep -w $L (with --column, -C)" '
-		{
-			echo ${HC}file:5:foo mmap bar
-			echo ${HC}file-foo_mmap bar
-			echo ${HC}file:14:foo_mmap bar mmap
-			echo ${HC}file:5:foo mmap bar_mmap
-			echo ${HC}file:14:foo_mmap bar mmap baz
-		} >expected &&
+		cat >expected <<-EOF &&
+		${HC}file:5:foo mmap bar
+		${HC}file-foo_mmap bar
+		${HC}file:14:foo_mmap bar mmap
+		${HC}file:5:foo mmap bar_mmap
+		${HC}file:14:foo_mmap bar mmap baz
+		EOF
 		git grep --column -w -C1 -e mmap $H >actual &&
 		test_cmp expected actual
 	'
 
 	test_expect_success "grep -w $L (with --line-number, --column)" '
-		{
-			echo ${HC}file:1:5:foo mmap bar
-			echo ${HC}file:3:14:foo_mmap bar mmap
-			echo ${HC}file:4:5:foo mmap bar_mmap
-			echo ${HC}file:5:14:foo_mmap bar mmap baz
-		} >expected &&
+		cat >expected <<-EOF &&
+		${HC}file:1:5:foo mmap bar
+		${HC}file:3:14:foo_mmap bar mmap
+		${HC}file:4:5:foo mmap bar_mmap
+		${HC}file:5:14:foo_mmap bar mmap baz
+		EOF
 		git grep -n --column -w -e mmap $H >actual &&
 		test_cmp expected actual
 	'
 
 	test_expect_success "grep -w $L (with non-extended patterns, --column)" '
-		{
-			echo ${HC}file:5:foo mmap bar
-			echo ${HC}file:10:foo_mmap bar
-			echo ${HC}file:10:foo_mmap bar mmap
-			echo ${HC}file:5:foo mmap bar_mmap
-			echo ${HC}file:10:foo_mmap bar mmap baz
-		} >expected &&
+		cat >expected <<-EOF &&
+		${HC}file:5:foo mmap bar
+		${HC}file:10:foo_mmap bar
+		${HC}file:10:foo_mmap bar mmap
+		${HC}file:5:foo mmap bar_mmap
+		${HC}file:10:foo_mmap bar mmap baz
+		EOF
 		git grep --column -w -e bar -e mmap $H >actual &&
 		test_cmp expected actual
 	'
 
 	test_expect_success "grep -w $L" '
-		{
-			echo ${HC}file:1:foo mmap bar
-			echo ${HC}file:3:foo_mmap bar mmap
-			echo ${HC}file:4:foo mmap bar_mmap
-			echo ${HC}file:5:foo_mmap bar mmap baz
-		} >expected &&
+		cat >expected <<-EOF &&
+		${HC}file:1:foo mmap bar
+		${HC}file:3:foo_mmap bar mmap
+		${HC}file:4:foo mmap bar_mmap
+		${HC}file:5:foo_mmap bar mmap baz
+		EOF
 		git -c grep.linenumber=true grep -w -e mmap $H >actual &&
 		test_cmp expected actual
 	'
 
 	test_expect_success "grep -w $L" '
-		{
-			echo ${HC}file:foo mmap bar
-			echo ${HC}file:foo_mmap bar mmap
-			echo ${HC}file:foo mmap bar_mmap
-			echo ${HC}file:foo_mmap bar mmap baz
-		} >expected &&
+		cat >expected <<-EOF &&
+		${HC}file:foo mmap bar
+		${HC}file:foo_mmap bar mmap
+		${HC}file:foo mmap bar_mmap
+		${HC}file:foo_mmap bar mmap baz
+		EOF
 		git -c grep.linenumber=true grep --no-line-number -w -e mmap $H >actual &&
 		test_cmp expected actual
 	'
@@ -239,17 +239,17 @@ do
 	'
 
 	test_expect_success "grep -w $L (x)" '
-		{
-			echo ${HC}x:1:x x xx x
-		} >expected &&
+		cat >expected <<-EOF &&
+		${HC}x:1:x x xx x
+		EOF
 		git grep -n -w -e "x xx* x" $H >actual &&
 		test_cmp expected actual
 	'
 
 	test_expect_success "grep -w $L (y-1)" '
-		{
-			echo ${HC}y:1:y yy
-		} >expected &&
+		cat >expected <<-EOF &&
+		${HC}y:1:y yy
+		EOF
 		git grep -n -w -e "^y" $H >actual &&
 		test_cmp expected actual
 	'
@@ -277,16 +277,16 @@ do
 	'
 
 	test_expect_success "grep $L (with --column, --only-matching)" '
-		{
-			echo ${HC}file:1:5:mmap
-			echo ${HC}file:2:5:mmap
-			echo ${HC}file:3:5:mmap
-			echo ${HC}file:3:13:mmap
-			echo ${HC}file:4:5:mmap
-			echo ${HC}file:4:13:mmap
-			echo ${HC}file:5:5:mmap
-			echo ${HC}file:5:13:mmap
-		} >expected &&
+		cat >expected <<-EOF &&
+		${HC}file:1:5:mmap
+		${HC}file:2:5:mmap
+		${HC}file:3:5:mmap
+		${HC}file:3:13:mmap
+		${HC}file:4:5:mmap
+		${HC}file:4:13:mmap
+		${HC}file:5:5:mmap
+		${HC}file:5:13:mmap
+		EOF
 		git grep --column -n -o -e mmap $H >actual &&
 		test_cmp expected actual
 	'
@@ -320,11 +320,11 @@ do
 	'
 
 	test_expect_success "grep --max-depth -1 $L" '
-		{
-			echo ${HC}t/a/v:1:vvv
-			echo ${HC}t/v:1:vvv
-			echo ${HC}v:1:vvv
-		} >expected &&
+		cat >expected <<-EOF &&
+		${HC}t/a/v:1:vvv
+		${HC}t/v:1:vvv
+		${HC}v:1:vvv
+		EOF
 		git grep --max-depth -1 -n -e vvv $H >actual &&
 		test_cmp expected actual &&
 		git grep --recursive -n -e vvv $H >actual &&
@@ -332,9 +332,9 @@ do
 	'
 
 	test_expect_success "grep --max-depth 0 $L" '
-		{
-			echo ${HC}v:1:vvv
-		} >expected &&
+		cat >expected <<-EOF &&
+		${HC}v:1:vvv
+		EOF
 		git grep --max-depth 0 -n -e vvv $H >actual &&
 		test_cmp expected actual &&
 		git grep --no-recursive -n -e vvv $H >actual &&
@@ -342,11 +342,11 @@ do
 	'
 
 	test_expect_success "grep --max-depth 0 -- '*' $L" '
-		{
-			echo ${HC}t/a/v:1:vvv
-			echo ${HC}t/v:1:vvv
-			echo ${HC}v:1:vvv
-		} >expected &&
+		cat >expected <<-EOF &&
+		${HC}t/a/v:1:vvv
+		${HC}t/v:1:vvv
+		${HC}v:1:vvv
+		EOF
 		git grep --max-depth 0 -n -e vvv $H -- "*" >actual &&
 		test_cmp expected actual &&
 		git grep --no-recursive -n -e vvv $H -- "*" >actual &&
@@ -354,18 +354,18 @@ do
 	'
 
 	test_expect_success "grep --max-depth 1 $L" '
-		{
-			echo ${HC}t/v:1:vvv
-			echo ${HC}v:1:vvv
-		} >expected &&
+		cat >expected <<-EOF &&
+		${HC}t/v:1:vvv
+		${HC}v:1:vvv
+		EOF
 		git grep --max-depth 1 -n -e vvv $H >actual &&
 		test_cmp expected actual
 	'
 
 	test_expect_success "grep --max-depth 0 -- t $L" '
-		{
-			echo ${HC}t/v:1:vvv
-		} >expected &&
+		cat >expected <<-EOF &&
+		${HC}t/v:1:vvv
+		EOF
 		git grep --max-depth 0 -n -e vvv $H -- t >actual &&
 		test_cmp expected actual &&
 		git grep --no-recursive -n -e vvv $H -- t >actual &&
@@ -373,10 +373,10 @@ do
 	'
 
 	test_expect_success "grep --max-depth 0 -- . t $L" '
-		{
-			echo ${HC}t/v:1:vvv
-			echo ${HC}v:1:vvv
-		} >expected &&
+		cat >expected <<-EOF &&
+		${HC}t/v:1:vvv
+		${HC}v:1:vvv
+		EOF
 		git grep --max-depth 0 -n -e vvv $H -- . t >actual &&
 		test_cmp expected actual &&
 		git grep --no-recursive -n -e vvv $H -- . t >actual &&
@@ -384,10 +384,10 @@ do
 	'
 
 	test_expect_success "grep --max-depth 0 -- t . $L" '
-		{
-			echo ${HC}t/v:1:vvv
-			echo ${HC}v:1:vvv
-		} >expected &&
+		cat >expected <<-EOF &&
+		${HC}t/v:1:vvv
+		${HC}v:1:vvv
+		EOF
 		git grep --max-depth 0 -n -e vvv $H -- t . >actual &&
 		test_cmp expected actual &&
 		git grep --no-recursive -n -e vvv $H -- t . >actual &&
@@ -1314,10 +1314,10 @@ test_expect_success PCRE 'grep -P pattern with grep.extendedRegexp=true' '
 '
 
 test_expect_success PCRE 'grep -P -v pattern' '
-	{
-		echo "ab:a+b*c"
-		echo "ab:a+bc"
-	} >expected &&
+	cat >expected <<-\EOF &&
+	ab:a+b*c
+	ab:a+bc
+	EOF
 	git grep -P -v "abc" ab >actual &&
 	test_cmp expected actual
 '
@@ -1331,10 +1331,10 @@ test_expect_success PCRE 'grep -P -i pattern' '
 '
 
 test_expect_success PCRE 'grep -P -w pattern' '
-	{
-		echo "hello_world:Hello world"
-		echo "hello_world:HeLLo world"
-	} >expected &&
+	cat >expected <<-\EOF &&
+	hello_world:Hello world
+	hello_world:HeLLo world
+	EOF
 	git grep -P -w "He((?i)ll)o" hello_world >actual &&
 	test_cmp expected actual
 '
@@ -1469,10 +1469,10 @@ test_expect_success 'grep -F pattern with grep.patternType=basic' '
 '
 
 test_expect_success 'grep -G pattern with grep.patternType=fixed' '
-	{
-		echo "ab:a+b*c"
-		echo "ab:a+bc"
-	} >expected &&
+	cat >expected <<-\EOF &&
+	ab:a+b*c
+	ab:a+bc
+	EOF
 	git \
 		-c grep.patterntype=fixed \
 		grep -G "a+b" ab >actual &&
@@ -1480,11 +1480,11 @@ test_expect_success 'grep -G pattern with grep.patternType=fixed' '
 '
 
 test_expect_success 'grep -E pattern with grep.patternType=fixed' '
-	{
-		echo "ab:a+b*c"
-		echo "ab:a+bc"
-		echo "ab:abc"
-	} >expected &&
+	cat >expected <<-\EOF &&
+	ab:a+b*c
+	ab:a+bc
+	ab:abc
+	EOF
 	git \
 		-c grep.patterntype=fixed \
 		grep -E "a+" ab >actual &&
-- 
2.34.1.307.g9b7440fafd

