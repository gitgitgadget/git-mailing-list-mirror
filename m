From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] prompt: squelch error output from cat
Date: Sat, 15 Jun 2013 17:33:00 +0200
Message-ID: <20130615153300.GO2091@goldbirke>
References: <1371131209-32479-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 15 17:33:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnsTn-0000zX-5g
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 17:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577Ab3FOPdI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Jun 2013 11:33:08 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:60279 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab3FOPdH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 11:33:07 -0400
Received: from localhost6.localdomain6 (e179061165.adsl.alicedsl.de [85.179.61.165])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MZOYv-1V2W0X34t3-00Lk5p; Sat, 15 Jun 2013 17:33:00 +0200
Content-Disposition: inline
In-Reply-To: <1371131209-32479-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:NLYDfvNcym/e4LgLU1b3uEC7+I215lq8rqLKG6Wsu6J
 yYb7zYoHZpQeCQwIp9CJTK6jc8P1Dhcs9DdLYVmK+QsKHZd2v6
 HE86cERz7gPdzMDdgwyZqOmv2pqFcFVD5vmxWGAeU27jupV8CU
 v5Ktbarrg/NIo8Y1eDUITklABJBHCOzamILVj7Si9rKmfh1crc
 fyWg6Y7Vz2moAt6OEOuixp2eGSuvKiqQrIrpTo4klL6QgFZU81
 ksxch638ME7hOAeAzsuE7+m92In9S53TM6Z1844TDerp0y/zBP
 98USibeXIvfy9nyzst5CmxhrpwFsyHYRzcFWIwvw66tAOuHV23
 A8Vm0AyWW1CckmyAuW9NXW77v8Fa/E2lf+wdkXxZV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227958>

Hi Junio,

I see you picked up this patch in branch
'rr/prompt-autostash-breakage-fix'.  This patch has actually nothing
to do with autostash, it is a fix for b71dc3e1 (bash-prompt.sh: show
where rebase is at when stopped, 2013-04-25).


G=E1bor

On Thu, Jun 13, 2013 at 07:16:49PM +0530, Ramkumar Ramachandra wrote:
> The files $g/rebase-{merge,apply}/{head-name,msgnum,end} are not
> guaranteed to exist.  When attempting to cat them, squelch the error
> output to get rid of messages like these:
>=20
>   cat: .git/rebase-merge/msgnum: No such file or directory
>   cat: .git/rebase-merge/end: No such file or directory
>=20
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  contrib/completion/git-prompt.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/gi=
t-prompt.sh
> index 86a4f3f..07a6218 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -347,9 +347,9 @@ __git_ps1 ()
>  		local step=3D""
>  		local total=3D""
>  		if [ -d "$g/rebase-merge" ]; then
> -			b=3D"$(cat "$g/rebase-merge/head-name")"
> -			step=3D$(cat "$g/rebase-merge/msgnum")
> -			total=3D$(cat "$g/rebase-merge/end")
> +			b=3D"$(cat "$g/rebase-merge/head-name" 2>/dev/null)"
> +			step=3D$(cat "$g/rebase-merge/msgnum" 2>/dev/null)
> +			total=3D$(cat "$g/rebase-merge/end" 2>/dev/null)
>  			if [ -f "$g/rebase-merge/interactive" ]; then
>  				r=3D"|REBASE-i"
>  			else
> @@ -357,10 +357,10 @@ __git_ps1 ()
>  			fi
>  		else
>  			if [ -d "$g/rebase-apply" ]; then
> -				step=3D$(cat "$g/rebase-apply/next")
> -				total=3D$(cat "$g/rebase-apply/last")
> +				step=3D$(cat "$g/rebase-apply/next" 2>/dev/null)
> +				total=3D$(cat "$g/rebase-apply/last" 2>/dev/null)
>  				if [ -f "$g/rebase-apply/rebasing" ]; then
> -					b=3D"$(cat "$g/rebase-apply/head-name")"
> +					b=3D"$(cat "$g/rebase-apply/head-name" 2>/dev/null)"
>  					r=3D"|REBASE"
>  				elif [ -f "$g/rebase-apply/applying" ]; then
>  					r=3D"|AM"
> --=20
> 1.8.3.1.384.g7cec0b4
>=20
>=20
