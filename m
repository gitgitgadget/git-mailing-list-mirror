From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 10/12] completion: add new git_complete helper
Date: Thu, 12 Apr 2012 00:50:46 +0200
Message-ID: <20120411225046.GU2289@goldbirke>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
	<1333854479-23260-11-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 00:51:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI6NR-0006zh-B7
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 00:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758330Ab2DKWu4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 18:50:56 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:51809 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758300Ab2DKWuz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 18:50:55 -0400
Received: from localhost6.localdomain6 (p5B130C22.dip0.t-ipconnect.de [91.19.12.34])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0LtUJA-1S8Rkn29Bc-010wYk; Thu, 12 Apr 2012 00:50:46 +0200
Content-Disposition: inline
In-Reply-To: <1333854479-23260-11-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:m8y1T6IP//EdHoWZA1h3Ui9vXOmL64Dh6CaujXT+cGi
 CzEysNYShZ/DEN5bkBNr5erYuxYuss5Z7CiMy3pJqjd+JmX8q9
 klZrygA/vz/rfOqp3Kk5Js9bVbVPGW7cW/ULR+5DcA8murEM9o
 y1ogqeZLwoAtG7IkxAjiC1vhpTh3Jxr+5kBh303LMIyIt8PuZV
 +CQabLhWIIkx0KKLD1dzUhI1Xd/1L2KosIAhf+INpD2DaBp0d8
 zZe5WeeesQAsnTOT4C0cB6PofQMTHDGYsMaoAtw/xef4cMs4//
 IrBmTSFvr1SfHKpsLnmF7O4HSo2CHA6PJ9q51brqwLC9svaYFQ
 ZF79mtjEvQ95KuY1P9Qo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195279>

Hi,


On Sun, Apr 08, 2012 at 06:07:57AM +0300, Felipe Contreras wrote:
> This simplifies the completions, and makes it easier to define aliase=
s:
>=20
>  git_complete gf git_fetch
>=20
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash |   69 +++++++++++++++-------=
----------
>  t/t9902-completion.sh                  |    2 +-
>  2 files changed, 33 insertions(+), 38 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 60ea224..6cf1d98 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2616,21 +2616,6 @@ _git ()
>  {
>  	local i c=3D1 cmd cmd_pos __git_dir
> =20
> -	if [[ -n ${ZSH_VERSION-} ]]; then
> -		emulate -L bash
> -		setopt KSH_TYPESET
> -
> -		# workaround zsh's bug that leaves 'words' as a special
> -		# variable in versions < 4.3.12
> -		typeset -h words
> -
> -		# workaround zsh's bug that quotes spaces in the COMPREPLY
> -		# array if IFS doesn't contain spaces.
> -		typeset -h IFS
> -	fi
> -
> -	local cur words cword prev
> -	_get_comp_words_by_ref -n =3D: cur words cword prev
>  	while [ $c -lt $cword ]; do
>  		i=3D"${words[c]}"
>  		case "$i" in
> @@ -2683,22 +2668,6 @@ _git ()
> =20
>  _gitk ()
>  {
> -	if [[ -n ${ZSH_VERSION-} ]]; then
> -		emulate -L bash
> -		setopt KSH_TYPESET
> -
> -		# workaround zsh's bug that leaves 'words' as a special
> -		# variable in versions < 4.3.12
> -		typeset -h words
> -
> -		# workaround zsh's bug that quotes spaces in the COMPREPLY
> -		# array if IFS doesn't contain spaces.
> -		typeset -h IFS
> -	fi
> -
> -	local cur words cword prev
> -	_get_comp_words_by_ref -n =3D: cur words cword prev
> -

Eliminating code duplication, great!

>  	__git_has_doubledash && return
> =20
>  	local g=3D"$(__gitdir)"
> @@ -2719,16 +2688,42 @@ _gitk ()
>  	__git_complete_revlist
>  }
> =20
> -complete -o bashdefault -o default -o nospace -F _git git 2>/dev/nul=
l \
> -	|| complete -o default -o nospace -F _git git
> -complete -o bashdefault -o default -o nospace -F _gitk gitk 2>/dev/n=
ull \
> -	|| complete -o default -o nospace -F _gitk gitk

More greatness.

> +foo_wrap ()

This git-completion-specific internal helper function will pollute the
user's environment.  It should get a __git_ prefix.

> +{
> +	local cmd=3Dfoo_cmd cmd_pos=3D1
> +	if [[ -n ${ZSH_VERSION-} ]]; then
> +		emulate -L bash
> +		setopt KSH_TYPESET
> +
> +		# workaround zsh's bug that leaves 'words' as a special
> +		# variable in versions < 4.3.12
> +		typeset -h words
> +
> +		# workaround zsh's bug that quotes spaces in the COMPREPLY
> +		# array if IFS doesn't contain spaces.
> +		typeset -h IFS
> +	fi
> +	local cur words cword prev
> +	_get_comp_words_by_ref -n =3D: cur words cword prev
> +	foo "$@"
> +}
> +
> +git_complete ()

Maybe this should also get a prefix, but I'm not sure, because this
is, strictly speaking, not a bash completion function.

> +{
> +	local name=3D"${2-$1}"
> +	local cmd=3D"${name#git_}"
> +	eval "$(typeset -f foo_wrap | sed -e "s/foo_cmd/$cmd/" -e "s/foo/_$=
name/")"
> +	complete -o bashdefault -o default -o nospace -F _${name}_wrap $1 2=
>/dev/null \
> +		|| complete -o default -o nospace -F _${name}_wrap $1
> +}
> +
> +git_complete git
> +git_complete gitk

Clever ;)

But it needs a subshell and a sed invocation, so Windows people might
not be all too happy about this.  Perhaps it's not a big deal in the
default case, because it will be done only twice at startup time.
However, if someone wants several aliases on Windows, it can cause
noticeable delay.  It's a startup speed vs. convenience trade-off.
Anyway, I don't have any ideas how those fork()s and exec() could be
avoided.


Best,
G=E1bor
