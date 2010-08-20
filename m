From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] grep -A/-B/-Cinfinity to get full context
Date: Fri, 20 Aug 2010 06:55:27 -0500
Message-ID: <20100820115527.GR10407@burratino>
References: <201008180854.18474.ComputerDruid@gmail.com>
 <m362z6pact.fsf@localhost.localdomain>
 <AANLkTinQZxpLdFiCFH3kDTFVQ-ZLjJ1PEdmmsJSb=0YD@mail.gmail.com>
 <201008201122.09392.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>,
	computerdruid <computerdruid@gmail.com>, joey <joey@kitenet.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 13:57:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmQDm-0004Nm-8L
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 13:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843Ab0HTL5N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 07:57:13 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49547 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab0HTL5L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 07:57:11 -0400
Received: by gyd8 with SMTP id 8so1191360gyd.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 04:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wS08cC3ZN5djbX9GZxgFcdzuSQqQ0R8Gx3NB172uBfQ=;
        b=tznXW75mSvQOe6XHrHlCPzN35V/7/UhOt37jCBQl4mvdSwPiTajyY9nTSnyGimk0Fl
         jslpDq5ymKCEczN+l5z/HawS7Msv6YVIJu2uwff4a3d1WOwpEwbtAdoBI4i02pj1ofzF
         dzfSFftOmbYTd9I55L0nFBAfAWNUS8aswwPVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=itVzaI2EXhDlHmdTbVv2XfXDW6DS9RBLcnHfsdYx+kDcsoYTZ+7hWuxgZhKmaIwYUc
         OhqKw2358jPOfLTVLg0bqtz4tcYIEsKCt+/pNj5PcTpVTsbcRQcFqqyibmIo2Zioh7Aq
         0SOuFjcAb95ScampkoObGf/mja9AA/9LWEKpE=
Received: by 10.100.253.15 with SMTP id a15mr1389751ani.255.1282305430781;
        Fri, 20 Aug 2010 04:57:10 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t30sm4442937ann.27.2010.08.20.04.57.09
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 04:57:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201008201122.09392.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154016>

Just a proof of concept.

Cc: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jakub Narebski wrote:

> If there were more options that use <n> =3D=3D 0 to actually mean unl=
imited
> (infinity), perhaps it would be better to extend parseopt to provide =
for
> such situation, e.g. OPT_INT_INF or something.

Something like this, maybe.

 Documentation/technical/api-parse-options.txt |    6 ++++++
 builtin/grep.c                                |    8 ++++++--
 grep.c                                        |    8 +++++---
 grep.h                                        |    4 ++--
 parse-options.c                               |   21 +++++++++++++++++=
++++
 parse-options.h                               |    4 ++++
 6 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentat=
ion/technical/api-parse-options.txt
index 312e3b2..f152a3f 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -160,6 +160,12 @@ There are some macros to easily define options:
 	Introduce an option with integer argument.
 	The integer is put into `int_var`.
=20
+`OPT_INT_INF(short, long, &int_var, inf_val, description)`::
+	Introduce an option with integer argument.
+	The integer is put into `int_var`.  If the special value
+	"inf" (or "infinity") is used as an argument, then `inf_val`
+	is put into `int_var`.
+
 `OPT_DATE(short, long, &int_var, description)`::
 	Introduce an option with date argument, see `approxidate()`.
 	The timestamp is put into `int_var`.
diff --git a/builtin/grep.c b/builtin/grep.c
index 597f76b..9fbc985 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -750,6 +750,10 @@ static int context_callback(const struct option *o=
pt, const char *arg,
 		grep_opt->pre_context =3D grep_opt->post_context =3D 0;
 		return 0;
 	}
+	if (!strcasecmp(arg, "inf") || !strcasecmp(arg, "infinity")) {
+		grep_opt->pre_context =3D grep_opt->post_context =3D -1;
+		return 0;
+	}
 	value =3D strtol(arg, (char **)&endp, 10);
 	if (*endp) {
 		return error("switch `%c' expects a numerical value",
@@ -890,9 +894,9 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 		OPT_CALLBACK('C', NULL, &opt, "n",
 			"show <n> context lines before and after matches",
 			context_callback),
-		OPT_INTEGER('B', NULL, &opt.pre_context,
+		OPT_INT_INF('B', NULL, &opt.pre_context, -1,
 			"show <n> context lines before matches"),
-		OPT_INTEGER('A', NULL, &opt.post_context,
+		OPT_INT_INF('A', NULL, &opt.post_context, -1,
 			"show <n> context lines after matches"),
 		OPT_NUMBER_CALLBACK(&opt, "shortcut for -C NUM",
 			context_callback),
diff --git a/grep.c b/grep.c
index 82fb349..793d41f 100644
--- a/grep.c
+++ b/grep.c
@@ -687,7 +687,7 @@ static void show_pre_context(struct grep_opt *opt, =
const char *name, char *buf,
 	unsigned cur =3D lno, from =3D 1, funcname_lno =3D 0;
 	int funcname_needed =3D opt->funcname;
=20
-	if (opt->pre_context < lno)
+	if (opt->pre_context >=3D 0 && opt->pre_context < lno)
 		from =3D lno - opt->pre_context;
 	if (from <=3D opt->last_shown)
 		from =3D opt->last_shown + 1;
@@ -861,7 +861,8 @@ static int grep_buffer_1(struct grep_opt *opt, cons=
t char *name,
 		 */
 		if (try_lookahead
 		    && !(last_hit
-			 && lno <=3D last_hit + opt->post_context)
+			 && (opt->post_context < 0
+			     || lno <=3D last_hit + opt->post_context))
 		    && look_ahead(opt, &left, &lno, &bol))
 			break;
 		eol =3D end_of_line(bol, &left);
@@ -916,7 +917,8 @@ static int grep_buffer_1(struct grep_opt *opt, cons=
t char *name,
 			last_hit =3D lno;
 		}
 		else if (last_hit &&
-			 lno <=3D last_hit + opt->post_context) {
+			 (opt->post_context < 0 ||
+			  lno <=3D last_hit + opt->post_context)) {
 			/* If the last hit is within the post context,
 			 * we need to show this line.
 			 */
diff --git a/grep.h b/grep.h
index efa8cff..13aae94 100644
--- a/grep.h
+++ b/grep.h
@@ -95,8 +95,8 @@ struct grep_opt {
 	char color_selected[COLOR_MAXLEN];
 	char color_sep[COLOR_MAXLEN];
 	int regflags;
-	unsigned pre_context;
-	unsigned post_context;
+	int pre_context;
+	int post_context;
 	unsigned last_shown;
 	int show_hunk_mark;
 	void *priv;
diff --git a/parse-options.c b/parse-options.c
index 0fa79bc..b299125 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -612,6 +612,27 @@ int parse_opt_approxidate_cb(const struct option *=
opt, const char *arg,
 	return 0;
 }
=20
+int parse_opt_infinity_cb(const struct option *opt, const char *arg,
+			  int unset)
+{
+	const char *endp;
+
+	if (unset) {
+		*(int *)opt->value =3D 0;
+		return 0;
+	}
+	if (!arg)
+		return opterror(opt, "expects a numerical value", 0);
+	if (!strcasecmp(arg, "inf") || !strcasecmp(arg, "infinity")) {
+		*(int *)opt->value =3D opt->defval;
+		return 0;
+	}
+	*(int *)opt->value =3D strtol(arg, (char **)&endp, 10);
+	if (*endp)
+		return opterror(opt, "expects a numerical value", 0);
+	return 0;
+}
+
 int parse_opt_color_flag_cb(const struct option *opt, const char *arg,
 			    int unset)
 {
diff --git a/parse-options.h b/parse-options.h
index 7435cdb..6ae041a 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -126,6 +126,9 @@ struct option {
 #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (=
a), (h) }
 #define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), =
NULL, \
 				      (h), PARSE_OPT_NOARG, &parse_opt_tertiary }
+#define OPT_INT_INF(s, l, v, i, h) \
+	{ OPTION_CALLBACK, (s), (l), (v), "n", (h), 0, \
+	  parse_opt_infinity_cb, (intptr_t)(i) }
 #define OPT_DATE(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), "time",(h), 0, \
 	  parse_opt_approxidate_cb }
@@ -193,6 +196,7 @@ extern int parse_options_concat(struct option *dst,=
 size_t, struct option *src);
 /*----- some often used options -----*/
 extern int parse_opt_abbrev_cb(const struct option *, const char *, in=
t);
 extern int parse_opt_approxidate_cb(const struct option *, const char =
*, int);
+extern int parse_opt_infinity_cb(const struct option *, const char *, =
int);
 extern int parse_opt_color_flag_cb(const struct option *, const char *=
, int);
 extern int parse_opt_verbosity_cb(const struct option *, const char *,=
 int);
 extern int parse_opt_with_commit(const struct option *, const char *, =
int);
--=20
1.7.2.2.536.g42dab.dirty
