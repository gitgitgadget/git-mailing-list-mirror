From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/2] Emacs mode: delete patches
Date: Sun, 10 Feb 2008 21:54:08 +0100
Message-ID: <20080210204851.17886.69638.stgit@yoghurt>
References: <20080210204628.17886.27365.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 21:54:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOJCK-0008NP-6c
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 21:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755AbYBJUyN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 15:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754750AbYBJUyN
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 15:54:13 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1260 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754701AbYBJUyM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 15:54:12 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JOJBf-0005In-00; Sun, 10 Feb 2008 20:54:07 +0000
In-Reply-To: <20080210204628.17886.27365.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73414>

Teach the emacs mode to delete patches.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

David, could you have a look at this as well? In addition to me being
elisp challenged, there are the following issues:

  * Is "d" a reasonable binding? Any better suggestion?

  * Currently, this command requires you to mark one or more patches
    before deleting. This is convenient when deleting more than one
    patch, but one could argue that it should be possible to delete
    the patch at point without having to select it.

  * We should probably ask for confirmation before deleting.

 contrib/stgit.el |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)


diff --git a/contrib/stgit.el b/contrib/stgit.el
index 30c1cd1..7468fcd 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -150,7 +150,8 @@ Argument DIR is the repository path."
   (define-key stgit-mode-map "<"   'stgit-pop-next)
   (define-key stgit-mode-map "P"   'stgit-push-or-pop)
   (define-key stgit-mode-map "G"   'stgit-goto)
-  (define-key stgit-mode-map "=3D"   'stgit-show))
+  (define-key stgit-mode-map "=3D"   'stgit-show)
+  (define-key stgit-mode-map "d"   'stgit-delete))
=20
 (defun stgit-mode ()
   "Major mode for interacting with StGit.
@@ -341,6 +342,13 @@ Commands:
            (substring patch 0 20))
           (t patch))))
=20
+(defun stgit-delete (patch-names)
+  "Delete the named patches"
+  (interactive (list (stgit-marked-patches)))
+  (stgit-capture-output nil
+    (apply 'stgit-run "delete" patch-names))
+  (stgit-refresh))
+
 (defun stgit-coalesce (patch-names)
   "Run stg coalesce on the named patches"
   (interactive (list (stgit-marked-patches)))
