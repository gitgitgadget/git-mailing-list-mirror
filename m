From: Matt Porter <mporter@kernel.crashing.org>
Subject: [PATCH] cogito: cg-status option to show modified/uncommitted files
Date: Thu, 28 Apr 2005 15:43:20 -0700
Message-ID: <20050428154320.D24498@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 00:40:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRHgB-0003fc-W1
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 00:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVD1Wpa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 18:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbVD1Wpa
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 18:45:30 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:19910 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262308AbVD1WpD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 18:45:03 -0400
Received: from liberty.homelinux.org ([68.2.41.86]) by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428224501.VLBV7275.fed1rmmtao09.cox.net@liberty.homelinux.org>;
          Thu, 28 Apr 2005 18:45:01 -0400
Received: (from mmporter@localhost)
	by liberty.homelinux.org (8.9.3/8.9.3/Debian 8.9.3-21) id PAA26860;
	Thu, 28 Apr 2005 15:43:20 -0700
To: pasky@ucw.cz
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Adds a -a option to show all status of the working tree. After hacking
around I like to see what's new AND what's modified but uncommitted.

-Matt

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/cg-status  (mode:100755 sha1:c9b69b9d54b6a6756f0ecad5324642eb66810b33)
+++ uncommitted/cg-status  (mode:100755)
@@ -3,7 +3,8 @@
 # Show status of entries in your working tree.
 # Copyright (c) Petr Baudis, 2005
 #
-# Takes no arguments.
+# Takes an optional -a argument which will cause all repository status
+# to be shown, including modified but uncommitted files
 
 . cg-Xlib
 
@@ -20,3 +21,18 @@
 	shift
 done
 ' padding
+
+
+if [ "$1" = "-a" ]; then
+	{
+		update-cache --refresh
+	} | xargs -0 sh -c '
+while [ "$1" ]; do
+tag="M";
+filename=${1%: *};
+echo "$tag $filename";
+shift
+done
+' padding
+fi
+
