From: Teemu Matilainen <teemu.matilainen@iki.fi>
Subject: [PATCH 2/2] bash: Use dynamic binding for subcommand completion functions
Date: Tue, 23 Feb 2010 16:43:13 +0200
Message-ID: <1266936193-10644-2-git-send-email-teemu.matilainen@iki.fi>
References: <1266936193-10644-1-git-send-email-teemu.matilainen@iki.fi>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Teemu Matilainen <teemu.matilainen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 15:43:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjvzB-0007zl-VI
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 15:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042Ab0BWOni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 09:43:38 -0500
Received: from mx.reaktor.fi ([82.203.205.80]:60455 "EHLO mx.reaktor.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752217Ab0BWOnh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 09:43:37 -0500
Received: from localhost.localdomain (v16-6.openvpn.reaktor.fi [10.1.16.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx.reaktor.fi (Postfix) with ESMTPSA id 8BA4A2626A;
	Tue, 23 Feb 2010 16:43:34 +0200 (EET)
X-Mailer: git-send-email 1.7.0.83.g241b9
In-Reply-To: <1266936193-10644-1-git-send-email-teemu.matilainen@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140805>

Call git subcommand completion functions dynamically using the same
logic as with external commands.  I.e. call '_git_<subcommand>' if it
exists.

The only exceptions now are:
  - stage -> _git_add
  - whatchanged -> _git_log

This only changes how the functions are called.  The functionality remains
exactly the same.

Signed-off-by: Teemu Matilainen <teemu.matilainen@iki.fi>
---
 contrib/completion/git-completion.bash |   61 +++-----------------------------
 1 files changed, 5 insertions(+), 56 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c7ac727..1d71e87 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2208,63 +2208,12 @@ _git ()
 	[ "$expansion" ] && command="$expansion"
 
 	case "$command" in
-	am)          _git_am ;;
-	add)         _git_add ;;
-	apply)       _git_apply ;;
-	archive)     _git_archive ;;
-	bisect)      _git_bisect ;;
-	bundle)      _git_bundle ;;
-	branch)      _git_branch ;;
-	checkout)    _git_checkout ;;
-	cherry)      _git_cherry ;;
-	cherry-pick) _git_cherry_pick ;;
-	clean)       _git_clean ;;
-	clone)       _git_clone ;;
-	commit)      _git_commit ;;
-	config)      _git_config ;;
-	describe)    _git_describe ;;
-	diff)        _git_diff ;;
-	difftool)    _git_difftool ;;
-	fetch)       _git_fetch ;;
-	format-patch) _git_format_patch ;;
-	fsck)        _git_fsck ;;
-	gc)          _git_gc ;;
-	grep)        _git_grep ;;
-	help)        _git_help ;;
-	init)        _git_init ;;
-	log)         _git_log ;;
-	ls-files)    _git_ls_files ;;
-	ls-remote)   _git_ls_remote ;;
-	ls-tree)     _git_ls_tree ;;
-	merge)       _git_merge;;
-	mergetool)   _git_mergetool;;
-	merge-base)  _git_merge_base ;;
-	mv)          _git_mv ;;
-	name-rev)    _git_name_rev ;;
-	notes)       _git_notes ;;
-	pull)        _git_pull ;;
-	push)        _git_push ;;
-	rebase)      _git_rebase ;;
-	remote)      _git_remote ;;
-	replace)     _git_replace ;;
-	reset)       _git_reset ;;
-	revert)      _git_revert ;;
-	rm)          _git_rm ;;
-	send-email)  _git_send_email ;;
-	shortlog)    _git_shortlog ;;
-	show)        _git_show ;;
-	show-branch) _git_show_branch ;;
-	stash)       _git_stash ;;
-	stage)       _git_add ;;
-	submodule)   _git_submodule ;;
-	svn)         _git_svn ;;
-	tag)         _git_tag ;;
-	whatchanged) _git_log ;;
-	*)
-		local f="_git_${command//-/_}"
-		type -t "$f" >/dev/null && "$f" || COMPREPLY=()
-		;;
+	stage)       command="add" ;;
+	whatchanged) command="log" ;;
 	esac
+
+	local f="_git_${command//-/_}"
+	type -t "$f" >/dev/null && "$f" || COMPREPLY=()
 }
 
 _gitk ()
-- 
1.7.0.83.g241b9
