From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: [PATCH v2] rev-parse --parseopt: option argument name hints
Date: Sun,  9 Mar 2014 22:55:07 -0700
Message-ID: <1394430907-6052-1-git-send-email-ilya.bobyr@gmail.com>
References: <531D51EC.6050503@gmail.com>
Cc: Ilya Bobyr <ilya.bobyr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 06:56:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMtC7-0003eA-0p
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 06:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbaCJF4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 01:56:00 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:63819 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbaCJFzk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 01:55:40 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so6802605pbc.30
        for <git@vger.kernel.org>; Sun, 09 Mar 2014 22:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:cc;
        bh=2k0naYVxS8pJ7oThW4SAUZCtnnB/hlW1E2mhANfrOiU=;
        b=n4iIKQbrj0+JWONy8lp4dHCbsAgloN2jxRsReO9aZghOkOGO8vtlbdoLx8YybBZYk6
         yMczM/Sity3oqYkDawvmkTHQ6Cy3s/YI+CX1E73cR10aEoAacE11Zd7RcLMuqHeM/mWb
         JO+uXGmcMGT/l8FVsDdcUECmo2k5cpntAZ8fbGzUPB3S0qM3M/B4qG00RVWDmJYe75JD
         n51JDqJmsfNpcEFE/xP/tVfbYp8FxZ+QmJ0hzho6VJ0+F9DY5/xx5XFNOYATj9IkcEyD
         h4MUHPm8ctjbArGGVopCF2GmMg/sJPfD1RS/Ku71VDknAOTXRFUlkPQDqwWTSjJeJPW+
         dJHg==
X-Received: by 10.69.25.69 with SMTP id io5mr38399229pbd.22.1394430939285;
        Sun, 09 Mar 2014 22:55:39 -0700 (PDT)
Received: from localhost.localdomain (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id vx10sm73428019pac.17.2014.03.09.22.55.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Mar 2014 22:55:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <531D51EC.6050503@gmail.com>
CC: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243706>

Built-in commands can specify names for option arguments when usage text
is generated for a command.  sh based commands should be able to do the
same.

Option argument name hint is any text that comes after [*=?!] after the
argument name up to the first whitespace.  Underscores are replaced with
whitespace.  It is unlikely that an underscore would be useful in the
hint text.

Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
---
 Documentation/git-rev-parse.txt |   11 +++++++++--
 builtin/rev-parse.c             |   17 ++++++++++++++++-
 t/t1502-rev-parse-parseopt.sh   |   20 ++++++++++++++++++++
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 0d2cdcd..4cb6e02 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -284,13 +284,13 @@ Input Format
 
 'git rev-parse --parseopt' input format is fully text based. It has two parts,
 separated by a line that contains only `--`. The lines before the separator
-(should be more than one) are used for the usage.
+(could be more than one) are used for the usage.
 The lines after the separator describe the options.
 
 Each line of options has this format:
 
 ------------
-<opt_spec><flags>* SP+ help LF
+<opt_spec><flags>*<argh>? SP+ help LF
 ------------
 
 `<opt_spec>`::
@@ -313,6 +313,12 @@ Each line of options has this format:
 
 	* Use `!` to not make the corresponding negated long option available.
 
+`<argh>`::
+	`<argh>`, if specified, is used as a name of the argument, if the
+	option takes an argument. `<argh>` is terminated by the first
+	whitespace. Angle braces are added automatically.  Underscore symbols
+	are replaced with spaces.
+
 The remainder of the line, after stripping the spaces, is used
 as the help associated to the option.
 
@@ -333,6 +339,7 @@ h,help    show the help
 
 foo       some nifty option --foo
 bar=      some cool option --bar with an argument
+baz=arg   another cool option --baz with an argument named <arg>
 
   An option group Header
 C?        option C with an optional argument"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 45901df..7a58404 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -395,9 +395,10 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 		usage[unb++] = strbuf_detach(&sb, NULL);
 	}
 
-	/* parse: (<short>|<short>,<long>|<long>)[=?]? SP+ <help> */
+	/* parse: (<short>|<short>,<long>|<long>)[*=?!]*<arghint>? SP+ <help> */
 	while (strbuf_getline(&sb, stdin, '\n') != EOF) {
 		const char *s;
+		const char *argh;
 		struct option *o;
 
 		if (!sb.len)
@@ -419,6 +420,20 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 		o->value = &parsed;
 		o->flags = PARSE_OPT_NOARG;
 		o->callback = &parseopt_dump;
+
+		/* Possible argument name hint */
+		argh = s;
+		while (s > sb.buf && strchr("*=?!", s[-1]) == NULL)
+			--s;
+		if (s != sb.buf && s != argh) {
+			char *a;
+			o->argh = a = xmemdupz(s, argh - s);
+			while (a = strchr(a, '_'))
+				*a = ' ';
+		}
+		if (s == sb.buf)
+			s = argh;
+
 		while (s > sb.buf && strchr("*=?!", s[-1])) {
 			switch (*--s) {
 			case '=':
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 83b1300..bf0db05 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -18,6 +18,17 @@ An option group Header
     -C[...]               option C with an optional argument
     -d, --data[=...]      short and long option with an optional argument
 
+Argument hints
+    -b <arg>              short option required argument
+    --bar2 <arg>          long option required argument
+    -e, --fuz <with spaces>
+                          short and long option required argument
+    -s[<some>]            short option optional argument
+    --long[=<data>]       long option optional argument
+    -g, --fluf[=<path>]   short and long option optional argument
+    --longest <a very long argument hint>
+                          a very long argument hint
+
 Extras
     --extra1              line above used to cause a segfault but no longer does
 
@@ -39,6 +50,15 @@ b,baz     a short and long option
 C?        option C with an optional argument
 d,data?   short and long option with an optional argument
 
+ Argument hints
+b=arg     short option required argument
+bar2=arg  long option required argument
+e,fuz=with_spaces  short and long option required argument
+s?some    short option optional argument
+long?data long option optional argument
+g,fluf?path     short and long option optional argument
+longest=a_very_long_argument_hint  a very long argument hint
+
 Extras
 extra1    line above used to cause a segfault but no longer does
 EOF
-- 
1.7.9
