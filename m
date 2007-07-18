From: David Kastrup <dak@gnu.org>
Subject: [PATCH 2/2] Makefile: use $(FIND) instead of find
Date: Wed, 18 Jul 2007 16:45:36 +0200
Message-ID: <e59329b96603b8ed323b57179608bb7df9b57322.1184770193.git.dak@gnu.org>
References: <6e14af24a3aa8af7e21e0a3f92c83c82e147202a.1184770193.git.dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 16:55:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBAvl-0003Wc-MP
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 16:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830AbXGROzG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 10:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754289AbXGROzG
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 10:55:06 -0400
Received: from main.gmane.org ([80.91.229.2]:50075 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754527AbXGROzE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 10:55:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IBAve-00019l-4D
	for git@vger.kernel.org; Wed, 18 Jul 2007 16:55:02 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 16:55:02 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 16:55:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
In-Reply-To: <6e14af24a3aa8af7e21e0a3f92c83c82e147202a.1184770193.git.dak@gnu.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:9kdufk4LIlqSPTRFO07XM2VOgRQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52867>


Some people might prefer to be able to specify the find utility to
use, in particular for the more complicated usage in the
install-symlinks target.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 Makefile |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 7e53378..cf72327 100644
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
@@ -904,11 +905,11 @@ doc:
 
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
@@ -1000,10 +1001,10 @@ quick-install-doc:
 # The somewhat strange looking lines start with an ignored $(MAKE) in
 # order to be executed also in make -n calls.
 install-symlinks:
-	@: $(MAKE) && cd '$(prefix_SQ)' && find . -type d ! \( -iname 'git*' -prune \) -exec echo $(INSTALL) -m 755 -d '$(symlinkprefix)/{}' \;
-	@cd '$(prefix_SQ)' && find . -type d ! \( -iname 'git*' -prune \) -exec $(INSTALL) -m 755 -d '$(symlinkprefix)/{}' \;
-	@: $(MAKE) && cd '$(prefix_SQ)' && find . \( -type d -iname 'git*' -prune -o ! -type d \) -exec echo $(RM) -r '$(symlinkprefix)/{}' \; -exec echo ln -s '$(prefix_SQ)/{}' '$(symlinkprefix)/{}' \;
-	@cd '$(prefix_SQ)' && find . \( -type d -iname 'git*' -prune -o ! -type d \) -exec $(RM) -r '$(symlinkprefix)/{}' \; -exec ln -s '$(prefix_SQ)/{}' '$(symlinkprefix)/{}' \;
+	@: $(MAKE) && cd '$(prefix_SQ)' && $(FIND) . -type d ! \( -iname 'git*' -prune \) -exec echo $(INSTALL) -m 755 -d '$(symlinkprefix)/{}' \;
+	@cd '$(prefix_SQ)' && $(FIND) . -type d ! \( -iname 'git*' -prune \) -exec $(INSTALL) -m 755 -d '$(symlinkprefix)/{}' \;
+	@: $(MAKE) && cd '$(prefix_SQ)' && $(FIND) . \( -type d -iname 'git*' -prune -o ! -type d \) -exec echo $(RM) -r '$(symlinkprefix)/{}' \; -exec echo ln -s '$(prefix_SQ)/{}' '$(symlinkprefix)/{}' \;
+	@cd '$(prefix_SQ)' && $(FIND) . \( -type d -iname 'git*' -prune -o ! -type d \) -exec $(RM) -r '$(symlinkprefix)/{}' \; -exec ln -s '$(prefix_SQ)/{}' '$(symlinkprefix)/{}' \;
 
 ### Maintainer's dist rules
 
-- 
1.5.3.rc2.41.gb47b1
