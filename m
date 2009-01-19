From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/2] difftool: put the cursor on the editable file for Vim
Date: Sun, 18 Jan 2009 21:27:20 -0800
Message-ID: <1232342840-27459-2-git-send-email-davvid@gmail.com>
References: <1232342840-27459-1-git-send-email-davvid@gmail.com>
Cc: gitster@pobox.com, David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 06:28:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOmg9-0002s4-Qg
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 06:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755069AbZASF0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 00:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754912AbZASF0l
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 00:26:41 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:34302 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbZASF0j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 00:26:39 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2463014rvb.1
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 21:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=NfcJOd9qqRQSLBU9N8ClecrcqEdpJemXV2DCu+bKHyo=;
        b=p7HXGWG3X73F8rhQ2Bgdn2ecYRDgoZ60dGuwLxhA1s3vB15eH1qTyiob8Fa+XWuy7V
         aFYmHUoFJDaOYZy8JF7WsjQF9ai6rjFdM0zLRClnM05pHfJq6bMoL2z3gojnOhtDL30l
         YUay35i6e3zFc9od7GKFantWbSCEvV7KCn4yU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AXjQdmGyIE2jcmuJjm7W05FT6sf4tXPT3xzS93GJ7QPtb2Z69U21JXryuHt8RCzuso
         d6HVXWgTrVH2OKHLGMzxBJegC8aAQUj+Bc9j0uNitxF6LXYIuQG8bVwaeUq1SifDt+OL
         7ZhqnhU+hnmnSV3QJ0xrjT3f71JXUxXe1KEfM=
Received: by 10.141.62.7 with SMTP id p7mr743112rvk.113.1232342799518;
        Sun, 18 Jan 2009 21:26:39 -0800 (PST)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id b39sm4054995rvf.0.2009.01.18.21.26.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Jan 2009 21:26:38 -0800 (PST)
X-Mailer: git-send-email 1.6.1.149.g7bbd8
In-Reply-To: <1232342840-27459-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106323>

You only need to edit worktree files when comparing against
the worktree.  Put the cursor automatically into its window for
vimdiff and gvimdiff to avoid doing <C-w>r every time.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/difftool/git-difftool-helper |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/difftool/git-difftool-helper b/contrib/difftool/git-difftool-helper
index 0b266e3..a6f862f 100755
--- a/contrib/difftool/git-difftool-helper
+++ b/contrib/difftool/git-difftool-helper
@@ -78,12 +78,16 @@ launch_merge_tool () {
 		"$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"
 		;;
 
-	meld|vimdiff)
+	meld)
 		"$merge_tool_path" "$LOCAL" "$REMOTE"
 		;;
 
+	vimdiff)
+		"$merge_tool_path" -c "wincmd r" "$LOCAL" "$REMOTE"
+		;;
+
 	gvimdiff)
-		"$merge_tool_path" -f "$LOCAL" "$REMOTE"
+		"$merge_tool_path" -c "wincmd r" -f "$LOCAL" "$REMOTE"
 		;;
 
 	xxdiff)
-- 
1.6.1.149.g7bbd8
