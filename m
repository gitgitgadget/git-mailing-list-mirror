From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH 2/2] bash completion: Sync config variables with its man page
Date: Mon, 15 Dec 2008 10:45:49 -0700
Message-ID: <1229363149-37757-2-git-send-email-lee.marlow@gmail.com>
References: <1229363149-37757-1-git-send-email-lee.marlow@gmail.com>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 15 18:47:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCHXQ-00056T-Vg
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 18:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755432AbYLORp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 12:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755429AbYLORp6
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 12:45:58 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:57495 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755355AbYLORp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 12:45:57 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1117803yxb.65
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 09:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=r83RhOjr6WhiNamYJkcP7iCgh2WC6uakbYlWR0+d6cE=;
        b=jZ5nSDyw/ZSjXmSwZFi2Ef8gjLjPjDhvhaKdEWp4oSA/Ce/l87i5Y7lm/9gMDIfB32
         6Sm5pmqiLlEV94ZH2B7z25qgTALUJBLvUDhOpQ++Me7PIY1kOiDQ1FGdBrKgRpTOxpMp
         Zlx77Uq3iCW/t6eHP7ac2X+Yz67w/286WufUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FmSnXG5kzNlux/hBJ8rT4QR7TSVwYy1bE3svUn8pNfVhYdDGMzQ/sFPJv0pPL8ljFw
         LR2S+UiGKbYKiQMGvOgdDlBLphMdr6gndTjxTy4tt+OQ72Fea31vYqmmPp/kylIDDSlL
         hfIVumJmsAd2WO4hga+712Q+ps7EAc4E/MozY=
Received: by 10.90.56.16 with SMTP id e16mr3901151aga.72.1229363155572;
        Mon, 15 Dec 2008 09:45:55 -0800 (PST)
Received: from localhost.localdomain ([12.25.108.178])
        by mx.google.com with ESMTPS id 9sm8734004yxs.35.2008.12.15.09.45.53
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Dec 2008 09:45:54 -0800 (PST)
X-Mailer: git-send-email 1.6.1.rc2.20.gde0d
In-Reply-To: <1229363149-37757-1-git-send-email-lee.marlow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103191>

Add 'normal' to config color options.
Add 'mergeoptions' to branch config options.
Add 'proxy' and 'mirror' to remote config options.

Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
---
 contrib/completion/git-completion.bash |   87 +++++++++++++++++++++++++++++---
 1 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 79cbed5..e004549 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1155,7 +1155,7 @@ _git_config ()
 		;;
 	color.*.*)
 		__gitcomp "
-			black red green yellow blue magenta cyan white
+			normal black red green yellow blue magenta cyan white
 			bold dim ul blink reverse
 			"
 		return
@@ -1179,7 +1179,7 @@ _git_config ()
 	branch.*.*)
 		local pfx="${cur%.*}."
 		cur="${cur##*.}"
-		__gitcomp "remote merge" "$pfx" "$cur"
+		__gitcomp "remote merge mergeoptions" "$pfx" "$cur"
 		return
 		;;
 	branch.*)
@@ -1192,7 +1192,7 @@ _git_config ()
 		local pfx="${cur%.*}."
 		cur="${cur##*.}"
 		__gitcomp "
-			url fetch push skipDefaultUpdate
+			url proxy fetch push mirror skipDefaultUpdate
 			receivepack uploadpack tagopt
 			" "$pfx" "$cur"
 		return
@@ -1206,6 +1206,8 @@ _git_config ()
 	esac
 	__gitcomp "
 		apply.whitespace
+		branch.autosetupmerge
+		branch.autosetuprebase
 		clean.requireForce
 		color.branch
 		color.branch.current
@@ -1220,46 +1222,95 @@ _git_config ()
 		color.diff.old
 		color.diff.plain
 		color.diff.whitespace
+		color.interactive
+		color.interactive.header
+		color.interactive.help
+		color.interactive.prompt
 		color.pager
 		color.status
 		color.status.added
 		color.status.changed
 		color.status.header
+		color.status.nobranch
 		color.status.untracked
+		color.status.updated
+		color.ui
+		commit.template
+		core.autocrlf
+		core.bare
 		core.compression
+		core.deltaBaseCacheLimit
+		core.editor
+		core.excludesfile
 		core.fileMode
+		core.fsyncobjectfiles
 		core.gitProxy
+		core.ignoreCygwinFSTricks
 		core.ignoreStat
 		core.logAllRefUpdates
 		core.loosecompression
 		core.packedGitLimit
 		core.packedGitWindowSize
+		core.pager
 		core.preferSymlinkRefs
+		core.preloadindex
+		core.quotepath
 		core.repositoryFormatVersion
+		core.safecrlf
 		core.sharedRepository
+		core.symlinks
+		core.trustctime
 		core.warnAmbiguousRefs
+		core.whitespace
+		core.worktree
+		diff.autorefreshindex
+		diff.external
+		diff.mnemonicprefix
 		diff.renameLimit
+		diff.renameLimit.
 		diff.renames
 		fetch.unpackLimit
 		format.headers
-		format.subjectprefix
+		format.numbered
+		format.pretty
+		format.suffix
+		gc.aggressiveWindow
+		gc.auto
+		gc.autopacklimit
 		gc.packrefs
+		gc.pruneexpire
 		gc.reflogexpire
 		gc.reflogexpireunreachable
 		gc.rerereresolved
 		gc.rerereunresolved
 		gitcvs.allbinary
+		gitcvs.dbTableNamePrefix
 		gitcvs.dbdriver
 		gitcvs.dbname
 		gitcvs.dbpass
-		gitcvs.dbtablenameprefix
 		gitcvs.dbuser
 		gitcvs.enabled
 		gitcvs.logfile
+		gitcvs.usecrlfattr
+		gui.blamehistoryctx
+		gui.commitmsgwidth
+		gui.copyblamethreshold
+		gui.diffcontext
+		gui.encoding
+		gui.fastcopyblame
+		gui.matchtrackingbranch
+		gui.newbranchtemplate
+		gui.pruneduringfetch
+		gui.spellingdictionary
+		gui.trustmtime
+		help.autocorrect
+		help.browser
+		help.format
 		http.lowSpeedLimit
 		http.lowSpeedTime
 		http.maxRequests
 		http.noEPSV
+		http.proxy
 		http.sslCAInfo
 		http.sslCAPath
 		http.sslCert
@@ -1267,27 +1318,49 @@ _git_config ()
 		http.sslVerify
 		i18n.commitEncoding
 		i18n.logOutputEncoding
+		instaweb.browser
+		instaweb.httpd
+		instaweb.local
+		instaweb.modulepath
+		instaweb.port
+		log.date
 		log.showroot
-		merge.summary
+		man.viewer
+		merge.conflictstyle
+		merge.log
+		merge.renameLimit
+		merge.stat
 		merge.tool
 		merge.verbosity
+		mergetool.keepBackup
 		pack.compression
 		pack.deltaCacheLimit
 		pack.deltaCacheSize
 		pack.depth
+		pack.indexVersion
+		pack.packSizeLimit
+		pack.threads
 		pack.window
 		pack.windowMemory
 		pull.octopus
 		pull.twohead
+		receive.denyCurrentBranch
+		receive.denyDeletes
 		receive.denyNonFastForwards
+		receive.fsckObjects
 		receive.unpackLimit
-		repack.useDeltaBaseOffset
+		repack.usedeltabaseoffset
+		rerere.autoupdate
+		rerere.enabled
 		showbranch.default
+		status.relativePaths
+		status.showUntrackedFiles
 		tar.umask
 		transfer.unpackLimit
 		user.email
 		user.name
 		user.signingkey
+		web.browser
 		branch. remote.
 	"
 }
-- 
1.6.1.rc2.20.gde0d
