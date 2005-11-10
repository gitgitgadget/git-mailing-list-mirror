From: exon@op5.se (Andreas Ericsson)
Subject: [PATCH 2/2] git-clone: Allow cloning into directories other than child of current dir.
Date: Thu, 10 Nov 2005 12:58:08 +0100 (CET)
Message-ID: <20051110115808.466765BB44@nox.op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 10 12:59:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaB4I-0003Yr-4h
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 12:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVKJL6K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 06:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbVKJL6K
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 06:58:10 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:45464 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750792AbVKJL6J
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 06:58:09 -0500
Received: from nox.op5.se (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 6405C6BD0F
	for <git@vger.kernel.org>; Thu, 10 Nov 2005 12:58:08 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 466765BB44; Thu, 10 Nov 2005 12:58:08 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11480>


This patch adds -p to mkdir and an explicit check to see if the target
directory exists (since mkdir -p doesn't throw an error if it does).

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 git-clone.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

applies-to: 28cfa6f299b27be02a24b6887f9b82b42c0e08cd
48b959195a979b113e51e898ac878a0fd7cfb30a
diff --git a/git-clone.sh b/git-clone.sh
index 70cf7a2..4b98fb1 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -98,7 +98,8 @@ fi
 dir="$2"
 # Try using "humanish" part of source repo if user didn't specify one
 [ -z "$dir" ] && dir=$(echo "$repo" | sed -e 's#/*\.git$##' -e 's#.*[/:]##')
-mkdir "$dir" &&
+[ -e "$dir" ] && $(echo "$dir already exists."; usage)
+mkdir -p "$dir" &&
 D=$(
 	(cd "$dir" && git-init-db && pwd)
 ) &&
---
0.99.9.GIT
