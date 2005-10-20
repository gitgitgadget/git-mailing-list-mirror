From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cg-fetch will now retrieve commits related to tags if missing.
Date: Thu, 20 Oct 2005 13:55:45 +1300
Message-ID: <1129769745158-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Oct 20 02:53:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESOgC-0003y5-RL
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 02:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbVJTAxH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 20:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbVJTAxH
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 20:53:07 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:46025 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751671AbVJTAxF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 20:53:05 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1ESOfw-0005b6-Ck; Thu, 20 Oct 2005 13:52:56 +1300
Received: from mltest ([127.0.0.1])
	by mltest with smtp (Exim 3.36 #1 (Debian))
	id 1ESOif-0001rN-00; Thu, 20 Oct 2005 13:55:45 +1300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10331>

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 cg-fetch |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

applies-to: 38ed7981343a8e2bb734d64e019186a8a482dbef
48cb643964910a058881307513cb63aeee28a1de
diff --git a/cg-fetch b/cg-fetch
index 7694584..d4650e5 100755
--- a/cg-fetch
+++ b/cg-fetch
@@ -417,7 +417,8 @@ $get -i -s -u -d "$uri/refs/tags" "$_git
 	for tag in *; do
 		[ "$tag" = "*" ] && break
 		tagid=$(cat $tag)
-		GIT_DIR=../.. git-cat-file -t "$tagid" >/dev/null 2>&1 && continue
+		GIT_DIR=../.. [ "`git-cat-file -t $tagid 2>/dev/null`" = "commit" ] && continue
+		GIT_DIR=../.. git-cat-file commit `git-rev-parse $tag^{commit}  2>/dev/null` 2>&1 >> /dev/null && continue
 		echo -n "Missing object of tag $tag... "
 		if [ "$fetch" != "fetch_rsync" ] && GIT_DIR=../.. $fetch "$tagid" "$uri" 2>/dev/null >&2; then
 			echo "retrieved"
---
0.99.8.GIT
