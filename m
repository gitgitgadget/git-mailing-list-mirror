From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 02/14] git-mergetool/difftool: make (g)vimdiff workable under Windows
Date: Mon,  6 Apr 2009 01:31:17 -0700
Message-ID: <1239006689-14695-3-git-send-email-davvid@gmail.com>
References: <1239006689-14695-1-git-send-email-davvid@gmail.com>
 <1239006689-14695-2-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, charles@hashpling.org,
	markus.heidelberg@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 06 10:34:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqkID-0002l9-Vh
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 10:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230AbZDFIbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 04:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753884AbZDFIbw
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 04:31:52 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:12597 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbZDFIbu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 04:31:50 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1642070wah.21
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 01:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Pf3SLg5LwLsXBZ3RwlpjY8rK/ygL4SwnkwjgJglUFv8=;
        b=owxpbLIZ210Qu9D+9XelVI54HJHZAL+sO1DOAi92fhBaX7x6H1vveAwBLq9kKZsoYi
         tL7Y7mnG2ap506qPQAbv4GC1pu91dHwrSByjVOyzTW/eJRVsTgDSaQEjxBXAVW7XaWXz
         TVpPox+2UZ4F4yUWkBsQ3Gwll5rnm2M4JoPk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Z3F7OY57dN5aRwgrvWIXzvw9nX9hflC9EgI7OrSqs9zxfhdNiEoD3wWfFaNbg9/Cst
         SlYGE3Egv1SJ/ajxhn1yRsf9OWyAc0I8nmSRQh2bc091pymx5t83zL1PaI72IOx90ePW
         QSZ4W087MyIEx2Xrmca6kF22CXfzNDlV8fUPo=
Received: by 10.114.148.2 with SMTP id v2mr2143736wad.169.1239006708381;
        Mon, 06 Apr 2009 01:31:48 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id v25sm5173676wah.16.2009.04.06.01.31.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Apr 2009 01:31:48 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.414.g81aa9
In-Reply-To: <1239006689-14695-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115781>

From: Markus Heidelberg <markus.heidelberg@web.de>

Under Windows vimdiff and gvimdiff are not available as symbolic links,
but as batch files vimdiff.bat and gvimdiff.bat. These files weren't
found by 'type vimdiff' which led to the following error:

    The merge tool vimdiff is not available as 'vimdiff'

Even if they were found, it wouldn't work to invoke these batch files
from git-mergetool.

To solve this, use vim and gvim (vim.exe and gvim.exe) and pass the -d
command line switch over to them.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 contrib/difftool/git-difftool-helper |   10 ++++++++--
 git-mergetool.sh                     |   10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/contrib/difftool/git-difftool-helper b/contrib/difftool/git-difftool-helper
index 9c0a134..e481913 100755
--- a/contrib/difftool/git-difftool-helper
+++ b/contrib/difftool/git-difftool-helper
@@ -86,11 +86,11 @@ launch_merge_tool () {
 		;;
 
 	vimdiff)
-		"$merge_tool_path" -c "wincmd l" "$LOCAL" "$REMOTE"
+		"$merge_tool_path" -d -c "wincmd l" "$LOCAL" "$REMOTE"
 		;;
 
 	gvimdiff)
-		"$merge_tool_path" -c "wincmd l" -f "$LOCAL" "$REMOTE"
+		"$merge_tool_path" -d -c "wincmd l" -f "$LOCAL" "$REMOTE"
 		;;
 
 	xxdiff)
@@ -160,6 +160,12 @@ init_merge_tool_path() {
 	merge_tool_path=$(git config mergetool."$1".path)
 	if test -z "$merge_tool_path"; then
 		case "$1" in
+		vimdiff)
+			merge_tool_path=vim
+			;;
+		gvimdiff)
+			merge_tool_path=gvim
+			;;
 		emerge)
 			merge_tool_path=emacs
 			;;
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 87fa88a..6e611e9 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -214,12 +214,12 @@ merge_file () {
 	    ;;
 	vimdiff)
 	    touch "$BACKUP"
-	    "$merge_tool_path" -c "wincmd l" "$LOCAL" "$MERGED" "$REMOTE"
+	    "$merge_tool_path" -d -c "wincmd l" "$LOCAL" "$MERGED" "$REMOTE"
 	    check_unchanged
 	    ;;
 	gvimdiff)
 	    touch "$BACKUP"
-	    "$merge_tool_path" -c "wincmd l" -f "$LOCAL" "$MERGED" "$REMOTE"
+	    "$merge_tool_path" -d -c "wincmd l" -f "$LOCAL" "$MERGED" "$REMOTE"
 	    check_unchanged
 	    ;;
 	xxdiff)
@@ -359,6 +359,12 @@ init_merge_tool_path() {
 	merge_tool_path=`git config mergetool.$1.path`
 	if test -z "$merge_tool_path" ; then
 		case "$1" in
+			vimdiff)
+				merge_tool_path=vim
+				;;
+			gvimdiff)
+				merge_tool_path=gvim
+				;;
 			emerge)
 				merge_tool_path=emacs
 				;;
-- 
1.6.2.2.414.g81aa9
