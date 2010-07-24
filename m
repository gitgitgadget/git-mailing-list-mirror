From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [WIP PATCH 02/22] parse-options: add two helper functions
Date: Sat, 24 Jul 2010 23:13:34 +0800
Message-ID: <1279984434-28933-3-git-send-email-struggleyb.nku@gmail.com>
References: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 17:14:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcgR9-0001aF-CL
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 17:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575Ab0GXPOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 11:14:40 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:41271 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349Ab0GXPOg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 11:14:36 -0400
Received: by pxi14 with SMTP id 14so4061238pxi.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0/+bUAPZ/NSNEKMNTCEjOJtY2+yiiqZ745pih6gYWgU=;
        b=DrufJCHigQgOVTlM74pszBRngfxmR8XLp1gXnqTUK6Two/OfHDeScIOO65H4DMYuz2
         rpaOu1mvCIpSGijqN810TbIr9e6MzgexQL816MpReMajYBIW7LpGuq5B/feuOgvTh+nV
         LpHcw+zOY+cslGMBg8gquXBFM9Uq2+hKrGD+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ozBV2K769A4UFLRJ5pM9xgHHXlvH+Z8Zn4d/4rE81bsPvO+oI3A29MVzH7ydg+Rie1
         R2nHqCwsDgf/tFKpynfnMTbEA3rXWA/E9w9RU6VH/vIX0+KUSVRTLHY+gti3H7IWPrRO
         cReN1H26l5a7dbpI5e/9nc4nPC2sMzeVM+f9w=
Received: by 10.142.234.11 with SMTP id g11mr5965954wfh.202.1279984476199;
        Sat, 24 Jul 2010 08:14:36 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.121])
        by mx.google.com with ESMTPS id w8sm1705169wfd.19.2010.07.24.08.14.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 08:14:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc3.80.g6f8ea9.dirty
In-Reply-To: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151635>

1. parse_options_current: get the current option/argument the API
   is dealing with;
2. parse_options_next: make the API to deal with the next
   option/argument.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 parse-options.c |   19 +++++++++++++++++++
 parse-options.h |    4 ++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index cbb49d3..e0c3641 100644
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
+int parse_options_next(struct parse_opt_ctx_t *ctx, int keep)
+{
+	if (ctx->argc <= 0)
+		return -1;
+
+	if (keep)
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
index 407697a..d3b1932 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -187,6 +187,10 @@ extern int parse_options_step(struct parse_opt_ctx_t *ctx,
 			      const struct option *options,
 			      const char * const usagestr[]);
 
+extern const char *parse_options_current(struct parse_opt_ctx_t *ctx);
+
+extern int parse_options_next(struct parse_opt_ctx_t *ctx, int keep);
+
 extern int parse_options_end(struct parse_opt_ctx_t *ctx);
 
 extern int parse_options_concat(struct option *dst, size_t, struct option *src);
-- 
1.7.0.2.273.gc2413.dirty
