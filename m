From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: avoid ls-remote in certain scenarios
Date: Wed, 29 May 2013 09:44:08 +0200
Message-ID: <20130529074408.GA7955@goldbirke>
References: <1369797648-2921-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 09:44:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhb3Q-0005hd-9c
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 09:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935113Ab3E2HoL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 03:44:11 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:49478 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935105Ab3E2HoK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 03:44:10 -0400
Received: from localhost6.localdomain6 (g226136065.adsl.alicedsl.de [92.226.136.65])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0Mfpbg-1V2YDk2c7Q-00NBG2; Wed, 29 May 2013 09:44:08 +0200
Content-Disposition: inline
In-Reply-To: <1369797648-2921-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:hIHaeRy5Tm+qmEWjVSpfI+f4U+jKqaNF10hfsbYCjbR
 +ZmSoy7OKJ2sDEmRYpI0iDKjSpFQRVzGXyfJKqFUcICUfqX1nm
 ycVXSVSL83Jgcgk8/GXYBE7Sf7kjW5DcDBpE/RlkfBkAh8k3NM
 Yjrkw04FyOO0/Nvp5h6p5XBNxrLSdNEJTSWgibB4EUlknZwj+G
 ulSYBrZadog+deCx7vI3SPCaSI1U2dyvVYHJcHPaNeNyWXD5DH
 3ZdKvkERkV5YvArthr2EJ+ZtI6gVT35M1TvyXohAKcVNiyVfpc
 xyUGHjOBcfgbUBItsM5gjOA3UIRzw9FpGyhnJMtfWXuvY1pFQG
 GxWPS+iwjPYMcQt6JX9MDjV69xOWGRyucrTOfUcwZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225769>

On Tue, May 28, 2013 at 10:20:48PM -0500, Felipe Contreras wrote:
> It's _very_ slow in many cases, and there's really no point in fetchi=
ng
> *everything* from the remote just for completion. In many cases it mi=
ght
> be faster for the user to type the whole thing.
>=20
> If the user manually specifies 'refs/*', then the full ls-remote
> completion is triggered.
>=20
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 1c35eef..2ce4f7d 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -427,14 +427,8 @@ __git_refs ()
>  		done
>  		;;
>  	*)
> -		git ls-remote "$dir" HEAD ORIG_HEAD 'refs/tags/*' 'refs/heads/*' '=
refs/remotes/*' 2>/dev/null | \
> -		while read -r hash i; do
> -			case "$i" in
> -			*^{}) ;;
> -			refs/*) echo "${i#refs/*/}" ;;
> -			*) echo "$i" ;;
> -			esac
> -		done
> +		echo "HEAD"
> +		git for-each-ref --format=3D"%(refname:short)" -- "refs/remotes/$d=
ir/" | sed -e "s#^$dir/##"

This case statement is only executed when $dir is not a git directory,
so what ensures that the cwd is in a git repo or work tree when
executing this brach of the case statement?  What about 'git
--git-dir=3D/path/to/repo' invocations or when $GIT_DIR is specified?


G=E1bor
