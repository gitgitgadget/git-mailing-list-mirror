From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add another verbosity level to git-fetch
Date: Wed, 23 May 2007 23:31:13 +0200
Message-ID: <20070523213113.GF2554@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 23 23:31:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqyQU-00005k-4U
	for gcvg-git@gmane.org; Wed, 23 May 2007 23:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195AbXEWVbW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 17:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754980AbXEWVbW
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 17:31:22 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:40828 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757968AbXEWVbV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 17:31:21 -0400
Received: from tigra.home (Fa87d.f.strato-dslnet.de [195.4.168.125])
	by post.webmailer.de (fruni mo60) (RZmta 6.7)
	with ESMTP id C003c6j4NJfCo9 ; Wed, 23 May 2007 23:31:13 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B0822277BD;
	Wed, 23 May 2007 23:31:13 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 90DC5D195; Wed, 23 May 2007 23:31:13 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTSkVo8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48177>

Use "-v -v" to run git-fetch-pack in verbose mode.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Otherwise there is no way to show connect messages for git-fetch

 git-fetch.sh |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index 0e05cf1..6d3a346 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -61,7 +61,7 @@ do
 		quiet=--quiet
 		;;
 	-v|--verbose)
-		verbose=Yes
+		verbose="$verbose"Yes
 		;;
 	-k|--k|--ke|--kee|--keep)
 		keep='-k -k'
@@ -201,8 +201,14 @@ fetch_all_at_once () {
 			echo "$ls_remote_result" | \
 				git-fetch--tool pick-rref "$rref" "-"
 		else
+			flags=
+			case $verbose in
+			YesYes*)
+			    flags="-v"
+			    ;;
+			esac
 			git-fetch-pack --thin $exec $keep $shallow_depth \
-				$quiet $no_progress "$remote" $rref ||
+				$quiet $no_progress $flags "$remote" $rref ||
 			echo failed "$remote"
 		fi
 	fi
-- 
1.5.2.58.g7a94-dirty
