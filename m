From: Jeff King <peff@peff.net>
Subject: [PATCH 1/6] ident: make user_ident_explicitly_given private
Date: Tue, 13 Nov 2012 11:49:31 -0500
Message-ID: <20121113164931.GA12626@sigill.intra.peff.net>
References: <20121113164845.GD20361@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 17:49:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYJgM-0005hx-Pl
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 17:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128Ab2KMQth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 11:49:37 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47532 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932095Ab2KMQtg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 11:49:36 -0500
Received: (qmail 26460 invoked by uid 107); 13 Nov 2012 16:50:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Nov 2012 11:50:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2012 11:49:31 -0500
Content-Disposition: inline
In-Reply-To: <20121113164845.GD20361@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209634>

There are no users of this global variable, as queriers
go through the user_ident_sufficiently_given accessor.
Let's make it private, which will enable further
refactoring.

Signed-off-by: Jeff King <peff@peff.net>
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
