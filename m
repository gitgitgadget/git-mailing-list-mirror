From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: [PATCH] fix 'make test' for HP NonStop
Date: Mon, 22 Oct 2012 16:30:17 +0200
Message-ID: <001e01cdb061$c25f6380$471e2a80$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 16:30:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQJ1Y-0008Lc-S3
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 16:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235Ab2JVOaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 10:30:25 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:50764 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab2JVOaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 10:30:25 -0400
Received: from DualCore (dsdf-4d0a104c.pool.mediaWays.net [77.10.16.76])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MMcRu-1TWKtF310o-008Ftg; Mon, 22 Oct 2012 16:30:23 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2wYVOqGrpC8KggR6OYJx1fDBG+cw==
Content-language: de
X-Provags-ID: V02:K0:nUmx8wcjlDbXca/NGiHw03sNNnBJRj8leaCqeWWd0kI
 sPQp0fnvhZVsxeBTMxYguQDukLD+S5bB1iXkygTGSDJNqBE6MJ
 ElYGvHZtM5w1YHOdpX6LALTw8qKEfi/LDnAi+iqxdceSlJFauR
 7coHqvKl8kRSthSvr466T1szrnxxJx6XpHv6LHjlNOBbG1qUxj
 wnK+wYG/UCHofkQx8LvME1GQvNHj0QLfIKCbyORS4Kgp30+6Wt
 d2RksQywoDwLPeJwunhvPg2QYju76TyXuocrABnj43c9HUgPBZ
 Gfq1W19LAj+7MHZILs7n1HcUTJf478d7FDDp5qEYOvSsClTFEn
 8ope7QdyxpsywEZhQ1hn14pupJODgmbi9H+rBbQR4knUqUOIdY
 hlimpIFrKAX3w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208189>

This fixes the vast majority of test failures on HP NonStop.

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
A few more still insist on /usr/local/bin being 1st in PATH and having done that
we're down to one single failing test, t0301 #12 "helper (cache --timeout=1) times out"

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
+	# some need bash, and some need ${prefix}/bin in PATH first
+	SHELL_PATH=${prefix}/bin/bash
+	SANE_TOOL_PATH=${prefix}/bin
+	# as of H06.25/J06.14, we might better use this
+	#SHELL_PATH=/usr/coreutils/bin/bash
+	#SANE_TOOL_PATH=/usr/coreutils/bin:${prefix}/bin
endif
ifneq (,$(findstring MINGW,$(uname_S)))
	pathsep = ;
