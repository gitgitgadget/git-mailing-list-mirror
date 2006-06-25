From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Repack should try to prevent itself from running twice, concurrently.
Date: Sun, 25 Jun 2006 06:10:14 -0400
Message-ID: <11512302144123-git-send-email-ryan@michonline.com>
References: <7vy7vmormn.fsf@assigned-by-dhcp.cox.net>
Reply-To: Ryan Anderson <ryan@michonline.com>
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Sun Jun 25 12:12:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuRbG-0004Wp-AK
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 12:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWFYKMO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 06:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWFYKMO
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 06:12:14 -0400
Received: from h4x0r5.com ([70.85.31.202]:51977 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1751222AbWFYKMN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 06:12:13 -0400
Received: from c-71-202-182-135.hsd1.ca.comcast.net ([71.202.182.135] helo=mythical)
	by h4x0r5.com with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FuRZl-0001LD-CJ; Sun, 25 Jun 2006 03:10:45 -0700
Received: from ryan by mythical with local (Exim 4.62)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1FuRZG-0007ot-7u; Sun, 25 Jun 2006 06:10:14 -0400
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.1.rc1.gacb70
In-Reply-To: <7vy7vmormn.fsf@assigned-by-dhcp.cox.net>
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22602>

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---
 git-repack.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index eb75c8c..20f9b55 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -24,6 +24,15 @@ do
 	shift
 done
 
+if [ -f $GIT_DIR/repack.lock ]
+then
+	echo "Existing repack job appears to be running."
+	echo "Remove $GIT_DIR/repack.lock if this is not the case."
+	exit 1
+else
+	echo $$ > $GIT_DIR/repack.lock
+fi
+
 rm -f .tmp-pack-*
 PACKDIR="$GIT_OBJECT_DIRECTORY/pack"
 
@@ -83,3 +92,5 @@ case "$no_update_info" in
 t) : ;;
 *) git-update-server-info ;;
 esac
+
+rm $GIT_DIR/repack.lock
-- 
1.4.1.rc1.gacb70
