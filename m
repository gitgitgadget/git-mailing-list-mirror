From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH] git-name-rev: allow --name-only in combination with --stdin
Date: Thu, 31 Jul 2008 15:20:34 +0200
Message-ID: <1217510434-94979-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: Git Mailinglist <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 31 15:22:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOY67-00085r-L6
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 15:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbYGaNUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 09:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbYGaNUj
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 09:20:39 -0400
Received: from smtp-1.orange.nl ([193.252.22.241]:2633 "EHLO smtp-1.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbYGaNUi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 09:20:38 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6001.online.nl (SMTP Server) with ESMTP id E10C11C00087;
	Thu, 31 Jul 2008 15:20:36 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6001.online.nl (SMTP Server) with ESMTP id 3A2471C00085;
	Thu, 31 Jul 2008 15:20:35 +0200 (CEST)
X-ME-UUID: 20080731132036238.3A2471C00085@mwinf6001.online.nl
X-Mailer: git-send-email 1.6.0.rc1.163.gc85c5.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90947>


Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
---

	Or was there a specific reason not to allow this?

 Documentation/git-name-rev.txt |    3 +--
 builtin-name-rev.c             |   10 ++++++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 6e77ab1..c8a72dd 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -38,8 +38,7 @@ OPTIONS
 	Instead of printing both the SHA-1 and the name, print only
 	the name.  If given with --tags the usual tag prefix of
 	"tags/" is also omitted from the name, matching the output
-	of 'git-describe' more closely.  This option
-	cannot be combined with --stdin.
+	of 'git-describe' more closely.
 
 --no-undefined::
 	Die with error code != 0 when a reference is undefined,
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 85612c4..0536af4 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -266,8 +266,14 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 					if (!name)
 						continue;
 
-					fwrite(p_start, p - p_start + 1, 1, stdout);
-					printf(" (%s)", name);
+					if (data.name_only) {
+						fwrite(p_start, p - p_start + 1 - 40, 1, stdout);
+						printf(name);
+					}
+					else {
+						fwrite(p_start, p - p_start + 1, 1, stdout);
+						printf(" (%s)", name);
+					}
 					p_start = p + 1;
 				}
 			}
-- 
1.6.0.rc1.163.gc85c5.dirty
