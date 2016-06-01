From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Makefile: add $(DEVELOPER_CFLAGS) variable
Date: Wed,  1 Jun 2016 10:00:08 +0200
Message-ID: <20160601080008.7348-1-Matthieu.Moy@imag.fr>
References: <vpqpos11gv3.fsf@anie.imag.fr>
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 01 10:00:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b814v-0007nd-Gr
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 10:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757631AbcFAIAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 04:00:22 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50501 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757621AbcFAIAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 04:00:16 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u51809uZ020243
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 1 Jun 2016 10:00:10 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5180Aod015320;
	Wed, 1 Jun 2016 10:00:10 +0200
X-Mailer: git-send-email 2.8.2.397.gbe91ebf.dirty
In-Reply-To: <vpqpos11gv3.fsf@anie.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Wed, 01 Jun 2016 10:00:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u51809uZ020243
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1465372810.89368@1CngddUmbPO4dwvJlJkR/w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296065>

This does not change the behavior, but allows the user to tweak
DEVELOPER_CFLAGS on the command-line or in a config.mak* file if
needed.

This also makes the code somewhat cleaner as it follows the pattern

<initialisation of variables>
<include statements>
<actual build logic>

by specifying which flags to activate in the first part, and actually
activating them in the last one.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Junio, you can add this to mm/makefile-developer-can-be-in-config-mak
(or squash it in the commit, but having two separate commit messages
make sense IMO).

 Makefile | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 2226319..9753abe 100644
--- a/Makefile
+++ b/Makefile
@@ -375,6 +375,15 @@ GIT-VERSION-FILE: FORCE
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
 CFLAGS = -g -O2 -Wall
+DEVELOPER_CFLAGS = -Werror \
+	-Wdeclaration-after-statement \
+	-Wno-format-zero-length \
+	-Wold-style-definition \
+	-Woverflow \
+	-Wpointer-arith \
+	-Wstrict-prototypes \
+	-Wunused \
+	-Wvla
 LDFLAGS =
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
@@ -941,15 +950,7 @@ include config.mak.uname
 -include config.mak
 
 ifdef DEVELOPER
-CFLAGS += -Werror \
-	-Wdeclaration-after-statement \
-	-Wno-format-zero-length \
-	-Wold-style-definition \
-	-Woverflow \
-	-Wpointer-arith \
-	-Wstrict-prototypes \
-	-Wunused \
-	-Wvla
+CFLAGS += $(DEVELOPER_CFLAGS)
 endif
 
 ifndef sysconfdir
-- 
2.8.2.397.gbe91ebf.dirty
