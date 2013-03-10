From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 20/23] contrib/subtree: Teach push to use --force option
Date: Sun, 10 Mar 2013 23:41:28 +0000
Message-ID: <1362958891-26941-21-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>, James Roper <jroper@vz.net>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Matt Hoffman" <matt.hoffman@quantumretail.com>,
	"Michael Hart" <michael@adslot.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"Jakub Suder" <jakub.suder@gmail.com>,
	"John Yani" <vanuan@gmail.com>, "Wayne Walter" <wayne@tickzoom.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:46:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpwF-0005GC-60
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455Ab3CJXp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:45:29 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:35395 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249Ab3CJXp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:45:28 -0400
Received: by mail-wg0-f51.google.com with SMTP id 8so4262500wgl.18
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=sAV3kTe4q/eIwlTjkXjn1XC2qGo/tXxCsnsMlvNHhEw=;
        b=nWytRlun9iX/toyCzxwa4JvXFMuxIFzG5RnclYWpUYobLLNAe6m+rfNKFgEX/whLlu
         gTI8pgqDKND0Kkq5Rclyj80VghB1nZ3IBSngH6gO0t0i+WKkNxUEWBsA3u5AS/1Y8ILF
         5ekGGZfZCylHf9/I6tLKwZuvpc86x/59Y+DY96tTC3uFnA/jMYP2KVgWc6FIQmS1zp9P
         5/dl7uPi1s5spk45Kn1N5kSv1rBV7RDBBXeYxk28ZaEKmmORr+bGzERuPBrdERMUsbbp
         kneyQni3sAgqvBUfWEzXHTeSj5av6Dk/Stf7eNtYz99QClIxH4INadd1s8h6YiPTcxOZ
         8BMw==
X-Received: by 10.180.185.43 with SMTP id ez11mr9185783wic.28.1362959127227;
        Sun, 10 Mar 2013 16:45:27 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.45.22
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:45:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQngJ9WhUE5mRjCip8CQkIhDPCyCXuxSXNaslQeGbDheVxxuRKBTC3X5NbH4K7VbSedOQpq7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217840>

From: James Roper <jroper@vz.net>

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>

Conflicts:
	contrib/subtree/git-subtree.sh

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh  | 9 ++++++++-
 contrib/subtree/git-subtree.txt | 5 +++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 4605203..3582a55 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -32,6 +32,8 @@ b,branch=     create a new branch from the split subtree
 ignore-joins  ignore prior --rejoin commits
 onto=         try connecting new tree to an existing one
 rejoin        merge the new branch back into HEAD
+ options for 'push'
+f,force       use force push
  options for 'add', 'merge', 'pull' and 'push'
 squash        merge subtree changes as a single commit
 "
@@ -90,6 +92,7 @@ while [ $# -gt 0 ]; do
 		-b) branch="$1"; shift ;;
 		-P) prefix="$1"; shift ;;
 		-m) message="$1"; shift ;;
+        -f|--force) force=1 ;;
 		--no-prefix) prefix= ;;
 		--onto) onto="$1"; shift ;;
 		--no-onto) onto= ;;
@@ -790,10 +793,14 @@ cmd_push()
 	      repository=$(git config -f .gittrees subtree.$prefix.url)
         refspec=$(git config -f .gittrees subtree.$prefix.branch)
       fi
+        push_opts=
+        if [ "$force" == "1" ]; then 
+            push_opts="$push_opts --force"
+        fi
 	    echo "git push using: " $repository $refspec
 	    rev=$(git subtree split --prefix=$prefix)
 	    if [ -n "$rev" ]; then
-	        git push $repository $rev:refs/heads/$refspec
+	        git push $push_opts $repository $rev:refs/heads/$refspec
 	    else
 	        die "Couldn't push, 'git subtree split' failed."
 	    fi
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 385bde8..9e9eb9e 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -278,6 +278,11 @@ OPTIONS FOR split
 	'--rejoin' when you split, because you don't want the
 	subproject's history to be part of your project anyway.
 
+OPTIONS FOR push
+----------------
+-f::
+--force::
+    Uses 'git push --force'.
 
 EXAMPLE 1. Add command
 ----------------------
-- 
1.8.2.rc1
