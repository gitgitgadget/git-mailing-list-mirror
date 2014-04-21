From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] mergetools: add vimdiff3 mode
Date: Sun, 20 Apr 2014 19:24:20 -0500
Message-ID: <1398039860-31420-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 02:35:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wc2CO-0000gA-D3
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 02:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbaDUAen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 20:34:43 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:37170 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbaDUAem (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 20:34:42 -0400
Received: by mail-yh0-f43.google.com with SMTP id b6so3045509yha.2
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 17:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Z6Y6wdoYobFiMRn62X9AI4pz+YStsW2qbn5PVmrTFIc=;
        b=FAVjMnd1M+DY9kuwpkq9KH/JZn+XPph0I7FZZIkaZXo2thpumS7MsyOydj+PX4SJbz
         D7c4fOxaFMyDqZZ4clGNiDtY3cDhkHcMtopKNpaTDvLlHz+W3ppY4DFg0Zr3K2dNlQC1
         CKFCcXpDX83VT/9vRHc70iy3z3e5/RD4J6ppKycG1ezSkA9eUq80D+HoJHBSvfc/cRj/
         wLSigQLJi2I57y4gIbV1rDkdtRe9pkqWQSvDQG5ZHqYW9AfyVocpRf5iG208uJsFGtdJ
         5+2xkiJW1C/vwWn/qSl6LiMBSq1u7jnFSqru62Nywz9UiznyfmrQ+8rBu4/74lgqTW7T
         OnTQ==
X-Received: by 10.236.79.134 with SMTP id i6mr49466772yhe.16.1398040481589;
        Sun, 20 Apr 2014 17:34:41 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c66sm66633214yhk.23.2014.04.20.17.34.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 17:34:40 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.1.g5c924db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246603>

It's similar to the default, except that the other windows are hidden.
This ensures that removed/added colors are still visible on the main
merge window, but the other windows not visible.

Specially useful with merge.conflictstyle=diff3.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

How a conflict looks:
http://felipec.org/vimdiff3-conflict.png

How it looks resolved:
http://felipec.org/vimdiff3-resolved.png

 mergetools/gvimdiff3 |  1 +
 mergetools/vimdiff   | 14 ++++++++++++--
 mergetools/vimdiff3  |  1 +
 3 files changed, 14 insertions(+), 2 deletions(-)
 create mode 100644 mergetools/gvimdiff3
 create mode 100644 mergetools/vimdiff3

diff --git a/mergetools/gvimdiff3 b/mergetools/gvimdiff3
new file mode 100644
index 0000000..04a5bb0
--- /dev/null
+++ b/mergetools/gvimdiff3
@@ -0,0 +1 @@
+. "$MERGE_TOOLS_DIR/vimdiff"
diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 39d0327..1ddfbfc 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -20,16 +20,26 @@ merge_cmd () {
 		"$merge_tool_path" -f -d -c 'wincmd l' \
 			"$LOCAL" "$MERGED" "$REMOTE"
 		;;
+	gvimdiff3|vimdiff3)
+		if $base_present
+		then
+			"$merge_tool_path" -f -d -c 'hid | hid | hid' \
+				"$LOCAL" "$REMOTE" "$BASE" "$MERGED"
+		else
+			"$merge_tool_path" -f -d -c 'hid | hid' \
+				"$LOCAL" "$REMOTE" "$MERGED"
+		fi
+		;;
 	esac
 	check_unchanged
 }
 
 translate_merge_tool_path() {
 	case "$1" in
-	gvimdiff|gvimdiff2)
+	gvimdiff|gvimdiff2|gvimdiff3)
 		echo gvim
 		;;
-	vimdiff|vimdiff2)
+	vimdiff|vimdiff2|vimdiff3)
 		echo vim
 		;;
 	esac
diff --git a/mergetools/vimdiff3 b/mergetools/vimdiff3
new file mode 100644
index 0000000..04a5bb0
--- /dev/null
+++ b/mergetools/vimdiff3
@@ -0,0 +1 @@
+. "$MERGE_TOOLS_DIR/vimdiff"
-- 
1.9.2+fc1.1.g5c924db
