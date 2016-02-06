From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 00/11] Fix icase grep on non-ascii
Date: Sat,  6 Feb 2016 09:02:59 +0700
Message-ID: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 03:03:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRsDi-0003BH-TM
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 03:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbcBFCDX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 21:03:23 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36841 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbcBFCDV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 21:03:21 -0500
Received: by mail-pf0-f180.google.com with SMTP id n128so77466883pfn.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 18:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zA5oHlNx7e6gdvLzITCa4VM/GS6jMi3zXE60ovUsank=;
        b=nqWvZBufh6Jz4tS8ewXBIEy8fDzmU0P4JoGKl458e9mbXHXH4QKodtQkov1rNQDdt1
         rFN/XoX7/kWdEd16HBqECYKPd7uw+5Y/R3u1Xx9oXWkunzWs2TPBqiAB3EU04We/WLlQ
         bODAyHd99OQ/VF5bSc7Fc0f6lOBxPY440KND0/aseECmRBuU7dZmpsq6RQ4aysEmaSVw
         ZzAG8rB4wYam80H+JE7AqEP8pfPRBmrID77hmB4NpgaT3soKtOLGT2QS7DShcQk/dO9k
         MAGwJ+oaIN8+joUo/v0K6FgPrNoK3vqUlXuw4jHBGMT8TSy+gO7eAN1SnV2AFwNfypBZ
         seJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=zA5oHlNx7e6gdvLzITCa4VM/GS6jMi3zXE60ovUsank=;
        b=Q6StirCqu7EiJiVxfuJrFscZ9Z/qBcw5fowCI2+nWvijwzfWsm0g0FWWlzoM6TCeb2
         cYyaePhbkwKiPtdGsa9miwt8TdmvAl6KK/18HZXgEl1MmNnfygbFI1LGwNk215n8OQSY
         uHOkIumALPyZHqWRskcj7aL2DdhAWz5qAAU1/s5cWr6LcVZuLdkx0LHY0HEWBDD+v7G9
         dMMyRy/N9r6CaFWj9QRmzoPMr0l585yh4IdNN/jjBV/otLaja+Dvq5xze745nYJXItHp
         wd1vERoOCdaM1tR4eYw1m9sRaejT0vcttE9wNkf5iqHWQEk8tuDYAmSV7skVEtbtrYKo
         exOA==
X-Gm-Message-State: AG10YORN58LkjSgP8coxuSnT5NL1Z6yFup4tLwfyJbvl36MCZ4eTvZGszmJ9upyjNVQ0rw==
X-Received: by 10.98.42.135 with SMTP id q129mr24189987pfq.13.1454724201391;
        Fri, 05 Feb 2016 18:03:21 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id o73sm27225655pfa.37.2016.02.05.18.03.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 18:03:19 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 06 Feb 2016 09:03:33 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285666>

v6 fixes comments from Ramsay and Eric. Interdiff below. The only
thing to add is, I decided not to replace !icase_non_ascii with
icase_ascii_only. I went with spelling out "!icase || ascii_only". I
think it expresses the intention better.

diff --git a/grep.c b/grep.c
index 2e4f71d..aed4fe0 100644
--- a/grep.c
+++ b/grep.c
@@ -412,11 +412,11 @@ static void compile_fixed_regexp(struct grep_pat =
*p, struct grep_opt *opt)
 	basic_regex_quote_buf(&sb, p->pattern);
 	err =3D regcomp(&p->regexp, sb.buf, opt->regflags & ~REG_EXTENDED);
 	if (opt->debug)
-		fprintf(stderr, "fixed%s\n", sb.buf);
+		fprintf(stderr, "fixed %s\n", sb.buf);
 	strbuf_release(&sb);
 	if (err) {
 		char errbuf[1024];
-		regerror(err, &p->regexp, errbuf, 1024);
+		regerror(err, &p->regexp, errbuf, sizeof(errbuf));
 		regfree(&p->regexp);
 		compile_regexp_failed(p, errbuf);
 	}
@@ -424,19 +424,18 @@ static void compile_fixed_regexp(struct grep_pat =
*p, struct grep_opt *opt)
=20
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
-	int icase_non_ascii;
+	int icase, ascii_only;
 	int err;
=20
 	p->word_regexp =3D opt->word_regexp;
 	p->ignore_case =3D opt->ignore_case;
-	icase_non_ascii =3D
-		(opt->regflags & REG_ICASE || p->ignore_case) &&
-		has_non_ascii(p->pattern);
+	icase	       =3D opt->regflags & REG_ICASE || p->ignore_case;
+	ascii_only     =3D !has_non_ascii(p->pattern);
=20
-	if (!icase_non_ascii && is_fixed(p->pattern, p->patternlen))
+	if ((!icase || ascii_only) && is_fixed(p->pattern, p->patternlen))
 		p->fixed =3D 1;
 	else if (opt->fixed) {
-		p->fixed =3D !icase_non_ascii;
+		p->fixed =3D !icase || ascii_only;
 		if (!p->fixed) {
 			compile_fixed_regexp(p, opt);
 			return;
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 5ed69a6..991ed2a 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -31,7 +31,7 @@ test_expect_success 'git_mkstemps_mode does not fail =
if fd 0 is not open' '
=20
 test_expect_success 'check for a bug in the regex routines' '
 	# if this test fails, re-build git with NO_REGEX=3D1
-	test-regex
+	test-regex --bug
 '
=20
 test_done
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-a=
scii.sh
index a5475bb..4176625 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -38,12 +38,12 @@ test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep pc=
re utf-8 string with "+"' '
 test_expect_success REGEX_LOCALE 'grep literal string, with -F' '
 	git grep --debug -i -F "TILRAUN: Hall=C3=B3 Heimur!"  2>&1 >/dev/null=
 |
 		 grep fixed >debug1 &&
-	echo "fixedTILRAUN: Hall=C3=B3 Heimur!" >expect1 &&
+	echo "fixed TILRAUN: Hall=C3=B3 Heimur!" >expect1 &&
 	test_cmp expect1 debug1 &&
=20
 	git grep --debug -i -F "TILRAUN: HALL=C3=93 HEIMUR!"  2>&1 >/dev/null=
 |
 		 grep fixed >debug2 &&
-	echo "fixedTILRAUN: HALL=C3=93 HEIMUR!" >expect2 &&
+	echo "fixed TILRAUN: HALL=C3=93 HEIMUR!" >expect2 &&
 	test_cmp expect2 debug2
 '
=20
@@ -52,12 +52,12 @@ test_expect_success REGEX_LOCALE 'grep string with =
regex, with -F' '
=20
 	git grep --debug -i -F "^*TILR^AUN:.* \\Hall=C3=B3 \$He[]imur!\$" 2>&=
1 >/dev/null |
 		 grep fixed >debug1 &&
-	echo "fixed\\^*TILR^AUN:\\.\\* \\\\Hall=C3=B3 \$He\\[]imur!\\\$" >exp=
ect1 &&
+	echo "fixed \\^*TILR^AUN:\\.\\* \\\\Hall=C3=B3 \$He\\[]imur!\\\$" >ex=
pect1 &&
 	test_cmp expect1 debug1 &&
=20
 	git grep --debug -i -F "^*TILR^AUN:.* \\HALL=C3=93 \$HE[]IMUR!\$"  2>=
&1 >/dev/null |
 		 grep fixed >debug2 &&
-	echo "fixed\\^*TILR^AUN:\\.\\* \\\\HALL=C3=93 \$HE\\[]IMUR!\\\$" >exp=
ect2 &&
+	echo "fixed \\^*TILR^AUN:\\.\\* \\\\HALL=C3=93 \$HE\\[]IMUR!\\\$" >ex=
pect2 &&
 	test_cmp expect2 debug2
 '
=20
diff --git a/test-regex.c b/test-regex.c
index 3b5641c..d1a952c 100644
--- a/test-regex.c
+++ b/test-regex.c
@@ -17,6 +17,25 @@ static struct reg_flag reg_flags[] =3D {
 	{ NULL, 0 }
 };
=20
+static int test_regex_bug(void)
+{
+	char *pat =3D "[^=3D{} \t]+";
+	char *str =3D "=3D{}\nfred";
+	regex_t r;
+	regmatch_t m[1];
+
+	if (regcomp(&r, pat, REG_EXTENDED | REG_NEWLINE))
+		die("failed regcomp() for pattern '%s'", pat);
+	if (regexec(&r, str, 1, m, 0))
+		die("no match of pattern '%s' to string '%s'", pat, str);
+
+	/* http://sourceware.org/bugzilla/show_bug.cgi?id=3D3957  */
+	if (m[0].rm_so =3D=3D 3) /* matches '\n' when it should not */
+		die("regex bug confirmed: re-build git with NO_REGEX=3D1");
+
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	const char *pat;
@@ -25,40 +44,32 @@ int main(int argc, char **argv)
 	regex_t r;
 	regmatch_t m[1];
=20
-	if (argc =3D=3D 1) {
-		/* special case, bug check */
-		pat =3D "[^=3D{} \t]+";
-		str =3D "=3D{}\nfred";
-		flags =3D REG_EXTENDED | REG_NEWLINE;
-	} else {
+	if (argc =3D=3D 2 && !strcmp(argv[1], "--bug"))
+		return test_regex_bug();
+	else if (argc < 3)
+		die("usage: test-regex --bug\n"
+		    "       test-regex <pattern> <string> [<options>]");
+
+	argv++;
+	pat =3D *argv++;
+	str =3D *argv++;
+	while (*argv) {
+		struct reg_flag *rf;
+		for (rf =3D reg_flags; rf->name; rf++)
+			if (!strcmp(*argv, rf->name)) {
+				flags |=3D rf->flag;
+				break;
+			}
+		if (!rf->name)
+			die("do not recognize %s", *argv);
 		argv++;
-		pat =3D *argv++;
-		str =3D *argv++;
-		while (*argv) {
-			struct reg_flag *rf;
-			for (rf =3D reg_flags; rf->name; rf++)
-				if (!strcmp(*argv, rf->name)) {
-					flags |=3D rf->flag;
-					break;
-				}
-			if (!rf->name)
-				die("do not recognize %s", *argv);
-			argv++;
-		}
-		git_setup_gettext();
 	}
+	git_setup_gettext();
=20
 	if (regcomp(&r, pat, flags))
 		die("failed regcomp() for pattern '%s'", pat);
-	if (regexec(&r, str, 1, m, 0)) {
-		if (argc =3D=3D 1)
-			die("no match of pattern '%s' to string '%s'", pat, str);
+	if (regexec(&r, str, 1, m, 0))
 		return 1;
-	}
-
-	/* http://sourceware.org/bugzilla/show_bug.cgi?id=3D3957  */
-	if (argc =3D=3D 1 && m[0].rm_so =3D=3D 3) /* matches '\n' when it sho=
uld not */
-		die("regex bug confirmed: re-build git with NO_REGEX=3D1");
=20
-	exit(0);
+	return 0;
 }
--=20
2.7.0.377.g4cd97dd
