From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Prevent an exception if the user tries to push a non-existing ref.
Date: Sun,  8 Mar 2009 16:21:07 +0100
Message-ID: <1236525667-852-1-git-send-email-robin.rosenberg@dewire.com>
References: <20090307224831.GS16213@spearce.org>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org, Daniel Cheng <j16sdiz+freenet@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 16:23:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgKqo-0003Rj-1t
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 16:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbZCHPVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 11:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752282AbZCHPVS
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 11:21:18 -0400
Received: from mail.dewire.com ([83.140.172.130]:28014 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752098AbZCHPVR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 11:21:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id AD93615E0DEA;
	Sun,  8 Mar 2009 16:21:10 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Owy0kupbb-bd; Sun,  8 Mar 2009 16:21:09 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id A8EED15E0DE0;
	Sun,  8 Mar 2009 16:21:09 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
In-Reply-To: <20090307224831.GS16213@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112623>

Instead of a StringIndexOutOfBoundsException we now get an error telling
us that the ref could not be resolved.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/transport/Transport.java  |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index a0a2575..8a25213 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -255,7 +255,7 @@ else if (TransportLocal.canHandle(remote))
 			} else {
 				if (!remoteName.startsWith(Constants.R_REFS)) {
 					// null source is another special case (delete)
-					if (srcRef != null) {
+					if (src != null) {
 						// assume the same type of ref at the destination
 						String srcPrefix = srcRef.substring(0, srcRef.indexOf('/', Constants.R_REFS.length()));
 						remoteName = srcPrefix + "/" + remoteName;
-- 
1.6.1.285.g35d8b
