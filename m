From: Amos Waterland <apw@us.ibm.com>
Subject: [PATCH] do not cat version file if it does not exist
Date: Fri, 3 Feb 2006 05:11:52 -0500
Message-ID: <20060203101152.GA11233@kvasir.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 11:12:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4xv5-0006aN-NC
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 11:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWBCKL4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 05:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWBCKL4
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 05:11:56 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:5821 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750935AbWBCKLz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2006 05:11:55 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k13ABs8A011212
	for <git@vger.kernel.org>; Fri, 3 Feb 2006 05:11:54 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k13AEH4L034498
	for <git@vger.kernel.org>; Fri, 3 Feb 2006 03:14:17 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k13ABr3Y029965
	for <git@vger.kernel.org>; Fri, 3 Feb 2006 03:11:54 -0700
Received: from kvasir.watson.ibm.com (kvasir.watson.ibm.com [9.2.218.19])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id k13ABrBC029946;
	Fri, 3 Feb 2006 03:11:53 -0700
Received: from apw by kvasir.watson.ibm.com with local (Exim 4.52)
	id 1F4xuy-0002wT-B6; Fri, 03 Feb 2006 05:11:52 -0500
To: junkio@cox.net
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15536>

The build process currently produces this ugly message:

 $ make
 cat: version: No such file or directory
 GIT_VERSION = 1.1.GIT
 cat: version: No such file or directory

This patch make GIT-VERSION-GEN check that a file named `version' exists
before trying to cat it.

Signed-off-by: Amos Waterland <apw@us.ibm.com>

---

 GIT-VERSION-GEN |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

applies-to: 2b022b9b34b375afff456e7527a3d89a56ce8abf
eff0a8f6c905b3112538f30fb5a9ce09d4e18e72
diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 72201be..fbaa397 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -7,8 +7,10 @@ DEF_VER=v1.1.GIT
 # (included in release tarballs), then default
 if VN=$(git-describe --abbrev=4 HEAD 2>/dev/null); then
 	VN=$(echo "$VN" | sed -e 's/-/./g');
+elif test -f version; then
+	VN=$(cat version);
 else
-	VN=$(cat version) || VN="$DEF_VER"
+	VN="$DEF_VER";
 fi
 
 VN=$(expr "$VN" : v*'\(.*\)')
---
0.99.9.GIT
