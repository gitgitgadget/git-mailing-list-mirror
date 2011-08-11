From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v3 1/2] parse-options: export opterr, optbug
Date: Thu, 11 Aug 2011 15:15:37 +0600
Message-ID: <1313054138-30885-2-git-send-email-divanorama@gmail.com>
References: <1313054138-30885-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 11:15:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrRMZ-0000Uz-FX
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 11:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792Ab1HKJPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 05:15:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65409 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202Ab1HKJP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 05:15:27 -0400
Received: by bke11 with SMTP id 11so832987bke.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 02:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5sZVloZi8Sjv48Db4js9GcgDYvNTK1Rz32TTc1zecdw=;
        b=vJr1m2S5CKVcHMJIPNFaXumhLztg+amsrOo7yuqOZD89PIR07oglf2DGq5yTbYGEKk
         nXEu/iLGWYCLz6u7PN1F+3LLTT0/8hDwkvI9fwcHYgBAb4eYJ4aS9cvSVQ5SNaV00piq
         cGEP4M3wvhbOR5XFh5iJcH+zblfLDBAP+QOsE=
Received: by 10.204.156.71 with SMTP id v7mr1410296bkw.94.1313054126342;
        Thu, 11 Aug 2011 02:15:26 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id n9sm458521bkd.40.2011.08.11.02.15.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 02:15:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313054138-30885-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179095>

opterror and optbug functions are used by some of parsing routines
in parse-options.c to report errors and bugs respectively.

Export these functions to allow more custom parsing routines to use
them in a uniform way.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 parse-options.c |    4 ++--
 parse-options.h |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 879ea82..7b061af 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -12,14 +12,14 @@ static int parse_options_usage(struct parse_opt_ctx_t *ctx,
 #define OPT_SHORT 1
 #define OPT_UNSET 2
 
-static int optbug(const struct option *opt, const char *reason)
+int optbug(const struct option *opt, const char *reason)
 {
 	if (opt->long_name)
 		return error("BUG: option '%s' %s", opt->long_name, reason);
 	return error("BUG: switch '%c' %s", opt->short_name, reason);
 }
 
-static int opterror(const struct option *opt, const char *reason, int flags)
+int opterror(const struct option *opt, const char *reason, int flags)
 {
 	if (flags & OPT_SHORT)
 		return error("switch `%c' %s", opt->short_name, reason);
diff --git a/parse-options.h b/parse-options.h
index 05eb09b..59e0b52 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -165,6 +165,8 @@ extern NORETURN void usage_msg_opt(const char *msg,
 				   const char * const *usagestr,
 				   const struct option *options);
 
+extern int optbug(const struct option *opt, const char *reason);
+extern int opterror(const struct option *opt, const char *reason, int flags);
 /*----- incremental advanced APIs -----*/
 
 enum {
-- 
1.7.3.4
