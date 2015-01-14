From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] git-prompt: preserve value of $? in all cases
Date: Wed, 14 Jan 2015 13:10:06 +0100
Message-ID: <20150114131006.Horde._hnEBDLPm_RUjO-IJlS9dw1@webmail.informatik.kit.edu>
References: <20150114005726.Horde.idyLC0Or9SvaghEN_N_pRg1@webmail.informatik.kit.edu>
 <alpine.LSU.2.00.1501141005560.23307@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Wed Jan 14 13:10:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBMmP-0000GN-Nu
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 13:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbbANMK3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jan 2015 07:10:29 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:51508 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751706AbbANMK2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 07:10:28 -0500
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YBMmC-0007Kz-RK; Wed, 14 Jan 2015 13:10:20 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1YBMly-0007nJ-Dk; Wed, 14 Jan 2015 13:10:06 +0100
Received: from tmo-102-36.customers.d1-online.com
 (tmo-102-36.customers.d1-online.com [80.187.102.36]) by
 webmail.informatik.kit.edu (Horde Framework) with HTTP; Wed, 14 Jan 2015
 13:10:06 +0100
In-Reply-To: <alpine.LSU.2.00.1501141005560.23307@hermes-1.csi.cam.ac.uk>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1421237420.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262377>

Hi,

Quoting Tony Finch <dot@dotat.at>:
> Signed-off-by: Tony Finch <dot@dotat.at>
> ---
>  contrib/completion/git-prompt.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/completion/git-prompt.sh =20
> b/contrib/completion/git-prompt.sh
> index 3c3fc6d..3e70e74 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -288,6 +288,7 @@ __git_eread ()
>  # In this mode you can request colored hints using =20
> GIT_PS1_SHOWCOLORHINTS=3Dtrue
>  __git_ps1 ()
>  {
> +	# preserve exit status
>  	local exit=3D$?
>  	local pcmode=3Dno
>  	local detached=3Dno
> @@ -303,7 +304,7 @@ __git_ps1 ()
>  		;;
>  		0|1)	printf_format=3D"${1:-$printf_format}"
>  		;;
> -		*)	return
> +		*)	return $exit
>  		;;
>  	esac
>
> @@ -355,7 +356,7 @@ __git_ps1 ()
>  			#In PC mode PS1 always needs to be set
>  			PS1=3D"$ps1pc_start$ps1pc_end"
>  		fi
> -		return
> +		return $exit
>  	fi
>
>  	local short_sha
> @@ -416,7 +417,7 @@ __git_ps1 ()
>  				if [ $pcmode =3D yes ]; then
>  					PS1=3D"$ps1pc_start$ps1pc_end"
>  				fi
> -				return
> +				return $exit
>  			fi
>  			# is it a symbolic ref?
>  			b=3D"${head#ref: }"
> @@ -513,6 +514,5 @@ __git_ps1 ()
>  		printf -- "$printf_format" "$gitstring"
>  	fi
>
> -	# preserve exit status
>  	return $exit
>  }
> --
> 2.2.1.68.g56d9796

Thanks for the quick turnaround, looks good to me.  I didn't remember =20
the early return in the second hunk.

I wonder whether we could test this behavior...  but how could we set =20
$? and pass it to __git_ps1()?

Junio,
as far as I can judge from the last What's cooking and the relevant =20
patch emails on Gmane, this patch will have a textual conflict with =20
the first patch in 'rh/hide-prompt-in-ignored-directory'.  While the =20
conflict is trivial (maybe git would even be able to resolve it by =20
itself?), the second patch in that series adds yet another early =20
return to __git_ps1().  Please be sure to add 'return $exit' when =20
merging.


Best,
G=C3=A1bor
