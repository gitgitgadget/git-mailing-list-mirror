From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH] git.el: Set process-environment instead of invoking env
Date: Tue, 19 Feb 2008 15:01:53 +0100
Message-ID: <87r6f958k5.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 15:24:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRTOD-0008E5-90
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 15:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756280AbYBSOXc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Feb 2008 09:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753070AbYBSOXc
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 09:23:32 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:47687 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198AbYBSOXb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 09:23:31 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 3F983200A1DF;
	Tue, 19 Feb 2008 15:23:30 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 11352-01-85; Tue, 19 Feb 2008 15:23:29 +0100 (CET)
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id AF8D8200A1D7;
	Tue, 19 Feb 2008 15:23:29 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id D2C2A7B4078; Tue, 19 Feb 2008 15:23:38 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74410>

This will make it a little less posix-dependent, and more efficient.

Included is also a minor doc improvement.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
 contrib/emacs/git.el |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index a8bf0ef..f69b697 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -185,9 +185,8 @@ if there is already one that displays the same dire=
ctory."
=20
 (defun git-call-process-env (buffer env &rest args)
   "Wrapper for call-process that sets environment strings."
-  (if env
-      (apply #'call-process "env" nil buffer nil
-             (append (git-get-env-strings env) (list "git") args))
+  (let ((process-environment (append (git-get-env-strings env)
+                                     process-environment)))
     (apply #'call-process "git" nil buffer nil args)))
=20
 (defun git-call-process-display-error (&rest args)
@@ -204,7 +203,7 @@ if there is already one that displays the same dire=
ctory."
=20
 (defun git-call-process-env-string (env &rest args)
   "Wrapper for call-process that sets environment strings,
-and returns the process output as a string."
+and returns the process output as a string, or nil if the git failed."
   (with-temp-buffer
     (and (eq 0 (apply #' git-call-process-env t env args))
          (buffer-string))))
--=20
1.5.4.2.148.g410dc


--=20
David K=C3=A5gedal
