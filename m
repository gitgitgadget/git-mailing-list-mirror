From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v5 1/2] git-prompt.sh: if pc mode, immediately set PS1
Date: Wed, 14 Jan 2015 12:45:00 +0100
Message-ID: <20150114124500.Horde.yfl7_QOVJQq0-zVzaAY52g6@webmail.informatik.kit.edu>
References: <xmqqwq4zmqpt.fsf@gitster.dls.corp.google.com>
 <1420593747-24110-1-git-send-email-rhansen@bbn.com>
 <1420593747-24110-2-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, j6t@kdbg.org, jess.austin@gmail.com,
	git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 12:45:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBMOE-0005IP-AG
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 12:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbbANLpa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jan 2015 06:45:30 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:51067 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751670AbbANLp3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 06:45:29 -0500
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YBMNv-0005PA-9h; Wed, 14 Jan 2015 12:45:15 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1YBMNg-0006qi-Rn; Wed, 14 Jan 2015 12:45:00 +0100
Received: from tmo-102-36.customers.d1-online.com
 (tmo-102-36.customers.d1-online.com [80.187.102.36]) by
 webmail.informatik.kit.edu (Horde Framework) with HTTP; Wed, 14 Jan 2015
 12:45:00 +0100
In-Reply-To: <1420593747-24110-2-git-send-email-rhansen@bbn.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1421235915.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262375>

Hi,


Quoting Richard Hansen <rhansen@bbn.com>:
> At the beginning of __git_ps1, right after determining that the
> function is running in pc mode, set PS1 to a plain (undecorated)
> prompt.  This makes it possible to simply return early without having
> to set PS1 if the prompt should not be decorated.
>
> Signed-off-by: Richard Hansen <rhansen@bbn.com>
> ---
>   contrib/completion/git-prompt.sh | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/contrib/completion/git-prompt.sh
> b/contrib/completion/git-prompt.sh
> index 729f769..b0de082 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -299,6 +299,10 @@ __git_ps1 ()
>   			ps1pc_start=3D"$1"
>   			ps1pc_end=3D"$2"
>   			printf_format=3D"${3:-$printf_format}"
> +			# set PS1 to a plain prompt so that we can
> +			# simply return early if the prompt should not
> +			# be decorated
> +			PS1=3D"$ps1pc_start$ps1pc_end"
>   		;;
>   		0|1)	printf_format=3D"${1:-$printf_format}"
>   		;;
> @@ -350,10 +354,6 @@ __git_ps1 ()
>   	rev_parse_exit_code=3D"$?"
>
>   	if [ -z "$repo_info" ]; then
> -		if [ $pcmode =3D yes ]; then
> -			#In PC mode PS1 always needs to be set
> -			PS1=3D"$ps1pc_start$ps1pc_end"
> -		fi
>   		return
>   	fi
>
> @@ -412,9 +412,6 @@ __git_ps1 ()
>   		else
>   			local head=3D""
>   			if ! __git_eread "$g/HEAD" head; then
> -				if [ $pcmode =3D yes ]; then
> -					PS1=3D"$ps1pc_start$ps1pc_end"
> -				fi
>   				return
>   			fi
>   			# is it a symbolic ref?
> --
> 2.2.1

As the one responsible for the last hunk I really like this change.

Thanks,
G=C3=A1bor
