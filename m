From: "=?UTF-8?q?Micha=C5=82=20Pomorski?=" <misieck@gmail.com>
Subject: [PATCH] Corrected cmitmode set in the right lower window when initiating a diff.
Date: Tue, 23 Nov 2010 03:32:06 +0100
Message-ID: <1290479526-21167-1-git-send-email-michal.pomorski@scalado.com>
References: <y>
Cc: =?UTF-8?q?Micha=C5=82=20Pomorski?= <michal.pomorski@scalado.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 23 03:33:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKih7-0005o1-C4
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 03:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211Ab0KWCdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 21:33:14 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61233 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab0KWCdN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 21:33:13 -0500
Received: by eye27 with SMTP id 27so4413273eye.19
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 18:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TE/Pu7T1mID9pmbIo13GvwytN/FKcMFiVpgDsQJdQN8=;
        b=JVyOCpYwKcafda4AXLhV2Mb0OZyw9BKXVOpQWt3fvI712fes6a+/TU30nI4z1jue/P
         G2xydkq8k3NCSkW5sutyJYYxKuYXQD32fS0RM4FyGPi7ke4JCchN1JFpT3P5rIMhYdqe
         utLZs55jx4vSSTZcxueowbzcgKHBvS/T+7ty0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=r0iEmWBjkbXF2AhZ1nHHlfzV6yCLkbHGtEB8S4M3nERZu1Q4pMSvXjNdF7uMSgLewL
         NDKpyddb2Scu55mtjaVxQtx+kTCZVLSlSH3i5/2eeUcXNBAsRtx8inf9QUNManzcDJ6+
         MOIzPKp95If2J+m0v0pE1MVPmmp1i3SlZ8qG4=
Received: by 10.213.114.5 with SMTP id c5mr5944290ebq.39.1290479592487;
        Mon, 22 Nov 2010 18:33:12 -0800 (PST)
Received: from localhost.localdomain (c83-254-136-198.bredband.comhem.se [83.254.136.198])
        by mx.google.com with ESMTPS id q58sm5286811eeh.21.2010.11.22.18.33.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Nov 2010 18:33:11 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <y>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161926>

Under certain circumstances it caused an error: bad text index "a:_number_" in treeopendir:
-Start gitk;
-Select the tree radio button in the lower right window;
-Choose a diff from the context menu in the main window (this->selected or vice versa)
-Observe the lower right window: a file list is displayed, but the radio button 'tree' remains selected
-Select one of the files listed. This should cause the error.

Because the variable cmitmode remains in the 'tree' setting, gitk is trying to calculate a tree view selection.
This patch corrects this by setting the cmitmode variable to 'patch' each time a diff is selected.
---
 gitk-git/gitk |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 1b0e09a..5d76de4 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -7330,8 +7330,9 @@ proc mergediff {id} {
 }
 
 proc startdiff {ids} {
-    global treediffs diffids treepending diffmergeid nullid nullid2
+    global treediffs diffids treepending diffmergeid nullid nullid2 cmitmode
 
+    set cmitmode patch
     settabs 1
     set diffids $ids
     catch {unset diffmergeid}
-- 
1.7.3.2
