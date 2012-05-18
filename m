From: Jeff King <peff@peff.net>
Subject: [PATCH 05/13] move git_default_* variables to ident.c
Date: Fri, 18 May 2012 19:11:13 -0400
Message-ID: <20120518231113.GE30031@sigill.intra.peff.net>
References: <20120518230528.GA30510@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 19 01:11:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVWKj-0004P6-Hz
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 01:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946767Ab2ERXLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 19:11:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48762
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946766Ab2ERXLR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 19:11:17 -0400
Received: (qmail 7643 invoked by uid 107); 18 May 2012 23:11:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 May 2012 19:11:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2012 19:11:13 -0400
Content-Disposition: inline
In-Reply-To: <20120518230528.GA30510@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197984>

There's no reason anybody outside of ident.c should access
these directly (they should use the new accessors which make
sure the variables are initialized), so we can make them
file-scope statics.

While we're at it, move user_ident_explicitly_given into
ident.c; while still globally visible, it makes more sense
to reside with the ident code.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h       | 3 ---
 environment.c | 3 ---
 ident.c       | 4 ++++
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 86224c8..f63b71f 100644
--- a/cache.h
+++ b/cache.h
@@ -1142,9 +1142,6 @@ struct config_include_data {
 #define CONFIG_INCLUDE_INIT { 0 }
 extern int git_config_include(const char *name, const char *value, void *data);
 
-#define MAX_GITNAME (1000)
-extern char git_default_email[MAX_GITNAME];
-extern char git_default_name[MAX_GITNAME];
 #define IDENT_NAME_GIVEN 01
 #define IDENT_MAIL_GIVEN 02
 #define IDENT_ALL_GIVEN (IDENT_NAME_GIVEN|IDENT_MAIL_GIVEN)
diff --git a/environment.c b/environment.c
index d7e6c65..669e498 100644
--- a/environment.c
+++ b/environment.c
@@ -11,9 +11,6 @@
 #include "refs.h"
 #include "fmt-merge-msg.h"
 
-char git_default_email[MAX_GITNAME];
-char git_default_name[MAX_GITNAME];
-int user_ident_explicitly_given;
 int trust_executable_bit = 1;
 int trust_ctime = 1;
 int has_symlinks = 1;
diff --git a/ident.c b/ident.c
index bb1158f..af92b2c 100644
--- a/ident.c
+++ b/ident.c
@@ -7,7 +7,11 @@
  */
 #include "cache.h"
 
+#define MAX_GITNAME (1000)
+static char git_default_name[MAX_GITNAME];
+static char git_default_email[MAX_GITNAME];
 static char git_default_date[50];
+int user_ident_explicitly_given;
 
 #ifdef NO_GECOS_IN_PWENT
 #define get_gecos(ignored) "&"
-- 
1.7.10.1.16.g53a707b
