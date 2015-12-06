From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 2/2] gitk: let .bleft.mid widgets 'breathe'
Date: Sun,  6 Dec 2015 13:25:23 +0100
Message-ID: <1449404723-27177-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1449404723-27177-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 06 13:26:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5YOM-0007Cl-7U
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 13:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbbLFM0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 07:26:09 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34108 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbbLFMZf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 07:25:35 -0500
Received: by wmvv187 with SMTP id v187so131322996wmv.1
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 04:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WGJ2JjgAman6VE4RPQ5t47YBlZh4P+0zN71PXB0ue4k=;
        b=I1eL7vG1tnyi9YtWeiMjMrvpArWp3MtMbSiW9KS9+DnbL4j4ay2I+lLtXNGErWEqxA
         KCpuDoaIqyod7/ZoHXj0Q3KT+Uvbr2PDU8kgD/uOVfpMKw09YWNvS8r1diZ7BsqBz+bY
         IYLsnKqyL6VkxFNGUU2JTeeWrnM+l/ZYIp2GZs2RKb8bqrftFX0zyFQMSb4F42/AkI6X
         CUWp32ahiSTJi2LApuMwXZafE81si7XTVtBdjrODGAzQS0gn29i7aG5FFLBrY/SnbUHW
         8OyuVd+397G4B48WjHI4NHu5/w0tGRecHxXiMrsNkB6w7lO94eQ47yxU+ev6zUJujCIV
         6DPw==
X-Received: by 10.194.178.202 with SMTP id da10mr26658555wjc.158.1449404733877;
        Sun, 06 Dec 2015 04:25:33 -0800 (PST)
Received: from localhost ([151.54.54.213])
        by smtp.gmail.com with ESMTPSA id z13sm20189310wjr.47.2015.12.06.04.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2015 04:25:33 -0800 (PST)
X-Mailer: git-send-email 2.6.3.659.gfdd8f28
In-Reply-To: <1449404723-27177-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282051>

The widgets on top of the diff window are very tightly packed. Make
them breathe a little by adding an 'i'-spaced padding between them.
---
 gitk | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index e04264b..b621762 100755
--- a/gitk
+++ b/gitk
@@ -2361,6 +2361,9 @@ proc makewindow {} {
     ${NS}::frame .bleft.mid
     ${NS}::frame .bleft.bottom
 
+    # gap between sub-widgets
+    set wgap [font measure uifont "i"]
+
     ${NS}::button .bleft.top.search -text [mc "Search"] -command dosearch
     pack .bleft.top.search -side left -padx 5
     set sstring .bleft.top.sstring
@@ -2375,8 +2378,9 @@ proc makewindow {} {
 	-command changediffdisp -variable diffelide -value {0 1}
     ${NS}::radiobutton .bleft.mid.new -text [mc "New version"] \
 	-command changediffdisp -variable diffelide -value {1 0}
+
     ${NS}::label .bleft.mid.labeldiffcontext -text "      [mc "Lines of context"]: "
-    pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new -side left
+    pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new -side left -ipadx $wgap
     spinbox .bleft.mid.diffcontext -width 5 \
 	-from 0 -increment 1 -to 10000000 \
 	-validate all -validatecommand "diffcontextvalidate %P" \
@@ -2384,7 +2388,7 @@ proc makewindow {} {
     .bleft.mid.diffcontext set $diffcontext
     trace add variable diffcontextstring write diffcontextchange
     lappend entries .bleft.mid.diffcontext
-    pack .bleft.mid.labeldiffcontext .bleft.mid.diffcontext -side left
+    pack .bleft.mid.labeldiffcontext .bleft.mid.diffcontext -side left -ipadx $wgap
     ${NS}::checkbutton .bleft.mid.ignspace -text [mc "Ignore space change"] \
 	-command changeignorespace -variable ignorespace
     pack .bleft.mid.ignspace -side left -padx 5
-- 
2.6.3.659.gfdd8f28
