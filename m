From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2 3/4] completion: cleanup __gitcomp*
Date: Tue, 31 Jan 2012 01:15:35 +0100
Message-ID: <20120131001535.GB2632@goldbirke>
References: <1327944197-6379-1-git-send-email-felipec@infradead.org>
	<1327944197-6379-4-git-send-email-felipec@infradead.org>
	<20120130175004.GG10618@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipec@infradead.org>, git@vger.kernel.org,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ted Pavlic <ted@tedpavlic.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 31 01:15:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rs1Ny-0003qQ-7O
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 01:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148Ab2AaAPj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jan 2012 19:15:39 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:59209 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622Ab2AaAPg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 19:15:36 -0500
Received: from localhost6.localdomain6 (p5B1304BC.dip0.t-ipconnect.de [91.19.4.188])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0MJoUy-1RqvSB3bZE-001XoQ; Tue, 31 Jan 2012 01:15:32 +0100
Content-Disposition: inline
In-Reply-To: <20120130175004.GG10618@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:w450hiy+2fnpzzU8ofDgI/vTLewiskDZXRWx/xgCgEn
 PopqmS01ahU0GerZIBquRphBrBEAeZ6QFipO3MOup0XaigfNFp
 DDTHq+eqtTY9HCjK68rQA68WWogrlDiIf2K+4QY6JCdoouFTdQ
 L/h3ZFD/qDM61eiVjnIy5SQ/Q06Q3wvjR1AEpNmIXTxF2ceE7y
 tqovKT26oZypybxGQ1o5zn3o4AwDg2nRYLgS/isyjGUJzwo6gi
 75Qty5JdOC/j3Z5Jr/DngGFKDN1FNKuTEGT7XQnt55XZetmtqL
 bf8zEOR93Mo5/9oJCEHui/Gj/lV+G7L755krKzkIF8FwfsL7es
 kusWLogishuAyXJRddic=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189436>

Hi,


On Mon, Jan 30, 2012 at 11:50:04AM -0600, Jonathan Nieder wrote:
> Felipe Contreras wrote:
>=20
> > I don't know why there's so much code; these functions don't seem t=
o be
> > doing much:
>=20
> Unless you mean "This patch has had inadequate review and I don't
> understand the code I'm patching, so do not trust it", please drop
> this commentary or place it after the three dashes.
>=20
> >  * no need to check $#, ${3:-$cur} is much easier
> >  * __gitcomp_nl doesn't seem to using the initial IFS
> >
> > This makes the code much simpler.
> >
> > Eventually it would be nice to wrap everything that touches compgen=
 and
> > COMPREPLY in one function for the zsh wrapper.
> >
> > Comments by Jonathan Nieder.
>=20
> I don't want this acknowledgement.  Who should care that I commented
> on something?
>=20
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  contrib/completion/git-completion.bash |   20 +++-----------------
> >  1 files changed, 3 insertions(+), 17 deletions(-)
>=20
> This diffstat tells me more of what I wanted to know about the patch
> than the description did.
>=20
> I imagine it would have been enough to say something along the lines =
of
> "The __gitcomp and __gitcomp_nl functions are unnecessarily verbose.
> __gitcomp_nl sets IFS to " \t\n" unnecessarily

Yeah, that's unnecessary.  I'm not sure why I did that, perhaps just
blindly followed suit of gitcomp_1(), without realizing that I don't
do any word-splitting in __gitcomp_nl() except when invoking compgen.

> before setting it to "\n"
> by mistake.

But that is deliberate, that's why it's called __gitcomp_nl(), see
a31e6262 (completion: optimize refs completion, 2011-10-15), third
paragraph.

>  Both functions use 'if' statements to read parameters
> with defaults, where the ${parameter:-default} idiom would be just as
> clear.  By fixing these, we can make each function almost a one-liner=
=2E"
>=20
> By the way, the subject ("clean up __gitcomp*") tells me almost as
> little as something like "fix __gitcomp*".  A person reading the
> shortlog would like to know _how_ you are fixing it, or what the
> impact of the change will be --- e.g., something like "simplify
> __gitcomp and __gitcomp_nl" would be clearer.
>=20
> [...]
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> [...]
> > @@ -524,18 +520,8 @@ __gitcomp ()
> >  #    appended.
> >  __gitcomp_nl ()
> >  {
> > -	local s=3D$'\n' IFS=3D' '$'\t'$'\n'
> > -	local cur_=3D"$cur" suffix=3D" "
> > -
> > -	if [ $# -gt 2 ]; then
> > -		cur_=3D"$3"
> > -		if [ $# -gt 3 ]; then
> > -			suffix=3D"$4"
> > -		fi
> > -	fi
> > -
> > -	IFS=3D$s
> > -	COMPREPLY=3D($(compgen -P "${2-}" -S "$suffix" -W "$1" -- "$cur_"=
))
> > +	local IFS=3D$'\n'
> > +	COMPREPLY=3D($(compgen -P "${2-}" -S "${4:- }" -W "$1" -- "${3:-$=
cur}"))
>=20
> This loses the nice name $suffix for the -S argument.  Not a problem,
> just noticing.

I think loosing the name of $suffix would be OK, because the comment
above the function explains what the fourth parameter is about.

However, that comment also says that "If [the 4. argument is]
specified but empty, nothing is appended.", but this patch changes
this behavior, because "${4:- }" is substituted by a SP when $4 is an
empty string.  You have to drop the colon and use "${4- }" there:

$ foo=3D""
$ echo ,${foo:- },
, ,
$ echo ,${foo- },
,,


Best,
G=E1bor
