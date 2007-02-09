From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH 4/7] git-blame.el: improve color handling
Date: Fri, 09 Feb 2007 09:21:03 +0100
Message-ID: <87r6szpwr4.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 09:35:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFRDp-0000tP-NA
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 09:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946219AbXBIIfG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 9 Feb 2007 03:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946223AbXBIIfG
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 03:35:06 -0500
Received: from main.gmane.org ([80.91.229.2]:58924 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946219AbXBIIfE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 03:35:04 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HFRDi-0007Gi-Ct
	for git@vger.kernel.org; Fri, 09 Feb 2007 09:35:02 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 09:35:02 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 09:35:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:kkRUVLY7Phg9ZvhO4MVYwv5QcY8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39162>


Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
 contrib/emacs/git-blame.el |   24 ++++++++++--------------
 1 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index c99437e..7ffc153 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -95,16 +95,10 @@
     colors))
=20
 (defvar git-blame-dark-colors
-  (color-scale '("00" "04" "08" "0c"
-                 "10" "14" "18" "1c"
-                 "20" "24" "28" "2c"
-                 "30" "34" "38" "3c")))
+  (color-scale '("0c" "04" "24" "1c" "2c" "34" "14" "3c")))
=20
 (defvar git-blame-light-colors
-  (color-scale '("c0" "c4" "c8" "cc"
-                 "d0" "d4" "d8" "dc"
-                 "e0" "e4" "e8" "ec"
-                 "f0" "f4" "f8" "fc")))
+  (color-scale '("c4" "d4" "cc" "dc" "f4" "e4" "fc" "ec")))
=20
 (defvar git-blame-ancient-color "dark green")
=20
@@ -127,13 +121,15 @@
   (make-local-variable 'git-blame-overlays)
   (make-local-variable 'git-blame-colors)
   (make-local-variable 'git-blame-cache)
-  (let ((bgmode (cdr (assoc 'background-mode (frame-parameters)))))
-    (if (eq bgmode 'dark)
-        (setq git-blame-colors git-blame-dark-colors)
-      (setq git-blame-colors git-blame-light-colors)))
+  (git-blame-cleanup)
   (if git-blame-mode
-      (git-blame-run)
-    (git-blame-cleanup)))
+      (progn
+        (let ((bgmode (cdr (assoc 'background-mode (frame-parameters))=
)))
+          (if (eq bgmode 'dark)
+              (setq git-blame-colors git-blame-dark-colors)
+            (setq git-blame-colors git-blame-light-colors)))
+        (setq git-blame-cache (make-hash-table :test 'equal))
+        (git-blame-run))))
=20
 (defun git-blame-run ()
   (let* ((display-buf (current-buffer))
--=20
1.5.0.rc3.204.g93c76


--=20
David K=C3=A5gedal
