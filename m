From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 14/17] Emacs mode: added fontification
Date: Fri, 14 Dec 2007 11:59:13 +0100
Message-ID: <20071214105907.18066.5325.stgit@krank>
References: <20071214105238.18066.23281.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 12:00:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J38HA-0001xm-W2
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 12:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764347AbXLNK65 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 05:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764346AbXLNK65
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 05:58:57 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:51849 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764294AbXLNK64 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 05:58:56 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 55504200A217;
	Fri, 14 Dec 2007 11:58:55 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 28143-01-60; Fri, 14 Dec 2007 11:58:55 +0100 (CET)
Received: from krank (oden.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 0ACEA200A1E8;
	Fri, 14 Dec 2007 11:58:55 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id 746117B406D;
	Fri, 14 Dec 2007 11:59:13 +0100 (CET)
In-Reply-To: <20071214105238.18066.23281.stgit@krank>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68291>


Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 contrib/stgit.el |   44 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 43 insertions(+), 1 deletions(-)


diff --git a/contrib/stgit.el b/contrib/stgit.el
index a344869..0859086 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -70,10 +70,52 @@ Argument DIR is the repository path."
     (insert "Branch: ")
     (stgit-run "branch")
     (stgit-run "series" "--description")
+    (stgit-rehighlight (point-min) (point-max))
     (if curpatch
         (stgit-goto-patch curpatch)
       (goto-line curline))))
=20
+(defface stgit-description-face
+  '((((background dark)) (:foreground "tan"))
+    (((background light)) (:foreground "dark red")))
+  "The face used for StGit desriptions")
+
+(defface stgit-top-patch-face
+  '((((background dark)) (:weight bold :foreground "yellow"))
+    (((background light)) (:weight bold :foreground "purple"))
+    (t (:weight bold)))
+  "The face used for the top patch names")
+
+(defface stgit-applied-patch-face
+  '((((background dark)) (:foreground "light yellow"))
+    (((background light)) (:foreground "purple"))
+    (t ()))
+  "The face used for applied patch names")
+
+(defface stgit-unapplied-patch-face
+  '((((background dark)) (:foreground "gray80"))
+    (((background light)) (:foreground "orchid"))
+    (t ()))
+  "The face used for unapplied patch names")
+
+(defun stgit-rehighlight (start end)
+  "Refresh fontification of region between START and END."
+  (save-excursion
+    (goto-char start)
+    (while (< (point) end)
+      (cond ((looking-at "Branch: \\(.*\\)")
+             (put-text-property (match-beginning 1) (match-end 1) 'fac=
e 'bold))
+            ((looking-at "\\([>+-]\\) \\([^ ]+\\) *| \\(.*\\)")
+             (let ((state (match-string 1)))
+               (put-text-property
+                (match-beginning 2) (match-end 2)
+                'face (cond ((string=3D state ">") 'stgit-top-patch-fa=
ce)
+                            ((string=3D state "+") 'stgit-applied-patc=
h-face)
+                            ((string=3D state "-") 'stgit-unapplied-pa=
tch-face)))
+               (put-text-property (match-beginning 3) (match-end 3)
+                                  'face 'stgit-description-face))))
+      (forward-line 1))))
+
 (defvar stgit-mode-hook nil
   "Run after `stgit-mode' is setup.")
=20
@@ -118,7 +160,7 @@ Commands:
   (save-excursion
     (beginning-of-line)
     (if (looking-at "[>+-] \\([^ ]*\\)")
-        (match-string 1)
+        (match-string-no-properties 1)
       nil)))
=20
 (defun stgit-goto-patch (patch)
