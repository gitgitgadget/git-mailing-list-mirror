From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 04/14] difftool: remove merge options for opendiff, tkdiff, kdiff3 and xxdiff
Date: Mon,  6 Apr 2009 01:31:19 -0700
Message-ID: <1239006689-14695-5-git-send-email-davvid@gmail.com>
References: <1239006689-14695-1-git-send-email-davvid@gmail.com>
 <1239006689-14695-2-git-send-email-davvid@gmail.com>
 <1239006689-14695-3-git-send-email-davvid@gmail.com>
 <1239006689-14695-4-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, charles@hashpling.org,
	markus.heidelberg@web.de, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 06 10:35:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqkIF-0002l9-Ej
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 10:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630AbZDFIb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 04:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754350AbZDFIb5
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 04:31:57 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:11551 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194AbZDFIby (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 04:31:54 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2100137rvb.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 01:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Pu/ypACI1BCeolHTzxTgaYYI+6FOI4b6siVDIOP8lZw=;
        b=jBukjbCQu7WfqEt08DPWdE77EAV1OkajhtmT7rn8HyOo4pgo1MzGqvxY6Yy8QGRzxZ
         uh1BeERq3eanJ7u1vfHwRG1juFJ0XB4bykEHEzZd+x1RmnzPTW70AeYI/R9TnQK5wYwv
         hSwOI0xXFjjsAnD6k17PTlZqIq7eCXowLnSgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iMuo/+6mDranYnIsidYJTP3R8Dw7Ru1FLAlAhXbBcmGoemekfEowK4C/dVJHhfd5ie
         K2RGUeS8R0nY7udoJ+auQcvKBNyJEBa00CGoV8azhrXC/6wQceuGuYfFiMtSRihtdxy8
         e9T/ui/ttGbRe3xM/aaIrBV6gYG7Y2jouTEgo=
Received: by 10.115.110.15 with SMTP id n15mr2152069wam.144.1239006711704;
        Mon, 06 Apr 2009 01:31:51 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m17sm5206042waf.66.2009.04.06.01.31.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Apr 2009 01:31:51 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.414.g81aa9
In-Reply-To: <1239006689-14695-4-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115787>

We shouldn't try to merge files when using difftool, so remove
any merge-specific options.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/difftool/git-difftool-helper |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/contrib/difftool/git-difftool-helper b/contrib/difftool/git-difftool-helper
index e481913..ef684b6 100755
--- a/contrib/difftool/git-difftool-helper
+++ b/contrib/difftool/git-difftool-helper
@@ -69,7 +69,7 @@ launch_merge_tool () {
 		"$merge_tool_path" --auto \
 			--L1 "$basename (A)" \
 			--L2 "$basename (B)" \
-			-o "$MERGED" "$LOCAL" "$REMOTE" \
+			"$LOCAL" "$REMOTE" \
 			> /dev/null 2>&1
 		;;
 
@@ -78,7 +78,7 @@ launch_merge_tool () {
 		;;
 
 	tkdiff)
-		"$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"
+		"$merge_tool_path" "$LOCAL" "$REMOTE"
 		;;
 
 	meld)
@@ -95,17 +95,13 @@ launch_merge_tool () {
 
 	xxdiff)
 		"$merge_tool_path" \
-			-X \
-			-R 'Accel.SaveAsMerged: "Ctrl-S"' \
 			-R 'Accel.Search: "Ctrl+F"' \
 			-R 'Accel.SearchForward: "Ctrl-G"' \
-			--merged-file "$MERGED" \
 			"$LOCAL" "$REMOTE"
 		;;
 
 	opendiff)
-		"$merge_tool_path" "$LOCAL" "$REMOTE" \
-			-merge "$MERGED" | cat
+		"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
 		;;
 
 	ecmerge)
-- 
1.6.2.2.414.g81aa9
