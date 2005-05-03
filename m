From: Matt Porter <mporter@kernel.crashing.org>
Subject: [PATCH] cogito: Updated cg-status -a
Date: Tue, 3 May 2005 10:47:26 -0700
Message-ID: <20050503104725.A29663@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 19:44:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT1QM-0007G4-3o
	for gcvg-git@gmane.org; Tue, 03 May 2005 19:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVECRtX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 13:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVECRtX
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 13:49:23 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:22448 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261488AbVECRtT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 13:49:19 -0400
Received: from liberty.homelinux.org ([68.2.41.86]) by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503174916.TFOJ20235.fed1rmmtao10.cox.net@liberty.homelinux.org>;
          Tue, 3 May 2005 13:49:16 -0400
Received: (from mmporter@localhost)
	by liberty.homelinux.org (8.9.3/8.9.3/Debian 8.9.3-21) id KAA29761;
	Tue, 3 May 2005 10:47:26 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Updated patch versus latest cogito and bug fix for a thinko.
If -a is passed, the same output is generated but it also shows
all modified but uncommitted files as well.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

--- aa6233be6d1b8bf42797c409a7c23b50593afc99/cg-status  (mode:100755 sha1:9e7f0e59284a3d15cda35bbd5579c44d8eda05d5)
+++ ee35a6204e59cf47966080be20d8248a6e4aa3c3/cg-status  (mode:100755 sha1:dc821a1255f012a612aa4d25ffc551c32b017bd9)
@@ -3,7 +3,9 @@
 # Show status of entries in your working tree.
 # Copyright (c) Petr Baudis, 2005
 #
-# Takes no arguments.
+# Takes an optional -a argument which will cause all repository status
+# to be shown, including modified but uncommitted files
+
 
 . cg-Xlib
 
@@ -20,3 +22,16 @@
 	shift
 done
 ' padding
+
+if [ "$1" = "-a" ]; then
+	{
+		git-update-cache --refresh
+	} | cut -f 1 -d ":" | xargs sh -c '
+	while [ "$1" ]; do
+		tag="M";
+		filename=${1%: *};
+		echo "$tag $filename";
+		shift
+	done
+	' padding
+fi
