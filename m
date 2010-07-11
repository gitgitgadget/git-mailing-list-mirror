From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v3 02/13] parse-options: add two helper functions
Date: Sun, 11 Jul 2010 14:18:50 +0800
Message-ID: <1278829141-11900-2-git-send-email-struggleyb.nku@gmail.com>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 11 08:21:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXput-00021P-77
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 08:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209Ab0GKGVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 02:21:15 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58225 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab0GKGVO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 02:21:14 -0400
Received: by pzk26 with SMTP id 26so808174pzk.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 23:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cwV1AQyv2lDtzlT5vjL9TVBrnMcUvIoPW8Is6bvjbl0=;
        b=uzhthFiflz5lpZGtIE74FAQiXPNcbD5lc3Rm9VEfbGeym05yLvYdq+Knr/ddVSS2dm
         e5CgSLdsrwnUW0SNnBY8LliguBGEOkWScasZmEEcll3HvZr29W2O/XecuxVZ9kPKwmyO
         HtU8TyHLDPvfEvcaAwsJhILKB+t8fDh8nHQFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=T51r4qXWerOZGzDec3a8w86Xd6shFpaf552RwdkJqqbbtoX7DyzoGm3+yKkRTtG1aZ
         RLjKXH9kMfpROY5qCSH9lPx9w8/njVPTJvwGtW3ZauYKwbOmV/L8ZJvttnWqtXiVIJrx
         r8S84V8KWgg30ksm87sw02zZO9ExODBGPISJU=
Received: by 10.142.48.18 with SMTP id v18mr14183977wfv.337.1278829273542;
        Sat, 10 Jul 2010 23:21:13 -0700 (PDT)
Received: from localhost.localdomain ([222.35.175.242])
        by mx.google.com with ESMTPS id c15sm2927911rvi.11.2010.07.10.23.21.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 23:21:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc2.18.g2bc49
In-Reply-To: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150746>

1. parse_options_current: get the current option/argument the API
   now is dealing with;
2. parse_options_next: make the API to deal with the next
   option/argument.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 parse-options.c |   19 +++++++++++++++++++
 parse-options.h |    4 ++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index cbb49d3..4266bde 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -439,6 +439,25 @@ unknown:
 	return PARSE_OPT_DONE;
 }
 
+const char *parse_options_current(struct parse_opt_ctx_t *ctx)
+{
+	return ctx->argv[0];
+}
+
+int parse_options_next(struct parse_opt_ctx_t *ctx, int retain)
+{
+	if (ctx->argc <= 0)
+		return -1;
+
+	if (retain == 1)
+		ctx->out[ctx->cpidx++] = ctx->argv[0];
+
+	ctx->argc--;
+	ctx->argv++;
+
+	return 0;
+}
+
 int parse_options_end(struct parse_opt_ctx_t *ctx)
 {
 	memmove(ctx->out + ctx->cpidx, ctx->argv, ctx->argc * sizeof(*ctx->out));
diff --git a/parse-options.h b/parse-options.h
index 407697a..4791baa 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -187,6 +187,10 @@ extern int parse_options_step(struct parse_opt_ctx_t *ctx,
 			      const struct option *options,
 			      const char * const usagestr[]);
 
+extern const char *parse_options_current(struct parse_opt_ctx_t *ctx);
+
+extern int parse_options_next(struct parse_opt_ctx_t *ctx, int retain);
+
 extern int parse_options_end(struct parse_opt_ctx_t *ctx);
 
 extern int parse_options_concat(struct option *dst, size_t, struct option *src);
-- 
1.7.0.2.273.gc2413.dirty
