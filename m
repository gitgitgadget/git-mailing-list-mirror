From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/5] i18n: parseopt: lookup help and argument translations when showing usage
Date: Thu,  8 Mar 2012 16:16:36 +0700
Message-ID: <1331198198-22409-4-git-send-email-pclouds@gmail.com>
References: <1331198198-22409-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 10:17:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5ZTt-0000Ji-EK
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 10:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978Ab2CHJRk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 04:17:40 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54679 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550Ab2CHJRj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 04:17:39 -0500
Received: by mail-pz0-f46.google.com with SMTP id r28so259341daj.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 01:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Gu0qoQq/IuCpa689sBySRg4JoC5Hz4aEDkSoEa1A8+A=;
        b=lFWTvnxdyUPcqo0NHrm4uC1L4aGbnOt9S8jI9Y4AyXTsDPQMMjoTYJOb78z458g26B
         ICp25eZ7fa9dMXM1vfqm4uIrJSWhQHn4TIpLV5wR85FQvAOKTGTtiNh52h+ELIx72m7k
         thJBw7+AZdPkklASQ+2vYFsKZ63kQVplFYmcQMVXVenBkKOJwqJ+Jr+O4soH10aqb11L
         Jz4wf1CiTlwAjwPl0vauF+HVHOpnacONoviUROinifovDSC36GErDvTRQnw3EMXxaV9f
         lpFn6T/c2f67yKincGqzBvNQByAdm6oOCIJvroSjogFdSw8iojKTqSKZVCNZxBJWI8YR
         CW5A==
Received: by 10.68.194.65 with SMTP id hu1mr8533035pbc.75.1331198258981;
        Thu, 08 Mar 2012 01:17:38 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id h3sm2291670pbr.75.2012.03.08.01.17.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 01:17:38 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 08 Mar 2012 16:17:09 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1331198198-22409-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192543>

"struct option" and the help usage array needs N_() marking on help
and argument text for this to work.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 parse-options.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 850cfa7..6247c20 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -490,7 +490,7 @@ static int usage_argh(const struct option *opts, FI=
LE *outfile)
 			s =3D literal ? "[%s]" : "[<%s>]";
 	else
 		s =3D literal ? " %s" : " <%s>";
-	return fprintf(outfile, s, opts->argh ? opts->argh : "...");
+	return fprintf(outfile, s, opts->argh ? gettext(opts->argh) : "...");
 }
=20
 #define USAGE_OPTS_WIDTH 24
@@ -508,13 +508,12 @@ static int usage_with_options_internal(struct par=
se_opt_ctx_t *ctx,
 	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
 		fprintf(outfile, "cat <<\\EOF\n");
=20
-	fprintf(outfile, "usage: %s\n", *usagestr++);
+	fprintf(outfile, _("usage: %s\n"), gettext(*usagestr++));
 	while (*usagestr && **usagestr)
-		fprintf(outfile, "   or: %s\n", *usagestr++);
+		fprintf(outfile, _("   or: %s\n"), gettext(*usagestr++));
 	while (*usagestr) {
-		fprintf(outfile, "%s%s\n",
-				**usagestr ? "    " : "",
-				*usagestr);
+		fprintf(outfile, "%s%s\n", **usagestr ? "    " : "",
+			gettext(*usagestr));
 		usagestr++;
 	}
=20
@@ -528,7 +527,7 @@ static int usage_with_options_internal(struct parse=
_opt_ctx_t *ctx,
 		if (opts->type =3D=3D OPTION_GROUP) {
 			fputc('\n', outfile);
 			if (*opts->help)
-				fprintf(outfile, "%s\n", opts->help);
+				fprintf(outfile, "%s\n", gettext(opts->help));
 			continue;
 		}
 		if (!full && (opts->flags & PARSE_OPT_HIDDEN))
@@ -558,7 +557,7 @@ static int usage_with_options_internal(struct parse=
_opt_ctx_t *ctx,
 			fputc('\n', outfile);
 			pad =3D USAGE_OPTS_WIDTH;
 		}
-		fprintf(outfile, "%*s%s\n", pad + USAGE_GAP, "", opts->help);
+		fprintf(outfile, "%*s%s\n", pad + USAGE_GAP, "", gettext(opts->help)=
);
 	}
 	fputc('\n', outfile);
=20
--=20
1.7.3.1.256.g2539c.dirty
