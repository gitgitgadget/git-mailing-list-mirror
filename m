From: Matt Porter <mporter@kernel.crashing.org>
Subject: [PATCH] Add exclude file support to cg-status
Date: Mon, 2 May 2005 17:10:42 -0700
Message-ID: <20050502171042.A24299@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 02:06:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSkvg-0007VY-S3
	for gcvg-git@gmane.org; Tue, 03 May 2005 02:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVECAMf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 20:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVECAMf
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 20:12:35 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:53993 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261238AbVECAMe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2005 20:12:34 -0400
Received: from liberty.homelinux.org ([68.2.41.86]) by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503001232.FRO22430.fed1rmmtao02.cox.net@liberty.homelinux.org>;
          Mon, 2 May 2005 20:12:32 -0400
Received: (from mmporter@localhost)
	by liberty.homelinux.org (8.9.3/8.9.3/Debian 8.9.3-21) id RAA24882;
	Mon, 2 May 2005 17:10:43 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Adds a trivial per-repository exclude file implementation for
cg-status on top of the new git-ls-files option.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

--- 002c6f1e4924965e2101d2e6447855f10c55df41/cg-status  (mode:100755 sha1:9e7f0e59284a3d15cda35bbd5579c44d8eda05d5)
+++ 1b8c5395679e5c04734b1c86445a6355124ada7e/cg-status  (mode:100755 sha1:6669e36f5ff5d5964882b58ba43a5dcab4fd7fc6)
@@ -7,8 +7,14 @@
 
 . cg-Xlib
 
+EXCLUDEFILE=.git/exclude
+EXCLUDE=
+if [ -f $EXCLUDEFILE ]; then
+	EXCLUDE="--exclude-from=$EXCLUDEFILE"
+fi
+
 {
-	git-ls-files -z -t --others --deleted --unmerged
+	git-ls-files -z -t --others --deleted --unmerged $EXCLUDE
 } | sort -z -k 2 | xargs -0 sh -c '
 while [ "$1" ]; do
 	tag=${1% *};
