From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 2/2] parse-options: simplify usage argh handling
Date: Thu,  4 Jun 2009 16:43:57 -0700
Message-ID: <1244159037-9292-2-git-send-email-bebarino@gmail.com>
References: <4A26DBA3.90604@lsrfire.ath.cx>
 <1244159037-9292-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 01:44:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCMbg-0000iC-JD
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 01:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbZFDXoH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jun 2009 19:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbZFDXoG
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 19:44:06 -0400
Received: from mail-pz0-f171.google.com ([209.85.222.171]:43208 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbZFDXoF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 19:44:05 -0400
Received: by pzk1 with SMTP id 1so478945pzk.33
        for <git@vger.kernel.org>; Thu, 04 Jun 2009 16:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=MwNM6aCuaMrYSyKDhkViPm4c5Gm1U7Qvt/hqTCa43KQ=;
        b=dkOPgIvn10vZjvkNVCxty/hP3IHL97ebcu7NBWTz1bH4uMC6ltYz49qLh7Ro5dMNkC
         UNNrjtG1TQfA/ST7W49UkmEoRR2bgvMdpC+j1eLmzNVe6p5WT05M3wZ18BvvrFA+jDpx
         bzLh0vkq1j/UsxOyo0cQgObZRvGuaULVgiZ18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=EMjuo8u5Yxy7/aNU8q1+U3cpO5fZmGRTrMu7L6Q487qmxvk8PTEj4P15BoyRRPbCXm
         oaQ627zGOytkby+RvOi0orapwEclHGR9R91/42cmHxk4PpdH32nWzbiO/50a3bGhQfzQ
         bevXfLGF7ju7beRPbhsUgYB1KciRT4tOrR6Ww=
Received: by 10.114.59.9 with SMTP id h9mr3523098waa.211.1244159046947;
        Thu, 04 Jun 2009 16:44:06 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id v39sm11842842wah.62.2009.06.04.16.44.04
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 16:44:06 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 04 Jun 2009 16:44:02 -0700
X-Mailer: git-send-email 1.6.3.1.266.gb11cf
In-Reply-To: <1244159037-9292-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120728>

Simplify the argh printing by simply calling usage_argh() if the option
can take an argument. Update macros defined in parse-options.h to set
the PARSE_OPT_NOARG flag.

The only other user of custom non-argument taking options is git-apply
(in this case OPTION_BOOLEAN for deprecated options). Update it to set
the PARSE_OPT_NOARG flag.

Thanks to Ren=C3=A9 Scharfe for the suggestion and starter patch.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Ren=C3=A9, feel free to signoff if you like.

 builtin-apply.c |    6 ++++--
 parse-options.c |   33 ++++-----------------------------
 parse-options.h |   20 +++++++++++++-------
 3 files changed, 21 insertions(+), 38 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 94ba2bd..89a5185 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -3277,9 +3277,11 @@ int cmd_apply(int argc, const char **argv, const=
 char *unused_prefix)
 		OPT_BOOLEAN(0, "stat", &diffstat,
 			"instead of applying the patch, output diffstat for the input"),
 		{ OPTION_BOOLEAN, 0, "allow-binary-replacement", &binary,
-		  NULL, "old option, now no-op", PARSE_OPT_HIDDEN },
+		  NULL, "old option, now no-op",
+		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG },
 		{ OPTION_BOOLEAN, 0, "binary", &binary,
-		  NULL, "old option, now no-op", PARSE_OPT_HIDDEN },
+		  NULL, "old option, now no-op",
+		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG },
 		OPT_BOOLEAN(0, "numstat", &numstat,
 			"shows number of added and deleted lines in decimal notation"),
 		OPT_BOOLEAN(0, "summary", &summary,
diff --git a/parse-options.c b/parse-options.c
index 48ba62b..e469fc0 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -440,7 +440,7 @@ int parse_options(int argc, const char **argv, cons=
t char *prefix,
 static int usage_argh(const struct option *opts)
 {
 	const char *s;
-	int literal =3D opts->flags & PARSE_OPT_LITERAL_ARGHELP;
+	int literal =3D (opts->flags & PARSE_OPT_LITERAL_ARGHELP) || !opts->a=
rgh;
 	if (opts->flags & PARSE_OPT_OPTARG)
 		if (opts->long_name)
 			s =3D literal ? "[=3D%s]" : "[=3D<%s>]";
@@ -448,7 +448,7 @@ static int usage_argh(const struct option *opts)
 			s =3D literal ? "[%s]" : "[<%s>]";
 	else
 		s =3D literal ? " %s" : " <%s>";
-	return fprintf(stderr, s, opts->argh);
+	return fprintf(stderr, s, opts->argh ? opts->argh : "...");
 }
=20
 #define USAGE_OPTS_WIDTH 24
@@ -500,33 +500,8 @@ int usage_with_options_internal(const char * const=
 *usagestr,
 		if (opts->type =3D=3D OPTION_NUMBER)
 			pos +=3D fprintf(stderr, "-NUM");
=20
-		switch (opts->type) {
-		case OPTION_ARGUMENT:
-			break;
-		case OPTION_CALLBACK:
-			if (opts->flags & PARSE_OPT_NOARG)
-				break;
-			/* FALLTHROUGH */
-		case OPTION_INTEGER:
-			/* FALLTHROUGH */
-		case OPTION_FILENAME:
-			/* FALLTHROUGH */
-		case OPTION_STRING:
-			if (opts->argh)
-				pos +=3D usage_argh(opts);
-			else {
-				if (opts->flags & PARSE_OPT_OPTARG)
-					if (opts->long_name)
-						pos +=3D fprintf(stderr, "[=3D...]");
-					else
-						pos +=3D fprintf(stderr, "[...]");
-				else
-					pos +=3D fprintf(stderr, " ...");
-			}
-			break;
-		default: /* OPTION_{BIT,BOOLEAN,NUMBER,SET_INT,SET_PTR} */
-			break;
-		}
+		if (!(opts->flags & PARSE_OPT_NOARG))
+			pos +=3D usage_argh(opts);
=20
 		if (pos <=3D USAGE_OPTS_WIDTH)
 			pad =3D USAGE_OPTS_WIDTH - pos;
diff --git a/parse-options.h b/parse-options.h
index b141ae6..f65aca3 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -67,7 +67,7 @@ typedef int parse_opt_cb(const struct option *, const=
 char *arg, int unset);
  * `flags`::
  *   mask of parse_opt_option_flags.
  *   PARSE_OPT_OPTARG: says that the argument is optional (not for BOO=
LEANs)
- *   PARSE_OPT_NOARG: says that this option takes no argument, for CAL=
LBACKs
+ *   PARSE_OPT_NOARG: says that this option takes no argument
  *   PARSE_OPT_NONEG: says that this option cannot be negated
  *   PARSE_OPT_HIDDEN: this option is skipped in the default usage, an=
d
  *                     shown only in the full usage.
@@ -101,13 +101,19 @@ struct option {
 };
=20
 #define OPT_END()                   { OPTION_END }
-#define OPT_ARGUMENT(l, h)          { OPTION_ARGUMENT, 0, (l), NULL, N=
ULL, (h) }
+#define OPT_ARGUMENT(l, h)          { OPTION_ARGUMENT, 0, (l), NULL, N=
ULL, \
+				      (h), PARSE_OPT_NOARG}
 #define OPT_GROUP(h)                { OPTION_GROUP, 0, NULL, NULL, NUL=
L, (h) }
-#define OPT_BIT(s, l, v, h, b)      { OPTION_BIT, (s), (l), (v), NULL,=
 (h), 0, NULL, (b) }
-#define OPT_NEGBIT(s, l, v, h, b)   { OPTION_NEGBIT, (s), (l), (v), NU=
LL, (h), 0, NULL, (b) }
-#define OPT_BOOLEAN(s, l, v, h)     { OPTION_BOOLEAN, (s), (l), (v), N=
ULL, (h) }
-#define OPT_SET_INT(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), N=
ULL, (h), 0, NULL, (i) }
-#define OPT_SET_PTR(s, l, v, h, p)  { OPTION_SET_PTR, (s), (l), (v), N=
ULL, (h), 0, NULL, (p) }
+#define OPT_BIT(s, l, v, h, b)      { OPTION_BIT, (s), (l), (v), NULL,=
 (h), \
+				      PARSE_OPT_NOARG, NULL, (b) }
+#define OPT_NEGBIT(s, l, v, h, b)   { OPTION_NEGBIT, (s), (l), (v), NU=
LL, \
+				      (h), PARSE_OPT_NOARG, NULL, (b) }
+#define OPT_BOOLEAN(s, l, v, h)     { OPTION_BOOLEAN, (s), (l), (v), N=
ULL, \
+				      (h), PARSE_OPT_NOARG }
+#define OPT_SET_INT(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), N=
ULL, \
+				      (h), PARSE_OPT_NOARG, NULL, (i) }
+#define OPT_SET_PTR(s, l, v, h, p)  { OPTION_SET_PTR, (s), (l), (v), N=
ULL, \
+				      (h), PARSE_OPT_NOARG, NULL, (p) }
 #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), "=
n", (h) }
 #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (=
a), (h) }
 #define OPT_DATE(s, l, v, h) \
--=20
1.6.3.1.266.gb11cf
