From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git.el: Add support for interactive diffs.
Date: Sat, 11 Aug 2007 12:22:47 +0200
Message-ID: <87k5s2wetk.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 12:23:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJo7U-00025S-Gd
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 12:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790AbXHKKWw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 06:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753484AbXHKKWw
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 06:22:52 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:39393 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbXHKKWv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 06:22:51 -0400
Received: from adsl-89-217-132-200.adslplus.ch ([89.217.132.200] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1IJo7O-0000BY-F0
	for git@vger.kernel.org; Sat, 11 Aug 2007 05:22:50 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id B6C1B429EA1; Sat, 11 Aug 2007 12:22:47 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55602>

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index f6102fc..214b75c 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -965,7 +965,13 @@ Return the list of files that haven't been handled."
 (defun git-diff-file-idiff ()
   "Perform an interactive diff on the current file."
   (interactive)
-  (error "Interactive diffs not implemented yet."))
+  (let ((files (git-marked-files-state 'added 'deleted 'modified)))
+    (unless (eq 1 (length files))
+      (error "Cannot perform an interactive diff on multiple files."))
+    (let* ((filename (car (git-get-filenames files)))
+           (buff1 (find-file-noselect filename))
+           (buff2 (git-run-command-buffer (concat filename ".~HEAD~") "cat-file" "blob" (concat "HEAD:" filename))))
+      (ediff-buffers buff1 buff2))))
 
 (defun git-log-file ()
   "Display a log of changes to the marked file(s)."
-- 
1.5.3.rc4.70.gf909

-- 
Alexandre Julliard
julliard@winehq.org
