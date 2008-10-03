From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: remove fetch, push, pull dashed form leftovers
Date: Fri, 3 Oct 2008 21:34:49 +0200
Message-ID: <20081003193449.GA24821@neumann>
References: <fc113d400810030825l75f9451dwc4cbf68807be0b5b@mail.gmail.com>
	<1223051705-30347-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Rob Sanheim <rsanheim@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 03 21:36:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlqRX-0001YF-67
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 21:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbYJCTew convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Oct 2008 15:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752603AbYJCTew
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 15:34:52 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:53656 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbYJCTev (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 15:34:51 -0400
Received: from [127.0.1.1] (p5B1337F6.dip0.t-ipconnect.de [91.19.55.246])
	by mrelayeu.kundenserver.de (node=mrelayeu7) with ESMTP (Nemesis)
	id 0ML2xA-1KlqQJ1WzI-00040i; Fri, 03 Oct 2008 21:34:48 +0200
Content-Disposition: inline
In-Reply-To: <1223051705-30347-1-git-send-email-trast@student.ethz.ch>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1/dn/sldJTjHjTepgc3p/C2gT28LTwK8636RVw
 R1fAtlb73hXZmthinNHIG/gJnUGQ1D4lo+zx0Vjyr2CBRv8lPx
 4gL24/m0P01vB/bZymq6g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97446>

We don't provide complation for git-commands in dashed form anymore,
so there is no need to keep those cases.

Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
---

On Fri, Oct 03, 2008 at 06:35:05PM +0200, Thomas Rast wrote:
> Actually it's not enough, you need to teach fetch, pull and push to
> recognise the new alias too, as in this patch.  I do wonder if there'=
s
> a better approach to those functions however, so that the "obvious"
> fix suggested by Shawn would work.

Maybe something like this?


 contrib/completion/git-completion.bash |   36 ++++++++----------------=
--------
 1 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 95c81f9..5a4e8c8 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -784,14 +784,9 @@ _git_fetch ()
 {
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
=20
-	case "${COMP_WORDS[0]},$COMP_CWORD" in
-	git-fetch*,1)
+	if [ "$COMP_CWORD" =3D 2 ]; then
 		__gitcomp "$(__git_remotes)"
-		;;
-	git,2)
-		__gitcomp "$(__git_remotes)"
-		;;
-	*)
+	else
 		case "$cur" in
 		*:*)
 			local pfx=3D""
@@ -810,8 +805,7 @@ _git_fetch ()
 			__gitcomp "$(__git_refs2 "$remote")"
 			;;
 		esac
-		;;
-	esac
+	fi
 }
=20
 _git_format_patch ()
@@ -1051,36 +1045,25 @@ _git_pull ()
 {
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
=20
-	case "${COMP_WORDS[0]},$COMP_CWORD" in
-	git-pull*,1)
-		__gitcomp "$(__git_remotes)"
-		;;
-	git,2)
+	if [ "$COMP_CWORD" =3D 2 ]; then
 		__gitcomp "$(__git_remotes)"
-		;;
-	*)
+	else
 		local remote
 		case "${COMP_WORDS[0]}" in
 		git-pull)  remote=3D"${COMP_WORDS[1]}" ;;
 		git)       remote=3D"${COMP_WORDS[2]}" ;;
 		esac
 		__gitcomp "$(__git_refs "$remote")"
-		;;
-	esac
+	fi
 }
=20
 _git_push ()
 {
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
=20
-	case "${COMP_WORDS[0]},$COMP_CWORD" in
-	git-push*,1)
-		__gitcomp "$(__git_remotes)"
-		;;
-	git,2)
+	if [ "$COMP_CWORD" =3D 2 ]; then
 		__gitcomp "$(__git_remotes)"
-		;;
-	*)
+	else
 		case "$cur" in
 		*:*)
 			local remote
@@ -1104,8 +1087,7 @@ _git_push ()
 			__gitcomp "$(__git_refs)"
 			;;
 		esac
-		;;
-	esac
+	fi
 }
=20
 _git_rebase ()
--=20
1.6.0.2.474.ga74ad.dirty
