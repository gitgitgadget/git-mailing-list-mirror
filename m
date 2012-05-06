From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/65] i18n: parseopt: lookup help and argument translations when showing usage
Date: Sun,  6 May 2012 21:23:51 +0700
Message-ID: <1336314232-21002-2-git-send-email-pclouds@gmail.com>
References: <1336314232-21002-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 16:27:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR2R8-00060V-0S
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 16:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353Ab2EFO1l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 10:27:41 -0400
Received: from mail-pz0-f51.google.com ([209.85.210.51]:53899 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213Ab2EFO1l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 10:27:41 -0400
Received: by dajt11 with SMTP id t11so245393daj.10
        for <git@vger.kernel.org>; Sun, 06 May 2012 07:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3kQhPh4BV3ENQxAolsqYWcZhCJx4m4vbToEKNvGjRxs=;
        b=TZQgeDyPp3m048M7PvFHIBC07bJPJ3PSoi9dpuKkEQERxWYg7WRZThpNVm3Jwwt5cb
         xTzKiPqxx+ugLeAyl/7CzWmXvZprFQfms5uOnQsjEgf4/cyKnieerMZpyZALzVUWUIFa
         kJ5NZcy+deN7KxKeBc22pBhHfdRF1xXmyoEnK6O7EzGIQoJp9zaGobg2MzHM03HIfVi2
         sRrJmH3P/0Fu/8NKUoANdrIcEELVZlkyZh22RJh/A24IDcXRsMvSttAhPMUAQMQ7Mqj9
         9vrB6WQRcVXhXmdn2SacY3lVOPMT7aaSD/QcWu+FOLtnK9CjKINz9WHJziWQXwFAm8iq
         rcmQ==
Received: by 10.68.196.200 with SMTP id io8mr5787351pbc.91.1336314460684;
        Sun, 06 May 2012 07:27:40 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.32.70])
        by mx.google.com with ESMTPS id q1sm15073172pbp.62.2012.05.06.07.27.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 May 2012 07:27:39 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 06 May 2012 21:24:04 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1336314232-21002-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197192>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 parse-options.c |   19 +++++++++++--------
 parse-options.h |   25 ++++++++++++++-----------
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 850cfa7..ab70c29 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -490,7 +490,7 @@ static int usage_argh(const struct option *opts, FI=
LE *outfile)
 			s =3D literal ? "[%s]" : "[<%s>]";
 	else
 		s =3D literal ? " %s" : " <%s>";
-	return fprintf(outfile, s, opts->argh ? opts->argh : "...");
+	return fprintf(outfile, s, opts->argh ? _(opts->argh) : _("..."));
 }
=20
 #define USAGE_OPTS_WIDTH 24
@@ -508,13 +508,16 @@ static int usage_with_options_internal(struct par=
se_opt_ctx_t *ctx,
 	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
 		fprintf(outfile, "cat <<\\EOF\n");
=20
-	fprintf(outfile, "usage: %s\n", *usagestr++);
+	fprintf_ln(outfile, _("usage: %s"), _(*usagestr++));
 	while (*usagestr && **usagestr)
-		fprintf(outfile, "   or: %s\n", *usagestr++);
+		/* TRANSLATORS: the colon here should align with the
+		   one in "usage: %s" translation */
+		fprintf_ln(outfile, _("   or: %s"), _(*usagestr++));
 	while (*usagestr) {
-		fprintf(outfile, "%s%s\n",
-				**usagestr ? "    " : "",
-				*usagestr);
+		if (**usagestr)
+			fprintf_ln(outfile, _("    %s"), _(*usagestr));
+		else
+			putchar('\n');
 		usagestr++;
 	}
=20
@@ -528,7 +531,7 @@ static int usage_with_options_internal(struct parse=
_opt_ctx_t *ctx,
 		if (opts->type =3D=3D OPTION_GROUP) {
 			fputc('\n', outfile);
 			if (*opts->help)
-				fprintf(outfile, "%s\n", opts->help);
+				fprintf(outfile, "%s\n", _(opts->help));
 			continue;
 		}
 		if (!full && (opts->flags & PARSE_OPT_HIDDEN))
@@ -558,7 +561,7 @@ static int usage_with_options_internal(struct parse=
_opt_ctx_t *ctx,
 			fputc('\n', outfile);
 			pad =3D USAGE_OPTS_WIDTH;
 		}
-		fprintf(outfile, "%*s%s\n", pad + USAGE_GAP, "", opts->help);
+		fprintf(outfile, "%*s%s\n", pad + USAGE_GAP, "", _(opts->help));
 	}
 	fputc('\n', outfile);
=20
diff --git a/parse-options.h b/parse-options.h
index da999f8..77a4a8b 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -66,12 +66,14 @@ typedef int parse_opt_ll_cb(struct parse_opt_ctx_t =
*ctx,
  *
  * `argh`::
  *   token to explain the kind of argument this option wants. Keep it
- *   homogeneous across the repository.
+ *   homogeneous across the repository. Should be wrapped by N_() for
+ *   translation.
  *
  * `help`::
  *   the short help associated to what the option does.
  *   Must never be NULL (except for OPTION_END).
  *   OPTION_GROUP uses this pointer to store the group header.
+ *   Should be wrapped by N_() for translation.
  *
  * `flags`::
  *   mask of parse_opt_option_flags.
@@ -128,7 +130,7 @@ struct option {
 #define OPT_BOOL(s, l, v, h)        OPT_SET_INT(s, l, v, h, 1)
 #define OPT_SET_PTR(s, l, v, h, p)  { OPTION_SET_PTR, (s), (l), (v), N=
ULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (p) }
-#define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), "=
n", (h) }
+#define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), N=
_("n"), (h) }
 #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (=
a), (h) }
 #define OPT_STRING_LIST(s, l, v, a, h) \
 				    { OPTION_CALLBACK, (s), (l), (v), (a), \
@@ -136,7 +138,7 @@ struct option {
 #define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), =
NULL, \
 				      (h), PARSE_OPT_NOARG, &parse_opt_tertiary }
 #define OPT_DATE(s, l, v, h) \
-	{ OPTION_CALLBACK, (s), (l), (v), "time",(h), 0, \
+	{ OPTION_CALLBACK, (s), (l), (v), N_("time"),(h), 0,	\
 	  parse_opt_approxidate_cb }
 #define OPT_CALLBACK(s, l, v, a, h, f) \
 	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), 0, (f) }
@@ -144,21 +146,22 @@ struct option {
 	{ OPTION_NUMBER, 0, NULL, (v), NULL, (h), \
 	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, (f) }
 #define OPT_FILENAME(s, l, v, h)    { OPTION_FILENAME, (s), (l), (v), =
\
-				       "file", (h) }
+				       N_("file"), (h) }
 #define OPT_COLOR_FLAG(s, l, v, h) \
-	{ OPTION_CALLBACK, (s), (l), (v), "when", (h), PARSE_OPT_OPTARG, \
+	{ OPTION_CALLBACK, (s), (l), (v), N_("when"), (h), PARSE_OPT_OPTARG, =
\
 		parse_opt_color_flag_cb, (intptr_t)"always" }
=20
 #define OPT_NOOP_NOARG(s, l) \
 	{ OPTION_CALLBACK, (s), (l), NULL, NULL, \
-	  "no-op (backward compatibility)", \
+	  N_("no-op (backward compatibility)"),		\
 	  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, parse_opt_noop_cb }
=20
 /* Deprecated synonym */
 #define OPT_BOOLEAN OPT_COUNTUP
=20
 /* parse_options() will filter out the processed options and leave the
- * non-option arguments in argv[].
+ * non-option arguments in argv[]. usagestr strings should be marked
+ * for translation with N_().
  * Returns the number of arguments left in argv[].
  */
 extern int parse_options(int argc, const char **argv, const char *pref=
ix,
@@ -222,15 +225,15 @@ extern int parse_opt_noop_cb(const struct option =
*, const char *, int);
 #define OPT__VERBOSE(var, h)  OPT_BOOLEAN('v', "verbose", (var), (h))
 #define OPT__QUIET(var, h)    OPT_BOOLEAN('q', "quiet",   (var), (h))
 #define OPT__VERBOSITY(var) \
-	{ OPTION_CALLBACK, 'v', "verbose", (var), NULL, "be more verbose", \
+	{ OPTION_CALLBACK, 'v', "verbose", (var), NULL, N_("be more verbose")=
, \
 	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }, \
-	{ OPTION_CALLBACK, 'q', "quiet", (var), NULL, "be more quiet", \
+	{ OPTION_CALLBACK, 'q', "quiet", (var), NULL, N_("be more quiet"), \
 	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }
 #define OPT__DRY_RUN(var, h)  OPT_BOOLEAN('n', "dry-run", (var), (h))
 #define OPT__FORCE(var, h)    OPT_BOOLEAN('f', "force",   (var), (h))
 #define OPT__ABBREV(var)  \
-	{ OPTION_CALLBACK, 0, "abbrev", (var), "n", \
-	  "use <n> digits to display SHA-1s", \
+	{ OPTION_CALLBACK, 0, "abbrev", (var), N_("n"),	\
+	  N_("use <n> digits to display SHA-1s"),	\
 	  PARSE_OPT_OPTARG, &parse_opt_abbrev_cb, 0 }
 #define OPT__COLOR(var, h) \
 	OPT_COLOR_FLAG(0, "color", (var), (h))
--=20
1.7.8.36.g69ee2
