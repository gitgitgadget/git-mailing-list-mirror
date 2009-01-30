From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH] Quick and dirty mergetool fix - take 2
Date: Fri, 30 Jan 2009 16:16:06 +0000
Message-ID: <1233332166-14300-1-git-send-email-charles@hashpling.org>
References: <4983241B.6020208@gmail.com>
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>
To: =?utf-8?q?Jonas=20Flod=C3=A9n?= <jonas.floden@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 17:17:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSw3p-0007rQ-ED
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 17:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbZA3QQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 11:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbZA3QQK
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 11:16:10 -0500
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:36814 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751716AbZA3QQJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2009 11:16:09 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAGa2gknUnw4S/2dsb2JhbADLEoQQBg
Received: from pih-relay05.plus.net ([212.159.14.18])
  by relay.pcl-ipout02.plus.net with ESMTP; 30 Jan 2009 16:16:08 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay05.plus.net with esmtp (Exim) id 1LSw2J-0000yv-GN; Fri, 30 Jan 2009 16:16:07 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n0UGG6Oe014336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 Jan 2009 16:16:06 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n0UGG6ex014335;
	Fri, 30 Jan 2009 16:16:06 GMT
X-Mailer: git-send-email 1.6.1.235.gc9d403
In-Reply-To: <4983241B.6020208@gmail.com>
X-Plusnet-Relay: faca663ed183926cbe8faf1ccb4f31dc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107838>

---
 git-mergetool.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index aefdca7..d495a6b 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -131,7 +131,7 @@ checkout_staged_file () {
     tmpfile=$(expr "$(git checkout-index --temp --stage="$1" "$2")" : '\([^	]*\)	')
 
     if test $? -eq 0 -a -n "$tmpfile" ; then
-	mv -- "$tmpfile" "$3"
+	mv -- "$(git rev-parse --show-cdup)$tmpfile" "$3"
     fi
 }
 
@@ -161,9 +161,9 @@ merge_file () {
     local_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}'`
     remote_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}'`
 
-    base_present   && checkout_staged_file 1 "$prefix$MERGED" "$BASE"
-    local_present  && checkout_staged_file 2 "$prefix$MERGED" "$LOCAL"
-    remote_present && checkout_staged_file 3 "$prefix$MERGED" "$REMOTE"
+    base_present   && checkout_staged_file 1 "$MERGED" "$BASE"
+    local_present  && checkout_staged_file 2 "$MERGED" "$LOCAL"
+    remote_present && checkout_staged_file 3 "$MERGED" "$REMOTE"
 
     if test -z "$local_mode" -o -z "$remote_mode"; then
 	echo "Deleted merge conflict for '$MERGED':"
-- 
1.6.1.235.gc9d403
