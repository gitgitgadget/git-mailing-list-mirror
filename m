From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: add completer for status
Date: Fri, 28 Jun 2013 12:29:36 +0200
Message-ID: <20130628102936.GA16562@goldbirke>
References: <1372094575-20799-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 12:29:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsVw0-0007mT-7B
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 12:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755306Ab3F1K3k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jun 2013 06:29:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:50407 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068Ab3F1K3j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 06:29:39 -0400
Received: from localhost6.localdomain6 (g226130042.adsl.alicedsl.de [92.226.130.42])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0Lf0ON-1UTcFS1hnz-00qDMN; Fri, 28 Jun 2013 12:29:37 +0200
Content-Disposition: inline
In-Reply-To: <1372094575-20799-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:PPm+X9te7Y2WCfr1AGqRysqfeCQnk/SzknwI2SLAzHJ
 Z4E53pMX0newCdeuz3xCoZqYKf/3v1QGuxYZo0X1+KOfudabaH
 KkxhjqvArq5Wrn1TX9PDRPKQvqtdGE+GGhS/rZbbwvp9qV14H+
 YRK0FikZJJHttf6RUFFz5DV0TCujSA1zMiOUytMa/HwwIFlX+J
 yQCcM8nYZeuQ8yQ1ka0PhbwJxnDGFaHd8X8WL8vd9lp+LsoX2E
 KJ38MnovFg3xc3qxH2pk8jXE76Q07VFzJ76IpTA+NJ+aectttj
 xR+L3CF13ZyaYfzZiHMse0jptyuAgafNWiYAWh/AqNetYBkycY
 k02QqYzCCb4Y3akATJNylxNbYhNy7yr+tTtvl/etw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229185>

Hi,

On Mon, Jun 24, 2013 at 10:52:55PM +0530, Ramkumar Ramachandra wrote:
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 26 ++++++++++++++++++++++++=
++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 6c3bafe..912fb98 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1695,6 +1695,32 @@ _git_stage ()
>  	_git_add
>  }
> =20
> +_git_status ()
> +{
> +	case "$cur" in
> +	--untracked-files=3D*)
> +		__gitcomp "no normal all" "" "${cur##--untracked-files=3D}"
> +		return
> +		;;
> +	--ignore-submodules=3D*)
> +		__gitcomp "none untracked dirty all" "" "${cur##--ignore-submodule=
s=3D}"
> +		return
> +		;;
> +	--column=3D*)
> +		__gitcomp "always never auto column row plain dense nodense" "" "$=
{cur##--column=3D}"
> +		return
> +		;;
> +	--*)
> +		__gitcomp "
> +			--short --branch --long --porcelain
> +			--untracked-files=3D --ignore-submodules=3D --ignored --column=3D

The parameter for '--untracked-files' '--ignore-submodules' and
'--column' is optional.  In such cases we usually list the option both
with and without the '=3D' as a reminder, e.g. look at 'git log's
'--decorate' and '--dirstat'.

> +			"
> +		return
> +		;;
> +	esac
> +	__git_complete_index_file

With or without this change we can't ask for the status of a certain
deleted file:

$ git rm version.h
rm 'version.h'
$ git status=20
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       deleted:    version.h
#
$ git status v<TAB>
varint.c   varint.h   vcs-svn/   version.c =20

I wonder whether there is some clever combination of options that
would make that possible?  I didn't find it.


G=E1bor
