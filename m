From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git.el: Refresh only the changed file marks when marking/unmarking all.
Date: Sun, 28 Oct 2007 11:06:27 +0100
Message-ID: <878x5nd04c.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 11:06:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im52g-000594-9E
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 11:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbXJ1KGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 06:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbXJ1KGi
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 06:06:38 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:52190 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbXJ1KGh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 06:06:37 -0400
Received: from adsl-62-167-50-148.adslplus.ch ([62.167.50.148] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1Im52M-0005mC-NF
	for git@vger.kernel.org; Sun, 28 Oct 2007 05:06:36 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id D4D3A1E7146; Sun, 28 Oct 2007 11:06:27 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -2.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62546>

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 0e5091c..e5ee8ce 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -842,7 +842,8 @@ Return the list of files that haven't been handled."
   "Mark all files."
   (interactive)
   (unless git-status (error "Not in git-status buffer."))
-  (ewoc-map (lambda (info) (setf (git-fileinfo->marked info) t) t) git-status)
+  (ewoc-map (lambda (info) (unless (git-fileinfo->marked info)
+                             (setf (git-fileinfo->marked info) t))) git-status)
   ; move back to goal column after invalidate
   (when goal-column (move-to-column goal-column)))
 
@@ -850,7 +851,9 @@ Return the list of files that haven't been handled."
   "Unmark all files."
   (interactive)
   (unless git-status (error "Not in git-status buffer."))
-  (ewoc-map (lambda (info) (setf (git-fileinfo->marked info) nil) t) git-status)
+  (ewoc-map (lambda (info) (when (git-fileinfo->marked info)
+                             (setf (git-fileinfo->marked info) nil)
+                             t)) git-status)
   ; move back to goal column after invalidate
   (when goal-column (move-to-column goal-column)))
 
-- 
1.5.3.4.404.g5a866

-- 
Alexandre Julliard
julliard@winehq.org
