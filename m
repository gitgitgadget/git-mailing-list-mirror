From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] Do not try to remove directories when removing old links
Date: Tue, 27 Oct 2009 12:23:33 +0100
Message-ID: <hc6l9h$fn6$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 12:25:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2kAj-0004k1-Dj
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 12:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508AbZJ0LYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 07:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753212AbZJ0LYy
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 07:24:54 -0400
Received: from lo.gmane.org ([80.91.229.12]:60037 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537AbZJ0LYx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 07:24:53 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N2kAb-0004fO-IU
	for git@vger.kernel.org; Tue, 27 Oct 2009 12:24:57 +0100
Received: from 91-64-214-160-dynip.superkabel.de ([91.64.214.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 12:24:57 +0100
Received: from sschuberth by 91-64-214-160-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 12:24:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 91-64-214-160-dynip.superkabel.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131325>

When building Git with MSVC on Windows, directories named after the Git alias
are created for the output files, e.g. there is a "git-merge-index" directory
next to the "git-merge-index.exe" executable in the build root. Previously,
"make all" just checked if "git-merge-index" and "git-merge-index.exe" are the
same file, and if not, tried to remove "git-merge-index". This fails in the
case of "git-merge-index" being a directory, which is why this is checked now.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 42b7d60..268aede 100644
--- a/Makefile
+++ b/Makefile
@@ -1375,7 +1375,7 @@ SHELL = $(SHELL_PATH)
 
 all:: shell_compatibility_test $(ALL_PROGRAMS) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
 ifneq (,$X)
-	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), test '$p' -ef '$p$X' || $(RM) '$p';)
+	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
 endif
 
 all::
-- 
1.6.5.rc2.13.g1be2
