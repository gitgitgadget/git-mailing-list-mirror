From: Pal-Kristian Engstad <pal_engstad@naughtydog.com>
Subject: [PATCH 1/3] git-p4: default submit to use rename detection
Date: Thu, 21 Jan 2010 18:03:36 -0800
Message-ID: <4B590778.30403@naughtydog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 03:03:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY8rm-0005j2-0B
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 03:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750Ab0AVCDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 21:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752370Ab0AVCDN
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 21:03:13 -0500
Received: from ironport01a.scea.com ([160.33.44.41]:10808 "EHLO
	ironport01a.scea.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab0AVCDL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 21:03:11 -0500
X-IronPort-AV: E=Sophos;i="4.49,322,1262592000"; 
   d="scan'208";a="10635370"
Received: from inbetweener01.scea.com ([160.33.45.195])
  by ironport01a.scea.com with ESMTP; 21 Jan 2010 18:03:08 -0800
Received: from postal1-dog.naughtydog.com (intmail.naughtydog.com [10.15.0.14])
	by inbetweener01.scea.com (Postfix) with ESMTP id 31331F017A;
	Thu, 21 Jan 2010 18:03:08 -0800 (PST)
Received: from [127.0.0.1] ([150.0.6.116]) by postal1-dog.naughtydog.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 21 Jan 2010 18:03:36 -0800
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-OriginalArrivalTime: 22 Jan 2010 02:03:36.0901 (UTC) FILETIME=[1BEC0750:01CA9B07]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137716>

Enable git's rename detection by default. This is needed to preserve
Perforce's history.

Removed the '-M' flag and added a '--no-detect' flag to preserve the
old behavior.

Signed-off-by: Pal-Kristian Engstad <pal_engstad@naughtydog.com>
---
 contrib/fast-import/git-p4 |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 48059d0..c65ef8a 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -543,13 +543,14 @@ class P4Submit(Command):
         self.options = [
                 optparse.make_option("--verbose", dest="verbose", action="store_true"),
                 optparse.make_option("--origin", dest="origin"),
-                optparse.make_option("-M", dest="detectRename", action="store_true"),
+                optparse.make_option("--no-detect", dest="detectRename", action="store_false",
+                                     help="Disable git's rename detection, forcing \"p4 delete\" and \"p4 add\" instead of \"p4 integrate\" and \"p4 edit\""),
         ]
         self.description = "Submit changes from git to the perforce depot."
         self.usage += " [name of git branch to submit into perforce depot]"
         self.interactive = True
         self.origin = ""
-        self.detectRename = False
+        self.detectRename = True
         self.verbose = False
         self.isWindows = (platform.system() == "Windows")
 
-- 
1.6.5.2.6.gc3c1e.dirty
