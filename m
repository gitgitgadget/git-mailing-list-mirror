From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] cg-init shouldn't create master branch when pulling
Date: Wed, 27 Apr 2005 17:33:37 -0400
Message-ID: <1114637617.15385.10.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Apr 27 23:28:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQu57-0006R2-Sa
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 23:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVD0Vdt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 17:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVD0Vdt
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 17:33:49 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:13492
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S262032AbVD0Vdk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 17:33:40 -0400
Received: by localhost.localdomain (Postfix, from userid 500)
	id 80D7BEFF68; Wed, 27 Apr 2005 17:33:37 -0400 (EDT)
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

>From what I see in the current cogito sources, ".git/refs/heads/master"
is never used once it's created by cg-init.  I believe the "master"
branch is only useful when creating a new repository.  Then it's the
only branch in the repository.

When pulling from a remote repository, the "origin" branch is created,
and it should be default.  There is no need in having a separate
"master" branch unless the user decides to create it for local
development.

This patch changes cg-init so that the "master" branch is only created
when the remote URI is not specified.

Signed-off-by: Pavel Roskin <proski@gnu.org>

Index: cg-init
===================================================================
--- 8dc4ace046ad3545d48088e604012f95e34e24d3/cg-init  (mode:100755 sha1:d249140002888742c46ecba5925cae7c8025ea93)
+++ uncommitted/cg-init  (mode:100755)
@@ -14,17 +14,18 @@
 
 init-db
 mkdir .git/branches .git/refs .git/refs/heads .git/refs/tags
-touch .git/refs/heads/master
-ln -s refs/heads/master .git/HEAD
 
 if [ "$uri" ]; then
 	echo "$uri" >.git/branches/origin
+	ln -s refs/heads/origin .git/HEAD
 	cg-pull origin || die "pull failed"
 
-	cp .git/refs/heads/origin .git/refs/heads/master
 	read-tree $(tree-id)
 	checkout-cache -a
 	update-cache --refresh
 
 	echo "Cloned (origin $uri available as branch \"origin\")"
+else
+	touch .git/refs/heads/master
+	ln -s refs/heads/master .git/HEAD
 fi


-- 
Regards,
Pavel Roskin

