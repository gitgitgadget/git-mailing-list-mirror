From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv2 4/5] t0040 (parse-options): modernize style
Date: Fri,  2 Mar 2012 18:15:36 -0800
Message-ID: <1330740942-25130-5-git-send-email-tmgrennan@gmail.com>
References: <1330740942-25130-1-git-send-email-tmgrennan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 03:17:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3eX2-00026b-6V
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 03:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166Ab2CCCQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 21:16:36 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48188 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab2CCCQF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 21:16:05 -0500
Received: by mail-vx0-f174.google.com with SMTP id p1so2024061vcq.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 18:16:05 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.52.90.111 as permitted sender) client-ip=10.52.90.111;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.52.90.111 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.52.90.111])
        by 10.52.90.111 with SMTP id bv15mr21104698vdb.34.1330740965183 (num_hops = 1);
        Fri, 02 Mar 2012 18:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=lmrO5jD/imghBPX5kVi+n88A+2fuOdwWCXME70EahJ4=;
        b=FYukqc7bRmdGIzDu0xVvSN7K7jn6yKJ8x/fLc8KFb7rhTYPFMYZdtPi6UI3wfcMnaU
         vNbz1cd93SuBUunSsuE8ppWXoE7qXO6cmnkqr4wfSRnqbW82LzmIZUyqyFvbhfdYt/hK
         k8gA+Uud9gkdJtRnWUWBKee8n0Y8/m0RjQZm3Sf40kHdU5OCVrgH/y9VurhHszDFlB9z
         wkT6t07zcW9rpTT8mWTHKeIoswJ3wgGOWbZCGahPFk3FAcbmA+uJmvCSOaneFYEqBzO9
         UwZSjeIIES8dRq1UvHosbGmDjqBcEsh1w3Gryw2XeXORgkGmo1RJEeECH6u+T81Ffmrf
         1GXg==
Received: by 10.52.90.111 with SMTP id bv15mr17997052vdb.34.1330740965130;
        Fri, 02 Mar 2012 18:16:05 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id e10sm11763981vdj.21.2012.03.02.18.16.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 18:16:04 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1330740942-25130-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192086>

- Guard setup with test_expect_success

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 t/t0040-parse-options.sh |  438 ++++++++++++++++++++++------------------------
 1 files changed, 212 insertions(+), 226 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index a1e4616..4a0b991 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -7,87 +7,83 @@ test_description='our own option parser'
 
 . ./test-lib.sh
 
-cat > expect << EOF
-usage: test-parse-options <options>
-
-    -b, --boolean         get a boolean
-    -4, --or4             bitwise-or boolean with ...0100
-    --neg-or4             same as --no-or4
-
-    -i, --integer <n>     get a integer
-    -j <n>                get a integer, too
-    --set23               set integer to 23
-    -t <time>             get timestamp of <time>
-    -L, --length <str>    get length of <str>
-    -F, --file <file>     set file to <file>
-
-String options
-    -s, --string <string>
-                          get a string
-    --string2 <str>       get another string
-    --st <st>             get another string (pervert ordering)
-    -o <str>              get another string
-    --default-string      set string to default
-    --list <str>          add str to list
-
-Magic arguments
-    --quux                means --quux
-    -NUM                  set integer to NUM
-    +                     same as -b
-    --ambiguous           positive ambiguity
-    --no-ambiguous        negative ambiguity
-
-Standard options
-    --abbrev[=<n>]        use <n> digits to display SHA-1s
-    -v, --verbose         be verbose
-    -n, --dry-run         dry run
-    -q, --quiet           be quiet
-
-EOF
-
 test_expect_success 'test help' '
-	test_must_fail test-parse-options -h > output 2> output.err &&
+	cat >expect <<-EOF &&
+		usage: test-parse-options <options>
+
+		    -b, --boolean         get a boolean
+		    -4, --or4             bitwise-or boolean with ...0100
+		    --neg-or4             same as --no-or4
+
+		    -i, --integer <n>     get a integer
+		    -j <n>                get a integer, too
+		    --set23               set integer to 23
+		    -t <time>             get timestamp of <time>
+		    -L, --length <str>    get length of <str>
+		    -F, --file <file>     set file to <file>
+
+		String options
+		    -s, --string <string>
+		''                          get a string
+		    --string2 <str>       get another string
+		    --st <st>             get another string (pervert ordering)
+		    -o <str>              get another string
+		    --default-string      set string to default
+		    --list <str>          add str to list
+
+		Magic arguments
+		    --quux                means --quux
+		    -NUM                  set integer to NUM
+		    +                     same as -b
+		    --ambiguous           positive ambiguity
+		    --no-ambiguous        negative ambiguity
+
+		Standard options
+		    --abbrev[=<n>]        use <n> digits to display SHA-1s
+		    -v, --verbose         be verbose
+		    -n, --dry-run         dry run
+		    -q, --quiet           be quiet
+
+	EOF
+	cp expect expect.err &&
+	test_must_fail test-parse-options -h >output 2>output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
 
-mv expect expect.err
-
-cat > expect << EOF
-boolean: 2
-integer: 1729
-timestamp: 0
-string: 123
-abbrev: 7
-verbose: 2
-quiet: no
-dry run: yes
-file: prefix/my.file
-EOF
-
 test_expect_success 'short options' '
+	cat >expect <<-\EOF &&
+		boolean: 2
+		integer: 1729
+		timestamp: 0
+		string: 123
+		abbrev: 7
+		verbose: 2
+		quiet: no
+		dry run: yes
+		file: prefix/my.file
+	EOF
 	test-parse-options -s123 -b -i 1729 -b -vv -n -F my.file \
-	> output 2> output.err &&
+		>output 2>output.err &&
 	test_cmp expect output &&
 	test ! -s output.err
 '
 
-cat > expect << EOF
-boolean: 2
-integer: 1729
-timestamp: 0
-string: 321
-abbrev: 10
-verbose: 2
-quiet: no
-dry run: no
-file: prefix/fi.le
-EOF
-
 test_expect_success 'long options' '
+	cat >expect <<-\EOF &&
+		boolean: 2
+		integer: 1729
+		timestamp: 0
+		string: 321
+		abbrev: 10
+		verbose: 2
+		quiet: no
+		dry run: no
+		file: prefix/fi.le
+	EOF
 	test-parse-options --boolean --integer 1729 --boolean --string2=321 \
-		--verbose --verbose --no-dry-run --abbrev=10 --file fi.le\
-		--obsolete > output 2> output.err &&
+		--verbose --verbose --no-dry-run --abbrev=10 --file fi.le \
+		--obsolete >output 2>output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
@@ -101,48 +97,46 @@ test_expect_success 'missing required value' '
 	test $? = 129
 '
 
-cat > expect << EOF
-boolean: 1
-integer: 13
-timestamp: 0
-string: 123
-abbrev: 7
-verbose: 0
-quiet: no
-dry run: no
-file: (not set)
-arg 00: a1
-arg 01: b1
-arg 02: --boolean
-EOF
-
 test_expect_success 'intermingled arguments' '
+	cat >expect <<-\EOF &&
+		boolean: 1
+		integer: 13
+		timestamp: 0
+		string: 123
+		abbrev: 7
+		verbose: 0
+		quiet: no
+		dry run: no
+		file: (not set)
+		arg 00: a1
+		arg 01: b1
+		arg 02: --boolean
+	EOF
 	test-parse-options a1 --string 123 b1 --boolean -j 13 -- --boolean \
-		> output 2> output.err &&
+		>output 2>output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
-boolean: 0
-integer: 2
-timestamp: 0
-string: (not set)
-abbrev: 7
-verbose: 0
-quiet: no
-dry run: no
-file: (not set)
-EOF
-
 test_expect_success 'unambiguously abbreviated option' '
-	test-parse-options --int 2 --boolean --no-bo > output 2> output.err &&
+	cat >expect <<-\EOF &&
+		boolean: 0
+		integer: 2
+		timestamp: 0
+		string: (not set)
+		abbrev: 7
+		verbose: 0
+		quiet: no
+		dry run: no
+		file: (not set)
+	EOF
+	test-parse-options --int 2 --boolean --no-bo >output 2>output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'unambiguously abbreviated option with "="' '
-	test-parse-options --int=2 > output 2> output.err &&
+	test-parse-options --int=2 >output 2>output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
@@ -152,198 +146,190 @@ test_expect_success 'ambiguously abbreviated option' '
 	test $? = 129
 '
 
-cat > expect << EOF
-boolean: 0
-integer: 0
-timestamp: 0
-string: 123
-abbrev: 7
-verbose: 0
-quiet: no
-dry run: no
-file: (not set)
-EOF
-
 test_expect_success 'non ambiguous option (after two options it abbreviates)' '
-	test-parse-options --st 123 > output 2> output.err &&
+	cat >expect <<-\EOF &&
+		boolean: 0
+		integer: 0
+		timestamp: 0
+		string: 123
+		abbrev: 7
+		verbose: 0
+		quiet: no
+		dry run: no
+		file: (not set)
+	EOF
+	test-parse-options --st 123 >output 2>output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
 
-cat > typo.err << EOF
-error: did you mean \`--boolean\` (with two dashes ?)
-EOF
-
 test_expect_success 'detect possible typos' '
-	test_must_fail test-parse-options -boolean > output 2> output.err &&
-	test ! -s output &&
-	test_cmp typo.err output.err
+	cat >typo.err <<-\EOF &&
+		error: did you mean `--boolean` (with two dashes ?)
+	EOF
+	>expect
+	test_must_fail test-parse-options -boolean >output 2>output.err &&
+	test_cmp typo.err output.err &&
+	test_cmp expect output
 '
 
-cat > expect <<EOF
-boolean: 0
-integer: 0
-timestamp: 0
-string: (not set)
-abbrev: 7
-verbose: 0
-quiet: no
-dry run: no
-file: (not set)
-arg 00: --quux
-EOF
-
 test_expect_success 'keep some options as arguments' '
-	test-parse-options --quux > output 2> output.err &&
-        test ! -s output.err &&
-        test_cmp expect output
+	cat >expect <<-\EOF &&
+		boolean: 0
+		integer: 0
+		timestamp: 0
+		string: (not set)
+		abbrev: 7
+		verbose: 0
+		quiet: no
+		dry run: no
+		file: (not set)
+		arg 00: --quux
+	EOF
+	test-parse-options --quux >output 2>output.err &&
+	test ! -s output.err &&
+	test_cmp expect output
 '
 
-cat > expect <<EOF
-boolean: 0
-integer: 0
-timestamp: 1
-string: default
-abbrev: 7
-verbose: 0
-quiet: yes
-dry run: no
-file: (not set)
-arg 00: foo
-EOF
-
 test_expect_success 'OPT_DATE() and OPT_SET_PTR() work' '
-	test-parse-options -t "1970-01-01 00:00:01 +0000" --default-string \
-		foo -q > output 2> output.err &&
+	cat >expect <<-\EOF &&
+		boolean: 0
+		integer: 0
+		timestamp: 1
+		string: default
+		abbrev: 7
+		verbose: 0
+		quiet: yes
+		dry run: no
+		file: (not set)
+		arg 00: foo
+	EOF
+	test-parse-options -t "1970-01-01 00:00:01 +0000" \
+		--default-string foo -q >output 2>output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
 
-cat > expect <<EOF
-Callback: "four", 0
-boolean: 5
-integer: 4
-timestamp: 0
-string: (not set)
-abbrev: 7
-verbose: 0
-quiet: no
-dry run: no
-file: (not set)
-EOF
-
 test_expect_success 'OPT_CALLBACK() and OPT_BIT() work' '
-	test-parse-options --length=four -b -4 > output 2> output.err &&
+	cat >expect <<-\EOF &&
+		Callback: "four", 0
+		boolean: 5
+		integer: 4
+		timestamp: 0
+		string: (not set)
+		abbrev: 7
+		verbose: 0
+		quiet: no
+		dry run: no
+		file: (not set)
+	EOF
+	test-parse-options --length=four -b -4 >output 2>output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
 
-cat > expect <<EOF
-Callback: "not set", 1
-EOF
-
 test_expect_success 'OPT_CALLBACK() and callback errors work' '
-	test_must_fail test-parse-options --no-length > output 2> output.err &&
+	cat >expect <<-\EOF &&
+		Callback: "not set", 1
+	EOF
+	test_must_fail test-parse-options --no-length >output 2>output.err &&
 	test_cmp expect output &&
 	test_cmp expect.err output.err
 '
 
-cat > expect <<EOF
-boolean: 1
-integer: 23
-timestamp: 0
-string: (not set)
-abbrev: 7
-verbose: 0
-quiet: no
-dry run: no
-file: (not set)
-EOF
-
 test_expect_success 'OPT_BIT() and OPT_SET_INT() work' '
-	test-parse-options --set23 -bbbbb --no-or4 > output 2> output.err &&
+	cat >expect <<-\EOF &&
+		boolean: 1
+		integer: 23
+		timestamp: 0
+		string: (not set)
+		abbrev: 7
+		verbose: 0
+		quiet: no
+		dry run: no
+		file: (not set)
+	EOF
+	test-parse-options --set23 -bbbbb --no-or4 >output 2>output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'OPT_NEGBIT() and OPT_SET_INT() work' '
-	test-parse-options --set23 -bbbbb --neg-or4 > output 2> output.err &&
+	test-parse-options --set23 -bbbbb --neg-or4 >output 2>output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
 
-cat > expect <<EOF
-boolean: 6
-integer: 0
-timestamp: 0
-string: (not set)
-abbrev: 7
-verbose: 0
-quiet: no
-dry run: no
-file: (not set)
-EOF
-
 test_expect_success 'OPT_BIT() works' '
-	test-parse-options -bb --or4 > output 2> output.err &&
+	cat >expect <<-\EOF &&
+		boolean: 6
+		integer: 0
+		timestamp: 0
+		string: (not set)
+		abbrev: 7
+		verbose: 0
+		quiet: no
+		dry run: no
+		file: (not set)
+	EOF
+	test-parse-options -bb --or4 >output 2>output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'OPT_NEGBIT() works' '
-	test-parse-options -bb --no-neg-or4 > output 2> output.err &&
+	test-parse-options -bb --no-neg-or4 >output 2>output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'OPT_BOOLEAN() with PARSE_OPT_NODASH works' '
-	test-parse-options + + + + + + > output 2> output.err &&
+	test-parse-options + + + + + + >output 2>output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
 
-cat > expect <<EOF
-boolean: 0
-integer: 12345
-timestamp: 0
-string: (not set)
-abbrev: 7
-verbose: 0
-quiet: no
-dry run: no
-file: (not set)
-EOF
 
 test_expect_success 'OPT_NUMBER_CALLBACK() works' '
-	test-parse-options -12345 > output 2> output.err &&
+	cat >expect <<-\EOF &&
+		boolean: 0
+		integer: 12345
+		timestamp: 0
+		string: (not set)
+		abbrev: 7
+		verbose: 0
+		quiet: no
+		dry run: no
+		file: (not set)
+	EOF
+	test-parse-options -12345 >output 2>output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
 
-cat >expect <<EOF
-boolean: 0
-integer: 0
-timestamp: 0
-string: (not set)
-abbrev: 7
-verbose: 0
-quiet: no
-dry run: no
-file: (not set)
-EOF
-
 test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
+	cat >expect <<-\EOF &&
+		boolean: 0
+		integer: 0
+		timestamp: 0
+		string: (not set)
+		abbrev: 7
+		verbose: 0
+		quiet: no
+		dry run: no
+		file: (not set)
+	EOF
 	test-parse-options --no-ambig >output 2>output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
 
-cat >>expect <<'EOF'
-list: foo
-list: bar
-list: baz
-EOF
 test_expect_success '--list keeps list of strings' '
+	cat >>expect <<-\EOF &&
+		list: foo
+		list: bar
+		list: baz
+	EOF
 	test-parse-options --list foo --list=bar --list=baz >output &&
 	test_cmp expect output
 '
-- 
1.7.8
