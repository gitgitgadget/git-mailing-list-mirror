From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: move out of contrib
Date: Fri,  2 May 2014 19:36:43 -0500
Message-ID: <1399077403-19678-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 02:47:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgO74-0001bq-8t
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 02:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbaECArY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 20:47:24 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:34979 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbaECArX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 20:47:23 -0400
Received: by mail-oa0-f43.google.com with SMTP id eb12so6042647oac.2
        for <git@vger.kernel.org>; Fri, 02 May 2014 17:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7WfBAzgsMzJPiGbo+dlZb+7jslCDK/gSXnKC83sN9W4=;
        b=Q3qAjdGlvOMM0yAa1/eVXNcUIWIe6+hP0kmgqjYqcGe3JbFaNt/4VBafSTjf6Mn/8T
         6cm4hLa62FWil/05hSR1fF8+G1VwZWYJ5YtnTDXdYJCDcwE5khHDr5zPy8WgYHRd/zYo
         gYFhrKQeK1pv4cf96Y55u/Uqq4Frxw/mm4q/rSBj1+P0x98+/tLwjZy0lU1Avq8u/WhP
         z/qPHvjs/zU+t9weqUHURjgKDBtqYrIyg2+dR+hVPqTKzVA6pj7OZprzZI4iXZymVFn0
         E50vsct2+pO16QOPXXklNUPTol/Dbla5IAOGeriXgttQyTAIQF7EvwcWTc48BZVT4Cj5
         V+BQ==
X-Received: by 10.182.225.137 with SMTP id rk9mr17978553obc.51.1399078042937;
        Fri, 02 May 2014 17:47:22 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f9sm1416262obm.2.2014.05.02.17.47.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 May 2014 17:47:21 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.20.g204a630
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248012>

These have been stable and widely used for quite a long time, they even
have tests outside of the contrib area, and most distributions ship
them, so they can be considered part of the core already.

Let's move them out of contrib and install them by default.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile                                           | 5 ++++-
 {contrib/completion => shared}/git-completion.bash | 0
 {contrib/completion => shared}/git-completion.zsh  | 0
 {contrib/completion => shared}/git-prompt.sh       | 0
 t/t9902-completion.sh                              | 2 +-
 t/t9903-bash-prompt.sh                             | 2 +-
 6 files changed, 6 insertions(+), 3 deletions(-)
 rename {contrib/completion => shared}/git-completion.bash (100%)
 rename {contrib/completion => shared}/git-completion.zsh (100%)
 rename {contrib/completion => shared}/git-prompt.sh (100%)

diff --git a/Makefile b/Makefile
index a53f3a8..4a022cd 100644
--- a/Makefile
+++ b/Makefile
@@ -1581,6 +1581,7 @@ template_dir_SQ = $(subst ','\'',$(template_dir))
 htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
 prefix_SQ = $(subst ','\'',$(prefix))
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
+sharedir_SQ = $(subst ','\'',$(sharedir))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
@@ -2334,7 +2335,6 @@ endif
 mergetools_instdir_SQ = $(subst ','\'',$(mergetools_instdir))
 
 install_bindir_programs := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)) $(BINDIR_PROGRAMS_NO_X)
-
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
@@ -2344,6 +2344,9 @@ install: all
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
 	$(INSTALL) -m 644 mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
+	$(INSTALL) -D -m 644 shared/git-completion.bash '$(DESTDIR_SQ)$(sharedir_SQ)'/bash-completion/completions/git
+	$(INSTALL) -D -m 644 shared/git-prompt.sh '$(DESTDIR_SQ)$(sharedir_SQ)'/git-core/git-prompt.sh
+	$(INSTALL) -D -m 644 shared/git-completion.zsh '$(DESTDIR_SQ)$(sharedir_SQ)'/zsh/site-functions/_git
 ifndef NO_GETTEXT
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)'
 	(cd po/build/locale && $(TAR) cf - .) | \
diff --git a/contrib/completion/git-completion.bash b/shared/git-completion.bash
similarity index 100%
rename from contrib/completion/git-completion.bash
rename to shared/git-completion.bash
diff --git a/contrib/completion/git-completion.zsh b/shared/git-completion.zsh
similarity index 100%
rename from contrib/completion/git-completion.zsh
rename to shared/git-completion.zsh
diff --git a/contrib/completion/git-prompt.sh b/shared/git-prompt.sh
similarity index 100%
rename from contrib/completion/git-prompt.sh
rename to shared/git-prompt.sh
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2d4beb5..d8674e4 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -32,7 +32,7 @@ complete ()
 
 GIT_TESTING_COMMAND_COMPLETION='add checkout check-attr filter-branch ls-files'
 
-. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
+. "$GIT_BUILD_DIR/shared/git-completion.bash"
 
 # We don't need this function to actually join words or do anything special.
 # Also, it's cleaner to avoid touching bash's internal completion variables.
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 59f875e..272e5b3 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -7,7 +7,7 @@ test_description='test git-specific bash prompt functions'
 
 . ./lib-bash.sh
 
-. "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
+. "$GIT_BUILD_DIR/shared/git-prompt.sh"
 
 actual="$TRASH_DIRECTORY/actual"
 c_red='\\[\\e[31m\\]'
-- 
1.9.2+fc1.20.g204a630
