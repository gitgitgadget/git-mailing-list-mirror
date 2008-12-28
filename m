From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitk: try to provide a window icon
Date: Sun, 28 Dec 2008 12:28:04 +0100
Message-ID: <1230463684-26412-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 28 12:29:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGtpj-0007MB-69
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 12:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758AbYL1L2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2008 06:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753747AbYL1L2A
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 06:28:00 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:14122 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615AbYL1L17 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2008 06:27:59 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1578188fgg.17
        for <git@vger.kernel.org>; Sun, 28 Dec 2008 03:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=krhVBIwHuKHrGFot+rYG50Btkl8/lezihIbu6/GC6AU=;
        b=DkJ0cOf9f7Pda4590mljLYh+FTdU7Nx6beqdjWLQOrM+sFFp+xhz3BQCGlVv4bCiHy
         dXqA9hJzKoPq0jMvgnxJmmHO+u/m28MOBCSbWQRzkYw2OC7sJTRU3E86tMOg1edG42cs
         77sMbU1iaHBRlXztiECyYjI+o/5N+viTgacG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=WJXtLVAc5/ntuaytbuX6XUoEtpQPexXahP6vr4wu+1KIbt4e/40/i5ip3rkGIPmtyO
         HwIPLV6Hzv/Ma/pf92ylUi0+KW+N1+ZKF8uBoa89W3TPATLhtMS105sJy8SXWFEGmaLU
         e2ueKl2aMpvCC+1ehSihnoP3yNsd7ZUJlMNtU=
Received: by 10.86.79.19 with SMTP id c19mr7424742fgb.41.1230463677289;
        Sun, 28 Dec 2008 03:27:57 -0800 (PST)
Received: from localhost ([94.37.16.11])
        by mx.google.com with ESMTPS id 4sm17961946fgg.24.2008.12.28.03.27.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Dec 2008 03:27:56 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104046>

Try to set up a 16x16 Tk photo image (based on the git logo) and use it
as window icon. Wrap the code in a catch because it may fail in earlier
Tcl/Tk 8.4 releases that don't provide 'wm iconphoto'.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

Resend (with a typo fixed in the commit message), because it seems to
have flied a little too low on the previous round of commits.

 gitk-git/gitk |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index dc2a439..8c6a50d 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -10881,6 +10881,26 @@ set lserial 0
 set isworktree [expr {[exec git rev-parse --is-inside-work-tree] == "true"}]
 setcoords
 makewindow
+catch {
+	image create photo gitlogo      -width 16 -height 16
+
+	image create photo gitlogominus -width  4 -height  2
+	gitlogominus put #C00000 -to 0 0 4 2
+	gitlogo copy gitlogominus -to  1 5
+	gitlogo copy gitlogominus -to  6 5
+	gitlogo copy gitlogominus -to 11 5
+	image delete gitlogominus
+
+	image create photo gitlogoplus  -width  4 -height  4
+	gitlogoplus  put #008000 -to 1 0 3 4
+	gitlogoplus  put #008000 -to 0 1 4 3
+	gitlogo copy gitlogoplus  -to  1 9
+	gitlogo copy gitlogoplus  -to  6 9
+	gitlogo copy gitlogoplus  -to 11 9
+	image delete gitlogoplus
+
+	wm iconphoto . -default gitlogo
+}
 # wait for the window to become visible
 tkwait visibility .
 wm title . "[file tail $argv0]: [file tail [pwd]]"
-- 
1.5.6.5
