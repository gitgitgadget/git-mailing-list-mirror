From: Matt Korostoff <mkorostoff@gmail.com>
Subject: [PATCH] contrib/completion: deprecate __git_remotes in bash completion
Date: Tue, 10 Feb 2015 10:25:07 -0500
Message-ID: <1423581907-88600-1-git-send-email-MKorostoff@gmail.com>
References: <20150210031008.Horde.1WYJ_81O2E96Rgv2xrVmqw1@webmail.informatik.kit.edu>
Cc: Matt Korostoff <MKorostoff@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 16:24:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLCgB-0002w2-Dx
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 16:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbbBJPYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 10:24:43 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:48633 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbbBJPYm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 10:24:42 -0500
Received: by mail-qg0-f47.google.com with SMTP id q107so11955635qgd.6
        for <git@vger.kernel.org>; Tue, 10 Feb 2015 07:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=JUVZPmVh6VRp/K9JPSrLUWAa/T4Wa1Dzg5GeZkZaVhY=;
        b=Mc8UscnvXazg+SyEi5kQA6NTrkJkf1AMtuYEBL7EtbbOsePV673bJ8kpfP7l/2L2eY
         K4tz3vY39OIIOJ/g4iLBCvmS7z/eUN2Ezx8q+8vm9kXdWKCxe+UFSLPMI34x56Qj0bjX
         o4h4t4dkwxtkPogoJEABN4ut5TaGp2mAbbdfmCFLWUv3N2flwnmg7ul37UoHK4GPuZwl
         k0/3c8m5vjplT7FIQKUGBhL7juhTOVBpjenP0cIUZuw5lTTzvQ9AKLUSOmCF7xqSZLxj
         sW+w8rW6qflZfo1VBwFK5gfMj3NOK9f6EK1EC7Rao4Fad/vFb/eGTLH+UbE8lF/dWpvj
         F8uQ==
X-Received: by 10.140.28.166 with SMTP id 35mr14254158qgz.5.1423581881944;
        Tue, 10 Feb 2015 07:24:41 -0800 (PST)
Received: from localhost.localdomain (static-71-172-38-122.nwrknj.fios.verizon.net. [71.172.38.122])
        by mx.google.com with ESMTPSA id z7sm7207529qah.30.2015.02.10.07.24.41
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Feb 2015 07:24:41 -0800 (PST)
X-Google-Original-From: Matt Korostoff <MKorostoff@gmail.com>
X-Mailer: git-send-email 1.7.10.2 (Apple Git-33)
In-Reply-To: <20150210031008.Horde.1WYJ_81O2E96Rgv2xrVmqw1@webmail.informatik.kit.edu>
In-Reply-To: <20150210031008.Horde.1WYJ_81O2E96Rgv2xrVmqw1@webmail.informatik.kit.edu>
References: <20150210031008.Horde.1WYJ_81O2E96Rgv2xrVmqw1@webmail.informatik.kit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263633>

Bash auto completion supplies a function __git_remotes which
lists the git remotes of a repository by reading the
.git/remotes directory.  As of git 1.7.6 this is handled
natively by the `git remote` command.  This function is
now deprecated.

Signed-off-by: Matt Korostoff <MKorostoff@gmail.com>
---

*****

Great point Gabor! I would hesitate a little about removing the function 
entirely, because users may have external scripts that rely on this function,
but certainly for our internal purposes the __git_remotes shell function can be
replaced with the native.  Here's a short screen cast of the included patch 
working on my local http://i.imgur.com/6ZSMXCO.gif

*****

 contrib/completion/git-completion.bash |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2fece98..8b41871 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -409,14 +409,14 @@ __git_refs_remotes ()
 	done
 }
 
+# Deprecated wrapper function around git remote.  Supplied for legacy purposes,
+# to avoid breaking any external scripts which rely on this function.
+# Originally this function was used to programmatically generate a list of git
+# remotes by reading the .git/remotes directory, but as of git 1.7.6 that is
+# natively handled by the git remote command
 __git_remotes ()
 {
-	local i IFS=$'\n' d="$(__gitdir)"
-	test -d "$d/remotes" && ls -1 "$d/remotes"
-	for i in $(git --git-dir="$d" config --get-regexp 'remote\..*\.url' 2>/dev/null); do
-		i="${i#remote.}"
-		echo "${i/.url*/}"
-	done
+	git remote
 }
 
 __git_list_merge_strategies ()
@@ -558,7 +558,7 @@ __git_complete_remote_or_refspec ()
 		((c++))
 	done
 	if [ -z "$remote" ]; then
-		__gitcomp_nl "$(__git_remotes)"
+		__gitcomp_nl "$(git remote)"
 		return
 	fi
 	if [ $no_complete_refspec = 1 ]; then
@@ -927,7 +927,7 @@ _git_archive ()
 		return
 		;;
 	--remote=*)
-		__gitcomp_nl "$(__git_remotes)" "" "${cur##--remote=}"
+		__gitcomp_nl "$(git remote)" "" "${cur##--remote=}"
 		return
 		;;
 	--*)
@@ -1397,7 +1397,7 @@ _git_ls_files ()
 
 _git_ls_remote ()
 {
-	__gitcomp_nl "$(__git_remotes)"
+	__gitcomp_nl "$(git remote)"
 }
 
 _git_ls_tree ()
@@ -1639,7 +1639,7 @@ _git_push ()
 {
 	case "$prev" in
 	--repo)
-		__gitcomp_nl "$(__git_remotes)"
+		__gitcomp_nl "$(git remote)"
 		return
 		;;
 	--recurse-submodules)
@@ -1649,7 +1649,7 @@ _git_push ()
 	esac
 	case "$cur" in
 	--repo=*)
-		__gitcomp_nl "$(__git_remotes)" "" "${cur##--repo=}"
+		__gitcomp_nl "$(git remote)" "" "${cur##--repo=}"
 		return
 		;;
 	--recurse-submodules=*)
@@ -1797,7 +1797,7 @@ _git_config ()
 {
 	case "$prev" in
 	branch.*.remote|branch.*.pushremote)
-		__gitcomp_nl "$(__git_remotes)"
+		__gitcomp_nl "$(git remote)"
 		return
 		;;
 	branch.*.merge)
@@ -1809,7 +1809,7 @@ _git_config ()
 		return
 		;;
 	remote.pushdefault)
-		__gitcomp_nl "$(__git_remotes)"
+		__gitcomp_nl "$(git remote)"
 		return
 		;;
 	remote.*.fetch)
@@ -1944,7 +1944,7 @@ _git_config ()
 		;;
 	remote.*)
 		local pfx="${cur%.*}." cur_="${cur#*.}"
-		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
+		__gitcomp_nl "$(git remote)" "$pfx" "$cur_" "."
 		__gitcomp_nl_append "pushdefault" "$pfx" "$cur_"
 		return
 		;;
@@ -2250,7 +2250,7 @@ _git_remote ()
 
 	case "$subcommand" in
 	rename|remove|set-url|show|prune)
-		__gitcomp_nl "$(__git_remotes)"
+		__gitcomp_nl "$(git remote)"
 		;;
 	set-head|set-branches)
 		__git_complete_remote_or_refspec
-- 
1.7.10.2 (Apple Git-33)
