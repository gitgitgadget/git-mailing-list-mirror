From: Mathias Lafledt <misfire@debugon.org>
Subject: [PATCH] GIT-VERSION-GEN: make use of git describe --dirty
Date: Thu, 14 Oct 2010 18:17:46 +0200
Message-ID: <4CB72D2A.7050601@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 14 18:17:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6QVB-00056N-5T
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 18:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364Ab0JNQRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 12:17:51 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:53790 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab0JNQRu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 12:17:50 -0400
Received: from [192.168.2.102] (dslb-088-070-157-236.pools.arcor-ip.net [88.70.157.236])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MLCD7-1P69Nq3zsH-0003UN; Thu, 14 Oct 2010 18:17:49 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100915 Thunderbird/3.0.8
X-Provags-ID: V02:K0:6JZL/IqJejuC9H4HfgSs6mtpRGEYm6QVdd1Dxl3Go2T
 nLe7F4txTR3G4ShJyE25ch811jK+Iwx8+roXypA5rWnRR7hdQU
 3kAS2m7I4wal+8hpv8hfZCWHH+8KWF6vOzvFr1hsg8WFbWud/4
 U9VM+JKOI2McQFR9u8TP5pCUENxAivdEi7/JLzUFpnT5IVg3Vq
 5rUcjYjfa4+xOObTm8Ttoh80LGG7iOmETV5dJuo2J4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159052>

Currently, GIT-VERSION-GEN invokes the plumbing commands "git update-index" and
"git diff-index" to determine if the working tree is dirty. It then appends
"-dirty" to the version string returned by "git describe".

However, as of Git v1.6.6, "git describe" can be told to do all that with the
"--dirty" option, saving us the plumbing.

Signed-off-by: Mathias Lafeldt <misfire@debugon.org>
---
 GIT-VERSION-GEN |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index d441d88..73d5cf9 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -12,13 +12,10 @@ if test -f version
 then
 	VN=$(cat version) || VN="$DEF_VER"
 elif test -d .git -o -f .git &&
-	VN=$(git describe --match "v[0-9]*" --abbrev=4 HEAD 2>/dev/null) &&
+	VN=$(git describe --match "v[0-9]*" --abbrev=4 --dirty 2>/dev/null) &&
 	case "$VN" in
 	*$LF*) (exit 1) ;;
-	v[0-9]*)
-		git update-index -q --refresh
-		test -z "$(git diff-index --name-only HEAD --)" ||
-		VN="$VN-dirty" ;;
+	v[0-9]*) : ;;
 	esac
 then
 	VN=$(echo "$VN" | sed -e 's/-/./g');
-- 
1.7.3.GIT
