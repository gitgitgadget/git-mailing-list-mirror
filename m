From: David Aguilar <davvid@gmail.com>
Subject: [PATCH (resend) 2/2] difftool: put the cursor on the editable file for Vim
Date: Sun, 18 Jan 2009 21:34:29 -0800
Message-ID: <1232343269-27665-1-git-send-email-davvid@gmail.com>
Cc: gitster@pobox.com, David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 06:35:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOmn9-00046R-5e
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 06:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755454AbZASFdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 00:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755426AbZASFdx
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 00:33:53 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:33478 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbZASFdw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 00:33:52 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2464845rvb.1
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 21:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=X/2xqRD0KHQR9Flb6CG5eLi8jaYRyxZ2q0FOHBr17M8=;
        b=ubjNvhWwm/Tje7mi1HuKOnCPtO37SxC/92UDrk4imMUnMHQZuzst/4cgamhbvk9Q0r
         H0EKRBmT53qJlcktZnTJr7/6pygmcek8lY0FdcVLeCoDe9pGSCEdldBhXXbXt7z+XL2e
         A/TQ//1skDxb4NaKgb8w9NRG5P8/9ZU3OM1fk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=VIbpBrh6ScE66fXqsuKmOwQH3m6DsJ/zMLWwZ9qa1Zr7uUsLyVlMwKEs82XRDFSLj8
         kidMDiCnxCBDWL3/5J+5FaPUnbS93FhzfDz10tyO70b8kOCWxlnYb04y52pYtox35vlI
         qFG8SICjR+Ej1j/jG4B15jYPbzyZb8Orum6ZE=
Received: by 10.140.139.6 with SMTP id m6mr2633795rvd.234.1232343231995;
        Sun, 18 Jan 2009 21:33:51 -0800 (PST)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id l31sm9206450rvb.2.2009.01.18.21.33.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Jan 2009 21:33:46 -0800 (PST)
X-Mailer: git-send-email 1.6.1.149.g7bbd8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106325>

You only need to edit worktree files when comparing against
the worktree.  Put the cursor automatically into its window for
vimdiff and gvimdiff to avoid doing <C-w>l every time.

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
+		"$merge_tool_path" -c "wincmd l" "$LOCAL" "$REMOTE"
+		;;
+
 	gvimdiff)
-		"$merge_tool_path" -f "$LOCAL" "$REMOTE"
+		"$merge_tool_path" -c "wincmd l" -f "$LOCAL" "$REMOTE"
 		;;
 
 	xxdiff)
-- 
1.6.1.149.g7bbd8
