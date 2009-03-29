From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] git-gui: make "Git GUI Here" Explorer extension more robust
Date: Mon, 30 Mar 2009 00:30:03 +0200
Message-ID: <200903300030.03733.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Mon Mar 30 00:33:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo3ZD-0003kE-4p
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 00:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466AbZC2Wby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 18:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753449AbZC2Wbx
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 18:31:53 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:53834 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007AbZC2Wbw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 18:31:52 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 8082CFC39202;
	Mon, 30 Mar 2009 00:31:49 +0200 (CEST)
Received: from [89.59.99.140] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1Lo3Xh-0005XY-00; Mon, 30 Mar 2009 00:31:49 +0200
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/WRjhPRtAyZfVr5+8O5wB6xyotlBmEVdlS103r
	ocENcHABcCS3dUbm7n2DGMavmL3Il1kQunMMd5GnRbaBxwbfvI
	LzEUYyg9q3O7leXH5xVw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115044>

Starting git-gui via Windows Explorer shell extension caused problems
when not started from the project directory, but from a directory within
the project: starting the Explorer from the git-gui menu "Explore
Working Copy" didn't work then.

Starting git-gui via Explorer shell extension from the .git directory
didn't work at all.

To make these things possible, "cd .." until we see .git/

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 windows/git-gui.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/windows/git-gui.sh b/windows/git-gui.sh
index 53c3a94..16c4a2a 100644
--- a/windows/git-gui.sh
+++ b/windows/git-gui.sh
@@ -4,6 +4,9 @@ exec wish "$0" -- "$@"
 
 if { $argc >=2 && [lindex $argv 0] == "--working-dir" } {
 	cd [lindex $argv 1]
+	while { ![file isdirectory .git] } {
+		cd ..
+	}
 	set argv [lrange $argv 2 end]
 	incr argc -2
 }
-- 
1.6.2.1.409.gad7bf.dirty
