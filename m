From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitk: try to provide a window icon
Date: Sun, 16 Nov 2008 03:41:39 +0100
Message-ID: <1226803299-26474-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <cb7bb73a0811151814va151c32ud5e940820ff92011@mail.gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 03:42:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1Xb3-0003AU-AH
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 03:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbYKPClb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 21:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbYKPClb
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 21:41:31 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:12095 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbYKPCla (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 21:41:30 -0500
Received: by nf-out-0910.google.com with SMTP id d3so955549nfc.21
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 18:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=yQg8ZNZRVuWijvB6oPl7muINVvLY/xmRu7cVll0DhKg=;
        b=vJqNIl0lEzTm34kGErpioAj2hKM6UK64vRYVzXeKZKsfEAFo+u6Ku7AGCyINVs92/g
         IQjSer4Ec8UFgVuJ3Ij/9mDv51sj0ntfo/T1e27+LCrDv1czBIlDYuHQwxjpqLkL1a9S
         IFnML/la4yYih4WKJWb4LQf62vjZdHiNKkRxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gEIHpBYLqkVNOFHyXxPIGLXhN5z9XG8DamCSdsbNvILy+HytpndNzwR15QKihSIXuu
         vDwWTqO7ZahjxjgYgCCf4A3DLYuwFCxVBlWL2QaJO7ALVpeo1OH19ePJtAlh7Pk9PAsD
         RrU3J6+yUnMqIi3kvNnkigMhfufIJ5sC6itE4=
Received: by 10.210.22.8 with SMTP id 8mr2653063ebv.46.1226803288027;
        Sat, 15 Nov 2008 18:41:28 -0800 (PST)
Received: from localhost ([94.37.6.2])
        by mx.google.com with ESMTPS id 7sm1794139eyg.9.2008.11.15.18.41.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 Nov 2008 18:41:27 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <cb7bb73a0811151814va151c32ud5e940820ff92011@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101113>

Try to set up a 16x16 Tk photo image (based on the git logo) and use it
a window icon. Wrap the code in a catch because it may fail in earlier
Tcl/Tk 8.4 releases that don't provide 'wm iconphoto'.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitk-git/gitk |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 3353f4a..6b671a6 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -10797,6 +10797,26 @@ set lserial 0
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
