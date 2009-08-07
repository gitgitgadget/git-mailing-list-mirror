From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 3/3] git-am: print fair error message when format detection fails
Date: Thu,  6 Aug 2009 20:08:13 -0500
Message-ID: <COrzR9ThNBy5SQ7chsXyUBcRjlQZ5mxjnQCmJLjctoPOo1ieWRAzuS-B2EZLAe3of_HNxTmt-ck@cipher.nrlssc.navy.mil>
References: <MEhvdM_GHnyaFj9ZU3lxKS47vmOk5BKslGm0FxkE_lg0SQT5Zx6KhA@cipher.nrlssc.navy.mil> <COrzR9ThNBy5SQ7chsXyUOUuBmX-VWMCz3MUVwvBOlIZzlIXRRMP6EMS7BRy_6uJvxt5H-FbtdY@cipher.nrlssc.navy.mil> <COrzR9ThNBy5SQ7chsXyUB30jVGIijxZQ3LI9L_y7Ab5vWcDcy_HolvjjuHTC7DHI9ntV-eR_v0@cipher.nrlssc.navy.mil>
Cc: ni.s@laposte.net, giuseppe.bilotta@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 07 03:09:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZDxZ-0004W5-Py
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 03:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756741AbZHGBJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 21:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752686AbZHGBJJ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 21:09:09 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33974 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017AbZHGBJH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 21:09:07 -0400
Received: by mail.nrlssc.navy.mil id n771937D024887; Thu, 6 Aug 2009 20:09:05 -0500
In-Reply-To: <COrzR9ThNBy5SQ7chsXyUB30jVGIijxZQ3LI9L_y7Ab5vWcDcy_HolvjjuHTC7DHI9ntV-eR_v0@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 07 Aug 2009 01:09:03.0469 (UTC) FILETIME=[A767F1D0:01CA16FB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125151>

From: Nicolas Sebrecht <ni.s@laposte.net>

Avoid git ending with this message:
	"Patch format  is not supported."

With improved error message in the format detection failure case by
Giuseppe Bilotta.

Signed-off-by: Nicolas Sebrecht <ni.s@laposte.net>
Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 git-am.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index dd60f5d..f719f6e 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -268,7 +268,11 @@ split_patches () {
 		msgnum=
 		;;
 	*)
-		clean_abort "Patch format $patch_format is not supported."
+		if test -n "$parse_patch" ; then
+			clean_abort "Patch format $patch_format is not supported."
+		else
+			clean_abort "Patch format detection failed."
+		fi
 		;;
 	esac
 }
-- 
1.6.4
