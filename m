From: Vassili Karpov <av1474@comtv.ru>
Subject: [PATCH v2] Change octal literals to be XEmacs friendly
Date: Sat, 24 Jan 2009 02:20:52 +0300 (MSK)
Message-ID: <Pine.LNX.4.64.0901240219530.19590@linmac.oyster.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Sat Jan 24 00:22:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQVLn-00057f-4W
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 00:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757903AbZAWXUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 18:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757743AbZAWXUr
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 18:20:47 -0500
Received: from fe01x03-cgp.akado.ru ([77.232.31.164]:55278 "EHLO akado.ru"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757572AbZAWXUq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 18:20:46 -0500
Received: from [10.0.66.9] ([10.0.66.9] verified)
  by fe01-cgp.akado.ru (CommuniGate Pro SMTP 5.1.16)
  with ESMTPS id 54110093; Sat, 24 Jan 2009 02:20:41 +0300
X-X-Sender: malc@linmac.oyster.ru
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106931>


The type-of ?\octal in XEmacs is character while in FSF Emacs it is
integer. Case expression using this syntax will not work correctly on
XEmacs. #ooctal syntax on the other hand produces integers everywhere.

Signed-off-by: Vassili Karpov <av1474@comtv.ru>
---
  contrib/emacs/git.el |   30 +++++++++++++++---------------
  1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 09e8bae..715580a 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -562,29 +562,29 @@ the process output as a string, or nil if the git 
command failed."
    (let* ((old-type (lsh (or old-perm 0) -9))
  	 (new-type (lsh (or new-perm 0) -9))
  	 (str (case new-type
-		(?\100  ;; file
+		(#o100  ;; file
  		 (case old-type
-		   (?\100 nil)
-		   (?\120 "   (type change symlink -> file)")
-		   (?\160 "   (type change subproject -> file)")))
-		 (?\120  ;; symlink
+		   (#o100 nil)
+		   (#o120 "   (type change symlink -> file)")
+		   (#o160 "   (type change subproject -> file)")))
+		 (#o120  ;; symlink
  		  (case old-type
-		    (?\100 "   (type change file -> symlink)")
-		    (?\160 "   (type change subproject -> symlink)")
+		    (#o100 "   (type change file -> symlink)")
+		    (#o160 "   (type change subproject -> symlink)")
  		    (t "   (symlink)")))
-		  (?\160  ;; subproject
+		  (#o160  ;; subproject
  		   (case old-type
-		     (?\100 "   (type change file -> subproject)")
-		     (?\120 "   (type change symlink -> subproject)")
+		     (#o100 "   (type change file -> subproject)")
+		     (#o120 "   (type change symlink -> subproject)")
  		     (t "   (subproject)")))
-                  (?\110 nil)  ;; directory (internal, not a real git 
state)
-		  (?\000  ;; deleted or unknown
+                  (#o110 nil)  ;; directory (internal, not a real git 
state)
+		  (#o000  ;; deleted or unknown
  		   (case old-type
-		     (?\120 "   (symlink)")
-		     (?\160 "   (subproject)")))
+		     (#o120 "   (symlink)")
+		     (#o160 "   (subproject)")))
  		  (t (format "   (unknown type %o)" new-type)))))
      (cond (str (propertize str 'face 'git-status-face))
-          ((eq new-type ?\110) "/")
+          ((eq new-type #o110) "/")
            (t ""))))

  (defun git-rename-as-string (info)
-- 
1.6.0.2.GIT



-- 
mailto:av1474@comtv.ru
