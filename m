From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Zsh completion regression
Date: Sat, 14 Jan 2012 15:32:08 +0100
Message-ID: <vpq7h0ufj87.fsf@bauges.imag.fr>
References: <1kdr5xk.1sopzul1hygnbrM%lists@haller-berlin.de>
	<vpq62ghj7fn.fsf@bauges.imag.fr> <20120114132343.GW30469@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Jan 14 15:32:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rm4eq-0006RW-QM
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 15:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818Ab2ANOcc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jan 2012 09:32:32 -0500
Received: from mx2.imag.fr ([129.88.30.17]:53389 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754653Ab2ANOcb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 09:32:31 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q0EEUWRS027973
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 14 Jan 2012 15:30:32 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Rm4eO-0002RZ-SQ; Sat, 14 Jan 2012 15:32:08 +0100
In-Reply-To: <20120114132343.GW30469@goldbirke> ("SZEDER =?iso-8859-1?Q?G?=
 =?iso-8859-1?Q?=E1bor=22's?= message of
	"Sat, 14 Jan 2012 14:23:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 14 Jan 2012 15:30:34 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q0EEUWRS027973
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1327156235.9704@Gos18TeKIdRN1vdoQhSlsg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188570>

SZEDER G=E1bor <szeder@ira.uka.de> writes:

>> but e.g. "git checkout
>> master<TAB>" does not add the trailing space, at all.
>
> I'm not sure what you mean; did you got a trailing space after
> 'master<TAB>' before a31e6262 (completion: optimize refs completion,
> 2011-10-15)?

No. My above sentence should read "... not add the trailing space, at
all, even for bash users". IOW, your understanding is correct.

> We could fix the regression by not appending a space suffix to
> completion words in __gitcomp_nl(), but only when the completion
> script is running under zsh to avoid hurting bash users, like this:
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 2d02a7f3..49393243 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -601,6 +601,9 @@ __gitcomp_nl ()
>  			suffix=3D"$4"
>  		fi
>  	fi
> +	if [ -n "${ZSH_VERSION-}" ] && [ "$suffix" =3D " " ]; then
> +		suffix=3D""
> +	fi
> =20
>  	IFS=3D$s
>  	COMPREPLY=3D($(compgen -P "${2-}" -S "$suffix" -W "$1" -- "$cur_"))

I hate to see special case for different shells, but if no one finds a
better solution, then yes, this is the way to go. Not having the space
may be irritating, but having the quoted space hurts really much more (=
I
have to delete the space and the backslash manually to continue).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
