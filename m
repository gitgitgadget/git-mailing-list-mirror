From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-Xlib: use git-rev-parse to locate .git dir and set relpath
Date: Sun, 27 Nov 2005 16:55:21 +0100
Message-ID: <20051127155521.GA9558@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 16:57:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgOtQ-0006D8-Sd
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 16:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVK0PzY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 10:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVK0PzY
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 10:55:24 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:26590 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1751098AbVK0PzY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 10:55:24 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 0140F6DFFDE; Sun, 27 Nov 2005 16:54:41 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id C0D046DFFD5; Sun, 27 Nov 2005 16:54:41 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id B95766145C; Sun, 27 Nov 2005 16:55:22 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12813>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
diff --git a/cg-Xlib b/cg-Xlib
index dedbb62..e3c365f 100755
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -502,16 +502,10 @@ fi
 
 _git=${GIT_DIR:-.git}
 if [ ! "$_git_repo_unneeded" ] && [ ! "$GIT_DIR" ] && [ ! -d $_git ]; then
-	rootpath=.
-	# while not /
-	while [ ! -d $rootpath/.git ] && [ "$(stat -c %i $rootpath)" != "$(stat -c %i $rootpath/..)" ]; do
-		rootpath=../$rootpath
-	done
-	if [ -d $rootpath/.git ]; then
-		mainpath="$(echo "$(pwd)/$rootpath" | normpath)"
-		_git_relpath=$(pwd)/
-		export _git_relpath=${_git_relpath:$((${#mainpath}+1))}
-		cd "$rootpath"
+	_git_abs_path="$(git-rev-parse --git-dir 2>/dev/null)"
+	if [ -d "$_git_abs_path" ]; then
+		export _git_relpath="$(git-rev-parse --show-prefix)"
+		cd "$_git_abs_path/.."
 	fi
 fi
 _git_objects="${GIT_OBJECT_DIRECTORY:-$_git/objects}"

-- 
Jonas Fonseca
