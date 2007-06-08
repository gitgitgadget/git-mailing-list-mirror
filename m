From: Kevin Green <Kevin.Green@morganstanley.com>
Subject: [PATCH] git-p4import.py: handle paths with symlinks
Date: Fri, 8 Jun 2007 18:33:00 -0400
Message-ID: <20070608223300.GL25093@menevado.ms.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 00:39:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwn7K-0006UE-NY
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 00:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032308AbXFHWjS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 18:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032101AbXFHWjR
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 18:39:17 -0400
Received: from hqvsbh1.ms.com ([205.228.12.101]:65406 "EHLO hqvsbh1.ms.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031588AbXFHWjP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 18:39:15 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Jun 2007 18:39:14 EDT
Received: from hqvsbh1.ms.com (localhost [127.0.0.1])
	by hqvsbh1.ms.com (Postfix) with ESMTP id BEC274C7A
	for <git@vger.kernel.org>; Fri,  8 Jun 2007 18:33:00 -0400 (EDT)
Received: from ny16im02.ms.com (unknown [144.14.206.243])
	by hqvsbh1.ms.com (internal Postfix) with ESMTP id 9E7933D08
	for <git@vger.kernel.org>; Fri,  8 Jun 2007 18:33:00 -0400 (EDT)
Received: from menevado.ms.com (menevado [144.14.26.134])
	by ny16im02.ms.com (Sendmail MTA Hub) with ESMTP id l58MX0F06266;
	Fri, 8 Jun 2007 18:33:00 -0400 (EDT)
Received: (kgreen@localhost) by menevado.ms.com (8.12.11.20060308/sendmail.cf.client v1.05) id l58MX03q014305; Fri, 8 Jun 2007 18:33:00 -0400
X-Authentication-Warning: menevado.ms.com: kgreen set sender to Kevin.Green@morganstanley.com using -f
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49518>

Need to expand symlinks when checking if the p4 client is misconfigured
for the local git dir.

Signed-off-by: Kevin Green <Kevin.Green@morganstanley.com>
---
 git-p4import.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-p4import.py b/git-p4import.py
index 0f3d97b..ad15708 100644
--- a/git-p4import.py
+++ b/git-p4import.py
@@ -312,7 +312,7 @@ for o, a in opts:
         p4.authors(a)

 localdir = git.basedir()
-if p4.where()[:len(localdir)] != localdir:
+if os.path.realpath(os.path.dirname(p4.where())) != os.path.realpath(localdir):
     report(1, "**WARNING** Appears p4 client is misconfigured")
     report(1, "   for sync from %s to %s" % (p4.repopath, localdir))
     if ignore_warnings != True:
--
1.5.2.1
