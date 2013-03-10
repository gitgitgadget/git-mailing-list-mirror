From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 05/23] contrib/subtree: Add commands pull_all and push_all
Date: Sun, 10 Mar 2013 23:41:13 +0000
Message-ID: <1362958891-26941-6-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>, bibendi <bibendi@bk.ru>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Peter Jaros" <pjaros@pivotallabs.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"Win Treese" <treese@acm.org>, "Wayne Walter" <wayne@tickzoom.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:44:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpum-0003xN-A4
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328Ab3CJXoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:44:00 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:38862 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab3CJXoA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:44:00 -0400
Received: by mail-wg0-f50.google.com with SMTP id es5so4274362wgb.17
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=l5XWnZWE24C2M4uiwz6JLdDtX9a/UT7Pe7MtMb4IOXs=;
        b=FAzPSf+URhuFQuzcJexO1UjIKEGujzO+NZgcY9HW8DPhoYq2MoDmKcRtz9AiEqlePf
         JRXhnDA3RCDFaJS2SgSyAjVd9xMBn4WlnnBZvoWZBqEF5EpZk1oy3kUfWtyimfDP173M
         ADQXj3ZKYScNSuDc3hWKmP/3SdYTptvmT1Ar1Ou5QFTFdk7+6mX1JRoaK+JLWCJ2wdRF
         5JZ2V30reMd/AajRAZcpNBnpR0R1qXNMTUzhFphFIraBBGZ/4R3Ru7NW/M5Y/fEUFn1I
         W1RcyPRzNJjurh1YJTHdoB5tcui6nuSth26YA4Oi0C5DLjpBJFcG8xu2rBlF3enFI2hl
         Kr1Q==
X-Received: by 10.194.63.240 with SMTP id j16mr15571536wjs.45.1362959038754;
        Sun, 10 Mar 2013 16:43:58 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.43.48
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:43:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQltRQf3rcjY8x+n9gFquKFnUDMO13pKmj0zBx4RL0JAWfhVkO8HcCImpBfui1jfGUIYn4NF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217825>

From: bibendi <bibendi@bk.ru>

For each subtree listed in .gittrees perform a push or a pull.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>

Conflicts:
	contrib/subtree/git-subtree.sh
---
 contrib/subtree/git-subtree.sh | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 1aff956..ddae56e 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -12,6 +12,7 @@ git subtree add   --prefix=<prefix> <commit>
 git subtree add   --prefix=<prefix> <repository> <commit>
 git subtree merge --prefix=<prefix> <commit>
 git subtree pull  --prefix=<prefix> <repository> <refspec...>
+git subtree pull_all
 git subtree push  --prefix=<prefix> <repository> <refspec...>
 git subtree split --prefix=<prefix> <commit...>
 git subtree from-submodule --prefix=<prefix>
@@ -102,16 +103,18 @@ done
 command="$1"
 shift
 case "$command" in
-	add|merge|pull|from-submodule) default= ;;
+	add|merge|pull|from-submodule|pull_all|push_all) default= ;;
 	split|push) default="--default HEAD" ;;
 	*) die "Unknown command '$command'" ;;
 esac
 
-if [ -z "$prefix" ]; then
+if [ -z "$prefix" -a "$command" != "pull_all" -a "$command" != "push_all" ]; then
 	die "You must provide the --prefix option."
 fi
 
 case "$command" in
+    pull_all);;
+    push_all);;
 	add) [ -e "$prefix" ] && 
 		die "prefix '$prefix' already exists." ;;
 	*)   [ -e "$prefix" ] || 
@@ -120,7 +123,7 @@ esac
 
 dir="$(dirname "$prefix/.")"
 
-if [ "$command" != "pull" -a "$command" != "add" -a "$command" != "push" ]; then
+if [ "$command" != "pull" -a "$command" != "add" -a "$command" != "push" -a "$command" != "pull_all" ]; then
 	revs=$(git rev-parse $default --revs-only "$@") || exit $?
 	dirs="$(git rev-parse --no-revs --no-flags "$@")" || exit $?
 	if [ -n "$dirs" ]; then
@@ -767,4 +770,20 @@ cmd_from-submodule()
 	rm -rf $tmp_repo
 }
 
+cmd_pull_all()
+{
+    git config -f .gittrees -l | grep subtree | grep path | grep -o '=.*' | grep -o '[^=].*' |
+        while read path; do
+            git subtree pull -P $path master || exit $?
+        done
+}
+
+cmd_push_all()
+{
+    git config -f .gittrees -l | grep subtree | grep path | grep -o '=.*' | grep -o '[^=].*' |
+        while read path; do
+            git subtree push -P $path master || exit $?
+        done
+}
+
 "cmd_$command" "$@"
-- 
1.8.2.rc1
