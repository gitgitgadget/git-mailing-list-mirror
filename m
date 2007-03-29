From: Francis Daly <francis@daoine.org>
Subject: [PATCH] git-quiltimport /bin/sh-ism fix
Date: Thu, 29 Mar 2007 22:38:20 +0100
Message-ID: <20070329213820.GY24561@craic.sysops.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 00:27:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX35p-00076y-WF
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 00:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422650AbXC2W1i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 18:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422651AbXC2W1i
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 18:27:38 -0400
Received: from craic.sysops.org ([217.75.2.2]:51020 "EHLO craic.sysops.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422650AbXC2W1i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 18:27:38 -0400
X-Greylist: delayed 2949 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Mar 2007 18:27:37 EDT
Received: from craic.sysops.org (craic.sysops.org [127.0.0.1])
	by craic.sysops.org (8.13.1/8.12.11) with SMTP id l2TLcKU1006110
	for <git@vger.kernel.org>; Thu, 29 Mar 2007 22:38:21 +0100
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: ClamAV 0.88/2958/Thu Mar 29 01:52:27 2007 on craic.sysops.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.4 required=2.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.1.7
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on craic.sysops.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43483>


Bryan Wu reported
/usr/local/bin/git-quiltimport: 114: Syntax error: Missing '))'

Most bourne-ish shells I have here accept
 x=$((echo x)|cat)
but all bourne-ish shells I have here accept
 x=$( (echo x)|cat)
because $(( might mean arithmetic expansion.

Signed-off-by: Francis Daly <francis@daoine.org>
---
 git-quiltimport.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 08ac9bb..edccd82 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -115,7 +115,7 @@ for patch_name in $(cat "$QUILT_PATCHES/series" | grep -v '^#'); do
 	if [ -z "$dry_run" ] ; then
 		git-apply --index -C1 "$tmp_patch" &&
 		tree=$(git-write-tree) &&
-		commit=$((echo "$SUBJECT"; echo; cat "$tmp_msg") | git-commit-tree $tree -p $commit) &&
+		commit=$( (echo "$SUBJECT"; echo; cat "$tmp_msg") | git-commit-tree $tree -p $commit) &&
 		git-update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
 	fi
 done
-- 
1.5.1.rc3-dirty
