From: dev+git@drbeat.li
Subject: [PATCH 4/5] update_unicode.sh: Make the output structure visible
Date: Fri, 19 Dec 2014 15:39:30 +0100
Message-ID: <1418999971-21548-4-git-send-email-dev+git@drbeat.li>
References: <1418999971-21548-1-git-send-email-dev+git@drbeat.li>
Cc: tboegi@web.de, Beat Bolli <dev+git@drbeat.li>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 19 15:48:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1yqz-0001ud-Ew
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 15:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbaLSOsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 09:48:19 -0500
Received: from smtp4.mail.fcom.ch ([212.60.46.173]:47272 "EHLO
	smtp4.mail.fcom.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbaLSOsT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 09:48:19 -0500
Received: from drbeat.li (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by smtp4.mail.fcom.ch (Postfix) with ESMTP id E59BC20AED;
	Fri, 19 Dec 2014 15:40:14 +0100 (CET)
Received: by drbeat.li (Postfix, from userid 1000)
	id 2B2ED20E8B; Fri, 19 Dec 2014 15:40:13 +0100 (CET)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418999971-21548-1-git-send-email-dev+git@drbeat.li>
X-Virus-Scanned: clamav-milter 0.98.5 at smtp4.mail.fcom.ch
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261560>

From: Beat Bolli <dev+git@drbeat.li>

By using printf instead of the echo/uniset sequence, the final structure
of the generated file becomes obvious.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 update_unicode.sh | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/update_unicode.sh b/update_unicode.sh
index f5cc14b..61968d9 100755
--- a/update_unicode.sh
+++ b/update_unicode.sh
@@ -28,12 +28,16 @@ fi &&
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
+		printf "\
+static const struct interval zero_width[] = {
+%s
+};
+static const struct interval double_width[] = {
+%s
+};
+" \
+		"$(uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD |
+		grep -v plane)" \
+		"$(uniset/uniset --32 eaw:F,W)"
 	} >$UNICODEWIDTH_H
 )
-- 
2.1.3
