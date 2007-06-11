From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Avoid double-slash in path names that depend on $(sharedir).
Date: Mon, 11 Jun 2007 10:02:17 +0200
Message-ID: <11815489372169-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 11 10:02:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxer6-0000bw-GT
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 10:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbXFKIC0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 04:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbXFKIC0
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 04:02:26 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:9391 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbXFKICX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 04:02:23 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.44)
	id 1Hxeqx-0006cD-DN; Mon, 11 Jun 2007 10:02:19 +0200
Received: from srv.linz.eudaptics (srv.linz.eudaptics [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0737D4E9; Mon, 11 Jun 2007 10:02:18 +0200 (CEST)
Received: by srv.linz.eudaptics (Postfix, from userid 503)
	id 5037F104; Mon, 11 Jun 2007 10:02:17 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.1.120.gd732
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49829>

Recent git-gui has the ability to determine the location of its library
files relative to the --exec-dir. Its Makefile enables this capability
depending on the install paths that are specified. However, without this
fix there is an extra slash in a path specification, so that the Makefile
does not recognize the equivalence of two paths that it compares.

A side-effect is that all "standard" builds (which do not set $(sharedir)
explicitly) now exploit above mentioned gut-gui feature.

Another side-effect is that an ugly compiled-in double-slash in
$(template_dir) is avoided.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index af84af9..c23031c 100644
--- a/Makefile
+++ b/Makefile
@@ -144,7 +144,7 @@ STRIP ?= strip
 prefix = $(HOME)
 bindir = $(prefix)/bin
 gitexecdir = $(bindir)
-sharedir = $(prefix)/share/
+sharedir = $(prefix)/share
 template_dir = $(sharedir)/git-core/templates/
 ifeq ($(prefix),/usr)
 sysconfdir = /etc
-- 
1.5.2.1.120.gd732
