From: dev+git@drbeat.li
Subject: [PATCH 2/5] update_unicode.sh: set UNICODE_DIR only once
Date: Fri, 19 Dec 2014 15:39:28 +0100
Message-ID: <1418999971-21548-2-git-send-email-dev+git@drbeat.li>
References: <1418999971-21548-1-git-send-email-dev+git@drbeat.li>
Cc: tboegi@web.de, Beat Bolli <dev+git@drbeat.li>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 19 15:47:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1yqP-0001fC-Ri
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 15:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbaLSOri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 09:47:38 -0500
Received: from smtp1.mail.fcom.ch ([212.60.46.170]:51442 "EHLO
	smtp1.mail.fcom.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbaLSOrh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 09:47:37 -0500
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Dec 2014 09:47:37 EST
Received: from drbeat.li (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by smtp1.mail.fcom.ch (Postfix) with ESMTP id 8054F21505;
	Fri, 19 Dec 2014 15:40:13 +0100 (CET)
Received: by drbeat.li (Postfix, from userid 1000)
	id 257F6209AB; Fri, 19 Dec 2014 15:40:13 +0100 (CET)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418999971-21548-1-git-send-email-dev+git@drbeat.li>
X-Virus-Scanned: clamav-milter 0.98.4 at smtp1.mail.fcom.ch
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261558>

From: Beat Bolli <dev+git@drbeat.li>

The value is the same on both uniset invocations, so "Don't Repeat
Yourself" applies.

Since we're in a subshell already, there's no need to unset UNICODE_DIR
at the end.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 update_unicode.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/update_unicode.sh b/update_unicode.sh
index c1c876c..bed8916 100755
--- a/update_unicode.sh
+++ b/update_unicode.sh
@@ -27,12 +27,13 @@ fi &&
 		fi &&
 		make
 	) && {
+		UNICODE_DIR=. && export UNICODE_DIR &&
 		echo "static const struct interval zero_width[] = {" &&
-		UNICODE_DIR=. ./uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD |
+		./uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD |
 		grep -v plane &&
 		echo "};" &&
 		echo "static const struct interval double_width[] = {" &&
-		UNICODE_DIR=. ./uniset/uniset --32 eaw:F,W &&
+		./uniset/uniset --32 eaw:F,W &&
 		echo "};"
 	} >$UNICODEWIDTH_H
 )
-- 
2.1.3
