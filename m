From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/4] bash: update 'git stash' completion
Date: Tue, 15 Sep 2009 12:21:44 +0200
Message-ID: <0d125e60b97ab58ad51fef170fd36b707a271a10.1253009868.git.szeder@ira.uka.de>
References: <e927e4d3bfe50d93e5e6d65c46821158332b37f9.1253009868.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 15 12:22:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnVB2-0004bX-CS
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 12:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbZIOKWM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 06:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752708AbZIOKWL
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 06:22:11 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:51299 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbZIOKWK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 06:22:10 -0400
Received: from [127.0.1.1] (p5B131467.dip0.t-ipconnect.de [91.19.20.103])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MKt2u-1MnVAo3JmJ-000GxT; Tue, 15 Sep 2009 12:22:11 +0200
X-Mailer: git-send-email 1.6.5.rc1.92.gee3c1
In-Reply-To: <e927e4d3bfe50d93e5e6d65c46821158332b37f9.1253009868.git.szeder@ira.uka.de>
In-Reply-To: <e927e4d3bfe50d93e5e6d65c46821158332b37f9.1253009868.git.szeder@ira.uka.de>
References: <e927e4d3bfe50d93e5e6d65c46821158332b37f9.1253009868.git.szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX18nNr2g0YX0K7f+V5KZ/1/QCqc3CPJ8APAvKjq
 qBB/dH3uhspDzJ333yR10Ee6PUXhwjzPv8LP9ocl6gZS+KQeG1
 8nShLZcuguwT2cokST6Kg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128522>

This update adds 'git stash (apply|pop) --quiet' and all options known
to 'git stash save', and handles the DWIMery from 3c2eb80f (stash:
simplify defaulting to "save" and reject unknown options, 2009-08-18).
Care is taken to avoid offering subcommands in the DWIM case.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index c539385..2529cec 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1878,18 +1878,30 @@ _git_show_branch ()
=20
 _git_stash ()
 {
+	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local save_opts=3D'--keep-index --no-keep-index --quiet --patch'
 	local subcommands=3D'save list show apply clear drop pop create branc=
h'
 	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
-		__gitcomp "$subcommands"
+		case "$cur" in
+		--*)
+			__gitcomp "$save_opts"
+			;;
+		*)
+			if [ -z "$(__git_find_on_cmdline "$save_opts")" ]; then
+				__gitcomp "$subcommands"
+			else
+				COMPREPLY=3D()
+			fi
+			;;
+		esac
 	else
-		local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 		case "$subcommand,$cur" in
 		save,--*)
-			__gitcomp "--keep-index"
+			__gitcomp "$save_opts"
 			;;
 		apply,--*|pop,--*)
-			__gitcomp "--index"
+			__gitcomp "--index --quiet"
 			;;
 		show,--*|drop,--*|branch,--*)
 			COMPREPLY=3D()
--=20
1.6.5.rc1.92.gee3c1
