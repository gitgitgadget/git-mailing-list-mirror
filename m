From: Emil Medve <Emilian.Medve@Freescale.com>
Subject: [PATCH] git-submodule: Instead of using only annotated tags, use any tag found in .git/refs/tags
Date: Tue, 26 Jun 2007 18:40:58 -0500
Message-ID: <11829012583562-git-send-email-Emilian.Medve@Freescale.com>
Cc: Emil Medve <Emilian.Medve@Freescale.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 01:43:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Kgw-0005OQ-3m
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 01:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757366AbXFZXnS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 19:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756772AbXFZXnS
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 19:43:18 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:43670 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827AbXFZXnR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 19:43:17 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id l5QNhEXl013379
	for <git@vger.kernel.org>; Tue, 26 Jun 2007 16:43:15 -0700 (MST)
Received: from localhost.localdomain ([10.82.124.180])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l5QNhEGC019749;
	Tue, 26 Jun 2007 18:43:14 -0500 (CDT)
X-Mailer: git-send-email 1.5.2.2.549.gaeb59
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50987>

Some repositories might not use/have annotated tags (for example repositories created with
git-cvsimport) and git-submodule status might fail because git-describe might fail to find a tag.
This change allows the status of a submodule to be described/displayed relative to lightweight tags
as well.

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 git-submodule.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 89a3885..56ea935 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -155,7 +155,7 @@ modules_list()
 			say "-$sha1 $path"
 			continue;
 		fi
-		revname=$(unset GIT_DIR && cd "$path" && git-describe $sha1)
+		revname=$(unset GIT_DIR && cd "$path" && git-describe --tags $sha1)
 		if git diff-files --quiet -- "$path"
 		then
 			say " $sha1 $path ($revname)"
@@ -163,7 +163,7 @@ modules_list()
 			if test -z "$cached"
 			then
 				sha1=$(unset GIT_DIR && cd "$path" && git-rev-parse --verify HEAD)
-				revname=$(unset GIT_DIR && cd "$path" && git-describe $sha1)
+				revname=$(unset GIT_DIR && cd "$path" && git-describe --tags $sha1)
 			fi
 			say "+$sha1 $path ($revname)"
 		fi
-- 
1.5.2.2.549.gaeb59
