From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 02/12] completion: simplify __gitcomp
Date: Sun, 8 Apr 2012 14:46:52 +0200
Message-ID: <20120408124652.GN2289@goldbirke>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
	<1333854479-23260-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 14:47:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGrWF-0000zD-Ol
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 14:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482Ab2DHMqz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Apr 2012 08:46:55 -0400
Received: from mailhost.fzi.de ([141.21.8.250]:39720 "EHLO
	EX-E-1.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab2DHMqy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 08:46:54 -0400
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by EX-E-1.perimeter.fzi.de
 (141.21.8.250) with Microsoft SMTP Server (TLS) id 14.1.355.2; Sun, 8 Apr
 2012 14:46:51 +0200
Received: from localhost6.localdomain6 (141.21.34.29) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.355.2; Sun, 8 Apr
 2012 14:46:53 +0200
Content-Disposition: inline
In-Reply-To: <1333854479-23260-3-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194994>

Hi,


On Sun, Apr 08, 2012 at 06:07:49AM +0300, Felipe Contreras wrote:
> The suffix is never used.

The suffix was used to offer completion after 'git config
branch.<TAB>' ending with a period.  It is not used by git's
completion script anymore, because nowadays this case is handled by
the __gitcomp_nl helper() function.

However, users can provide custom completion functions to their
aliases or additional git commands, and there might be a custom
completion function out there that passes a suffix to __gitcomp().

We don't want to break those custom completion functions, so I think
the suffix should stay.


Best,
G=E1bor



> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash |   12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 31f714d..39f5435 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -304,15 +304,14 @@ __git_ps1 ()
>  	fi
>  }
> =20
> -# __gitcomp_1 requires 2 arguments
>  __gitcomp_1 ()
>  {
>  	local c IFS=3D' '$'\t'$'\n'
>  	for c in $1; do
> -		case "$c$2" in
> -		--*=3D*) printf %s$'\n' "$c$2" ;;
> -		*.)    printf %s$'\n' "$c$2" ;;
> -		*)     printf %s$'\n' "$c$2 " ;;
> +		case "$c" in
> +		--*=3D*) printf %s$'\n' "$c" ;;
> +		*.)    printf %s$'\n' "$c" ;;
> +		*)     printf %s$'\n' "$c " ;;
>  		esac
>  	done
>  }
> @@ -479,7 +478,6 @@ fi
>  # 1: List of possible completion words.
>  # 2: A prefix to be added to each possible completion word (optional=
).
>  # 3: Generate possible completion matches for this word (optional).
> -# 4: A suffix to be appended to each possible completion word (optio=
nal).
>  __gitcomp ()
>  {
>  	local cur_=3D"${3-$cur}"
> @@ -491,7 +489,7 @@ __gitcomp ()
>  	*)
>  		local IFS=3D$'\n'
>  		COMPREPLY=3D($(compgen -P "${2-}" \
> -			-W "$(__gitcomp_1 "${1-}" "${4-}")" \
> +			-W "$(__gitcomp_1 "${1-}")" \
>  			-- "$cur_"))
>  		;;
>  	esac
> --=20
> 1.7.10.3.g5a738d
>=20
