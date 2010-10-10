From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2] bash: support pretty format aliases
Date: Mon, 11 Oct 2010 00:06:22 +0200
Message-ID: <20101010220622.GC12529@neumann>
References: <1286746461-7338-1-git-send-email-szeder@ira.uka.de>
	<20101010214410.GA16253@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 00:06:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P542O-0005kO-C4
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 00:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129Ab0JJWG1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 18:06:27 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:58615 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014Ab0JJWG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 18:06:26 -0400
Received: from [127.0.1.1] (p5B130D54.dip0.t-ipconnect.de [91.19.13.84])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MDCvo-1Ov6oN3U3Y-00GmyW; Mon, 11 Oct 2010 00:06:24 +0200
Content-Disposition: inline
In-Reply-To: <20101010214410.GA16253@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V02:K0:mz4MhTHlJkqfFSyoMJO5IP4Pw/OmUr9rS6jy8zb2NeE
 zZzOmy1Y/nIuYXOt3Od13WZXAQdRa6W/KUn/y8ixyVSc7uW9PG
 MCPfw0an1QlzyisZ55PUpcoExXD4LJofy00NytEK7QmdeRiomh
 pKTWBXRG9WPwYSudw6eIM15GHVgeqFbrFyBwJCFlBtUOlahQQd
 6kszB1Etm4S4jOK6kHNgg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158723>

Users can have their own pretty format aliases since 8028184 (pretty:
add aliases for pretty formats, 2010-05-02), so let's offer those
after '--pretty=3D' and '--format=3D' for 'log' and 'show', too.

Similar to the completion of aliases, this will invoke 'git config'
each time pretty aliases needs to be completed, so changes in pretty.*
configuration will be reflected immediately.

Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
---

On Sun, Oct 10, 2010 at 04:44:11PM -0500, Jonathan Nieder wrote:
> Does this apply to
>=20
> 	git log --format=3D
> 	git show --pretty=3D
> 	git show --format=3D
>=20
> too?

Yes ;)

 contrib/completion/git-completion.bash |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 6756990..4d54c32 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -750,6 +750,19 @@ __git_compute_porcelain_commands ()
 	: ${__git_porcelain_commands:=3D$(__git_list_porcelain_commands)}
 }
=20
+__git_pretty_aliases ()
+{
+	local i IFS=3D$'\n'
+	for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "pretty\=
=2E.*" 2>/dev/null); do
+		case "$i" in
+		pretty.*)
+			i=3D"${i#pretty.}"
+			echo "${i/ */}"
+			;;
+		esac
+	done
+}
+
 __git_aliases ()
 {
 	local i IFS=3D$'\n'
@@ -1368,12 +1381,12 @@ _git_log ()
 	fi
 	case "$cur" in
 	--pretty=3D*)
-		__gitcomp "$__git_log_pretty_formats
+		__gitcomp "$__git_log_pretty_formats $(__git_pretty_aliases)
 			" "" "${cur##--pretty=3D}"
 		return
 		;;
 	--format=3D*)
-		__gitcomp "$__git_log_pretty_formats
+		__gitcomp "$__git_log_pretty_formats $(__git_pretty_aliases)
 			" "" "${cur##--format=3D}"
 		return
 		;;
@@ -2100,12 +2113,12 @@ _git_show ()
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--pretty=3D*)
-		__gitcomp "$__git_log_pretty_formats
+		__gitcomp "$__git_log_pretty_formats $(__git_pretty_aliases)
 			" "" "${cur##--pretty=3D}"
 		return
 		;;
 	--format=3D*)
-		__gitcomp "$__git_log_pretty_formats
+		__gitcomp "$__git_log_pretty_formats $(__git_pretty_aliases)
 			" "" "${cur##--format=3D}"
 		return
 		;;
--=20
1.7.3.1.148.g2fffa
