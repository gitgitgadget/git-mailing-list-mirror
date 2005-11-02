From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH][Cogito] Let cg-push default to git+ssh on a host:path syntax
Date: Wed, 2 Nov 2005 22:27:26 +0100
Message-ID: <200511022227.26323.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 22:22:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXQ3d-00055Z-BY
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 22:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbVKBVWG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 16:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965253AbVKBVWG
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 16:22:06 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:56513 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S965249AbVKBVWF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2005 16:22:05 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 465F827BB;
	Wed,  2 Nov 2005 22:22:04 +0100 (MET)
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.8.2
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11044>

Let cg-push default to git+ssh on a host:path syntax

cg-update/cg-fetch fall back to git+ssh protocol for host:path
syntax. cg-push should do the same.

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
---

 cg-push |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

applies-to: 9294c00b9e87de048c0d29f8ad99c0a6d2733b16
1f6693e09a8aa4c02297472764b972a07d1c0d02
diff --git a/cg-push b/cg-push
index 4c29b33..d63fb65 100755
--- a/cg-push
+++ b/cg-push
@@ -51,8 +51,12 @@ if echo "$uri" | grep -q "^http://"; the
 	die "pushing over HTTP not supported yet"
 elif echo "$uri" | grep -q "^git+ssh://"; then
 	git-send-pack "$(echo "$uri" | sed 's#^git+ssh://\([^/]*\)\(/.*\)$#\1:\2#')" $_git_head$sprembranch "${tags[@]}"
+elif echo "$uri" | grep -q "^rsync://"; then
+        die "pushing over rsync not supported"
 elif echo "$uri" | grep -q ":"; then
-	die "pushing over rsync not supported"
+	echo "WARNING: I guessed the host:path syntax was used and fell back to the git+ssh protocol."
+	echo "WARNING: The host:path syntax is evil because it is implicit. Please just use a URI."
+	git-send-pack "$uri" $_git_head$sprembranch "${tags[@]}"
 else
 	remgit="$uri"; [ -d "$remgit/.git" ] && remgit="$remgit/.git"
 	if is_same_repo "$_git_objects" "$remgit/objects"; then
---
0.99.9
