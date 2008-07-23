From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH] bash completion: Add completion for 'git help'
Date: Wed, 23 Jul 2008 17:13:15 -0600
Message-ID: <1216854795-51155-1-git-send-email-lee.marlow@gmail.com>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 24 01:14:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLnXI-0001EE-Fh
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 01:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbYGWXNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 19:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754108AbYGWXNU
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 19:13:20 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:11633 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097AbYGWXNT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 19:13:19 -0400
Received: by yx-out-2324.google.com with SMTP id 8so478780yxm.1
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 16:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=x8iarxwNT3SV0G77/Fo2yr0F2CO3smBFioGmVmhJCkM=;
        b=ULDL0UJ5SWU3rvQyygSdGCRBtjdUcR7qNWm8LziB1AtTHkk+ui4vZQEUSxhqOSEQDV
         h0PECcimxI0VJ9nAAbX9Bpjefy4vtVtuAXHEpFPLRPTEWYPNO0K2OyRhBb5muo26xKrD
         rT3y8tJ6Pbto3ntudlxxgFsV852XIS23wg6y8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=t0HtSwVM1SB3I+ff5wb9PXsaa6xBiEYNFwiRPDEGhSc+Zg188wGQdn9PIiA9DLE+kQ
         tWyxAJqFDQOQmfODUz+A9lCwtYGYPHFzcKzg+o6E+MnnDllbPXCSaOIqBaTrwM2IPrOm
         tvktqjTdL68pdsxq4p5r2JXCRJXsOuqR4aqwI=
Received: by 10.151.153.14 with SMTP id f14mr418067ybo.29.1216854798364;
        Wed, 23 Jul 2008 16:13:18 -0700 (PDT)
Received: from localhost.localdomain ( [72.14.241.7])
        by mx.google.com with ESMTPS id 4sm4679452yxq.8.2008.07.23.16.13.16
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 16:13:17 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89802>

Renamed cached __git_commandlist to __git_porcelain_commandlist
and added __git_all_commandlist that only filters out *--* helpers.
Completions for 'git help' will use the __git_all_commandlist, while
__git_porcelain_commandlist is used for git command completion.
Users who actually read man pages may want to see help for plumbing
commands.

Options added: --all --info --man --web

Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
---
 contrib/completion/git-completion.bash |   46 +++++++++++++++++++++++++++-----
 1 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2edb341..0e37b71 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -349,10 +349,10 @@ __git_complete_revlist ()
 	esac
 }
 
-__git_commands ()
+__git_all_commands ()
 {
-	if [ -n "$__git_commandlist" ]; then
-		echo "$__git_commandlist"
+	if [ -n "$__git_all_commandlist" ]; then
+		echo "$__git_all_commandlist"
 		return
 	fi
 	local i IFS=" "$'\n'
@@ -360,6 +360,24 @@ __git_commands ()
 	do
 		case $i in
 		*--*)             : helper pattern;;
+		*) echo $i;;
+		esac
+	done
+}
+__git_all_commandlist=
+__git_all_commandlist="$(__git_all_commands 2>/dev/null)"
+
+__git_porcelain_commands ()
+{
+	if [ -n "$__git_porcelain_commandlist" ]; then
+		echo "$__git_porcelain_commandlist"
+		return
+	fi
+	local i IFS=" "$'\n'
+	for i in 'help' $__git_all_commands
+	do
+		case $i in
+		*--*)             : helper pattern;;
 		applymbox)        : ask gittus;;
 		applypatch)       : ask gittus;;
 		archimport)       : import;;
@@ -427,8 +445,8 @@ __git_commands ()
 		esac
 	done
 }
-__git_commandlist=
-__git_commandlist="$(__git_commands 2>/dev/null)"
+__git_porcelain_commandlist=
+__git_porcelain_commandlist="$(__git_porcelain_commands 2>/dev/null)"
 
 __git_aliases ()
 {
@@ -767,6 +785,18 @@ _git_gc ()
 	COMPREPLY=()
 }
 
+_git_help ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		__gitcomp "--all --info --man --web"
+		return
+		;;
+	esac
+	__gitcomp "$(__git_all_commands)"
+}
+
 _git_ls_remote ()
 {
 	__gitcomp "$(__git_remotes)"
@@ -1369,7 +1399,8 @@ _git ()
 		case "$i" in
 		--git-dir=*) __git_dir="${i#--git-dir=}" ;;
 		--bare)      __git_dir="." ;;
-		--version|--help|-p|--paginate) ;;
+		--version|-p|--paginate) ;;
+		--help) command="help"; break ;;
 		*) command="$i"; break ;;
 		esac
 		c=$((++c))
@@ -1389,7 +1420,7 @@ _git ()
 			--help
 			"
 			;;
-		*)     __gitcomp "$(__git_commands) $(__git_aliases)" ;;
+		*)     __gitcomp "$(__git_porcelain_commands) $(__git_aliases)" ;;
 		esac
 		return
 	fi
@@ -1414,6 +1445,7 @@ _git ()
 	fetch)       _git_fetch ;;
 	format-patch) _git_format_patch ;;
 	gc)          _git_gc ;;
+	help)        _git_help ;;
 	log)         _git_log ;;
 	ls-remote)   _git_ls_remote ;;
 	ls-tree)     _git_ls_tree ;;
-- 
1.6.0.rc0.14.g95f8
