From: "Adam W. Hawks" <awhawks@writeme.com>
Subject: [JGIT PATCH 1/1] Fix for Repository.stripWorkDir when using partial
 paths
Date: Tue, 11 Aug 2009 20:48:39 -0400
Message-ID: <4A821167.6030107@writeme.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 12 02:59:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb2C5-0002P9-RI
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 02:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbZHLA7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 20:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbZHLA7s
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 20:59:48 -0400
Received: from outbound1-2.us4.outblaze.com ([208.36.123.130]:48149 "EHLO
	outbound1-2.us4.outblaze.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751490AbZHLA7s (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 20:59:48 -0400
X-Greylist: delayed 663 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Aug 2009 20:59:48 EDT
Received: from smtp1.us4.outblaze.com (73.11.168.192.in-addr.arpa [192.168.11.73])
	by outbound1-2.us4.outblaze.com (Postfix) with SMTP id 89A6B5C0FA9F
	for <git@vger.kernel.org>; Wed, 12 Aug 2009 00:48:46 +0000 (GMT)
Received: (qmail 24049 invoked from network); 12 Aug 2009 00:48:46 -0000
Received: from unknown (HELO ?192.168.0.4?) (awhawks:writeme.com@mail.com@24.74.41.120)
  by ws1-9.us4.outblaze.com with SMTP; 12 Aug 2009 00:48:45 -0000
User-Agent: Thunderbird 2.0.0.22 (X11/20090605)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125635>


>From ef993e633cdcb1dddda5e71db1b62306df7ce83f Mon Sep 17 00:00:00 2001
Date: Tue, 11 Aug 2009 20:02:56 -0400

When you call stripWorkDir with a relative path
you can get a string out of bounds error.

This change fixes that problem by using the absolute paths
of the file instead of its relative name.

Signed-off-by: Adam W. Hawks <awhawks@writeme.com>
---
 .../src/org/spearce/jgit/lib/Repository.java       |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 468cf4c..a68817b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -1036,7 +1036,7 @@ public static boolean isValidRefName(final String refName) {
 	 * @return normalized repository relative path
 	 */
 	public static String stripWorkDir(File wd, File f) {
-		String relName = f.getPath().substring(wd.getPath().length() + 1);
+		String relName = f.getAbsolutePath().substring(wd.getPath().length() + 1);
 		relName = relName.replace(File.separatorChar, '/');
 		return relName;
 	}
-- 
1.6.0.2
