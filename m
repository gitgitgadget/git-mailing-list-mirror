From: David Kastrup <dak@gnu.org>
Subject: [PATCH] Makefile: use $(FIND) instead of find
Date: Sun, 29 Jul 2007 23:27:40 +0200
Organization: Organization?!?
Message-ID: <85ir82vr1v.fsf@lola.goethe.zz>
References: <85lkcyvr4f.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 29 23:28:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFGJQ-0003Xf-1a
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 23:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936877AbXG2V2U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 17:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936851AbXG2V2U
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 17:28:20 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:49401 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936812AbXG2V2T (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 17:28:19 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id BBF7633680C
	for <git@vger.kernel.org>; Sun, 29 Jul 2007 23:28:17 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 5C8C0345C06
	for <git@vger.kernel.org>; Sun, 29 Jul 2007 23:28:16 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-015.pools.arcor-ip.net [84.61.17.15])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 3405B1DB654
	for <git@vger.kernel.org>; Sun, 29 Jul 2007 23:28:10 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 8429B1C39595; Sun, 29 Jul 2007 23:27:40 +0200 (CEST)
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3808/Sun Jul 29 22:05:04 2007 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54139>

Some people might prefer to be able to specify the find utility to
use, in particular for the more complicated usage in the
install-symlinks target.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 Makefile |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 87b317f..29dfdeb 100644
--- a/Makefile
+++ b/Makefile
@@ -178,6 +178,7 @@ AR = ar
 RM = rm -f
 TAR = tar
 INSTALL = install
+FIND = find
 RPMBUILD = rpmbuild
 TCL_PATH = tclsh
 TCLTK_PATH = wish
@@ -905,11 +906,11 @@ doc:
 
 TAGS:
 	$(RM) TAGS
-	find . -name '*.[hcS]' -print | xargs etags -a
+	$(FIND) . -name '*.[hcS]' -print | xargs etags -a
 
 tags:
 	$(RM) tags
-	find . -name '*.[hcS]' -print | xargs ctags -a
+	$(FIND) . -name '*.[hcS]' -print | xargs ctags -a
 
 ### Detect prefix changes
 TRACK_CFLAGS = $(subst ','\'',$(ALL_CFLAGS)):\
@@ -1001,10 +1002,10 @@ quick-install-doc:
 # The somewhat strange looking lines start with an ignored $(MAKE) in
 # order to be executed also in make -n calls.
 install-symlinks:
-	@: $(MAKE) && echo cd '$(prefix_SQ)' && cd '$(prefix_SQ)' && find . -type d ! \( -iname 'git*' -prune \) -exec echo $(INSTALL) -m 755 -d '$(symlinkprefix_SQ)/{}' \;
-	@cd '$(prefix_SQ)' && find . -type d ! \( -iname 'git*' -prune \) -exec $(INSTALL) -m 755 -d '$(symlinkprefix_SQ)/{}' \;
-	@: $(MAKE) && echo cd '$(prefix_SQ)' && cd '$(prefix_SQ)' && find . \( -type d -iname 'git*' -prune -o ! -type d \) -exec echo $(RM) -r '$(symlinkprefix_SQ)/{}' \; -exec echo ln -s '$(prefix_SQ)/{}' '$(symlinkprefix_SQ)/{}' \;
-	@cd '$(prefix_SQ)' && find . \( -type d -iname 'git*' -prune -o ! -type d \) -exec $(RM) -r '$(symlinkprefix_SQ)/{}' \; -exec ln -s '$(prefix_SQ)/{}' '$(symlinkprefix_SQ)/{}' \;
+	@: $(MAKE) && echo cd '$(prefix_SQ)' && cd '$(prefix_SQ)' && $(FIND) . -type d ! \( -iname 'git*' -prune \) -exec echo $(INSTALL) -m 755 -d '$(symlinkprefix_SQ)/{}' \;
+	@cd '$(prefix_SQ)' && $(FIND) . -type d ! \( -iname 'git*' -prune \) -exec $(INSTALL) -m 755 -d '$(symlinkprefix_SQ)/{}' \;
+	@: $(MAKE) && echo cd '$(prefix_SQ)' && cd '$(prefix_SQ)' && $(FIND) . \( -type d -iname 'git*' -prune -o ! -type d \) -exec echo $(RM) -r '$(symlinkprefix_SQ)/{}' \; -exec echo ln -s '$(prefix_SQ)/{}' '$(symlinkprefix_SQ)/{}' \;
+	@cd '$(prefix_SQ)' && $(FIND) . \( -type d -iname 'git*' -prune -o ! -type d \) -exec $(RM) -r '$(symlinkprefix_SQ)/{}' \; -exec ln -s '$(prefix_SQ)/{}' '$(symlinkprefix_SQ)/{}' \;
 
 ### Maintainer's dist rules
 
-- 
1.5.3.rc2.84.g6497
