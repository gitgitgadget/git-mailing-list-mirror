From: dev+git@drbeat.li
Subject: [PATCH v2 4/5] update_unicode.sh: Make the output structure visible
Date: Fri, 19 Dec 2014 17:21:33 +0100
Message-ID: <1419006094-24572-4-git-send-email-dev+git@drbeat.li>
References: <1419006094-24572-1-git-send-email-dev+git@drbeat.li>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 19 17:21:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y20JP-0005Cv-5t
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 17:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641AbaLSQVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 11:21:43 -0500
Received: from smtp4.mail.fcom.ch ([212.60.46.173]:54533 "EHLO
	smtp4.mail.fcom.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbaLSQVl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 11:21:41 -0500
Received: from drbeat.li (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by smtp4.mail.fcom.ch (Postfix) with ESMTP id C66A52029F
	for <git@vger.kernel.org>; Fri, 19 Dec 2014 17:21:36 +0100 (CET)
Received: by drbeat.li (Postfix, from userid 1000)
	id C011120E8B; Fri, 19 Dec 2014 17:21:34 +0100 (CET)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1419006094-24572-1-git-send-email-dev+git@drbeat.li>
X-Virus-Scanned: clamav-milter 0.98.5 at smtp4.mail.fcom.ch
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261574>

From: Beat Bolli <dev+git@drbeat.li>

By using a here document instead of the echo/uniset sequence, the final
structure of the generated file becomes obvious.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 update_unicode.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/update_unicode.sh b/update_unicode.sh
index f5cc14b..d7343b9 100755
--- a/update_unicode.sh
+++ b/update_unicode.sh
@@ -28,12 +28,14 @@ fi &&
 		make
 	) && {
 		UNICODE_DIR=. && export UNICODE_DIR &&
-		echo "static const struct interval zero_width[] = {" &&
-		uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD |
-		grep -v plane &&
-		echo "};" &&
-		echo "static const struct interval double_width[] = {" &&
-		uniset/uniset --32 eaw:F,W &&
-		echo "};"
+		cat <<-EOF
+		static const struct interval zero_width[] = {
+			$(uniset/uniset --32 cat:Me,Mn,Cf \
+			  + U+1160..U+11FF - U+00AD | grep -v plane)
+		};
+		static const struct interval double_width[] = {
+			$(uniset/uniset --32 eaw:F,W)
+		};
+		EOF
 	} >$UNICODEWIDTH_H
 )
-- 
2.1.3
