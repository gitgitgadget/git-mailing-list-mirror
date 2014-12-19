From: dev+git@drbeat.li
Subject: [PATCH v2 1/5] update_unicode.sh: simplify output capture
Date: Fri, 19 Dec 2014 17:21:30 +0100
Message-ID: <1419006094-24572-1-git-send-email-dev+git@drbeat.li>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 19 17:21:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y20JE-00058R-6N
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 17:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbaLSQVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 11:21:40 -0500
Received: from smtp2.mail.fcom.ch ([212.60.46.171]:43393 "EHLO
	smtp2.mail.fcom.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbaLSQVj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 11:21:39 -0500
Received: from drbeat.li (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by smtp2.mail.fcom.ch (Postfix) with ESMTP id CAE9220E4C
	for <git@vger.kernel.org>; Fri, 19 Dec 2014 17:21:35 +0100 (CET)
Received: by drbeat.li (Postfix, from userid 1000)
	id BBF3420949; Fri, 19 Dec 2014 17:21:34 +0100 (CET)
X-Mailer: git-send-email 2.1.3
X-Virus-Scanned: clamav-milter 0.98.4 at smtp2.mail.fcom.ch
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261570>

From: Beat Bolli <dev+git@drbeat.li>

Instead of capturing the output of each echo and uniset invocation, wrap
the whole section in a group command and redirect its output all at
once.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 update_unicode.sh | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/update_unicode.sh b/update_unicode.sh
index 000b937..c1c876c 100755
--- a/update_unicode.sh
+++ b/update_unicode.sh
@@ -26,12 +26,13 @@ fi &&
 			./configure --enable-warnings=-Werror CFLAGS='-O0 -ggdb'
 		fi &&
 		make
-	) &&
-	echo "static const struct interval zero_width[] = {" >$UNICODEWIDTH_H &&
-	UNICODE_DIR=. ./uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD |
-	grep -v plane >>$UNICODEWIDTH_H &&
-	echo "};" >>$UNICODEWIDTH_H &&
-	echo "static const struct interval double_width[] = {" >>$UNICODEWIDTH_H &&
-	UNICODE_DIR=. ./uniset/uniset --32 eaw:F,W >>$UNICODEWIDTH_H &&
-	echo "};" >>$UNICODEWIDTH_H
+	) && {
+		echo "static const struct interval zero_width[] = {" &&
+		UNICODE_DIR=. ./uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD |
+		grep -v plane &&
+		echo "};" &&
+		echo "static const struct interval double_width[] = {" &&
+		UNICODE_DIR=. ./uniset/uniset --32 eaw:F,W &&
+		echo "};"
+	} >$UNICODEWIDTH_H
 )
-- 
2.1.3
