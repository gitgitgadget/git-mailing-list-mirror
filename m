From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/2] gitk: try to provide a window icon
Date: Thu, 19 Mar 2009 01:54:17 -0700
Message-ID: <61242ff6c582f3b82b7ddf4db75bdad45f0a457e.1237451887.git.bebarino@gmail.com>
References: <cover.1237451887.git.bebarino@gmail.com>
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 09:55:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkE2d-0003sJ-K1
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 09:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754842AbZCSIy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 04:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754390AbZCSIy1
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 04:54:27 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:18173 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114AbZCSIy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 04:54:26 -0400
Received: by wa-out-1112.google.com with SMTP id j5so294381wah.21
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 01:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:in-reply-to
         :references;
        bh=uo8oMPE5bnFNUqjthEwZtjK1ZgkNRL+z1FyOWGzWByo=;
        b=f7QCVVQ8fkdAVjIet0KBGa3s+yW4W8+S1h/ZKSY63QepqNzV1BmMvfK5gYrpkn+84y
         FBK40d+Yzr6Ijs2Mdzg0VJORRBxf7DqgBBxIq8W90sK4xKSHbR2ogS/aeaYFGsn3zOjF
         TNPo483s8Usea+BTDuLEKUc/HRo5dFHj/hv3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NdrVBg34r6GPu2/3Mg+X+FM5v9WSEzl0Vzu3AmsLcBQrMpODmk3wvZ2lETJnrROxPl
         i9PaMVHyZ5wCxEOqZ5VkyJpYEa0dsl5AL0jCEybpVq84+GjKxbCMJHL4DiUceNv1fm9j
         FaxKukwqMmHWCnOBQp8ruplwjb+TZgf//6R2o=
Received: by 10.114.202.15 with SMTP id z15mr1486130waf.67.1237452864398;
        Thu, 19 Mar 2009 01:54:24 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id v32sm935670wah.17.2009.03.19.01.54.22
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Mar 2009 01:54:24 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 19 Mar 2009 01:54:21 -0700
X-Mailer: git-send-email 1.6.2
In-Reply-To: <cover.1237451887.git.bebarino@gmail.com>
In-Reply-To: <cover.1237451887.git.bebarino@gmail.com>
References: <cover.1237451887.git.bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113736>

From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Try to set up a 16x16 Tk photo image (based on the git logo) and use it
as window icon. Wrap the code in a catch because it may fail in earlier
Tcl/Tk 8.4 releases that don't provide 'wm iconphoto'.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 gitk |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 1773ae6..cfbb699 100755
--- a/gitk
+++ b/gitk
@@ -10883,6 +10883,26 @@ set lserial 0
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
1.6.2
