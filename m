From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] mergetool: put the cursor on the editable file for Vim
Date: Sat, 17 Jan 2009 22:28:45 +0100
Message-ID: <200901172228.45450.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 17 22:29:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOIji-0006p3-7E
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 22:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763908AbZAQV2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 16:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763693AbZAQV2G
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 16:28:06 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:48593 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932908AbZAQV2F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 16:28:05 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 2C92FF8FD50C;
	Sat, 17 Jan 2009 22:28:02 +0100 (CET)
Received: from [89.59.83.225] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LOIi1-0006Sc-00; Sat, 17 Jan 2009 22:28:01 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18iTzgdd6NVKIWWgItxLQo9FOdLBWmYCuFHQJBr
	2aop8a569NQFVC5K6nNwWa7jGOSst7o+kPoIoITYMjQzJGHY+k
	OrhFZlEXir1qIm0Tb0lA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106109>

When resolving conflicts, you only need to edit the $MERGED file. Put
the cursor automatically into its window for vimdiff and gvimdiff to
avoid doing <C-w>l every time.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 git-mergetool.sh |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index b2d5375..00e1337 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -200,14 +200,19 @@ merge_file () {
 	    fi
 	    status=$?
 	    ;;
-	meld|vimdiff)
+	meld)
 	    touch "$BACKUP"
 	    "$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
 	    check_unchanged
 	    ;;
+	vimdiff)
+	    touch "$BACKUP"
+	    "$merge_tool_path" -c "wincmd l" "$LOCAL" "$MERGED" "$REMOTE"
+	    check_unchanged
+	    ;;
 	gvimdiff)
 	    touch "$BACKUP"
-	    "$merge_tool_path" -f "$LOCAL" "$MERGED" "$REMOTE"
+	    "$merge_tool_path" -c "wincmd l" -f "$LOCAL" "$MERGED" "$REMOTE"
 	    check_unchanged
 	    ;;
 	xxdiff)
-- 
1.6.1.154.g97e2f
