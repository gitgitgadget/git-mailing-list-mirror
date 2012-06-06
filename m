From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH] Use system_path to find 'po'-dir to resolve relative paths
Date: Wed,  6 Jun 2012 13:01:15 +0000
Message-ID: <1338987675-7388-1-git-send-email-vfr@lyx.org>
Cc: gitster@pobox.com, Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 15:01:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScFrw-0001mI-Sn
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 15:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676Ab2FFNBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 09:01:45 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:46074 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304Ab2FFNBo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 09:01:44 -0400
Received: by wibhj8 with SMTP id hj8so5007721wib.1
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 06:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=6x0vSi5suNRIqtfHNm+2JYJTx9GNp9V3FPyMmSOySMg=;
        b=VLKRPNbz3EwLNggajwJYtCQFcUStwrZbc8jTpdvwTMN0QHt1UyEoNOStzqAVpeu0KG
         mikXFSVGRIAS00TYheLaOLDUYoubru70Cl0pUxfz5MYTslbUuZrmF2MK3vIHrdqMXJ1Q
         6MbTOFFfsSOoDK07YnueuWXSga1RLoEg0jjdlEv6lY8okUAVmoSko+SKeWZJA80W0pwp
         guTY8jPgz2OaUO5xs+AQD6rTdjjHLEPdZpJVEGFb91ENdyrdX8hbxTFD5Pnirg/ZHeqn
         PYN7BGKp7B1KZdBlIkd2DYSmVHHAGUbRJpJl4UnlB3zYfWL9LKkLG90R7+u5js3Ug4AX
         36zA==
Received: by 10.216.214.82 with SMTP id b60mr17195363wep.38.1338987703317;
        Wed, 06 Jun 2012 06:01:43 -0700 (PDT)
Received: from localhost (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id ei4sm4068624wid.5.2012.06.06.06.01.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 06:01:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.msysgit.0
X-Gm-Message-State: ALoCoQnUcKPV0p50f2tCS7TK20B/s24Mwe7DyHuC7gLa45ei+eUUggPRHGd4I84d5LphUWjn0cLq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199322>

If the specified path for the 'po'-files is a relative path and if
RUNTIME_PREFIX is set, system_path must be used to resolve the directory relative to the executable.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 gettext.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gettext.c b/gettext.c
index f75bca7..632ccf8 100644
--- a/gettext.c
+++ b/gettext.c
@@ -4,6 +4,7 @@
 
 #include "git-compat-util.h"
 #include "gettext.h"
+#include "exec_cmd.h"
 
 #ifndef NO_GETTEXT
 #	include <locale.h>
@@ -123,7 +124,7 @@ void git_setup_gettext(void)
 
 	if (!podir)
 		podir = GIT_LOCALE_PATH;
-	bindtextdomain("git", podir);
+	bindtextdomain("git", system_path(podir));
 	setlocale(LC_MESSAGES, "");
 	init_gettext_charset("git");
 	textdomain("git");
-- 
1.7.9.msysgit.0
