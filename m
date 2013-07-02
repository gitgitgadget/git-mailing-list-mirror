From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH 2/4] git-blame.el: Make all line prefixes to have the same length
Date: Tue,  2 Jul 2013 19:34:35 +0200
Message-ID: <1372786477-13122-3-git-send-email-sojkam1@fel.cvut.cz>
References: <1372786477-13122-1-git-send-email-sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>,
	Lawrence Mitchell <wence@gmx.li>,
	=?UTF-8?q?R=C3=BCdiger=20Sonderfeld?= <ruediger@c-plusplus.de>,
	Michal Sojka <sojkam1@fel.cvut.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 02 19:43:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu4bo-0007jb-Mf
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 19:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373Ab3GBRnR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jul 2013 13:43:17 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:55264 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753083Ab3GBRnP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 13:43:15 -0400
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id 6806C19F3618;
	Tue,  2 Jul 2013 19:36:01 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id zEQXG13R_2AU; Tue,  2 Jul 2013 19:35:57 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 273AA19F3636;
	Tue,  2 Jul 2013 19:35:56 +0200 (CEST)
Received: from wsh by steelpick.2x.cz with local (Exim 4.80)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1Uu4Ud-0003VV-4H; Tue, 02 Jul 2013 19:35:55 +0200
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1372786477-13122-1-git-send-email-sojkam1@fel.cvut.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229404>

Without this patch, the beginning of git-blame.el in emacs buffer looks
like this (note the Messige-ID line):

b52ba1   <jnareb@gmail.com>:;; Authors:    David K=C3=A5gedal <davidk@l=
ysator.liu.se>
b52ba1   <jnareb@gmail.com>:;; Created:    31 Jan 2007
28389d <davidk@lysator.liu.se>:;; Message-ID: <87iren2vqx.fsf@morpheus.=
local>
b52ba1   <jnareb@gmail.com>:;; License:    GPL
b52ba1   <jnareb@gmail.com>:;; Keywords:   git, version control, releas=
e management

With this patch, all lines are aligned even if email addresses have
different length.

b52ba1   <jnareb@gmail.com>:   ;; Authors:    David K=C3=A5gedal <david=
k@lysator.liu.se>
b52ba1   <jnareb@gmail.com>:   ;; Created:    31 Jan 2007
28389d <davidk@lysator.liu.se> ;; Message-ID: <87iren2vqx.fsf@morpheus.=
local>
b52ba1   <jnareb@gmail.com>:   ;; License:    GPL
b52ba1   <jnareb@gmail.com>:   ;; Keywords:   git, version control, rel=
ease management


Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 contrib/emacs/git-blame.el | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index 18ce241..573f408 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -116,6 +116,15 @@ mode. The format is passed to `format-spec' with t=
he following format keys:
 "
   :group 'git-blame)
=20
+(defcustom git-blame-prefix-width
+  "%-30.30s "
+  "The format for post-processing the prefix produced according
+to `git-blame-prefix-format'. This format is passed to `format'
+function. The default value ensures that all prefixes have the
+same length, i.e. the it causes the prefix to be either truncated
+or padded to 30 characters.
+"
+  :group 'git-blame)
 (defcustom git-blame-mouseover-format
   "%h %a %A: %s"
   "The format of the description shown when pointing at a line in
@@ -410,8 +419,9 @@ See also function `git-blame-mode'."
               (overlay-put ovl 'face (list :background
                                            (cdr (assq 'color (cdr info=
))))))
           (overlay-put ovl 'line-prefix
-                       (propertize (format-spec git-blame-prefix-forma=
t spec)
-                                   'face 'git-blame-prefix-face)))))))
+                       (propertize (format git-blame-prefix-width
+					   (format-spec git-blame-prefix-format spec))
+					   'face 'git-blame-prefix-face)))))))
=20
 (defun git-blame-add-info (info key value)
   (nconc info (list (cons (intern key) value))))
--=20
1.8.3.1
