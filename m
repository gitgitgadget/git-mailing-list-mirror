From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/4] bash: rename __git_find_subcommand() to
	__git_find_on_cmdline()
Date: Tue, 15 Sep 2009 12:21:43 +0200
Message-ID: <e927e4d3bfe50d93e5e6d65c46821158332b37f9.1253009868.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 15 12:22:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnVAq-0004XY-Pg
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 12:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690AbZIOKWE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 06:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752663AbZIOKWD
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 06:22:03 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:52878 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbZIOKWB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 06:22:01 -0400
Received: from [127.0.1.1] (p5B131467.dip0.t-ipconnect.de [91.19.20.103])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MKt2u-1MnVAd1brA-000Fh3; Tue, 15 Sep 2009 12:22:00 +0200
X-Mailer: git-send-email 1.6.5.rc1.92.gee3c1
X-Provags-ID: V01U2FsdGVkX18hQY2a2067jh5w6n2Qmx6xhk81X5zIJA6sGw/
 H1Cb+New5gp6y/92/MUXpfX8IlT9rFdcUdNTZsUXtAyrX/Ky74
 WUXonVJQfuSqL09Vh1plg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128520>

__git_find_subcommand() was originally meant to check whether
subcommands are already present on the command line.  But the code is
general enough to be used for checking the presence of command line
options as well, and the next commit will use it for that purpose, so
let's give it a more general name.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index f47c519..c539385 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -619,8 +619,8 @@ __git_aliased_command ()
 	done
 }
=20
-# __git_find_subcommand requires 1 argument
-__git_find_subcommand ()
+# __git_find_on_cmdline requires 1 argument
+__git_find_on_cmdline ()
 {
 	local word subcommand c=3D1
=20
@@ -739,7 +739,7 @@ _git_bisect ()
 	__git_has_doubledash && return
=20
 	local subcommands=3D"start bad good skip reset visualize replay log r=
un"
-	local subcommand=3D"$(__git_find_subcommand "$subcommands")"
+	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
 		return
@@ -1751,7 +1751,7 @@ _git_config ()
 _git_remote ()
 {
 	local subcommands=3D"add rename rm show prune update set-head"
-	local subcommand=3D"$(__git_find_subcommand "$subcommands")"
+	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
 		return
@@ -1879,7 +1879,7 @@ _git_show_branch ()
 _git_stash ()
 {
 	local subcommands=3D'save list show apply clear drop pop create branc=
h'
-	local subcommand=3D"$(__git_find_subcommand "$subcommands")"
+	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
 	else
@@ -1910,7 +1910,7 @@ _git_submodule ()
 	__git_has_doubledash && return
=20
 	local subcommands=3D"add status init update summary foreach sync"
-	if [ -z "$(__git_find_subcommand "$subcommands")" ]; then
+	if [ -z "$(__git_find_on_cmdline "$subcommands")" ]; then
 		local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 		case "$cur" in
 		--*)
@@ -1932,7 +1932,7 @@ _git_svn ()
 		proplist show-ignore show-externals branch tag blame
 		migrate
 		"
-	local subcommand=3D"$(__git_find_subcommand "$subcommands")"
+	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
 	else
--=20
1.6.5.rc1.92.gee3c1
