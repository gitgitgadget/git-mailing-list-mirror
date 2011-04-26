From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: [PATCH] Automatically autoload bashcompinit for ZSH, when needed
Date: Tue, 26 Apr 2011 15:28:10 -0500
Message-ID: <1303849690-20894-1-git-send-email-mstormo@gmail.com>
References: <7vtydkddto.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Marius Storm-Olsen <mstormo@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 22:28:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEos5-0000Ul-Jz
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 22:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755682Ab1DZU23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 16:28:29 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51691 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047Ab1DZU22 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 16:28:28 -0400
Received: by wya21 with SMTP id 21so770437wya.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 13:28:26 -0700 (PDT)
Received: by 10.216.184.129 with SMTP id s1mr5116827wem.32.1303849706484;
        Tue, 26 Apr 2011 13:28:26 -0700 (PDT)
Received: from localhost.localdomain (24-155-176-18.dyn.grandenetworks.net [24.155.176.18])
        by mx.google.com with ESMTPS id l5sm42643wej.8.2011.04.26.13.28.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Apr 2011 13:28:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc2.4.g4d8b3
In-Reply-To: <7vtydkddto.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172124>

If bashcompinit has not already been autoloaded, do so
automatically, as it is required to properly parse the
git-completion file with ZSH.

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 Since I rebased the previous version, I didn't notice that some
 effort had already gone into making git-completion.bash parsable
 with ZSH.
 
 I've therefore dropped everything from the previous patch, and
 rather added some code to automatically do the required steps
 for ZSH, should it not have been done already; as well as
 simplified the 'documentation'.
 
 My appologies for not more closely inspecting the recent changes
 to the file.
 
 contrib/completion/git-completion.bash |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 840ae38..35d1c9b 100755
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
+#    2) Added the following line to your .bashrc/.zshrc:
 #        source ~/.git-completion.sh
 #
 #    3) Consider changing your PS1 to also show the current branch:
-#        PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
+#         Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
+#         ZSH:  PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
 #
 #       The argument to __git_ps1 will be displayed only if you
 #       are currently in a git repository.  The %s token will be
@@ -77,6 +73,13 @@
 #       git@vger.kernel.org
 #
 
+if [[ -n ${ZSH_VERSION-} ]]; then
+	if ! bashcompinit >/dev/null 2>&1; then
+		autoload -U bashcompinit
+		bashcompinit
+	fi
+fi
+
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
 *)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
-- 
1.7.5.rc2.4.g4d8b3
