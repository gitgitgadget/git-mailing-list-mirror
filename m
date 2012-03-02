From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH] mergetools: add support for DeltaWalker
Date: Thu,  1 Mar 2012 20:47:52 -0500
Message-ID: <1330652872-916-1-git-send-email-tim.henigan@gmail.com>
Cc: tim.henigan@gmail.com
To: git@vger.kernel.org, gitster@pobox.com, davvid@gmail.com
X-From: git-owner@vger.kernel.org Fri Mar 02 02:48:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3HbL-00075V-PU
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 02:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927Ab2CBBsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 20:48:01 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56277 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab2CBBsA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 20:48:00 -0500
Received: by iagz16 with SMTP id z16so1632471iag.19
        for <git@vger.kernel.org>; Thu, 01 Mar 2012 17:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=hFahUnTtMIwrdGtmiSVlHXQiQx/ZiQihp9odJGMmRyc=;
        b=Brm+NzVQHdLMJdxfDQrXKsMgpPc1h4+o21zZhvrsfBsi6cMZUZzYiPNyOsdXZdPo5j
         fnbgF7MhLlh25Sv/mjpFjJV7H6zEqnpDYQoYpAZM1zHY2CFBFrLnywsk2Wbra7IF9wgA
         ZebYdUzTdBhzQ3DqCatRu5gu/TkN7gtmpApbJz7JUQINMfpZ5bIaMUDCmw02N2MLqOxI
         dbuW+uU396kmH0w0PzBjzWth963pUNqe4kEOtJ5iNJ5m8khDec5IHLn38CUzpGJEPgef
         jpY7G6Sd5+PFLKrXUBOipVGYsZEXS+XlFpVgf9oFvLJhWHyG9J3Ot7LhPnpNhe3qqLkX
         Kq+g==
Received: by 10.50.169.9 with SMTP id aa9mr175308igc.23.1330652879638;
        Thu, 01 Mar 2012 17:47:59 -0800 (PST)
Received: from localhost ([75.38.216.51])
        by mx.google.com with ESMTPS id bi6sm246691igc.3.2012.03.01.17.47.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Mar 2012 17:47:59 -0800 (PST)
X-Mailer: git-send-email 1.7.9.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191993>

Since bc7a96a8965d, integration with external diff/merge tools requires
a mergetools/$tool file to be present.

This commits adds support for DeltaWalker.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

Tested with DeltaWalker v1.9.8 on Ubuntu 11.10 and msysgit on Win7.


 mergetools/DeltaWalker |   13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 mergetools/DeltaWalker

diff --git a/mergetools/DeltaWalker b/mergetools/DeltaWalker
new file mode 100644
index 0000000..ae66686
--- /dev/null
+++ b/mergetools/DeltaWalker
@@ -0,0 +1,13 @@
+diff_cmd () {
+       "$merge_tool_path" "$LOCAL" "$REMOTE" >/dev/null 2>&1
+}
+
+merge_cmd () {
+       if $base_present
+       then
+               "$merge_tool_path" "$LOCAL" "$REMOTE" "$BASE" -merged="$PWD/$MERGED" >/dev/null 2>&1
+       else
+               "$merge_tool_path" "$LOCAL" "$REMOTE" -merged="$PWD/$MERGED" >/dev/null 2>&1
+       fi
+       status=$?
+}
-- 
1.7.9.GIT
