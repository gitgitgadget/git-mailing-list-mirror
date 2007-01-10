From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Makefile: add clean-obsolete-scripts target
Date: Wed, 10 Jan 2007 13:20:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701101319480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jan 10 13:20:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4cRM-0003tb-Lx
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 13:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932783AbXAJMUW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 07:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932787AbXAJMUW
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 07:20:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:46690 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932783AbXAJMUV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 07:20:21 -0500
Received: (qmail invoked by alias); 10 Jan 2007 12:20:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp023) with SMTP; 10 Jan 2007 13:20:19 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36502>


On Cygwin, newly builtins are not recognized, because there exist both
the executable binaries (with .exe extension) _and_ the now-obsolete
scripts (without extension), but the script is executed.

"make clean-obsolete-scripts" removes these ambiguities by removing the
older of these file pairs.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 Makefile |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 007ceb2..a46683a 100644
--- a/Makefile
+++ b/Makefile
@@ -905,6 +905,25 @@ dist-doc:
 
 ### Cleaning rules
 
+clean-obsolete-scripts:
+	@if test -n "$X"; \
+	then \
+		ls *$X '$(DESTDIR_SQ)$(gitexecdir_SQ)'/*$X | while read f; do \
+			script="`echo "$$f" | sed 's/$X\$$/./'`"; \
+			if test -f "$$script"; \
+			then \
+				if test "$$script" -ot "$$f"; \
+				then \
+					echo removing "$$script"; \
+					rm "$$script"; \
+				else \
+					echo removing "$$f"; \
+					rm "$$f"; \
+				fi; \
+			fi; \
+		done; \
+	fi
+
 clean:
 	rm -f *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o xdiff/*.o \
 		$(LIB_FILE) $(XDIFF_LIB)
-- 
1.4.4.4.g774d-dirty
