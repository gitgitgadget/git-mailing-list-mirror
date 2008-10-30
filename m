From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 1/3] stgit.el: Added undo command
Date: Thu, 30 Oct 2008 10:52:48 +0100
Message-ID: <20081030095248.10290.81253.stgit@krank>
References: <20081030095221.10290.58637.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: kha@treskal.com, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Thu Oct 30 11:15:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvUYW-0007zW-Hi
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 11:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbYJ3KNx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Oct 2008 06:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753514AbYJ3KNs
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 06:13:48 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:38021 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbYJ3KNp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 06:13:45 -0400
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id A37B540068;
	Thu, 30 Oct 2008 10:52:48 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id 943014006E; Thu, 30 Oct 2008 10:52:48 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham 
	version=3.1.7-deb
Received: from krank (vtab.com [62.20.90.195])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 39F3740068;
	Thu, 30 Oct 2008 10:52:48 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id DFA55DC0A4;
	Thu, 30 Oct 2008 10:52:48 +0100 (CET)
In-Reply-To: <20081030095221.10290.58637.stgit@krank>
User-Agent: StGIT/0.14.3.278.g6f7d
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99451>

Bound it to the two standard bindings C-/ and C-_.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
 contrib/stgit.el |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/contrib/stgit.el b/contrib/stgit.el
index aafefaf..e6b7d70 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -165,7 +165,9 @@ Argument DIR is the repository path."
   (define-key stgit-mode-map "P"   'stgit-push-or-pop)
   (define-key stgit-mode-map "G"   'stgit-goto)
   (define-key stgit-mode-map "=3D"   'stgit-show)
-  (define-key stgit-mode-map "D"   'stgit-delete))
+  (define-key stgit-mode-map "D"   'stgit-delete)
+  (define-key stgit-mode-map [(control ?/)] 'stgit-undo)
+  (define-key stgit-mode-map "\C-_" 'stgit-undo))
=20
 (defun stgit-mode ()
   "Major mode for interacting with StGit.
@@ -408,4 +410,14 @@ Commands:
   (interactive)
   (describe-function 'stgit-mode))
=20
+(defun stgit-undo (&optional arg)
+  "Run stg undo.
+With prefix argument, run it with the --hard flag."
+  (interactive "P")
+  (stgit-capture-output nil
+    (if arg
+        (stgit-run "undo" "--hard")
+      (stgit-run "undo")))
+  (stgit-refresh))
+
 (provide 'stgit)
