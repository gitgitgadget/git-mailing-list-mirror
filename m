From: malc@pulsesoft.com
Subject: [PATCH] Change octal literals to be XEmacs friendly
Date: Wed, 21 Jan 2009 20:02:39 +0300
Message-ID: <871vuwbnio.fsf@linmac.oyster.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 21 19:56:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPiFa-0004zn-AN
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 19:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273AbZAUSzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 13:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbZAUSzF
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 13:55:05 -0500
Received: from main.gmane.org ([80.91.229.2]:55703 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751603AbZAUSzD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 13:55:03 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LPiEB-0001Vz-2w
	for git@vger.kernel.org; Wed, 21 Jan 2009 18:55:03 +0000
Received: from 83.167.112.74 ([83.167.112.74])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 18:55:03 +0000
Received: from malc by 83.167.112.74 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 18:55:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 83.167.112.74
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.4.20 (linux)
Cancel-Lock: sha1:6Mi0IhTe/S470Rp1O8i44/L1KQU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106640>


case uses eql and (eql ?\001 1) evaluates to nil under XEmacs
(probably because some internal type of ?\001 is char)

Signed-off-by: Vassili Karpov <av1474@comtv.ru>
---
 contrib/emacs/git.el |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 09e8bae..715580a 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -562,29 +562,29 @@ the process output as a string, or nil if the git command failed."
   (let* ((old-type (lsh (or old-perm 0) -9))
         (new-type (lsh (or new-perm 0) -9))
         (str (case new-type
-               (?\100  ;; file
+               (#o100  ;; file
                 (case old-type
-                  (?\100 nil)
-                  (?\120 "   (type change symlink -> file)")
-                  (?\160 "   (type change subproject -> file)")))
-                (?\120  ;; symlink
+                  (#o100 nil)
+                  (#o120 "   (type change symlink -> file)")
+                  (#o160 "   (type change subproject -> file)")))
+                (#o120  ;; symlink
                  (case old-type
-                   (?\100 "   (type change file -> symlink)")
-                   (?\160 "   (type change subproject -> symlink)")
+                   (#o100 "   (type change file -> symlink)")
+                   (#o160 "   (type change subproject -> symlink)")
                    (t "   (symlink)")))
-                 (?\160  ;; subproject
+                 (#o160  ;; subproject
                   (case old-type
-                    (?\100 "   (type change file -> subproject)")
-                    (?\120 "   (type change symlink -> subproject)")
+                    (#o100 "   (type change file -> subproject)")
+                    (#o120 "   (type change symlink -> subproject)")
                     (t "   (subproject)")))
-                  (?\110 nil)  ;; directory (internal, not a real git state)
-                 (?\000  ;; deleted or unknown
+                  (#o110 nil)  ;; directory (internal, not a real git state)
+                 (#o000  ;; deleted or unknown
                   (case old-type
-                    (?\120 "   (symlink)")
-                    (?\160 "   (subproject)")))
+                    (#o120 "   (symlink)")
+                    (#o160 "   (subproject)")))
                  (t (format "   (unknown type %o)" new-type)))))
     (cond (str (propertize str 'face 'git-status-face))
-          ((eq new-type ?\110) "/")
+          ((eq new-type #o110) "/")
           (t ""))))
 
 (defun git-rename-as-string (info)

-- 
mailto:av1474@comtv.ru
