From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 19/19] bash prompt: alternative git prompt without
	command substitution
Date: Thu, 10 May 2012 00:08:44 +0200
Message-ID: <20120509220844.GG6958@goldbirke>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
	<1336524290-30023-20-git-send-email-szeder@ira.uka.de>
	<4FAAC7AE.3020002@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Thu May 10 00:09:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSF4F-0002Sr-Mw
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 00:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558Ab2EIWIw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 18:08:52 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:57642 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932494Ab2EIWIt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 18:08:49 -0400
Received: from localhost6.localdomain6 (p5B1303EC.dip0.t-ipconnect.de [91.19.3.236])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MQJuC-1SZpkF0nuO-00UHzu; Thu, 10 May 2012 00:08:43 +0200
Content-Disposition: inline
In-Reply-To: <4FAAC7AE.3020002@pileofstuff.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:QWMQJ25f2Y6LpFWxBtaLPqxV3cICsNvtw72SIQgBioI
 FXVIGI2ye7Hf5au0mL5spSKnKoXxPqJvdmaigmgkk4h+6Cac08
 sV2H2kJcB0vqYGuDyed2ZFcXJMNEhHIIQyr1FQcot+LJeUM4Pk
 EKz4x6rTVt83u3z49Q641bShGNalj/H14jgN2Ib+XdWtk33WXr
 jRZrQrFp77uWs6oEunIrUWk4AtZT6PlSdnykkpvZ6kod6BIK9I
 DiEd1THgsLsmTc1Pyz/zGHBzAxCzR0M2nMx5E737IG/Lz6Acyg
 QBYtUofyp7fwniKULs/afyP0fLoF+1KHUcP1mUn+te6VIiLmyX
 Nh7MqfNhksR0tPSj1y3w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197523>

Hi,

On Wed, May 09, 2012 at 08:38:22PM +0100, Andrew Sayers wrote:
> On 09/05/12 01:44, SZEDER G=E1bor wrote:
> >    PROMPT_COMMAND=3D__git_prompt_command
>=20
> Rather than overwrite any existing PROMPT_COMMAND, it would be better=
 to
> do something like:
>=20
> PROMPT_COMMAND=3D"__git_prompt_command; $PROMPT_COMMAND"

> > +#       Alternatively, to make the above Bash prompt a bit faster:
> > +#               PROMPT_COMMAND=3D__git_prompt_command
>=20
> As above, I'd recommend a simple documentation change:
> PROMPT_COMMAND=3D"__git_prompt_command; $PROMPT_COMMAND"
> (to show people how to chain any other prompt commands they have)

That's a good idea.  In fact I did manage to overwrite my
$PROMPT_COMMAND and was wondering why did the title of my terminal
windows disappear so suddenly...


> > @@ -365,7 +371,18 @@ __git_ps1 ()
> >  	fi
> > =20
> >  	local f=3D"$w$i$s$u"
> > -	printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
> > +	__git_ps1_string=3D"$c${b##refs/heads/}${f:+ $f}$r$p"
> > +}
> > +
> > +# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
> > +# returns text to add to bash PS1 prompt (includes branch name)
> > +__git_ps1 ()
> > +{
> > +	local __git_ps1_string
> > +	__git_prompt_command
> > +	if [ -n "$__git_ps1_string" ]; then
> > +		printf -- "${1:- (%s)}" "$__git_ps1_string"
> > +	fi
>=20
> How hard/appropriate would it be to export individual parts of the
> prompt here?  Something like:
>=20
> __git_ps1_string_dirtystate=3D"$i"
> __git_ps1_string_untrackedfiles=3D"$u"
>=20
> There have been requests in the past to let people individually
> colourise different bits of the prompt, which this would make practic=
al.

We can't do that from __git_ps1(), because, as I mentioned in the commi=
t
message, it must be invoked in a command substitution from $PS1, and
what's exported in a subshell that stays in that subshell.

Doing so from __git_prompt_command() would be quite simple: just
rename the appropriate variables and don't declare them as local.
It would even be more pleasing to the eyes than the current one-letter
variable names.


G=E1bor
