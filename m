From: Carl Worth <cworth@cworth.org>
Subject: [PATCH 1/3] Trap exit to clean up created directory if clone fails.
Date: Fri, 17 Feb 2006 13:33:24 -0800
Message-ID: <11402120042011-git-send-email-cworth@cworth.org>
References: <11402120031687-git-send-email-cworth@cworth.org>
Reply-To: Carl Worth <cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Fri Feb 17 22:34:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FADFC-0002yM-Jx
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 22:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030650AbWBQVeX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 16:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWBQVeX
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 16:34:23 -0500
Received: from theworths.org ([217.160.253.102]:31190 "EHLO theworths.org")
	by vger.kernel.org with ESMTP id S1751437AbWBQVeW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Feb 2006 16:34:22 -0500
Received: (qmail 15637 invoked from network); 17 Feb 2006 16:34:21 -0500
Received: from localhost (HELO raht) (127.0.0.1)
  by localhost with SMTP; 17 Feb 2006 16:34:21 -0500
In-Reply-To: <11402120031687-git-send-email-cworth@cworth.org>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16367>

Signed-off-by: Carl Worth <cworth@cworth.org>


---

 git-clone.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

589b68168e3dad89238b879b06680c662a99ad8d
diff --git a/git-clone.sh b/git-clone.sh
index e192b08..d184ceb 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -118,6 +118,7 @@ dir="$2"
 [ -e "$dir" ] && echo "$dir already exists." && usage
 mkdir -p "$dir" &&
 D=$(cd "$dir" && pwd) &&
+trap 'err=$?; rm -r $D; exit $err' exit
 case "$bare" in
 yes) GIT_DIR="$D" ;;
 *) GIT_DIR="$D/.git" ;;
@@ -255,3 +256,6 @@ Pull: $head_points_at:$origin" &&
 		git checkout
 	esac
 fi
+
+trap - exit
+
-- 
1.2.0.gf6e8
