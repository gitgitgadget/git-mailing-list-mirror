From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t/t9001-send-email.sh: ensure generated script is executed with $SHELL_PATH
Date: Mon, 22 Jun 2009 12:32:52 -0500
Message-ID: <0aBbhbpQqrYrkmoZ4FLobIiu7r9gRqhySR3zL0Ll2nRDg9pCmQ_amb4Z4AZXxbULu3EPW-03YA8@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 22 19:34:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MInPY-0006kK-Lo
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 19:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757386AbZFVRdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 13:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756249AbZFVRdU
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 13:33:20 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34862 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501AbZFVRdT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 13:33:19 -0400
Received: by mail.nrlssc.navy.mil id n5MHXIar004917; Mon, 22 Jun 2009 12:33:18 -0500
X-OriginalArrivalTime: 22 Jun 2009 17:33:18.0693 (UTC) FILETIME=[880F8150:01C9F35F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122049>

From: Brandon Casey <drafnel@gmail.com>

If the shell is not specified using the '#!' notation, then the OS will
use '/bin/sh' to execute the script which may not produce the desired
results.  In particular, /bin/sh on Solaris interprets '^' specially which
has an affect on the sed command that this patch touches.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 t/t9001-send-email.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index fb7d9f3..7b4cf55 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -152,7 +152,9 @@ test_expect_success 'cccmd works' '
 	clean_fake_sendmail &&
 	cp $patches cccmd.patch &&
 	echo cccmd--cccmd@example.com >>cccmd.patch &&
-	echo sed -n s/^cccmd--//p \"\$1\" > cccmd-sed &&
+	{ echo "#!$SHELL_PATH"
+	  echo sed -n s/^cccmd--//p \"\$1\"
+	} > cccmd-sed &&
 	chmod +x cccmd-sed &&
 	git send-email \
 		--from="Example <nobody@example.com>" \
-- 
1.6.3.1.24.g152f4
