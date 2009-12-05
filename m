From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: update 'git commit' completion
Date: Sat,  5 Dec 2009 01:51:41 +0100
Message-ID: <1259974301-11593-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Dec 05 01:52:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGism-0005Ab-5X
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 01:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbZLEAwB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Dec 2009 19:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbZLEAwA
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 19:52:00 -0500
Received: from moutng.kundenserver.de ([212.227.17.9]:63164 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932525AbZLEAwA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 19:52:00 -0500
Received: from [127.0.1.1] (p5B130A6D.dip0.t-ipconnect.de [91.19.10.109])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MOlGA-1NDz3b0pkc-006Fvf; Sat, 05 Dec 2009 01:51:58 +0100
X-Mailer: git-send-email 1.6.6.rc1.54.g791207
X-Provags-ID: V01U2FsdGVkX18Jl5R5q3Lng5jEsHg00HRF9m3aPJzsQqjnpdd
 HQGgRHhFJ/DFlNP2zTSTCzyU24GMKk53TaR5wCYIeTbkhXVyoy
 j+l3XI7mJjIXQejR7nE3Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134590>

I just wanted to add the recently learnt '--reset-author' option, but
then noticed that there are many more options missing.  This patch
adds support for all of 'git commit's options, except '--allow-empty',
because it is primarily there for foreign scm interfaces.

=46urthermore, this patch also adds support for completing the argument=
s
of those options that take a non-filename argument: valid modes are
offered for '--cleanup' and '--untracked-files', while refs for
'--reuse-message' and '--reedit-message', because these two take a
commit as argument.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 11bf17a..7c18b0c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -896,11 +896,31 @@ _git_commit ()
=20
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
+	--cleanup=3D*)
+		__gitcomp "default strip verbatim whitespace
+			" "" "${cur##--cleanup=3D}"
+		return
+		;;
+	--reuse-message=3D*)
+		__gitcomp "$(__git_refs)" "" "${cur##--reuse-message=3D}"
+		return
+		;;
+	--reedit-message=3D*)
+		__gitcomp "$(__git_refs)" "" "${cur##--reedit-message=3D}"
+		return
+		;;
+	--untracked-files=3D*)
+		__gitcomp "all no normal" "" "${cur##--untracked-files=3D}"
+		return
+		;;
 	--*)
 		__gitcomp "
 			--all --author=3D --signoff --verify --no-verify
 			--edit --amend --include --only --interactive
-			--dry-run
+			--dry-run --reuse-message=3D --reedit-message=3D
+			--reset-author --file=3D --message=3D --template=3D
+			--cleanup=3D --untracked-files --untracked-files=3D
+			--verbose --quiet
 			"
 		return
 	esac
--=20
1.6.6.rc1.54.g791207
