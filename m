From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] git-completion: Add support for git submodule options
Date: Tue, 12 Apr 2011 11:37:38 +0200
Message-ID: <20110412093738.GA6817@goldbirke>
References: <4DA33EC8.5040704@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 11:40:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9a59-0000cr-Ms
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 11:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756928Ab1DLJkO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 05:40:14 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:56527 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756916Ab1DLJkN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 05:40:13 -0400
Received: from localhost6.localdomain6 (p5B130BCD.dip0.t-ipconnect.de [91.19.11.205])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0LwVKN-1PpibU1u0d-017sUF; Tue, 12 Apr 2011 11:37:39 +0200
Content-Disposition: inline
In-Reply-To: <4DA33EC8.5040704@morey-chaisemartin.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:kKRmUk/wVv3EC4Ze+pPb/7cZjt9d5xIYrG2hbj2urj3
 UrfpUKhuIDyq5GC2h1RivYsWsF/GGzYRCMpTVL3oM0MzSeW2Iq
 GRA9v7a7vjmb12HPxeXKSli/XSaqBB4eFc7O/TWMYsZjQ+xsWI
 4xREf/39U+ydMUtwtpWi3w+cAtuWMmFbkFJ0q1+WQVYqUMVIaB
 ypr/PCGV5ztdnd73gUhhQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171388>

Hi,


On Mon, Apr 11, 2011 at 07:47:52PM +0200, Nicolas Morey-Chaisemartin wr=
ote:
> Completion for git submodule only handled subcommands.
> Add support for options of each subcommand
>=20
> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin=
=2Ecom>
> ---
> Changes:
>  - Inlined local variables listing options.
>
>  contrib/completion/git-completion.bash |   32 ++++++++++++++++++++++=
+++++++++-
>  1 files changed, 31 insertions(+), 1 deletions(-)

This change looks good overall, but I have a few nits, though.

> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 840ae38..20d0cf0 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2546,7 +2546,8 @@ _git_submodule ()
>  	__git_has_doubledash && return
> =20
>  	local subcommands=3D"add status init update summary foreach sync"
> -	if [ -z "$(__git_find_on_cmdline "$subcommands")" ]; then
> +	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
> +	if [ -z "$subcommand" ]; then
>  		local cur
>  		_get_comp_words_by_ref -n =3D: cur
>  		case "$cur" in
> @@ -2558,6 +2559,35 @@ _git_submodule ()
>  			;;
>  		esac
>  		return
> +	else
> +	    local cur
> +	    _get_comp_words_by_ref -n =3D: cur

Both branches of the if-else statement start with the same

	    local cur
	    _get_comp_words_by_ref -n =3D: cur

so these could be moved out in front of the if statement.

> +	    case "$subcommand,$cur" in
> +		 add,--*)
> +		     __gitcomp "--branch=3D --force --reference=3D"
> +		     ;;
> +		 status,--*)
> +		     __gitcomp "--cached --recursive"
> +		     ;;
> +		 update,--*)
> +		     __gitcomp "--init --no-fetch --rebase --reference=3D --merge =
--recursive"
> +		     ;;
> +		 summary,--*)
> +		     __gitcomp "--cached --files --summary-limit=3D"
> +		     ;;
> +		 summary,*)
> +		     __gitcomp "$(__git_refs)"
> +		     ;;
> +		 foreach,--*)
> +		     __gitcomp "--recursive"
> +		     ;;
> +		 sync,*)
> +		     COMPREPLY=3D()
> +		     ;;
> +		 *)
> +		     COMPREPLY=3D()
> +		     ;;

The 'sync,*' case is not necessary, because it has the same completion
reply as the '*' case, and that case would match it anyway.

And finally, please use tabs for indentation.


Best,
G=E1bor
