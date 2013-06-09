From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 34/36] rebase: cherry-pick: add merge options
Date: Sun,  9 Jun 2013 14:24:48 -0500
Message-ID: <1370805890-3453-35-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:28:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllI3-00048m-9E
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506Ab3FIT2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:28:25 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:33245 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab3FIT2W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:28:22 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so4988558oag.23
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=YDWkGWYarM1us5nVH6x5c61Xu72MbANfZHe0tUsC5Q0=;
        b=TwalDt0LMkixqxCMVv9y2F71sdCQluu2EzuDXwLcRD0Ov1+0Q5BwHUhU7JvZWpPmlQ
         bkPMGAXCjk4t2GisA1HEwrw+raBDIwUD4u/z6s6yEPqjcKhnvaTyq1O5Hqvr1mUvLPjT
         yqKSsSzrzeEdN1XKilcRcnQwP8wpwXM9LabMbfiW543cSdrs49CEdwXnytjmLfNU1qUe
         bZFi1uPfEEDdzqAnmCMw/TEbcNkUbzR8Oe4csQkUo2D0hzMzi9t1ktoZSF89gGOJY8CS
         IenBdsJK5x8/Pn3R4+yjvtAz/mP5xBf4Rjxh4Ggk02aAet/PW5FLYXkQe478VvSNQyvH
         HEwQ==
X-Received: by 10.182.79.33 with SMTP id g1mr5415923obx.78.1370806101644;
        Sun, 09 Jun 2013 12:28:21 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id dz4sm15932831obb.14.2013.06.09.12.28.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:28:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227141>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index 6f63618..644d45e 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -48,6 +48,14 @@ else
 fi
 test -n "$GIT_QUIET" && extra="$extra -q"
 test -z "$force_rebase" && extra="$extra --ff"
+test -n "$strategy" && extra="$extra --strategy=$strategy"
+for x in "$strategy_opts"
+do
+	test -z "$x" && continue
+	x=$(eval "echo $x")
+	extra="$extra -X${x#--}"
+done
+test -n "$allow_rerere_autoupdate" && extra="$extra $allow_rerere_autoupdate"
 
 git rev-list $rev_args > "$state_dir"/list
 git cherry-pick --action-name rebase $extra $rev_args
-- 
1.8.3.698.g079b096
