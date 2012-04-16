From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH i18n 03/11] i18n: parseopt: lookup help and argument translations when showing usage
Date: Mon, 16 Apr 2012 19:49:55 +0700
Message-ID: <1334580603-11577-4-git-send-email-pclouds@gmail.com>
References: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 14:51:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJlP2-0006e5-3X
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 14:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888Ab2DPMv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 08:51:27 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52864 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774Ab2DPMv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 08:51:27 -0400
Received: by pbcun15 with SMTP id un15so6309124pbc.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 05:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ALjbfEv8v6E31htW09E9oRXuvzfNVRbaobAO+8Xqxyw=;
        b=tIHuXm5mfZ/+1uLGd229rQWzKSgoKsBWGYMzDLs9JM5nrnNtQygCfSbezEQDQdBgEk
         ZTozbqV9bECMHUT0fJPSb3f3zljiHDTh9mkyxM3l05qrs90PMd485zenlAsU7l91qOuO
         efx1PaFY0uGKjYsDlcZ3CyFuVumhW+oeSvzzQpu82RDOSq/efT0MR7sSZr2Go4DwVadN
         HT6lW6BIxsks3AbtrvuoTZC6uqVlnwViqtMidsX/NgjL6H5Y85+jgHHRpGlSJVVTO+lM
         m8WqCkrosnpd46sgqnwApbiBwjToi7SkM1y18mB+4DlnvyDSUuWLAD+bdg6QoSHA94B3
         Ri5A==
Received: by 10.68.222.38 with SMTP id qj6mr1038178pbc.69.1334580686807;
        Mon, 16 Apr 2012 05:51:26 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id r6sm17630780pbc.40.2012.04.16.05.51.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 05:51:25 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Apr 2012 19:50:35 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195626>

---
 parse-options.c |   15 +++++++--------
 parse-options.h |    7 +++++--
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 850cfa7..7690de8 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -490,7 +490,7 @@ static int usage_argh(const struct option *opts, FILE *outfile)
 			s = literal ? "[%s]" : "[<%s>]";
 	else
 		s = literal ? " %s" : " <%s>";
-	return fprintf(outfile, s, opts->argh ? opts->argh : "...");
+	return fprintf(outfile, s, opts->argh ? _(opts->argh) : "...");
 }
 
 #define USAGE_OPTS_WIDTH 24
@@ -508,13 +508,12 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
 		fprintf(outfile, "cat <<\\EOF\n");
 
-	fprintf(outfile, "usage: %s\n", *usagestr++);
+	fprintf_ln(outfile, _("usage: %s"), _(*usagestr++));
 	while (*usagestr && **usagestr)
-		fprintf(outfile, "   or: %s\n", *usagestr++);
+		fprintf_ln(outfile, _("   or: %s"), _(*usagestr++));
 	while (*usagestr) {
-		fprintf(outfile, "%s%s\n",
-				**usagestr ? "    " : "",
-				*usagestr);
+		fprintf(outfile, "%s%s\n", **usagestr ? "    " : "",
+			_(*usagestr));
 		usagestr++;
 	}
 
@@ -528,7 +527,7 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 		if (opts->type == OPTION_GROUP) {
 			fputc('\n', outfile);
 			if (*opts->help)
-				fprintf(outfile, "%s\n", opts->help);
+				fprintf(outfile, "%s\n", _(opts->help));
 			continue;
 		}
 		if (!full && (opts->flags & PARSE_OPT_HIDDEN))
@@ -558,7 +557,7 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 			fputc('\n', outfile);
 			pad = USAGE_OPTS_WIDTH;
 		}
-		fprintf(outfile, "%*s%s\n", pad + USAGE_GAP, "", opts->help);
+		fprintf(outfile, "%*s%s\n", pad + USAGE_GAP, "", _(opts->help));
 	}
 	fputc('\n', outfile);
 
diff --git a/parse-options.h b/parse-options.h
index def9ced..4e59f2c 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -66,12 +66,14 @@ typedef int parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
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
@@ -158,7 +160,8 @@ struct option {
 #define OPT_BOOLEAN OPT_COUNTUP
 
 /* parse_options() will filter out the processed options and leave the
- * non-option arguments in argv[].
+ * non-option arguments in argv[]. usagestr strings should be marked
+ * for translation with N_().
  * Returns the number of arguments left in argv[].
  */
 extern int parse_options(int argc, const char **argv, const char *prefix,
-- 
1.7.3.1.256.g2539c.dirty
