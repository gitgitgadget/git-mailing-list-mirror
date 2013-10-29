From: Nicolas Cornu <ncornu@aldebaran-robotics.com>
Subject: [PATCH] Add a scrollbar for commit history in gitk
Date: Tue, 29 Oct 2013 14:53:23 +0100
Message-ID: <CAMXp-VN=CMRdXwJ3+LRZegm-bwiDmJd66-YnZb65BNpqyHQCLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 29 14:53:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb9jd-0000tn-QB
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 14:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573Ab3J2NxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 09:53:24 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:52999 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab3J2NxY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 09:53:24 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so14390074iec.28
        for <git@vger.kernel.org>; Tue, 29 Oct 2013 06:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aldebaran-robotics.com; s=google;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=i86PUshYUNfeNr2rBbR17rw8Hv2xiwhvObTHajCPKh8=;
        b=fGABw17MPZxHV0npHwQ7Dw817DwflFUd3uu3wuo89Gi/gCI03kzqWPhy/CpMNVgu3A
         1xIarMEj4Dt83FvWkIFF+TLnKqyQojMS/j8+9y2pwDyGko7+pz3H0jv1SNWVvYCl/MOh
         g3uc8MGEAOWo4kkFRqV0nvkwQZjckzUuGbjec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=i86PUshYUNfeNr2rBbR17rw8Hv2xiwhvObTHajCPKh8=;
        b=Vh5yfWZnYmEaOIS+EmcjBpDo6A4UY6icQncpz+NufSaMYBkVEyso3fpYgp9sQJt6S6
         U9kq9SCL9GRSj0CLu8Rx9k8snknpZ6iV++wPONLp3YEiolqzB++bV36VUkJhQAW1OtuI
         pEjdsZeJAK8sOvPr7K78Nvsj9aGtULLRE4sWc2FNDf4A44sNYeHJVuHQpZwMziZ1gFJB
         86IDMfRn/QruVQ6IwYLgIBNVlqKKoHLvdD/6/ZnEEr/GH4m11ja5NbbDbXZeJpews6Ld
         crRtZmQRbuiarn+MK/ij3eQZ09XiaCzCIFyGjsu3cAGARxm9tymZVnSDq+GehiL/RN4l
         CXcg==
X-Gm-Message-State: ALoCoQn42gAWsjqaMJmvyxKpKyLtyajxSL92Jlz7ru4mWvkWJ4Sd/AyUPNnkoqyH4aH/yuD6Rbwb
X-Received: by 10.43.93.5 with SMTP id bs5mr16406437icc.32.1383054803402; Tue,
 29 Oct 2013 06:53:23 -0700 (PDT)
Received: by 10.64.25.165 with HTTP; Tue, 29 Oct 2013 06:53:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236924>

>From b3570290bd761a1bf952ea491fa62b123231fe61 Mon Sep 17 00:00:00 2001
From: Nicolas Cornu <ncornu@aldebaran-robotics.com>
Date: Tue, 29 Oct 2013 14:51:29 +0100
Subject: [PATCH] Add a scrollbar for commit history in gitk

---
 gitk-git/gitk | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index d6f5e07..e517253 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2124,11 +2124,17 @@ proc makewindow {} {
     # create three canvases
     set cscroll .tf.histframe.csb
     set canv .tf.histframe.pwclist.canv
+    set cscrollhl .tf.histframe.pwclist.canv.csb
     canvas $canv \
     -selectbackground $selectbgcolor \
     -background $bgcolor -bd 0 \
-    -yscrollincr $linespc -yscrollcommand "scrollcanv $cscroll"
+    -yscrollincr $linespc -yscrollcommand "scrollcanv $cscroll" \
+    -xscrollcommand "scrollcanv $cscrollhl"
     .tf.histframe.pwclist add $canv
+    ${NS}::scrollbar $cscrollhl -command {$canv xview} -orient horizontal
+    if {!$use_ttk} {$cscrollhl configure -highlightthickness 0}
+    pack $cscrollhl -fill x -side bottom
+
     set canv2 .tf.histframe.pwclist.canv2
     canvas $canv2 \
     -selectbackground $selectbgcolor \
-- 
1.8.4.2
