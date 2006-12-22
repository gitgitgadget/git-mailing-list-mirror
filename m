From: "Duncan Mak" <duncan@a-chinaman.com>
Subject: Re: [PATCH] fix vc git
Date: Thu, 21 Dec 2006 23:11:32 -0500
Message-ID: <8e745ecf0612212011q26f81d91uce143b4212fc5e8b@mail.gmail.com>
References: <8e745ecf0612210325m72a569d7k370dd5953ccf6f27@mail.gmail.com>
	 <emdr6v$9ma$1@sea.gmane.org>
	 <8e745ecf0612210359j3f895521r1fff497a512253d3@mail.gmail.com>
	 <7vhcvo92fx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 05:11:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxbkw-0008BM-BB
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 05:11:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWLVELe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 23:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754811AbWLVELe
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 23:11:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:10829 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbWLVELe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 23:11:34 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2869319uga
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 20:11:32 -0800 (PST)
Received: by 10.78.185.16 with SMTP id i16mr1144124huf.1166760692834;
        Thu, 21 Dec 2006 20:11:32 -0800 (PST)
Received: by 10.78.172.10 with HTTP; Thu, 21 Dec 2006 20:11:32 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vhcvo92fx.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35125>

I don't think vc-git-registered-file will ever be called with a
filename without a directory, as it is used as a hook on
vc-next-action, which works on a real file.

Either way, it's a modified patch:

Fix vc-git.el to not cd into a non-existent directory.

---

 contrib/emacs/vc-git.el |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

base c902c9a608c1b727160d6fbb04fa363d9418cd00
last 96e9944b714094ab81f8091711a92506886b8004
diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
index 8b6361922fd6e6a2fcd9acb20fd54f5b645b36f0..668bd4a98653046aadf91e7a91af6cd76ba044d4
100644
--- a/contrib/emacs/vc-git.el
+++ b/contrib/emacs/vc-git.el
@@ -58,7 +58,7 @@
   (with-temp-buffer
     (let* ((dir (file-name-directory file))
            (name (file-relative-name file dir)))
-      (when dir (cd dir))
+      (when (and dir (file-exists-p dir)) (cd dir))
       (and (ignore-errors (eq 0 (call-process "git" nil '(t nil) nil
"ls-files" "-c" "-z" "--" name)))
            (let ((str (buffer-string)))
              (and (> (length str) (length name))
-- 
1.4.4.1
