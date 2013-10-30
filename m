From: Nicolas Cornu <ncornu@aldebaran-robotics.com>
Subject: [PATCH v2] gitk: Add a horizontal scrollbar for commit history
Date: Wed, 30 Oct 2013 11:58:22 +0100
Message-ID: <1383130702-4966-1-git-send-email-ncornu@aldebaran-robotics.com>
Cc: paulus@samba.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 30 11:58:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbTTv-00013p-IJ
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 11:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084Ab3J3K6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 06:58:31 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:60597 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977Ab3J3K6b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 06:58:31 -0400
Received: by mail-wg0-f52.google.com with SMTP id k14so1120519wgh.19
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 03:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aldebaran-robotics.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FI5OXp04haTuBH0K9dsLjhf0iGpbrDjOJnTe445Fef8=;
        b=P5Jt8GC1BvUjy059e01FtF5KLt59CBO95xAZcOZ+K8XR4vWozWGu4pUDYC4BB3JcrD
         yIRgehRj008HDpNVWJi77uqw/uRVcGZlaDeS9jCkssrD20FvJ5a9nEZdOxlANNQJicZP
         clY2kk3N0lhn3CJhOdXIE9fT+fpND8vqJiids=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FI5OXp04haTuBH0K9dsLjhf0iGpbrDjOJnTe445Fef8=;
        b=SuLgKUgtA85cLGC2ASdUgo2TP4yBJ7E6Cfxwxy1LXlUY3p2hyB6qJ+KLGLuwe9ilaH
         rPtK3rp86Y1SC2QeyIliL/wA2FBQXKBHOiCtFE53yWMpbhq/YrbxzuU9+I/HCbMmPcpl
         +pz45yPe6uTy/b4YJ7asKWSsXQasEppRLytRcMUZDeIPjrk28u1frmwmv3O9D0RQQAVT
         xVprK6jHIHTBYW3hIUz4W9vjF6wSUl0BmkqMLJk8uU8dq6lRJee0mvjRDQeu7sDaDWfM
         zNjlgdh0b+G6tDQpXI+cvFoQpzGeWiNO9iTf1Lm1LUwzix8vBFXZTSWt9mXWwoFTqqN0
         xazg==
X-Gm-Message-State: ALoCoQncjO3XT4LlQAcJ9CBigFuW0L43egz+vJJCKvhXnX9djiGQEPEyQLZOHp0QIIuHCR+udYeP
X-Received: by 10.194.187.232 with SMTP id fv8mr1326751wjc.56.1383130709377;
        Wed, 30 Oct 2013 03:58:29 -0700 (PDT)
Received: from Zeus.aldebaran.lan ([46.218.232.202])
        by mx.google.com with ESMTPSA id y20sm14359793wib.0.2013.10.30.03.58.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2013 03:58:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237012>

This scrollbar is not optional and is useful if there is a lot of tags or
branches.

Signed-off-by: Nicolas Cornu <ncornu@aldebaran-robotics.com>
---
 gitk | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 5cd00d8..62563b1 100755
--- a/gitk
+++ b/gitk
@@ -2120,11 +2120,17 @@ proc makewindow {} {
     # create three canvases
     set cscroll .tf.histframe.csb
     set canv .tf.histframe.pwclist.canv
+    set cscrollhl .tf.histframe.pwclist.canv.csb
     canvas $canv \
 	-selectbackground $selectbgcolor \
 	-background $bgcolor -bd 0 \
-	-yscrollincr $linespc -yscrollcommand "scrollcanv $cscroll"
+	-yscrollincr $linespc -yscrollcommand "scrollcanv $cscroll" \
+	-xscrollcommand "scrollcanv $cscrollhl"
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
