From: ilya.bobyr@gmail.com
Subject: [PATCHv2] =?UTF-8?q?rev-parse=20--parseopt:=20allow=20[*=3D=3F!]=20?= =?UTF-8?q?in=20argument=20hints?=
Date: Mon, 13 Jul 2015 03:12:35 -0700
Message-ID: <1436782355-3576-1-git-send-email-ilya.bobyr@gmail.com>
References: <1436693990-2908-1-git-send-email-ilya.bobyr@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Philip Oakley <philipoakley@iee.org>,
	Ilya Bobyr <ilya.bobyr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 13 12:13:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEajP-0001hV-D9
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 12:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbbGMKM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2015 06:12:58 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34688 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbbGMKM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2015 06:12:57 -0400
Received: by pdbep18 with SMTP id ep18so223194370pdb.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2015 03:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=64fPWQ75kMJgrfgJkRaKGnqnL9uYwbCSdCYhLld/AkE=;
        b=ztN1UaI974h7tsFTBXKWY1NjbrIMjMyD4G7wmw/d3Q9djYa+xU2xrTTpNmnvdO9yOw
         3nsoEw7pe8sIjWiOnuQUMG/6Vv5fxiwEAMHrbQoaeKXxOsFubYJGTymoQJNWAjyEQjBn
         3t3QN+UwXxzOEZecO1M3Cj0ehyRUbOa8HzkW9YiJZEjs5N7MAaXfZL2l6nTDjzYig1Aq
         3ScUlo6O6LCqYFFOGB06Uh2fLIWe6SmLe/FntfFMXbBIKl3k5G0ePR7Y1G4Y13W422SZ
         MNo0O2dh9Pg2iOiHS1ae6f2u0qBgluxlG3fKvqH6RDG+Vi+JFmn4K8dMot90ZDcOt/vy
         57VQ==
X-Received: by 10.67.5.2 with SMTP id ci2mr66853542pad.97.1436782377092;
        Mon, 13 Jul 2015 03:12:57 -0700 (PDT)
Received: from localhost.localdomain (c-50-156-82-222.hsd1.ca.comcast.net. [50.156.82.222])
        by smtp.gmail.com with ESMTPSA id k3sm18329035pde.18.2015.07.13.03.12.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jul 2015 03:12:55 -0700 (PDT)
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1436693990-2908-1-git-send-email-ilya.bobyr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273910>

From: Ilya Bobyr <ilya.bobyr@gmail.com>

A line in the input to "rev-parse --parseopt" describes an option by
listing a short and/or long name, optional flags [*=?!], argument hint, and
then whitespace and help string.

We did not allow any of the [*=?!] characters in the argument hints.  The
following <opt-spec>

    pair=key=value  equals sign in the hint

used to generate a help line like this:

    --pair=key <value>   equals sign in the hint

and used to expect "pair=key" as the argument name.

That is not very helpful as we generally do not want any of the [*=?!]
characters in the argument names.  But we do want to use at least the
equals sign in the argument hints.

Now long argument names stop at the very first [*=?!] character.

Added test case with equals sign in the argument hint and updated the
test to perform all the operations in test_expect_success matching the
t\README requirements and allowing commands like

    ./t1502-rev-parse-parseopt.sh --run=1-2

to stop at the test case 2 without any further modification of the test
state area.

Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
---
Junio, thank you very much for all the comments.  I hope I have included
all of the suggestions you made.  Please, let me know if I have missed
anything or if there is something else you think should be improved.

I assumed that the commit description would be read by someone making
changes in the same area of code.  So, I thought that an explanation
similar to the one in the very first paragraph would be redundant.

I have also made a slight addition to the man page to clarify the <flags>
parsing, based on the Philip Oakley comment.  Not sure if it is at the
level Philip wants it to be.  Please, let me know if you think it is still
not good enough.

 Documentation/git-rev-parse.txt |  9 ++--
 builtin/rev-parse.c             | 57 +++++++++++++-----------
 t/t1502-rev-parse-parseopt.sh   | 99 +++++++++++++++++++++++++----------------
 3 files changed, 95 insertions(+), 70 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index c483100..2ea169d 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -311,8 +311,8 @@ Each line of options has this format:
 `<opt-spec>`::
 	its format is the short option character, then the long option name
 	separated by a comma. Both parts are not required, though at least one
-	is necessary. `h,help`, `dry-run` and `f` are all three correct
-	`<opt-spec>`.
+	is necessary. May not contain any of the `<flags>` characters.
+	`h,help`, `dry-run` and `f` are all three correct `<opt-spec>`.
 
 `<flags>`::
 	`<flags>` are of `*`, `=`, `?` or `!`.
@@ -331,8 +331,9 @@ Each line of options has this format:
 `<arg-hint>`::
 	`<arg-hint>`, if specified, is used as a name of the argument in the
 	help output, for options that take arguments. `<arg-hint>` is
-	terminated by the first whitespace.  It is customary to use a
-	dash to separate words in a multi-word argument hint.
+	terminated by the first whitespace.  It may contain any of the
+	`<flags>` characters after the first character. It is customary to
+	use a dash to separate words in a multi-word argument hint.
 
 The remainder of the line, after stripping the spaces, is used
 as the help associated to the option.
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index b623239..15acea4 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -371,6 +371,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 					N_("output in stuck long form")),
 		OPT_END(),
 	};
+	static const char * const flag_chars = "*=?!";
 
 	struct strbuf sb = STRBUF_INIT, parsed = STRBUF_INIT;
 	const char **usage = NULL;
@@ -400,7 +401,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 	/* parse: (<short>|<short>,<long>|<long>)[*=?!]*<arghint>? SP+ <help> */
 	while (strbuf_getline(&sb, stdin, '\n') != EOF) {
 		const char *s;
-		const char *end;
+		const char *help;
 		struct option *o;
 
 		if (!sb.len)
@@ -410,54 +411,56 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 		memset(opts + onb, 0, sizeof(opts[onb]));
 
 		o = &opts[onb++];
-		s = strchr(sb.buf, ' ');
-		if (!s || *sb.buf == ' ') {
+		help = strchr(sb.buf, ' ');
+		if (!help || *sb.buf == ' ') {
 			o->type = OPTION_GROUP;
 			o->help = xstrdup(skipspaces(sb.buf));
 			continue;
 		}
 
 		o->type = OPTION_CALLBACK;
-		o->help = xstrdup(skipspaces(s));
+		o->help = xstrdup(skipspaces(help));
 		o->value = &parsed;
 		o->flags = PARSE_OPT_NOARG;
 		o->callback = &parseopt_dump;
 
-		/* Possible argument name hint */
-		end = s;
-		while (s > sb.buf && strchr("*=?!", s[-1]) == NULL)
-			--s;
-		if (s != sb.buf && s != end)
-			o->argh = xmemdupz(s, end - s);
-		if (s == sb.buf)
-			s = end;
-
-		while (s > sb.buf && strchr("*=?!", s[-1])) {
-			switch (*--s) {
+		/* name(s) */
+		s = strpbrk(sb.buf, flag_chars);
+		if (s == NULL)
+			s = help;
+
+		if (s - sb.buf == 1) /* short option only */
+			o->short_name = *sb.buf;
+		else if (sb.buf[1] != ',') /* long option only */
+			o->long_name = xmemdupz(sb.buf, s - sb.buf);
+		else {
+			o->short_name = *sb.buf;
+			o->long_name = xmemdupz(sb.buf + 2, s - sb.buf - 2);
+		}
+
+		/* type */
+		while (s < help) {
+			switch (*s++) {
 			case '=':
 				o->flags &= ~PARSE_OPT_NOARG;
-				break;
+				continue;
 			case '?':
 				o->flags &= ~PARSE_OPT_NOARG;
 				o->flags |= PARSE_OPT_OPTARG;
-				break;
+				continue;
 			case '!':
 				o->flags |= PARSE_OPT_NONEG;
-				break;
+				continue;
 			case '*':
 				o->flags |= PARSE_OPT_HIDDEN;
-				break;
+				continue;
 			}
+			s--;
+			break;
 		}
 
-		if (s - sb.buf == 1) /* short option only */
-			o->short_name = *sb.buf;
-		else if (sb.buf[1] != ',') /* long option only */
-			o->long_name = xmemdupz(sb.buf, s - sb.buf);
-		else {
-			o->short_name = *sb.buf;
-			o->long_name = xmemdupz(sb.buf + 2, s - sb.buf - 2);
-		}
+		if (s < help)
+			o->argh = xmemdupz(s, help - s);
 	}
 	strbuf_release(&sb);
 
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index ebe7c3b..63392a8 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -3,7 +3,40 @@
 test_description='test git rev-parse --parseopt'
 . ./test-lib.sh
 
-sed -e 's/^|//' >expect <<\END_EXPECT
+test_expect_success 'setup optionspec' '
+	sed -e "s/^|//" >optionspec <<\EOF
+|some-command [options] <args>...
+|
+|some-command does foo and bar!
+|--
+|h,help    show the help
+|
+|foo       some nifty option --foo
+|bar=      some cool option --bar with an argument
+|b,baz     a short and long option
+|
+| An option group Header
+|C?        option C with an optional argument
+|d,data?   short and long option with an optional argument
+|
+| Argument hints
+|B=arg     short option required argument
+|bar2=arg  long option required argument
+|e,fuz=with-space  short and long option required argument
+|s?some    short option optional argument
+|long?data long option optional argument
+|g,fluf?path     short and long option optional argument
+|longest=very-long-argument-hint  a very long argument hint
+|pair=key=value  with an equals sign in the hint
+|short-hint=a    with a one simbol hint
+|
+|Extras
+|extra1    line above used to cause a segfault but no longer does
+EOF
+'
+
+test_expect_success 'test --parseopt help output' '
+	sed -e "s/^|//" >expect <<\END_EXPECT &&
 |cat <<\EOF
 |usage: some-command [options] <args>...
 |
@@ -28,49 +61,23 @@ sed -e 's/^|//' >expect <<\END_EXPECT
 |    -g, --fluf[=<path>]   short and long option optional argument
 |    --longest <very-long-argument-hint>
 |                          a very long argument hint
+|    --pair <key=value>    with an equals sign in the hint
+|    --short-hint <a>      with a one simbol hint
 |
 |Extras
 |    --extra1              line above used to cause a segfault but no longer does
 |
 |EOF
 END_EXPECT
-
-sed -e 's/^|//' >optionspec <<\EOF
-|some-command [options] <args>...
-|
-|some-command does foo and bar!
-|--
-|h,help    show the help
-|
-|foo       some nifty option --foo
-|bar=      some cool option --bar with an argument
-|b,baz     a short and long option
-|
-| An option group Header
-|C?        option C with an optional argument
-|d,data?   short and long option with an optional argument
-|
-| Argument hints
-|B=arg     short option required argument
-|bar2=arg  long option required argument
-|e,fuz=with-space  short and long option required argument
-|s?some    short option optional argument
-|long?data long option optional argument
-|g,fluf?path     short and long option optional argument
-|longest=very-long-argument-hint  a very long argument hint
-|
-|Extras
-|extra1    line above used to cause a segfault but no longer does
-EOF
-
-test_expect_success 'test --parseopt help output' '
 	test_expect_code 129 git rev-parse --parseopt -- -h > output < optionspec &&
 	test_i18ncmp expect output
 '
 
-cat > expect <<EOF
+test_expect_success 'setup expect.1' "
+	cat > expect <<EOF
 set -- --foo --bar 'ham' -b -- 'arg'
 EOF
+"
 
 test_expect_success 'test --parseopt' '
 	git rev-parse --parseopt -- --foo --bar=ham --baz arg < optionspec > output &&
@@ -82,9 +89,11 @@ test_expect_success 'test --parseopt with mixed options and arguments' '
 	test_cmp expect output
 '
 
-cat > expect <<EOF
+test_expect_success 'setup expect.2' "
+	cat > expect <<EOF
 set -- --foo -- 'arg' '--bar=ham'
 EOF
+"
 
 test_expect_success 'test --parseopt with --' '
 	git rev-parse --parseopt -- --foo -- arg --bar=ham < optionspec > output &&
@@ -96,54 +105,66 @@ test_expect_success 'test --parseopt --stop-at-non-option' '
 	test_cmp expect output
 '
 
-cat > expect <<EOF
+test_expect_success 'setup expect.3' "
+	cat > expect <<EOF
 set -- --foo -- '--' 'arg' '--bar=ham'
 EOF
+"
 
 test_expect_success 'test --parseopt --keep-dashdash' '
 	git rev-parse --parseopt --keep-dashdash -- --foo -- arg --bar=ham < optionspec > output &&
 	test_cmp expect output
 '
 
-cat >expect <<EOF
+test_expect_success 'setup expect.4' "
+	cat >expect <<EOF
 set -- --foo -- '--' 'arg' '--spam=ham'
 EOF
+"
 
 test_expect_success 'test --parseopt --keep-dashdash --stop-at-non-option with --' '
 	git rev-parse --parseopt --keep-dashdash --stop-at-non-option -- --foo -- arg --spam=ham <optionspec >output &&
 	test_cmp expect output
 '
 
-cat > expect <<EOF
+test_expect_success 'setup expect.5' "
+	cat > expect <<EOF
 set -- --foo -- 'arg' '--spam=ham'
 EOF
+"
 
 test_expect_success 'test --parseopt --keep-dashdash --stop-at-non-option without --' '
 	git rev-parse --parseopt --keep-dashdash --stop-at-non-option -- --foo arg --spam=ham <optionspec >output &&
 	test_cmp expect output
 '
 
-cat > expect <<EOF
+test_expect_success 'setup expect.6' "
+	cat > expect <<EOF
 set -- --foo --bar='z' --baz -C'Z' --data='A' -- 'arg'
 EOF
+"
 
 test_expect_success 'test --parseopt --stuck-long' '
 	git rev-parse --parseopt --stuck-long -- --foo --bar=z -b arg -CZ -dA <optionspec >output &&
 	test_cmp expect output
 '
 
-cat > expect <<EOF
+test_expect_success 'setup expect.7' "
+	cat > expect <<EOF
 set -- --data='' -C --baz -- 'arg'
 EOF
+"
 
 test_expect_success 'test --parseopt --stuck-long and empty optional argument' '
 	git rev-parse --parseopt --stuck-long -- --data= arg -C -b <optionspec >output &&
 	test_cmp expect output
 '
 
-cat > expect <<EOF
+test_expect_success 'setup expect.8' "
+	cat > expect <<EOF
 set -- --data --baz -- 'arg'
 EOF
+"
 
 test_expect_success 'test --parseopt --stuck-long and long option with unset optional argument' '
 	git rev-parse --parseopt --stuck-long -- --data arg -b <optionspec >output &&
-- 
2.4.5
