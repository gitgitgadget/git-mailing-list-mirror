From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv2-w 104/105] t0040 (parse-options): modernize style
Date: Fri,  2 Mar 2012 18:15:41 -0800
Message-ID: <1330740942-25130-10-git-send-email-tmgrennan@gmail.com>
References: <1330740942-25130-1-git-send-email-tmgrennan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 03:16:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3eWg-0001tn-In
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 03:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230Ab2CCCQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 21:16:43 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37868 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab2CCCQR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 21:16:17 -0500
Received: by mail-vw0-f46.google.com with SMTP id ff1so2055487vbb.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 18:16:17 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.52.28.76 as permitted sender) client-ip=10.52.28.76;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.52.28.76 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.52.28.76])
        by 10.52.28.76 with SMTP id z12mr13867184vdg.81.1330740977322 (num_hops = 1);
        Fri, 02 Mar 2012 18:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=jopztqyHZ16UKDXBzaMgBpHEY0uKevaydGoxIOSqHQY=;
        b=jD4mEQuVTHdOEHOASL6WCTJLdtCXLDCRBjsDosMkONCqfVnVM+7wURcYwzXvqvwpBw
         hDu9XdmWL56J27EV0o6PMbEiJ6FLEdLnMKpc4h/NE1QoH8LZdFa+7cfwjao5msyBC6vI
         2py8ARs7YbuR5ORWs6B5cdX5SZh24kKqh7CZ29SUk/TXMcXeBl3dgZHao1CN3GsV3REg
         vQ6EoKgU1xwu5BWoRF/M1hZgYPeDuLsnlW/80BFYQ1i8sE1QDFs/D0LmG1Y6+TWpxj0x
         kPWXH1vjWblFfvNcWj63fzB28aSayH9w56DLMBKW8f0b1H4ciPzvXH3LOp58L1rhOGnQ
         hUFQ==
Received: by 10.52.28.76 with SMTP id z12mr11920586vdg.81.1330740977266;
        Fri, 02 Mar 2012 18:16:17 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id e10sm11763981vdj.21.2012.03.02.18.16.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 18:16:16 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1330740942-25130-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192084>

- Guard setup with test_expect_success

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 t/t0040-parse-options.sh |   96 +++++++++++++++++++--------------------------
 1 files changed, 41 insertions(+), 55 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index a1e4616..4a0b991 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -7,7 +7,8 @@ test_description='our own option parser'
 
 . ./test-lib.sh
 
-cat > expect << EOF
+test_expect_success 'test help' '
+	cat >expect <<-EOF &&
 usage: test-parse-options <options>
 
     -b, --boolean         get a boolean
@@ -23,7 +24,7 @@ usage: test-parse-options <options>
 
 String options
     -s, --string <string>
-                          get a string
+		''                          get a string
     --string2 <str>       get another string
     --st <st>             get another string (pervert ordering)
     -o <str>              get another string
@@ -44,16 +45,14 @@ Standard options
     -q, --quiet           be quiet
 
 EOF
-
-test_expect_success 'test help' '
+	cp expect expect.err &&
 	test_must_fail test-parse-options -h > output 2> output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
 
-mv expect expect.err
-
-cat > expect << EOF
+test_expect_success 'short options' '
+	cat >expect <<-\EOF &&
 boolean: 2
 integer: 1729
 timestamp: 0
@@ -64,15 +63,14 @@ quiet: no
 dry run: yes
 file: prefix/my.file
 EOF
-
-test_expect_success 'short options' '
 	test-parse-options -s123 -b -i 1729 -b -vv -n -F my.file \
 	> output 2> output.err &&
 	test_cmp expect output &&
 	test ! -s output.err
 '
 
-cat > expect << EOF
+test_expect_success 'long options' '
+	cat >expect <<-\EOF &&
 boolean: 2
 integer: 1729
 timestamp: 0
@@ -83,8 +81,6 @@ quiet: no
 dry run: no
 file: prefix/fi.le
 EOF
-
-test_expect_success 'long options' '
 	test-parse-options --boolean --integer 1729 --boolean --string2=321 \
 		--verbose --verbose --no-dry-run --abbrev=10 --file fi.le\
 		--obsolete > output 2> output.err &&
@@ -101,7 +97,8 @@ test_expect_success 'missing required value' '
 	test $? = 129
 '
 
-cat > expect << EOF
+test_expect_success 'intermingled arguments' '
+	cat >expect <<-\EOF &&
 boolean: 1
 integer: 13
 timestamp: 0
@@ -115,15 +112,14 @@ arg 00: a1
 arg 01: b1
 arg 02: --boolean
 EOF
-
-test_expect_success 'intermingled arguments' '
 	test-parse-options a1 --string 123 b1 --boolean -j 13 -- --boolean \
 		> output 2> output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
+test_expect_success 'unambiguously abbreviated option' '
+	cat >expect <<-\EOF &&
 boolean: 0
 integer: 2
 timestamp: 0
@@ -134,8 +130,6 @@ quiet: no
 dry run: no
 file: (not set)
 EOF
-
-test_expect_success 'unambiguously abbreviated option' '
 	test-parse-options --int 2 --boolean --no-bo > output 2> output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
@@ -152,7 +146,8 @@ test_expect_success 'ambiguously abbreviated option' '
 	test $? = 129
 '
 
-cat > expect << EOF
+test_expect_success 'non ambiguous option (after two options it abbreviates)' '
+	cat >expect <<-\EOF &&
 boolean: 0
 integer: 0
 timestamp: 0
@@ -163,24 +158,23 @@ quiet: no
 dry run: no
 file: (not set)
 EOF
-
-test_expect_success 'non ambiguous option (after two options it abbreviates)' '
 	test-parse-options --st 123 > output 2> output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
 
-cat > typo.err << EOF
-error: did you mean \`--boolean\` (with two dashes ?)
-EOF
-
 test_expect_success 'detect possible typos' '
+	cat >typo.err <<-\EOF &&
+		error: did you mean `--boolean` (with two dashes ?)
+	EOF
+	>expect
 	test_must_fail test-parse-options -boolean > output 2> output.err &&
-	test ! -s output &&
-	test_cmp typo.err output.err
+	test_cmp typo.err output.err &&
+	test_cmp expect output
 '
 
-cat > expect <<EOF
+test_expect_success 'keep some options as arguments' '
+	cat >expect <<-\EOF &&
 boolean: 0
 integer: 0
 timestamp: 0
@@ -192,14 +186,13 @@ dry run: no
 file: (not set)
 arg 00: --quux
 EOF
-
-test_expect_success 'keep some options as arguments' '
 	test-parse-options --quux > output 2> output.err &&
         test ! -s output.err &&
         test_cmp expect output
 '
 
-cat > expect <<EOF
+test_expect_success 'OPT_DATE() and OPT_SET_PTR() work' '
+	cat >expect <<-\EOF &&
 boolean: 0
 integer: 0
 timestamp: 1
@@ -211,15 +204,14 @@ dry run: no
 file: (not set)
 arg 00: foo
 EOF
-
-test_expect_success 'OPT_DATE() and OPT_SET_PTR() work' '
-	test-parse-options -t "1970-01-01 00:00:01 +0000" --default-string \
-		foo -q > output 2> output.err &&
+	test-parse-options -t "1970-01-01 00:00:01 +0000" \
+		--default-string foo -q >output 2>output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
 
-cat > expect <<EOF
+test_expect_success 'OPT_CALLBACK() and OPT_BIT() work' '
+	cat >expect <<-\EOF &&
 Callback: "four", 0
 boolean: 5
 integer: 4
@@ -231,24 +223,22 @@ quiet: no
 dry run: no
 file: (not set)
 EOF
-
-test_expect_success 'OPT_CALLBACK() and OPT_BIT() work' '
 	test-parse-options --length=four -b -4 > output 2> output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
 
-cat > expect <<EOF
+test_expect_success 'OPT_CALLBACK() and callback errors work' '
+	cat >expect <<-\EOF &&
 Callback: "not set", 1
 EOF
-
-test_expect_success 'OPT_CALLBACK() and callback errors work' '
 	test_must_fail test-parse-options --no-length > output 2> output.err &&
 	test_cmp expect output &&
 	test_cmp expect.err output.err
 '
 
-cat > expect <<EOF
+test_expect_success 'OPT_BIT() and OPT_SET_INT() work' '
+	cat >expect <<-\EOF &&
 boolean: 1
 integer: 23
 timestamp: 0
@@ -259,8 +249,6 @@ quiet: no
 dry run: no
 file: (not set)
 EOF
-
-test_expect_success 'OPT_BIT() and OPT_SET_INT() work' '
 	test-parse-options --set23 -bbbbb --no-or4 > output 2> output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
@@ -272,7 +260,8 @@ test_expect_success 'OPT_NEGBIT() and OPT_SET_INT() work' '
 	test_cmp expect output
 '
 
-cat > expect <<EOF
+test_expect_success 'OPT_BIT() works' '
+	cat >expect <<-\EOF &&
 boolean: 6
 integer: 0
 timestamp: 0
@@ -283,8 +272,6 @@ quiet: no
 dry run: no
 file: (not set)
 EOF
-
-test_expect_success 'OPT_BIT() works' '
 	test-parse-options -bb --or4 > output 2> output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
@@ -302,7 +289,9 @@ test_expect_success 'OPT_BOOLEAN() with PARSE_OPT_NODASH works' '
 	test_cmp expect output
 '
 
-cat > expect <<EOF
+
+test_expect_success 'OPT_NUMBER_CALLBACK() works' '
+	cat >expect <<-\EOF &&
 boolean: 0
 integer: 12345
 timestamp: 0
@@ -313,14 +302,13 @@ quiet: no
 dry run: no
 file: (not set)
 EOF
-
-test_expect_success 'OPT_NUMBER_CALLBACK() works' '
 	test-parse-options -12345 > output 2> output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
 
-cat >expect <<EOF
+test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
+	cat >expect <<-\EOF &&
 boolean: 0
 integer: 0
 timestamp: 0
@@ -331,19 +319,17 @@ quiet: no
 dry run: no
 file: (not set)
 EOF
-
-test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
 	test-parse-options --no-ambig >output 2>output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
 
-cat >>expect <<'EOF'
+test_expect_success '--list keeps list of strings' '
+	cat >>expect <<-\EOF &&
 list: foo
 list: bar
 list: baz
 EOF
-test_expect_success '--list keeps list of strings' '
 	test-parse-options --list foo --list=bar --list=baz >output &&
 	test_cmp expect output
 '
-- 
1.7.8
