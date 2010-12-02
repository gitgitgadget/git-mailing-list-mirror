From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v4 2/2] Use the new functions to get the current cword.
Date: Thu, 2 Dec 2010 23:36:01 +0100
Message-ID: <20101202223601.GA3577@neumann>
References: <1291236582-28603-1-git-send-email-peter@avirtualhome.com>
	<1291236582-28603-3-git-send-email-peter@avirtualhome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Peter van der Does <peter@avirtualhome.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 23:36:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POHl4-00036I-FR
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 23:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757481Ab0LBWgE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 17:36:04 -0500
Received: from moutng.kundenserver.de ([212.227.17.9]:59388 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757199Ab0LBWgD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 17:36:03 -0500
Received: from localhost6.localdomain6 (p5B130C9F.dip0.t-ipconnect.de [91.19.12.159])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0M6fZs-1OUNFO0Itw-00wpEr; Thu, 02 Dec 2010 23:36:02 +0100
Content-Disposition: inline
In-Reply-To: <1291236582-28603-3-git-send-email-peter@avirtualhome.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:qwicKswoMPyDq5uZzjNqHIVghNu6P94ARCCMsiYszi0
 U8eVyoiblN10bAItQp4yUP4mzUEtu7L81Q3Hh85f4itgQ0JHMd
 LD7jZ1n11WbPRxEW9ZfhbW7I9GmN/Wi4Hv8ht7YzNApWNpUTe8
 J7FdaY5QxBSnT4Ghcg1poC9FwSD21fBtVZDA+I4YYvs1wNP6pa
 HXmgJzo7uwiATgSmsv2tg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162750>

Hi,


Here are my nits I mentioned yesterday.

On Wed, Dec 01, 2010 at 03:49:42PM -0500, Peter van der Does wrote:
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 0036e8b..f915e1f 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash

> @@ -1064,9 +1073,10 @@ __git_find_on_cmdline ()
> =20
>  __git_has_doubledash ()
>  {
> -	local c=3D1
> -	while [ $c -lt $COMP_CWORD ]; do
> -		if [ "--" =3D "${COMP_WORDS[c]}" ]; then
> +	local c=3D1, words cword

No comma, and ...

> +	_get_comp_words_by_ref words cword
> +	while [ $c -lt $cwords ]; do

=2E.. that should be $cword in the condition, without the s at the end.
These two typos caused some weird behaviors when completing long
options for commands understanding the '--' option-path separator,
e.g. git diff --<TAB<TAB>.


> @@ -1775,7 +1814,7 @@ _git_notes ()
>  	prune,*)
>  		;;
>  	*)
> -		case "${COMP_WORDS[COMP_CWORD-1]}" in
> +		case "${prev}" in

> @@ -2615,7 +2670,7 @@ _git_tag ()
>  		c=3D$((++c))
>  	done
> =20
> -	case "${COMP_WORDS[COMP_CWORD-1]}" in
> +	case "${prev}" in

No {} are needed around prev.


> @@ -2639,15 +2694,16 @@ _git_whatchanged ()
> =20
>  _git ()
>  {
> -	local i c=3D1 command __git_dir
> +	local i c=3D1 command __git_dir words cword
> =20
> -	if [[ -n ${ZSH_VERSION-} ]]; then
> +	if [[ -n $ZSH_VERSION ]]; then

> @@ -2690,19 +2746,20 @@ _git ()
> =20
>  _gitk ()
>  {
> -	if [[ -n ${ZSH_VERSION-} ]]; then
> +	if [[ -n $ZSH_VERSION ]]; then

> @@ -2730,7 +2787,7 @@ complete -o bashdefault -o default -o nospace -=
=46 _git git.exe 2>/dev/null \
>  	|| complete -o default -o nospace -F _git git.exe
>  fi
> =20
> -if [[ -n ${ZSH_VERSION-} ]]; then
> +if [[ -n $ZSH_VERSION ]]; then

These three changes have nothing to do with bash4 issues, and they
break in 'set -u' environments, because $ZSH_VERSION is, of course,
undefined in bash.


Best,
G=E1bor
