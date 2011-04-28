From: Kacper Kornet <kornet@camk.edu.pl>
Subject: [PATCH] Respect definition of prefix from autotools in
 ETC_GITCONFIG and ETC_GITATTRIBUTES
Date: Thu, 28 Apr 2011 04:29:23 +0200
Message-ID: <20110428022922.GC4833@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 04:29:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFGzF-000808-DN
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 04:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372Ab1D1C3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 22:29:31 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:48141 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213Ab1D1C3a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 22:29:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 7B6E95F0047
	for <git@vger.kernel.org>; Thu, 28 Apr 2011 04:29:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gK4AUZ3u-PnE for <git@vger.kernel.org>;
	Thu, 28 Apr 2011 04:29:23 +0200 (CEST)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 222FB5F0046
	for <git@vger.kernel.org>; Thu, 28 Apr 2011 04:29:23 +0200 (CEST)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 0B416808C3; Thu, 28 Apr 2011 04:29:23 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172311>

Definitions of ETC_GITCONFIG and ETC_GITATTRIBUTES depend on value of
prefix. As prefix can be changed in config.mak.autogen, all if blocks
with conditions based on prefix should be placed after the file is
included in Makefile.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---
 Makefile |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index cbc3fce..5b4ae40 100644
--- a/Makefile
+++ b/Makefile
@@ -291,15 +291,8 @@ sharedir = $(prefix)/share
 gitwebdir = $(sharedir)/gitweb
 template_dir = share/git-core/templates
 htmldir = share/doc/git-doc
-ifeq ($(prefix),/usr)
-sysconfdir = /etc
 ETC_GITCONFIG = $(sysconfdir)/gitconfig
 ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
-else
-sysconfdir = $(prefix)/etc
-ETC_GITCONFIG = etc/gitconfig
-ETC_GITATTRIBUTES = etc/gitattributes
-endif
 lib = lib
 # DESTDIR=
 pathsep = :
@@ -1192,6 +1185,12 @@ endif
 -include config.mak.autogen
 -include config.mak
 
+ifeq ($(prefix),/usr)
+sysconfdir = /etc
+else
+sysconfdir = etc
+endif
+
 ifdef CHECK_HEADER_DEPENDENCIES
 COMPUTE_HEADER_DEPENDENCIES =
 USE_COMPUTED_HEADER_DEPENDENCIES =
-- 
1.7.5

-- 
  Kacper Kornet
