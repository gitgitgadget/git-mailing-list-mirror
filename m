From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: use for-each-ref format 'refname:short'
Date: Fri, 19 Sep 2008 16:51:54 -0700
Message-ID: <20080919235154.GE13139@spearce.org>
References: <1221862525-20574-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: SZEDER GGGbor <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Sep 20 01:53:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgpmd-0000Ax-VI
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 01:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbYISXvz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2008 19:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752642AbYISXvz
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 19:51:55 -0400
Received: from george.spearce.org ([209.20.77.23]:60780 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbYISXvy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 19:51:54 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 32C813835F; Fri, 19 Sep 2008 23:51:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1221862525-20574-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96326>

SZEDER GGGbor <szeder@ira.uka.de> wrote:
> Using this format simplifies the code for completing refs and (in som=
e
> cases) improves performance significantly.
>=20
> For repositories like the current git.git (with more than 200 refs)
> there is no real performance difference, but for a repository with 20=
00
> refs the total time needed to complete the refs is reduced by ~25% (f=
rom
> around 400ms to around 305ms).
>=20
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>

Nice improvement.

Acked-by: Shawn O. Pearce <spearce@spearce.org>


>  OK, so after the refname:short patch hit master, here is the updated
>  patch to use it in bash completion.  The patch itself is the same as
>  the original one, except, of course, the for-each-ref format name.  =
I
>  have also adjusted the performance numbers in the commit message.
>=20
>  contrib/completion/git-completion.bash |   26 ++++++----------------=
----
>  1 files changed, 6 insertions(+), 20 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index d3fb6ae..fccb499 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -154,11 +154,8 @@ __git_heads ()
>  {
>  	local cmd i is_hash=3Dy dir=3D"$(__gitdir "$1")"
>  	if [ -d "$dir" ]; then
> -		for i in $(git --git-dir=3D"$dir" \
> -			for-each-ref --format=3D'%(refname)' \
> -			refs/heads ); do
> -			echo "${i#refs/heads/}"
> -		done
> +		git --git-dir=3D"$dir" for-each-ref --format=3D'%(refname:short)' =
\
> +			refs/heads
>  		return
>  	fi
>  	for i in $(git ls-remote "$1" 2>/dev/null); do
> @@ -175,11 +172,8 @@ __git_tags ()
>  {
>  	local cmd i is_hash=3Dy dir=3D"$(__gitdir "$1")"
>  	if [ -d "$dir" ]; then
> -		for i in $(git --git-dir=3D"$dir" \
> -			for-each-ref --format=3D'%(refname)' \
> -			refs/tags ); do
> -			echo "${i#refs/tags/}"
> -		done
> +		git --git-dir=3D"$dir" for-each-ref --format=3D'%(refname:short)' =
\
> +			refs/tags
>  		return
>  	fi
>  	for i in $(git ls-remote "$1" 2>/dev/null); do
> @@ -197,16 +191,8 @@ __git_refs ()
>  	local cmd i is_hash=3Dy dir=3D"$(__gitdir "$1")"
>  	if [ -d "$dir" ]; then
>  		if [ -e "$dir/HEAD" ]; then echo HEAD; fi
> -		for i in $(git --git-dir=3D"$dir" \
> -			for-each-ref --format=3D'%(refname)' \
> -			refs/tags refs/heads refs/remotes); do
> -			case "$i" in
> -				refs/tags/*)    echo "${i#refs/tags/}" ;;
> -				refs/heads/*)   echo "${i#refs/heads/}" ;;
> -				refs/remotes/*) echo "${i#refs/remotes/}" ;;
> -				*)              echo "$i" ;;
> -			esac
> -		done
> +		git --git-dir=3D"$dir" for-each-ref --format=3D'%(refname:short)' =
\
> +			refs/tags refs/heads refs/remotes
>  		return
>  	fi
>  	for i in $(git ls-remote "$dir" 2>/dev/null); do

--=20
Shawn.
