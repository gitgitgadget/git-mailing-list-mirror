From: Mathias Lafeldt <misfire@debugon.org>
Subject: [PATCH v2] GIT-VERSION-GEN: make use of git describe --dirty
Date: Thu, 14 Oct 2010 21:45:54 +0200
Message-ID: <4CB75DF2.3050609@debugon.org>
References: <4CB72D2A.7050601@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 14 21:46:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6Tkk-0001Ne-E8
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 21:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755847Ab0JNTp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 15:45:58 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:55673 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491Ab0JNTp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 15:45:58 -0400
Received: from [192.168.2.102] (dslb-088-070-157-236.pools.arcor-ip.net [88.70.157.236])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0LzFLh-1ObUQ92mPp-014xXl; Thu, 14 Oct 2010 21:45:56 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100915 Thunderbird/3.0.8
In-Reply-To: <4CB72D2A.7050601@debugon.org>
X-Provags-ID: V02:K0:bZ65QwPtHso8NabAo8z9tSmHt6enXnmCP1PoitPGcLU
 9gLLaQLdeE5lvWSKbcpQV8J8tn5kGaGulMVbCdhjyPxtEdv5Ip
 dfmGMtPiK4Czfi5efWMM0cxv5p9ITuQEbu6MjiL32cn4dEeBYw
 z5xCfD1+p5GIxkfqQ75pUHLUVDsv51MvkpoY+gBxPC9ZFDS0Y4
 xJ43p5NY/UX03bSBcy3rPEx0fACgBk+6r0tsTJ6wE8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159067>

Currently, GIT-VERSION-GEN invokes the plumbing commands "git update-index" and
"git diff-index" to determine if the working tree is dirty. It then appends
"-dirty" to the version string returned by "git describe".

However, as of Git v1.6.6, "git describe" can be told to do all that with the
"--dirty" option, saving us the plumbing.

Signed-off-by: Mathias Lafeldt <misfire@debugon.org>
---
Corrected a typo in the "From:" field. Apart from that, the patch hasn't changed.

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
