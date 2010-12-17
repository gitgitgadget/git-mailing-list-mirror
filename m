From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: conflict resolution of pd/bash-4-completion [Re: What's cooking in
	git.git (Dec 2010, #05; Thu, 16)]
Date: Fri, 17 Dec 2010 12:18:56 +0100
Message-ID: <20101217111856.GA9304@neumann>
References: <7vk4j8kfwy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 12:19:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTYLK-0008GB-Gq
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 12:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab0LQLTS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Dec 2010 06:19:18 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:49303 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177Ab0LQLTR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 06:19:17 -0500
Received: from localhost6.localdomain6 (p5B130B15.dip0.t-ipconnect.de [91.19.11.21])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0Lz0Xw-1QXfZx1XIO-014DDj; Fri, 17 Dec 2010 12:18:57 +0100
Content-Disposition: inline
In-Reply-To: <7vk4j8kfwy.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:9EJxsH89M1kOp1BUoLSYGyZcB7ZG/S7XRqESYM/b6x/
 qxj62E+iSiXhZTkYKEUilbchrt7XcPRgXmdEg/riL6696yx/m7
 s9cyZCjMhfcEeOxGg6zWQdEnY/SzCt0hqyUHp12/HpnYR1Dwia
 B75kiLNh16XDrUfoEoNDqUhZNYP6Cu2tcSKZ47ERWMQPIT+7um
 LC+wxBVd5v2zTWSA1TfuQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163873>

Hi,


On Thu, Dec 16, 2010 at 11:38:21PM -0800, Junio C Hamano wrote:
> * pd/bash-4-completion (2010-12-15) 3 commits
>  - Merge branch 'master' (early part) into pd/bash-4-completion
>  - bash: simple reimplementation of _get_comp_words_by_ref
>  - bash: get --pretty=3Dm<tab> completion to work with bash v4
>=20
> Updated by Jonathan; this still has some conflicts around "notes"
> completion I tried to resolve near the tip of 'pu'.

The resolution of that conflict is not quite correct.  I'm not sure
how I should send a proper conflict resolution...  but I'll try
anyway.

So the patch below applies to today's pu (i.e. db92f24) and fixes the
current merge conflict resolution in the completion function for 'git
notes'.

I also have a few comments to the patches in this topic, but it's
quite hard to find the time to think them through and sum them up
properly in this pre-Xmas frenzy...


Best,
G=E1bor


diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index bd5b322..e0c40c3 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1707,20 +1707,15 @@ _git_notes ()
 {
 	local subcommands=3D'add append copy edit list prune remove show'
 	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
-	local words cword
-	_get_comp_words_by_ref -n =3D: words cword
-	local cur=3D${words[cword-1]}
-	if [ -z "$subcommand" ]; then
-		__gitcomp "$subcommands"
-		return
-	fi
+	local cur words cword
+	_get_comp_words_by_ref -n =3D: cur words cword
=20
 	case "$subcommand,$cur" in
 	,--*)
 		__gitcomp '--ref'
 		;;
 	,*)
-		case "${COMP_WORDS[COMP_CWORD-1]}" in
+		case "${words[cword-1]}" in
 		--ref)
 			__gitcomp "$(__git_refs)"
 			;;
@@ -1748,7 +1743,7 @@ _git_notes ()
 	prune,*)
 		;;
 	*)
-		case "${COMP_WORDS[COMP_CWORD-1]}" in
+		case "${words[cword-1]}" in
 		-m|-F)
 			;;
 		*)
--=20
1.7.3.4.547.g524288
