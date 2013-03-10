From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 11/23] contrib/subtree: Add command list
Date: Sun, 10 Mar 2013 23:41:19 +0000
Message-ID: <1362958891-26941-12-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Matt Hoffman <matt.hoffman@quantumretail.com>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Peter Jaros" <pjaros@pivotallabs.com>,
	"Avery Pennarun" <apenwarr@gmail.com>, "bibendi" <bibendi@bk.ru>,
	"Win Treese" <treese@acm.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:45:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpvQ-0004VR-Rx
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445Ab3CJXom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:44:42 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:45565 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab3CJXol (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:44:41 -0400
Received: by mail-wi0-f171.google.com with SMTP id hn17so608065wib.10
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=aVkTv9LtQ7KACj7VBiuaLkRx5Kp6tKsBTgRstvabyEg=;
        b=bWrp9VezAXa9w0kIdaDT2KXxrfYKDG0VLHZQQlwu2H7pOXL2PR/iprrWkRoZszBS5r
         chw2xwmzeHhyURp+ZvWK9aNP/+yo/ur+9JDtkRhucOs68mawGbIRTadH78KlBJOA2iRv
         8Pr/1nY38IQc0IUx2hXBlrFoo+3bsHfZzkbPKHayzLHkk0TQX/oVQSSXcfNCGwWnsnFk
         AB1yyJ/Thicgy8e4VBwa7lkMochJsWCw2EX3mW29rTAyNZL+2Cu81mR1V9WzEdXakycD
         /xDO2Vot5C7uDCQzRjm6eo780YsU0+FpthH4jTVoKTNt4Rthav8idRlJtz4zcbTNcvlw
         irXw==
X-Received: by 10.180.74.131 with SMTP id t3mr9130524wiv.23.1362959080745;
        Sun, 10 Mar 2013 16:44:40 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.44.33
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:44:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQnoHl011+imlQt+Uae05rXRn0oz2yazLBjFc0bXdjFlKGE8+uL0ceWtaqOG589W1vkF6NwN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217831>

From: Matt Hoffman <matt.hoffman@quantumretail.com>

Lists subtrees from the .gittrees file.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>

Conflicts:
	git-subtree.sh
---
 contrib/subtree/git-subtree.sh | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 4c3f3c0..7d08064 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -107,10 +107,10 @@ shift
 case "$command" in
 	add|merge|pull|from-submodule|pull-all|push-all) default= ;;
 	*) die "Unknown command '$command'" ;;
-    split|push|diff) default="--default HEAD" ;;
+    split|push|diff|list) default="--default HEAD" ;;
 esac
 
-if [ -z "$prefix" -a "$command" != "pull-all" -a "$command" != "push-all" ]; then
+if [ -z "$prefix" -a "$command" != "pull-all" -a "$command" != "push-all" -a "$command" != "list" ]; then
 	die "You must provide the --prefix option."
 fi
 
@@ -824,6 +824,21 @@ cmd_from-submodule()
 	rm -rf $tmp_repo
 }
 
+subtree_list() 
+{
+    git config -f .gittrees -l | grep subtree | grep path | grep -o '=.*' | grep -o '[^=].*' |
+    while read path; do 
+        repository=$(git config -f .gittrees subtree.$path.url)
+        refspec=$(git config -f .gittrees subtree.$path.branch)
+        echo "    $path        (merged from $repository branch $refspec) "
+    done
+}
+
+cmd_list()
+{
+  subtree_list 
+}
+
 cmd_pull-all()
 {
     git config -f .gittrees -l | grep subtree | grep path | grep -o '=.*' | grep -o '[^=].*' |
-- 
1.8.2.rc1
