From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] completion: rename _git and _gitk
Date: Sat, 19 May 2012 04:41:34 +0200
Message-ID: <1337395295-29162-2-git-send-email-felipe.contreras@gmail.com>
References: <1337395295-29162-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Carsten Mattner <carstenmattner@googlemail.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 19 04:42:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVZcF-0000K4-QQ
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 04:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030479Ab2ESClw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 22:41:52 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:46275 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab2ESClq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 22:41:46 -0400
Received: by mail-we0-f174.google.com with SMTP id u7so2152811wey.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 19:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4FfiX/XwuEaTEL+/e628SjyNdyF/RagixDKsV8W69eM=;
        b=tqyQQ6nxsN8SkWCrwRKiCZaJAmbG79C9tAhXNiBxQCFEldKxNZ++T7xq5P4/fdIVvc
         rwR9twRNCPXzTvvW12vhJRB+t34eVDP0LuVVfX4IondypgCx2BTA0fKou5V8Ul8izOZQ
         0ZzY/lYjHOvKpvqeQprVK+yaG9gboZgGduH6rL+vZrsOLp7sRhMpdYXr3GVnqWsEEWSl
         Dnss5/GxEc36TID8KFGP7mkIfnZxgOp9mybd088XrntAPwcwBWrP1uzjNUho+TXhZxNn
         jOohPSiZfHpCV+BptBWh9bH2wslBBrKOJMhaHSnCBvU52Syhqvcz6cuTp8VMdFiyKF0e
         kwRQ==
Received: by 10.180.7.133 with SMTP id j5mr6821375wia.14.1337395305471;
        Fri, 18 May 2012 19:41:45 -0700 (PDT)
Received: from localhost (ip-109-43-0-59.web.vodafone.de. [109.43.0.59])
        by mx.google.com with ESMTPS id z3sm12114670wix.0.2012.05.18.19.41.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 May 2012 19:41:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
In-Reply-To: <1337395295-29162-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198005>

Would be useful to provide backwards compatibility for _git. Also, zsh
completion uses _git, and it cannot be changed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |   10 +++++-----
 t/t9902-completion.sh                  |    2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index cd92322..3cb106e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2597,7 +2597,7 @@ _git_whatchanged ()
 	_git_log
 }
 
-_git ()
+_main_git ()
 {
 	local i c=1 command __git_dir
 
@@ -2648,7 +2648,7 @@ _git ()
 	fi
 }
 
-_gitk ()
+_main_gitk ()
 {
 	__git_has_doubledash && return
 
@@ -2700,13 +2700,13 @@ __git_complete ()
 		|| complete -o default -o nospace -F $wrapper $1
 }
 
-__git_complete git _git
-__git_complete gitk _gitk
+__git_complete git _main_git
+__git_complete gitk _main_gitk
 
 # The following are necessary only for Cygwin, and only are needed
 # when the user has tab-completed the executable name and consequently
 # included the '.exe' suffix.
 #
 if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
-__git_complete git.exe _git
+__git_complete git.exe _main_git
 fi
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 0f09fd6..9a80c60 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -63,7 +63,7 @@ run_completion ()
 	local _cword
 	_words=( $1 )
 	(( _cword = ${#_words[@]} - 1 ))
-	__git_wrap_git && print_comp
+	__git_wrap_main_git && print_comp
 }
 
 test_completion ()
-- 
1.7.10.2
