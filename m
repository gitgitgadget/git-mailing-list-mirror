From: "martin f. krafft" <madduck@madduck.net>
Subject: [PATCH] Clarify role of init command in git-submodules documentation
Date: Mon, 20 Aug 2007 09:09:44 +0200
Message-ID: <11875937841178-git-send-email-madduck@madduck.net>
References: <20070817103652.GK1070MdfPADPa@greensroom.kotnet.org>
Cc: hjemli@gmail.com, skimo@liacs.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 09:10:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN1PC-0002rx-P4
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 09:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbXHTHK2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 03:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbXHTHK1
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 03:10:27 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:50565 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbXHTHK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 03:10:27 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 2CCE38966EC;
	Mon, 20 Aug 2007 09:10:20 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 21467-03; Mon, 20 Aug 2007 09:10:20 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 9E11C8966DF;
	Mon, 20 Aug 2007 09:10:19 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id F259C9F16A;
	Mon, 20 Aug 2007 09:10:18 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id B54D843F9; Mon, 20 Aug 2007 09:09:44 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc5.40.g2f82
In-Reply-To: <20070817103652.GK1070MdfPADPa@greensroom.kotnet.org>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56181>

As per the discussion in this thread:

  http://marc.info/?t=118721709500008&r=1&w=2

this patch updates the git-submodules documentation to make the situation
a bit clearer and documents the intended workflow.

Signed-off-by: martin f. krafft <madduck@madduck.net>
---
 Documentation/git-submodule.txt |   30 +++++++++++++++++++-----------
 1 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 2c48936..8bc818a 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -32,15 +32,17 @@ status::
 	repository. This command is the default command for git-submodule.
 
 init::
-	Initialize the submodules, i.e. register in .git/config each submodule
-	name and url found in .gitmodules. The key used in .git/config is
-	`submodule.$name.url`. This command does not alter existing information
-	in .git/config.
+	Initialize the submodules, i.e. register in $GIT_DIR/config each
+	submodule name and url found in .gitmodules. The key used in
+	$GIT_DIR/config is `submodule.$name.url`. This command does not alter
+	existing information in $GIT_DIR/config, it only serves to initialise
+	the local configuration from the defaults in .gitmodules.
 
 update::
-	Update the registered submodules, i.e. clone missing submodules and
-	checkout the commit specified in the index of the containing repository.
-	This will make the submodules HEAD be detached.
+	Update the submodules registered in $GIT_DIR/config, i.e. clone
+	missing submodules and checkout the commit specified in the index of
+	the containing repository. This will make the submodules HEAD be
+	detached.
 
 
 OPTIONS
@@ -62,10 +64,16 @@ OPTIONS
 
 FILES
 -----
-When initializing submodules, a .gitmodules file in the top-level directory
-of the containing repository is used to find the url of each submodule.
-This file should be formatted in the same way as $GIR_DIR/config. The key
-to each submodule url is "submodule.$name.url".
+To work with submodules, a user has to prepare a repository clone with the
+command `git-submodule init`. This command copies the url of each submodule
+listed in the .gitmodules file in the top-level directory of the containing
+repository to $GIT_DIR/config. The key to each submodule url is
+"submodule.$name.url".
+
+The .gitmodules file then specifies the location of each submodule with
+respect to the repository (and is shared among all contributors), while the
+url of each submodule comes from the local configuration in $GIT_DIR/config
+and can thus be modified independently of all other users.
 
 
 AUTHOR
-- 
1.5.3.rc5.40.g2f82
