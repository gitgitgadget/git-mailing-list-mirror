From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] ident: make user_ident_explicitly_given static
Date: Wed, 28 Nov 2012 13:26:13 -0500
Message-ID: <20121128182613.GC17122@sigill.intra.peff.net>
References: <20121128182534.GA21020@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 19:26:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdmLB-0002R6-2b
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 19:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841Ab2K1S0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 13:26:16 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33892 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755783Ab2K1S0P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 13:26:15 -0500
Received: (qmail 9830 invoked by uid 107); 28 Nov 2012 18:27:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Nov 2012 13:27:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2012 13:26:13 -0500
Content-Disposition: inline
In-Reply-To: <20121128182534.GA21020@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210752>

In v1.5.6-rc0~56^2 (2008-05-04) "user_ident_explicitly_given"
was introduced as a global for communication between config,
ident, and builtin-commit.  In v1.7.0-rc0~72^2 (2010-01-07)
readers switched to using the common wrapper
user_ident_sufficiently_given().  After v1.7.11-rc1~15^2~18
(2012-05-21), the var is only written in ident.c.

Now we can make it static, which will enable further
refactoring without worrying about upsetting other code.

Signed-off-by: Jeff King <peff@peff.net>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 cache.h | 4 ----
 ident.c | 6 +++++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index dbd8018..50d9eea 100644
--- a/cache.h
+++ b/cache.h
@@ -1149,10 +1149,6 @@ struct config_include_data {
 #define CONFIG_INCLUDE_INIT { 0 }
 extern int git_config_include(const char *name, const char *value, void *data);
 
-#define IDENT_NAME_GIVEN 01
-#define IDENT_MAIL_GIVEN 02
-#define IDENT_ALL_GIVEN (IDENT_NAME_GIVEN|IDENT_MAIL_GIVEN)
-extern int user_ident_explicitly_given;
 extern int user_ident_sufficiently_given(void);
 
 extern const char *git_commit_encoding;
diff --git a/ident.c b/ident.c
index a4bf206..733d69d 100644
--- a/ident.c
+++ b/ident.c
@@ -10,7 +10,11 @@
 static struct strbuf git_default_name = STRBUF_INIT;
 static struct strbuf git_default_email = STRBUF_INIT;
 static char git_default_date[50];
-int user_ident_explicitly_given;
+
+#define IDENT_NAME_GIVEN 01
+#define IDENT_MAIL_GIVEN 02
+#define IDENT_ALL_GIVEN (IDENT_NAME_GIVEN|IDENT_MAIL_GIVEN)
+static int user_ident_explicitly_given;
 
 #ifdef NO_GECOS_IN_PWENT
 #define get_gecos(ignored) "&"
-- 
1.8.0.207.gdf2154c
