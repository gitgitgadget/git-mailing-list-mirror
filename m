From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH v2] mergetools: add support for DeltaWalker
Date: Fri,  2 Mar 2012 08:27:47 -0500
Message-ID: <1330694867-7601-1-git-send-email-tim.henigan@gmail.com>
Cc: tim.henigan@gmail.com
To: git@vger.kernel.org, gitster@pobox.com, davvid@gmail.com
X-From: git-owner@vger.kernel.org Fri Mar 02 14:28:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3SWy-0000CZ-58
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 14:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565Ab2CBN2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 08:28:13 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50222 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460Ab2CBN2M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 08:28:12 -0500
Received: by yhmm54 with SMTP id m54so743058yhm.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 05:28:12 -0800 (PST)
Received-SPF: pass (google.com: domain of tim.henigan@gmail.com designates 10.50.236.3 as permitted sender) client-ip=10.50.236.3;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tim.henigan@gmail.com designates 10.50.236.3 as permitted sender) smtp.mail=tim.henigan@gmail.com; dkim=pass header.i=tim.henigan@gmail.com
Received: from mr.google.com ([10.50.236.3])
        by 10.50.236.3 with SMTP id uq3mr1667122igc.11.1330694891908 (num_hops = 1);
        Fri, 02 Mar 2012 05:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=11S8UGO7FtahYNN07IDBV/yTtBXrk1j53OwvHDWzpGo=;
        b=tkr/nrgrWewNbNAGzsO/USRqAGuM9oVLOXmtxbv5MM4Fr2QTRH6q+GIkIm4EPt9QEi
         B+eUZ6PFgXZzcIhmjsWmZ+ItHVHbKPzfL2bEZfc0PSOe2uaPdFLvQQZmliWFzayzzw2L
         aLGS0/ro3doIxeDQOF8+EKImHsTyB8XzguhLiOzZ2pTject4ro/G7ZJovNlxmmNt3mS8
         3JUB8lRYbfoBvmuxLKsNXj2u048ZXO93fZSC4XXLselVEKz9ovfpS2M7m5n/Q7ox+9wB
         Ms9FSlxl9Kk6+mRDTZTPTjZCnueHDB+nWdeCcn4YMvdsGIMa8nkcb2ACD0/KC5FTdvPV
         UMAg==
Received: by 10.50.236.3 with SMTP id uq3mr1370913igc.11.1330694891866;
        Fri, 02 Mar 2012 05:28:11 -0800 (PST)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id ch2sm1881217igb.4.2012.03.02.05.28.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 05:28:10 -0800 (PST)
X-Mailer: git-send-email 1.7.9.2.315.g25a78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192040>

Thanks to bc7a96a8965d, it is possible to integrate new external
diff/merge tools by adding a simple shell script at mergetools/$tool.

This commit adds DeltaWalker support.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

Changes in v2:
  - reworded the commit message
  - moved >/dev/null redirect to after the final fi statement
  - removed the 'status=$?' line at the end of merge_cmd()

Tested with DeltaWalker v1.9.8 on Ubuntu 11.10 and msysgit on Win7.


 mergetools/DeltaWalker |   12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 mergetools/DeltaWalker

diff --git a/mergetools/DeltaWalker b/mergetools/DeltaWalker
new file mode 100644
index 0000000..b9e6618
--- /dev/null
+++ b/mergetools/DeltaWalker
@@ -0,0 +1,12 @@
+diff_cmd () {
+	"$merge_tool_path" "$LOCAL" "$REMOTE" >/dev/null 2>&1
+}
+
+merge_cmd () {
+	if $base_present
+	then
+		"$merge_tool_path" "$LOCAL" "$REMOTE" "$BASE" -merged="$PWD/$MERGED"
+	else
+		"$merge_tool_path" "$LOCAL" "$REMOTE" -merged="$PWD/$MERGED"
+	fi >/dev/null 2>&1
+}
-- 
1.7.9.2.315.g25a78
