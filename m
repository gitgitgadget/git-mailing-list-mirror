From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 05/17] Emacs mode: push/pop next patch,
	not patch at point
Date: Fri, 14 Dec 2007 11:57:19 +0100
Message-ID: <20071214105705.18066.30571.stgit@krank>
References: <20071214105238.18066.23281.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 11:57:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J38EQ-0000fw-Me
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 11:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765664AbXLNK5H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 05:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761799AbXLNK5F
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 05:57:05 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:51826 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760004AbXLNK5D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 05:57:03 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 55686200A239;
	Fri, 14 Dec 2007 11:57:01 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 28143-01-51; Fri, 14 Dec 2007 11:57:00 +0100 (CET)
Received: from krank (oden.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id E4B78200A238;
	Fri, 14 Dec 2007 11:57:00 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id 575B67B406D;
	Fri, 14 Dec 2007 11:57:19 +0100 (CET)
In-Reply-To: <20071214105238.18066.23281.stgit@krank>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68281>

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

The three operations we should have are:

  * Pop the topmost applied patch, no matter where point is.

  * Push the first unapplied patch, no matter where point is.

  * Push/pop the patch at point, depending on whether it's currently
    applied.

This patch makes "<" and ">" do the first two operations. The third is
coming in a later patch.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 contrib/stgit.el |   22 ++++++++--------------
 1 files changed, 8 insertions(+), 14 deletions(-)


diff --git a/contrib/stgit.el b/contrib/stgit.el
index cce0c0e..17b5d6b 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -81,7 +81,7 @@ Argument DIR is the repository path."
   (define-key stgit-mode-map "g"   'stgit-refresh)
   (define-key stgit-mode-map "r"   'stgit-rename)
   (define-key stgit-mode-map ">"   'stgit-push-next)
-  (define-key stgit-mode-map "<"   'stgit-pop)
+  (define-key stgit-mode-map "<"   'stgit-pop-next)
   (define-key stgit-mode-map "=3D"   'stgit-show))
=20
 (defun stgit-mode ()
@@ -127,22 +127,16 @@ Commands:
     (stgit-goto-patch name)))
=20
 (defun stgit-push-next ()
-  "Push the patch on the line after pos"
+  "Push the first unapplied patch"
   (interactive)
-  (forward-line 1)
-  (let ((patch (stgit-patch-at-point)))
-    (stgit-capture-output nil
-      (stgit-run "push" patch))
-    (stgit-refresh)))
+  (stgit-capture-output nil (stgit-run "push"))
+  (stgit-refresh))
=20
-(defun stgit-pop ()
-  "Pop the patch on the current line"
+(defun stgit-pop-next ()
+  "Pop the topmost applied patch"
   (interactive)
-  (let ((patch (stgit-patch-at-point)))
-    (stgit-capture-output nil
-      (stgit-run "pop" patch))
-    (stgit-refresh)
-    (previous-line)))
+  (stgit-capture-output nil (stgit-run "pop"))
+  (stgit-refresh))
=20
 (defun stgit-show ()
   "Show the patch on the current line"
