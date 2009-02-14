From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/2] bash: update 'git svn' options
Date: Sat, 14 Feb 2009 17:21:53 +0100
Message-ID: <1234628513-4573-2-git-send-email-szeder@ira.uka.de>
References: <1234628513-4573-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Feb 14 17:23:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYNIe-0003Uv-8E
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 17:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbZBNQWE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Feb 2009 11:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbZBNQWB
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 11:22:01 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:52109 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbZBNQV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 11:21:59 -0500
Received: from [127.0.1.1] (p5B130271.dip0.t-ipconnect.de [91.19.2.113])
	by mrelayeu.kundenserver.de (node=mrelayeu8) with ESMTP (Nemesis)
	id 0ML31I-1LYNHA3IfG-0007an; Sat, 14 Feb 2009 17:21:57 +0100
X-Mailer: git-send-email 1.6.2.rc0.111.g246ed
In-Reply-To: <1234628513-4573-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX1/GCn+GJSc5Px0zska4765MRdfS8RyZqAo0wdL
 +khxXnlI+Iv/QhVI1Tv9P4e7UHe02epWnVSyOiiOjt0STToNQy
 KOjdiMorvl8CBd4SMR6Zw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109879>

'git svn' got some new subcommands and otions in the last couple of
months.  This patch adds completion support for them.

In particular:

  * 'fetch', 'clone', etc.: '--ignore-paths=3D'
  * 'init' and 'clone': '--prefix=3D', '--use-log-author',
                        '--add-author-from'
  * 'dcommit': '--commit-url', '--revision'
  * 'log': '--color'
  * 'rebase': '--dry-run'
  * 'branch', 'tag', 'blame', 'migrate' subcommands and their options

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   31 ++++++++++++++++++++++++=
+------
 1 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 18cabe2..625e580 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1603,7 +1603,8 @@ _git_svn ()
 	local subcommands=3D"
 		init fetch clone rebase dcommit log find-rev
 		set-tree commit-diff info create-ignore propget
-		proplist show-ignore show-externals
+		proplist show-ignore show-externals branch tag blame
+		migrate
 		"
 	local subcommand=3D"$(__git_find_subcommand "$subcommands")"
 	if [ -z "$subcommand" ]; then
@@ -1614,13 +1615,15 @@ _git_svn ()
 			--follow-parent --authors-file=3D --repack=3D
 			--no-metadata --use-svm-props --use-svnsync-props
 			--log-window-size=3D --no-checkout --quiet
-			--repack-flags --use-log-author --localtime $remote_opts
+			--repack-flags --use-log-author --localtime
+			--ignore-paths=3D $remote_opts
 			"
 		local init_opts=3D"
 			--template=3D --shared=3D --trunk=3D --tags=3D
 			--branches=3D --stdlayout --minimize-url
 			--no-metadata --use-svm-props --use-svnsync-props
-			--rewrite-root=3D $remote_opts
+			--rewrite-root=3D --prefix=3D --use-log-author
+			--add-author-from $remote_opts
 			"
 		local cmt_opts=3D"
 			--edit --rmdir --find-copies-harder --copy-similarity=3D
@@ -1640,7 +1643,8 @@ _git_svn ()
 		dcommit,--*)
 			__gitcomp "
 				--merge --strategy=3D --verbose --dry-run
-				--fetch-all --no-rebase $cmt_opts $fc_opts
+				--fetch-all --no-rebase --commit-url
+				--revision $cmt_opts $fc_opts
 				"
 			;;
 		set-tree,--*)
@@ -1654,13 +1658,13 @@ _git_svn ()
 			__gitcomp "
 				--limit=3D --revision=3D --verbose --incremental
 				--oneline --show-commit --non-recursive
-				--authors-file=3D
+				--authors-file=3D --color
 				"
 			;;
 		rebase,--*)
 			__gitcomp "
 				--merge --verbose --strategy=3D --local
-				--fetch-all $fc_opts
+				--fetch-all --dry-run $fc_opts
 				"
 			;;
 		commit-diff,--*)
@@ -1669,6 +1673,21 @@ _git_svn ()
 		info,--*)
 			__gitcomp "--url"
 			;;
+		branch,--*)
+			__gitcomp "--dry-run --message --tag"
+			;;
+		tag,--*)
+			__gitcomp "--dry-run --message"
+			;;
+		blame,--*)
+			__gitcomp "--git-format"
+			;;
+		migrate,--*)
+			__gitcomp "
+				--config-dir=3D --ignore-paths=3D --minimize
+				--no-auth-cache --username=3D
+				"
+			;;
 		*)
 			COMPREPLY=3D()
 			;;
--=20
1.6.2.rc0.111.g246ed
