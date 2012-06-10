From: Lawrence Mitchell <wence@gmx.li>
Subject: [PATCH 2/3] git-blame.el: Use with-current-buffer where appropriate
Date: Sun, 10 Jun 2012 12:58:03 +0100
Message-ID: <1339329484-12088-2-git-send-email-wence@gmx.li>
References: <20120610073803.GA29461@burratino>
 <1339329484-12088-1-git-send-email-wence@gmx.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jrnieder@gmail.com, git@vger.kernel.org, davidk@lysator.liu.se,
	user42@zip.com.au, osv@javad.com
To: =?UTF-8?q?R=C3=BCdiger=20Sonderfeld?= <ruediger@c-plusplus.de>
X-From: git-owner@vger.kernel.org Sun Jun 10 14:35:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdhMb-0000hG-KE
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 14:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755651Ab2FJMfW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jun 2012 08:35:22 -0400
Received: from treacle.ucs.ed.ac.uk ([129.215.16.102]:53129 "EHLO
	treacle.ucs.ed.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab2FJMfR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 08:35:17 -0400
Received: from lmtp1.ucs.ed.ac.uk (lmtp1.ucs.ed.ac.uk [129.215.149.64])
	by treacle.ucs.ed.ac.uk (8.13.8/8.13.4) with ESMTP id q5ABwSHt006526;
	Sun, 10 Jun 2012 12:58:30 +0100 (BST)
Received: from localhost.localdomain (cpc11-sgyl30-2-0-cust962.sgyl.cable.virginmedia.com [94.175.87.195])
	(authenticated user=lmitche4 mech=PLAIN bits=0)
	by lmtp1.ucs.ed.ac.uk (8.13.8/8.13.7) with ESMTP id q5ABw4hm029717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 10 Jun 2012 12:58:28 +0100 (BST)
X-Mailer: git-send-email 1.7.10.2.552.gaa3bb87
In-Reply-To: <1339329484-12088-1-git-send-email-wence@gmx.li>
X-Edinburgh-Scanned: at treacle.ucs.ed.ac.uk
    with MIMEDefang 2.60, Sophie, Sophos Anti-Virus, Clam AntiVirus
X-Scanned-By: MIMEDefang 2.60 on 129.215.16.102
X-Scanned-By: MIMEDefang 2.52 on 129.215.149.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199597>

=46rom: R=C3=BCdiger Sonderfeld <ruediger@c-plusplus.de>

In git-blame-filter and git-blame-new-commit we need to execute the
body with (current-buffer) bound to the correct output buffer.  We
then want to restore the previous value of (current-buffer).  The
idiom

   (save-excursion
     (set-buffer buf)
     ...)

will not correctly save the original buffer the code was executed in.
Instead, use with-current-buffer as recommended in Emacs documentation.

Signed-off-by: R=C3=BCdiger Sonderfeld <ruediger@c-plusplus.de>
Signed-off-by: Lawrence Mitchell <wence@gmx.li>
---
 contrib/emacs/git-blame.el | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index 5428ff7..20cf9a6 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -337,8 +337,7 @@ See also function `git-blame-mode'."
 (defvar in-blame-filter nil)
=20
 (defun git-blame-filter (proc str)
-  (save-excursion
-    (set-buffer (process-buffer proc))
+  (with-current-buffer (process-buffer proc)
     (goto-char (process-mark proc))
     (insert-before-markers str)
     (goto-char 0)
@@ -385,8 +384,7 @@ See also function `git-blame-mode'."
           info))))
=20
 (defun git-blame-create-overlay (info start-line num-lines)
-  (save-excursion
-    (set-buffer git-blame-file)
+  (with-current-buffer git-blame-file
     (let ((inhibit-point-motion-hooks t)
           (inhibit-modification-hooks t))
       (goto-char (point-min))
--=20
1.7.10.2.552.gaa3bb87
