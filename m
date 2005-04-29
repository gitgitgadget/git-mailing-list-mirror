From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] GIT: Honour SHA1_FILE_DIRECTORY env var in git-pull-script
Date: Fri, 29 Apr 2005 20:31:50 +0200
Message-ID: <20050429183150.GA29729@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 20:27:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRaBs-0001Im-Ob
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 20:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262875AbVD2Sbz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 14:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262876AbVD2Sbz
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 14:31:55 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:1694 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262875AbVD2Sbv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 14:31:51 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 69F4440F; Fri, 29 Apr 2005 20:31:50 +0200 (CEST)
To: Linux Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

If you set SHA1_FILE_DIRECTORY to something else than .git/objects
git-pull-script will store the fetched files in a location the rest of
the tools does not expect.

git-prune-script also ignores this setting, but I think this is good,
because pruning a shared tree to fit a single project means throwing
away a lot of useful data. :-)

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

---
commit 6fef2965444a6509d11a79bd33842125034dcec0
tree 63e9cdf5ff724bf462d9dc408b9c951985d4cecf
parent db413479f1bb0dabfc613b2b0017ca74aeb5a919
author Rene Scharfe <rene.scharfe@lsrfire.ath.cx> 1114799335 +0200
committer Rene Scharfe <rene.scharfe@lsrfire.ath.cx> 1114799335 +0200

Index: git-pull-script
===================================================================
--- 1e2168c7d554a4fbd25a09bb591ae0f82dac6513/git-pull-script  (mode:100755 sha1:5111da98e68f4c3eb44499d20a210966dd445212)
+++ 63e9cdf5ff724bf462d9dc408b9c951985d4cecf/git-pull-script  (mode:100755 sha1:0198c4805db7c2b78cd4424634873b0a86ee4107)
@@ -9,7 +9,7 @@
 cp .git/HEAD .git/ORIG_HEAD
 
 echo "Getting object database"
-rsync -avz --ignore-existing $merge_repo/objects/. .git/objects/.
+rsync -avz --ignore-existing $merge_repo/objects/. ${SHA1_FILE_DIRECTORY:-.git/objects}/.
 
 echo "Getting remote head"
 rsync -L $merge_repo/HEAD .git/MERGE_HEAD || exit 1
