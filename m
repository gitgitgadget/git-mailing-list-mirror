From: Francis Galiegue <fg@one2team.com>
Subject: Re: [PATCH] git send-email: edit recipient addresses with the  --compose flag
Date: Mon, 10 Nov 2008 08:49:36 +0100
Organization: One2team
Message-ID: <200811100849.36736.fg@one2team.com>
References: <1226235588-2997-1-git-send-email-ian.hilt@gmx.com> <7viqqwa6wo.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0811091910570.21142@sys-0.hiltweb.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Ian Hilt <ian.hilt@gmx.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 08:51:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzRYK-0006DE-9Z
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 08:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbYKJHuA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 02:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753454AbYKJHuA
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 02:50:00 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:59792 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753335AbYKJHt7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 02:49:59 -0500
Received: from smtp.olympe.o2t (138.193.65-86.rev.gaoland.net [86.65.193.138])
	by ns35774.ovh.net (Postfix) with ESMTP id 11F8392C003;
	Mon, 10 Nov 2008 08:49:54 +0100 (CET)
Received: from erwin.kitchen.eel (unknown [10.8.0.6])
	by smtp.olympe.o2t (Postfix) with ESMTP id CC1877001F;
	Mon, 10 Nov 2008 08:49:56 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LFD.2.00.0811091910570.21142@sys-0.hiltweb.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100496>

Le Monday 10 November 2008 01:38:30 Ian Hilt, vous avez =E9crit=A0:
> On Sun, 9 Nov 2008, Junio C Hamano wrote:
> > Ian Hilt <ian.hilt@gmx.com> writes:
> > > On Sun, 9 Nov 2008, Francis Galiegue wrote:
> > >> Le Sunday 09 November 2008 13:59:48 Ian Hilt, vous avez =E9crit=A0=
:
> > >> > +	if ($c_file =3D~ /^To:\s*+(.+)\s*\nCc:/ism) {
> > >>
> > >> Greedy operators are only supported with perl 5.10 or more... I =
think
> > >> it's a bad idea to use them...
> > >
> > > The problem here was that a space should follow the field, but it=
 may
> > > not.  The user may unwarily backup over it.  "\s*" would match th=
is
> > > case.
> > >
> > > But if there is a space, it is included in the "(.+)".  So I trie=
d
> > > "\s+", which did not include the space, but it won't include the =
first
> > > address if there isn't a space after the field.
> > >
> > > The quantified subpattern seemed to do the trick.  But, if it cou=
ld
> > > result in a dependency issue, I would agree this would be a bad i=
dea.
> >
> > You expect something non-blank there anyway, so why not do:
> >
> > 	To:\s*(\S.*?)\s*\n....
>
> That works.  Although, I seem to be missing Francis' point.

No. The _lazy_ quantifiers (*?, ??, *?, +?, {...}?) are supported all r=
ight.=20
But they should be avoided in general.

> According=20
> to perlre, a quantified subpattern is "greedy".  So a "greedy operato=
r"
> is any one of the standard quantified subpatterns.  The "+" and "?"
> modify its matching behavior.  And it seems to me that it _has_ to us=
e a
> q.s. to work ...

My wording may be bad, then. They're not greedy, they just don't allow =
for=20
backtracking. They are more than greedy. Let me explain.

Consider "number 42" for instance. If you match it against:

* .*(\d+) =3D> $1 would be "2": the * eats everything but _has_ to back=
track for=20
\d+ to get anything, but just one number is enough;
* .*?(\d+) =3D> $1 would be "42": as *? is lazy, this means that after =
each=20
match, it looks to see whether the next element in the regex would matc=
h=20
anything; as soon as \d+ matches 4, .*? stops there;
* .*+(\d+) =3D> $1 would match nothing! *+ eats everything, but the + a=
fterwards=20
_doesn't allow it to backtrack_.

I hope this makes things a little clearer ;) I think the correct term f=
or *+,=20
++, ?+ etc is "possessive" quantifiers, I'm just not sure.

--=20
=46rancis Galiegue
ONE2TEAM
Ing=E9nieur syst=E8me
Mob : +33 (0) 6 83 87 78 75
Tel : +33 (0) 1 78 94 55 52
fge@one2team.com
40 avenue Raymond Poincar=E9
75116 Paris
