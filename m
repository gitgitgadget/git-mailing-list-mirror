From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: [PATCH v2] Automatically autoload bashcompinit for ZSH, when needed
Date: Tue, 26 Apr 2011 22:23:35 -0500
Message-ID: <1303874615-24718-1-git-send-email-mstormo@gmail.com>
References: <BANLkTi=qzBGmp80088hVrc+yicH2ofDGEg@mail.gmail.com>
Cc: git@vger.kernel.org, Marius Storm-Olsen <mstormo@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 05:23:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEvM2-00016x-Cv
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 05:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121Ab1D0DXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 23:23:49 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52286 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988Ab1D0DXs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 23:23:48 -0400
Received: by yxs7 with SMTP id 7so312897yxs.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 20:23:48 -0700 (PDT)
Received: by 10.236.122.243 with SMTP id t79mr1946528yhh.167.1303874627286;
        Tue, 26 Apr 2011 20:23:47 -0700 (PDT)
Received: from localhost.localdomain (24-155-176-18.dyn.grandenetworks.net [24.155.176.18])
        by mx.google.com with ESMTPS id z73sm220915yhc.47.2011.04.26.20.23.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Apr 2011 20:23:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc2.4.g4d8b3
In-Reply-To: <BANLkTi=qzBGmp80088hVrc+yicH2ofDGEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172160>

If bashcompinit has not already been autoloaded, do so
automatically, as it is required to properly parse the
git-completion file with ZSH.

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 Changes since v2:
 -----------------
 'Added' -> 'Add'
 Simplified test for bashcompinit, as per advice from Felipe Contreras

 contrib/completion/git-completion.bash |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 840ae38..9150ea6 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1,6 +1,6 @@
 #!bash
 #
-# bash completion support for core Git.
+# bash/zsh completion support for core Git.
 #
 # Copyright (C) 2006,2007 Shawn O. Pearce <spearce@spearce.org>
 # Conceptually based on gitcompletion (http://gitweb.hawaga.org.uk/).
@@ -18,16 +18,12 @@
 # To use these routines:
 #
 #    1) Copy this file to somewhere (e.g. ~/.git-completion.sh).
-#    2) Added the following line to your .bashrc:
-#        source ~/.git-completion.sh
-#
-#       Or, add the following lines to your .zshrc:
-#        autoload bashcompinit
-#        bashcompinit
+#    2) Add the following line to your .bashrc/.zshrc:
 #        source ~/.git-completion.sh
 #
 #    3) Consider changing your PS1 to also show the current branch:
-#        PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
+#         Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
+#         ZSH:  PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
 #
 #       The argument to __git_ps1 will be displayed only if you
 #       are currently in a git repository.  The %s token will be
@@ -77,6 +73,10 @@
 #       git@vger.kernel.org
 #
 
+if [[ -n ${ZSH_VERSION-} ]]; then
+	autoload -U +X bashcompinit && bashcompinit
+fi
+
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
 *)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
-- 
1.7.5.rc2.4.g4d8b3
