From: Martin Langhoff <martin@laptop.org>
Subject: [PATCH] gitk: add support for -G'regex' pickaxe variant
Date: Thu,  7 Jun 2012 22:32:22 -0400
Message-ID: <1339122742-28677-1-git-send-email-martin@laptop.org>
Cc: Martin Langhoff <martin@laptop.org>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 04:32:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scp0K-00082W-1k
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 04:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760230Ab2FHCcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 22:32:43 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48685 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759958Ab2FHCcm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 22:32:42 -0400
Received: by obbtb18 with SMTP id tb18so1738265obb.19
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 19:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=Cl658T3c1BGI+h3CVSlU6uNsiM8gO6po54eP72GDReg=;
        b=A/DIdrex6GJfJWN7jK525roTEpdSkIzSxDHIpFkcDU+/KP6+VgSkbu0jtnuEma72Co
         vGHTcJViJ/B8fc77/X4yddO7s6+yJ1x/qfudQGq4rShEhldugNBf2EyKWy/7XyTDHzlf
         OPigG7x8vPiWrP99/0h+3tt6f+i5oaKAf9EuJ8tfqzdLJOV5zyJkJNs0LPySAlXnOuHT
         PquKcu0ElkjfEWOXTj3777rAb9cAORnsZaFwz/0nIkKuock+qY0m7/mks2YB/IBqnh3p
         igIN6P58UqQYxezTuZPGkD4TXTEIGKyuJAalTWn8pZ6LWB+GkTcYtrLhqtO7221KQdP9
         qDPA==
Received: by 10.60.9.134 with SMTP id z6mr4348204oea.46.1339122762222;
        Thu, 07 Jun 2012 19:32:42 -0700 (PDT)
Received: from martin-tp.gateway.2wire.net (108-209-173-113.lightspeed.miamfl.sbcglobal.net. [108.209.173.113])
        by mx.google.com with ESMTPS id hd9sm4059620obc.6.2012.06.07.19.32.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jun 2012 19:32:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199461>

git log -G'regex' is a very usable alternative to the classic
pickaxe. Minimal patch to make it usable from gitk.
---
 gitk-git/gitk |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 22270ce..876b8f9 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2232,7 +2232,8 @@ proc makewindow {} {
     set gm [makedroplist .tf.lbar.gdttype gdttype \
 		[mc "containing:"] \
 		[mc "touching paths:"] \
-		[mc "adding/removing string:"]]
+		[mc "adding/removing string:"] \
+		[mc "changes match regex:"]]
     trace add variable gdttype write gdttype_change
     pack .tf.lbar.gdttype -side left -fill y
 
@@ -4595,6 +4596,8 @@ proc do_file_hl {serial} {
 	set gdtargs [concat -- $relative_paths]
     } elseif {$gdttype eq [mc "adding/removing string:"]} {
 	set gdtargs [list "-S$highlight_files"]
+    } elseif {$gdttype eq [mc "changes match regex:"]} {
+	set gdtargs [list "-G$highlight_files"]
     } else {
 	# must be "containing:", i.e. we're searching commit info
 	return
-- 
1.7.7.6
