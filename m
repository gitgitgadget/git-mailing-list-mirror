From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 2/2] gitk: let .bleft.mid widgets 'breathe'
Date: Tue,  8 Dec 2015 08:05:51 +0100
Message-ID: <1449558351-15038-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <CAPig+cSwWxLMRh7e231svhtiJQH-5WuMO+3Y5x-e9tEOyHtqDg@mail.gmail.com>
 <1449558351-15038-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: <git@vger.kernel.org>, Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Dec 08 08:06:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6CLb-0008S6-Hb
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 08:06:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933114AbbLHHF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 02:05:59 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36010 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933092AbbLHHF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 02:05:58 -0500
Received: by wmww144 with SMTP id w144so169251792wmw.1
        for <git@vger.kernel.org>; Mon, 07 Dec 2015 23:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EVdgZTU/cZTHHYgZ5Fw1k4vX/aZ09veYk5ztkmLxguU=;
        b=Gytb1PMP8+rJuZIz/Yq5kpYsDP/l4ExFjZv+MyudshxyZ1HzlQ3ur++UAEqXpS6vcA
         ckeQX1ytdKcogHJDWmQzLCzTNakr1TCStpLS87gTVe3XOFK0+hXsD2LoZLK62jb72FSY
         Hk2d+xDmBPZQ5CHRB+IPNlgHGsKdJRgBtW3C6W0ZxvoU3PJzedbAvpta4oXG/VW8Qjzn
         rlfmNxu1s1dBq4Ujk5Rc8ut+KMaz8t4alwl0IdP0Zp9bieACdRS7q75uhj2b3IEDYSEp
         RODF9XI71utf2LLc5QqAIXpr5cZqQfzRBmXkE/MBZAcqGBcXWzF32FhYYyAJcAM5Qd97
         jVKg==
X-Received: by 10.194.79.37 with SMTP id g5mr1873443wjx.107.1449558357235;
        Mon, 07 Dec 2015 23:05:57 -0800 (PST)
Received: from localhost ([151.54.54.213])
        by smtp.gmail.com with ESMTPSA id t133sm1998677wmf.24.2015.12.07.23.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2015 23:05:56 -0800 (PST)
X-Mailer: git-send-email 2.6.3.659.gfdd8f28
In-Reply-To: <1449558351-15038-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282148>

The widgets on top of the diff window are very tightly packed. Make
them breathe a little by adding an 'i'-spaced padding between them.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
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
