From: =?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH] git.el: Only show completions from refs/heads, refs/remotes and refs/tags
Date: Tue, 24 Feb 2009 09:32:30 +0100
Message-ID: <1235464350-23383-1-git-send-email-davidk@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 09:53:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbt2S-0000VI-AS
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 09:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbZBXIvt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 03:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbZBXIvs
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 03:51:48 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:53005 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbZBXIvs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 03:51:48 -0500
X-Greylist: delayed 1153 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Feb 2009 03:51:47 EST
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id EFA264000C;
	Tue, 24 Feb 2009 09:32:23 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id E32B44000E; Tue, 24 Feb 2009 09:32:23 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id A28CC4000C;
	Tue, 24 Feb 2009 09:32:23 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 83C9BDC489; Tue, 24 Feb 2009 09:32:30 +0100 (CET)
X-Mailer: git-send-email 1.6.2.rc1.21.gda6d
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111239>

Otherwise it will pick up e.g. lots of irrelevant stuff from
refs/bisect, refs/stash or refs/patches (for StGit users).

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
 contrib/emacs/git.el |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index feb229c..125e684 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1388,7 +1388,10 @@ With a prefix arg, diff the marked files instead=
=2E"
 (defun git-read-commit-name (prompt &optional default)
   "Ask for a commit name, with completion for local branch, remote bra=
nch and tag."
   (completing-read prompt
-                   (list* "HEAD" "ORIG_HEAD" "FETCH_HEAD" (mapcar #'ca=
r (git-for-each-ref)))
+                   (list* "HEAD" "ORIG_HEAD" "FETCH_HEAD"
+                          (mapcar #'car (git-for-each-ref "refs/heads"
+                                                          "refs/remote=
s"
+                                                          "refs/tags")=
))
 		   nil nil nil nil default))
=20
 (defun git-checkout (branch &optional merge)
--=20
1.6.2.rc1.21.gda6d
