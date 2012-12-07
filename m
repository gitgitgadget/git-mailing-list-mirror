From: marcnarc@xiplink.com
Subject: [PATCH] sh-setup: Explicitly set IFS to its default, instead of unsetting it.
Date: Fri,  7 Dec 2012 17:15:52 -0500
Message-ID: <1354918552-27150-1-git-send-email-marcnarc@xiplink.com>
References: <50C24ED7.90000@xiplink.com>
Cc: Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 07 23:30:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th6R1-00017q-9a
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 23:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521Ab2LGWaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 17:30:01 -0500
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:30716 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754285Ab2LGWaA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Dec 2012 17:30:00 -0500
X-Greylist: delayed 821 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Dec 2012 17:30:00 EST
Received: from xiplink.com (rincewind.xiplink.com [192.168.1.178])
	by farnsworth.xiplink.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id qB7MGI8e021193;
	Fri, 7 Dec 2012 17:16:18 -0500
X-Mailer: git-send-email 1.8.0.1
In-Reply-To: <50C24ED7.90000@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211198>

From: Marc Branchaud <marcnarc@xiplink.com>

Some sh implementations interpret "unset IFS" to mean IFS=''.  This was
seen in FreeBSD 7.2's sh.

We need to make sure IFS has its default value: <space><tab><newline>.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 git-sh-setup.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index ee0e0bc..56e6498 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -12,8 +12,11 @@
 # But we protect ourselves from such a user mistake nevertheless.
 unset CDPATH
 
-# Similarly for IFS
-unset IFS
+# Similarly for IFS, except that some sh implementations interpret "unset IFS"
+# as IFS='', so we need to set IFS explicitly to its POSIX default using
+# literal <space><tab><newline> characters.
+IFS=' 	
+'
 
 git_broken_path_fix () {
 	case ":$PATH:" in
-- 
1.8.0.1
