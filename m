From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH v2] Get rid of the non portable shell export VAR=VALUE costruct
Date: Fri, 23 May 2014 03:15:31 -0700
Message-ID: <1400840131-966-1-git-send-email-gitter.spiros@gmail.com>
Cc: gitster@pobox.com, tboegi@web.de, dak@gnu.org,
	Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 12:15:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnmVp-00063g-5X
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 12:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbaEWKPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 06:15:37 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:54704 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbaEWKPg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 06:15:36 -0400
Received: by mail-pa0-f46.google.com with SMTP id kq14so3884447pab.5
        for <git@vger.kernel.org>; Fri, 23 May 2014 03:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=VwlYVETKjE1Wmyy2c4CfvreRPpWyzEw4Q1pk90MuMtM=;
        b=n8B2L8bSypsvgXf2R4Tc7OCxQbCSmSIPqkVJxhnRx8WOJb2aWE/NzAywQv320hxVNn
         GIpl7dWMYyNWaaxd5YeAYlQv1Re4YzRotmEHI3XRtoiQKr6D2QdDZBQyKoUPEddQzbQ8
         ffXg/kZbvxiVMIkTezRacUY05oVCBOUO6M7Qjnd9sRWA+upFjIEmhhWdVceNZ9dhp8cb
         2qWtJHADwebCop05ygKW+so2msFJ4U2qKz8a2IaCQNxJCB3+NfPQCn4xt17i9GLxjAgx
         GWrzgZQuEyVkYNMiTy41pCPqfdY7UTpeEMB9g6kz7NglsMwzGvu5qt4svasY8aeMY6Rl
         G+Pw==
X-Received: by 10.68.186.130 with SMTP id fk2mr4640698pbc.60.1400840135801;
        Fri, 23 May 2014 03:15:35 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id ix7sm3896197pbd.36.2014.05.23.03.15.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 May 2014 03:15:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249980>

Found by check-non-portable-shell.pl

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
This is the second version of the patch that includes 
Junio suggestions.

 contrib/subtree/t/t7900-subtree.sh |    3 ++-
 git-remote-testgit.sh              |    3 ++-
 git-stash.sh                       |    3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 66ce4b0..8dc6840 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -8,7 +8,8 @@ This test verifies the basic operation of the merge, pull, add
 and split subcommands of git subtree.
 '
 
-export TEST_DIRECTORY=$(pwd)/../../../t
+TEST_DIRECTORY=$(pwd)/../../../t
+export TEST_DIRECTORY
 
 . ../../../t/test-lib.sh
 
diff --git a/git-remote-testgit.sh b/git-remote-testgit.sh
index 1c006a0..a9c75a2 100755
--- a/git-remote-testgit.sh
+++ b/git-remote-testgit.sh
@@ -13,7 +13,8 @@ refspec="${GIT_REMOTE_TESTGIT_REFSPEC-$default_refspec}"
 
 test -z "$refspec" && prefix="refs"
 
-export GIT_DIR="$url/.git"
+GIT_DIR="$url/.git"
+export GIT_DIR
 
 force=
 
diff --git a/git-stash.sh b/git-stash.sh
index 4798bcf..4621d81 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -94,7 +94,8 @@ create_stash () {
 		# ease of unpacking later.
 		u_commit=$(
 			untracked_files | (
-				export GIT_INDEX_FILE="$TMPindex"
+				GIT_INDEX_FILE="$TMPindex" &&
+				export GIT_INDEX_FILE &&
 				rm -f "$TMPindex" &&
 				git update-index -z --add --remove --stdin &&
 				u_tree=$(git write-tree) &&
-- 
1.7.10.4
