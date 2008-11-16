From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] git-gui: try to provide a window icon under X
Date: Sun, 16 Nov 2008 03:09:38 +0100
Message-ID: <1226801378-25501-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Alexander Gavrilov <angavrilov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 03:12:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1X86-00068P-9P
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 03:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbYKPCJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 21:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752275AbYKPCJ2
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 21:09:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:38016 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbYKPCJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 21:09:28 -0500
Received: by ug-out-1314.google.com with SMTP id 39so173003ugf.37
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 18:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=jhkx+dW4bLdknrebv6Zf2td/kFE4B7uXTOTGD8iOzpk=;
        b=WWspeCTxV0PxEOvka6YQd7C1jvYpblkKgyiY9+NEIaMAqjFG5W4SnkaYLZcyMMkjq1
         QEiK36nh+61oFKuuatnDZl4WoYmNvLPrdv0hdS0TYKpaC99W2q8zkbZWG8PX31cgn3ff
         cFYi0t8i7m28aknPcQZQnm+gPCO4rbGneyyXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MSkNJ5bhnqz2pmZuElzTlqNbDe7u4435oY0Wus8x4agqSNAEb3ypWVacSAVIou+DoM
         uLe1FdAJ6v4OoHvLkRNxoCCGV2IhPG/hMJD+7JQ2ym/dH3xvjXxXwAU9sKtDdB07me5W
         a8vjVpkz035O14QUllDJc/jUpLmux68CQjSZI=
Received: by 10.66.232.10 with SMTP id e10mr590525ugh.70.1226801366300;
        Sat, 15 Nov 2008 18:09:26 -0800 (PST)
Received: from localhost ([94.37.6.2])
        by mx.google.com with ESMTPS id k1sm1816792ugf.3.2008.11.15.18.09.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 Nov 2008 18:09:25 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101111>

When running under X, we try to set up a window icon by providing a
hand-crafted 16x16 Tk photo image equivalent to the .ico. Wrap in a
catch because the earlier Tcl/Tk 8.4 releases didn't provide the 'wm
iconphoto' command.
---
 git-gui/git-gui.sh |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index cf9ef6e..6ed6230 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -597,6 +597,28 @@ if {[is_Windows]} {
 	if {![info exists env(DISPLAY)]} {
 		set env(DISPLAY) :9999
 	}
+} else {
+	catch {
+		image create photo gitlogo -width 16 -height 16
+
+		gitlogo put #33CC33 -to  7  0  9  2
+		gitlogo put #33CC33 -to  4  2 12  4
+		gitlogo put #33CC33 -to  7  4  9  6
+		gitlogo put #CC3333 -to  4  6 12  8
+		gitlogo put gray26  -to  4  9  6 10
+		gitlogo put gray26  -to  3 10  6 12
+		gitlogo put gray26  -to  8  9 13 11
+		gitlogo put gray26  -to  8 11 10 12
+		gitlogo put gray26  -to 11 11 13 14
+		gitlogo put gray26  -to  3 12  5 14
+		gitlogo put gray26  -to  5 13
+		gitlogo put gray26  -to 10 13
+		gitlogo put gray26  -to  4 14 12 15
+		gitlogo put gray26  -to  5 15 11 16
+		gitlogo redither
+
+		wm iconphoto . -default gitlogo
+	}
 }
 
 ######################################################################
-- 
1.5.6.5
