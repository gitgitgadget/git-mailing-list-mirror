From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Zsh completion regression
Date: Sat, 14 Jan 2012 16:20:30 +0100
Message-ID: <20120114152030.GX30469@goldbirke>
References: <1kdr5xk.1sopzul1hygnbrM%lists@haller-berlin.de>
	<vpq62ghj7fn.fsf@bauges.imag.fr> <20120114132343.GW30469@goldbirke>
	<vpq7h0ufj87.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Jan 14 16:20:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rm5PN-0007we-Qx
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 16:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136Ab2ANPUe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jan 2012 10:20:34 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:55715 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060Ab2ANPUd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 10:20:33 -0500
Received: from localhost6.localdomain6 (p5B130AF3.dip0.t-ipconnect.de [91.19.10.243])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0LupVN-1SlN9i0Byj-010h1y; Sat, 14 Jan 2012 16:20:31 +0100
Content-Disposition: inline
In-Reply-To: <vpq7h0ufj87.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:20enWlrM7kBUoOf1efCjMNY7mV5okhMXlqahIMrWMJ/
 E28tRCV4Ts7OQ9BwM4oko+p55B8x2e2xE/GwnBjwfO9eu3K5hb
 684pdcEzOCscNTcD7jB/0sJTrGzh7rcGvQAe0n7gXKm8SYUzGn
 QlPVhXwFa6rF56gHcNkmi47cPXTg9q9/7PiYalfiYsaMxLolTO
 u9jxEFy5kzuLFPAeG9z3fZgg8wsfYM/hPHwzzNSpJqvcM6hPkn
 dR1RY1nVyQhh5UuoFCbzyZVUSrLFi1PJ6I2uNVRGXSN+xSEssS
 3L0OIih8Xw4ntePSVl470rD9QeOkg0QIzdOmnh0lqyIgfRnwDg
 CdotB7WEjZ8ZPO4e6EiM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188571>

Hi,


On Sat, Jan 14, 2012 at 03:32:08PM +0100, Matthieu Moy wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
> > We could fix the regression by not appending a space suffix to
> > completion words in __gitcomp_nl(), but only when the completion
> > script is running under zsh to avoid hurting bash users, like this:
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/compl=
etion/git-completion.bash
> > index 2d02a7f3..49393243 100755
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -601,6 +601,9 @@ __gitcomp_nl ()
> >  			suffix=3D"$4"
> >  		fi
> >  	fi
> > +	if [ -n "${ZSH_VERSION-}" ] && [ "$suffix" =3D " " ]; then
> > +		suffix=3D""
> > +	fi
> > =20
> >  	IFS=3D$s
> >  	COMPREPLY=3D($(compgen -P "${2-}" -S "$suffix" -W "$1" -- "$cur_"=
))
>=20
> I hate to see special case for different shells,

I agree and thought about that, too.  We are dealing with zsh quirks
in the completion script either by

- having whole functions with different definitions in zsh and
  in bash (currently__git_shopt() and _get_comp_words_by_ref()), or=20
- having similar shell-specific cases inside functions (currently
  _git() and _gitk()).

We use the former when the implementations for the two shells differ
significantly, and the latter when the shell-specific parts are small
and most of the function's implementation can be used in both shells.
I think this regression fix fits into the latter category.

> but if no one finds a
> better solution, then yes, this is the way to go. Not having the spac=
e
> may be irritating, but having the quoted space hurts really much more=
 (I
> have to delete the space and the backslash manually to continue).

I have no better idea for fixing this regression, and no idea at all
for a proper fix (i.e. to make zsh behave the same way in this respect
as bash).  I can imagine that it's irritating, that's why I aimed for
this minimal regression fix, which, maybe with a Tested-by from you or
Stefan, can even go into maint, so affected users can get it faster.


Best,
G=E1bor
