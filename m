From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v2] fix 'make test' for HP NonStop
Date: Thu, 25 Oct 2012 12:57:10 +0200
Message-ID: <003101cdb29f$7c8d9490$75a8bdb0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Jeff King'" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 12:57:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRL87-0005rF-Tv
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 12:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757029Ab2JYK5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 06:57:25 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:59934 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597Ab2JYK5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 06:57:24 -0400
Received: from DualCore (dsdf-4db53cfd.pool.mediaWays.net [77.181.60.253])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0MKZOx-1TSiQz2QuV-001S9j; Thu, 25 Oct 2012 12:57:19 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2ynz77tQODleGMRJOxSOdMZrGsew==
Content-Language: de
X-Provags-ID: V02:K0:gUA6Njho2vr+zv+hP0ZJL1KIjxduTmfuKCQ4tNT6/A6
 ygAuNx6d5lyDUNEyn8PG6pjjOsTFvm4e8lnP9DEMKGV6o9yPr0
 e6FWYBt0dwq1yD22JfFkf45ewXIWF1QlUme6Rmx2xLNmrZGyIY
 HcYCVULOqvdnCAhZ9P2fk/MrhtSordgEGsi4uTaZjOF911cMXk
 lShX9Mtl5bFiUOiW1YqEr0IFqkmAPUCeYG7Q5CxwoI1gNtQ28P
 AHDZYWP+SDk1Ha4lWGFbvhqXXA0rMm0G+oyOBPbaEkgU//jsds
 0mafgjH3fWHuWf/zI+02RZZ1rcaYzeFUK1UoWf7c1t9NN1EuEK
 jXbG7YxN94YHdsbhJ8bvDJXV0IQZ7xxLnmx7pvGXSdqSk3RKVK
 E1ZiFU4HZWpng==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208389>

This fixes the vast majority of test failures on HP NonStop.

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
v2: hardcode /usr/local rather than using ${prefix}

Makefile | 9 +++++++++
1 file changed, 9 insertions(+)

diff --git a/Makefile b/Makefile
index f69979e..35380dd 100644
--- a/Makefile
+++ b/Makefile
@@ -1381,6 +1381,15 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
	MKDIR_WO_TRAILING_SLASH = YesPlease
	# RFE 10-120912-4693 submitted to HP NonStop development.
	NO_SETITIMER = UnfortunatelyYes
+
+	# for 'make test'
+	# some test don't work with /bin/diff, some fail with /bin/tar
+	# some need bash, and some need /usr/local/bin in PATH first
+	SHELL_PATH=/usr/local/bin/bash
+	SANE_TOOL_PATH=/usr/local/bin
+	# as of H06.25/J06.14, we might better use this
+	#SHELL_PATH=/usr/coreutils/bin/bash
+	#SANE_TOOL_PATH=/usr/coreutils/bin:/usr/local/bin
endif
ifneq (,$(findstring MINGW,$(uname_S)))
	pathsep = ;
