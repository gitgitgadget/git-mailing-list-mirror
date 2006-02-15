From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] More useful/hinting error messages in git-checkout
Date: Wed, 15 Feb 2006 20:22:11 +0100
Message-ID: <200602152022.11162.Josef.Weidendorfer@gmx.de>
References: <43F20532.5000609@iaglans.de> <200602142317.29626.Josef.Weidendorfer@gmx.de> <7v3bilr2zr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 20:23:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9SEG-0004wo-Tv
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 20:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWBOTWR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 14:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWBOTWR
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 14:22:17 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:9098 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S932167AbWBOTWR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 14:22:17 -0500
Received: from dhcp-3s-57.lrr.in.tum.de (dhcp-3s-57.lrr.in.tum.de [131.159.35.57])
	by mail.in.tum.de (Postfix) with ESMTP id 3DAB32394;
	Wed, 15 Feb 2006 20:22:11 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.1
In-Reply-To: <7v3bilr2zr.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16252>


Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
---

On Tuesday 14 February 2006 23:26, you wrote:
>
> 	$ git checkout -b test v2.6.10
> 
> The user wanted to create a new branch test based on tag
> v2.6.10, alas that tag does not exist.  We give quite confusing
> error message because we are confused that the user meant to
> checkout only "./v2.6.10" file and that operation and switching
> branches are incompatible.

Does this patch clarify the error condition?

Josef


 git-checkout.sh |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

d15e024c0bd07a2f0dad6e2729e2681df374c8e6
diff --git a/git-checkout.sh b/git-checkout.sh
index 6a87c71..b7d892d 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -22,7 +22,7 @@ while [ "$#" != "0" ]; do
 		[ -e "$GIT_DIR/refs/heads/$newbranch" ] &&
 			die "git checkout: branch $newbranch already exists"
 		git-check-ref-format "heads/$newbranch" ||
-			die "we do not like '$newbranch' as a branch name."
+			die "git checkout: we do not like '$newbranch' as a branch name."
 		;;
 	"-f")
 		force=1
@@ -75,9 +75,15 @@ done
 
 if test "$#" -ge 1
 then
+	hint=
+	if test "$#" -eq 1
+	then
+		hint="
+Did you intend to checkout '$@' which can not be resolved as commit?"
+	fi
 	if test '' != "$newbranch$force$merge"
 	then
-		die "updating paths and switching branches or forcing are incompatible."
+		die "git checkout: updating paths is incompatible with switching branches/forcing$hint"
 	fi
 	if test '' != "$new"
 	then
@@ -117,7 +123,8 @@ fi
 
 [ -z "$branch$newbranch" ] &&
 	[ "$new" != "$old" ] &&
-	die "git checkout: you need to specify a new branch name"
+	die "git checkout: to checkout the requested commit you need to specify 
+              a name for a new branch which is created and switched to"
 
 if [ "$force" ]
 then
-- 
1.2.0.g719b
