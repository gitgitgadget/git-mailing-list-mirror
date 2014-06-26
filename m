From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: BUG: git request-pull broken for plain branches
Date: Thu, 26 Jun 2014 09:06:12 +0200
Message-ID: <20140626070612.GR14781@pengutronix.de>
References: <20140625095535.GA27365@pengutronix.de>
 <CA+55aFwZb7tT7xb7y2XJpzcmrxB=Rf--bjz5XbBcxC-7MMm9eg@mail.gmail.com>
 <20140625132131.GO14781@pengutronix.de>
 <xmqqoaxg90y4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>, kernel@pengutronix.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 09:06:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X03lK-0006Wa-IT
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 09:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbaFZHGV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jun 2014 03:06:21 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34462 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358AbaFZHGV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 03:06:21 -0400
Received: from ptx.hi.pengutronix.de ([2001:6f8:1178:2:5054:ff:fec0:8e10] ident=Debian-exim)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1X03l9-0005Jf-8C; Thu, 26 Jun 2014 09:06:15 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1X03l6-0002fL-Gg; Thu, 26 Jun 2014 09:06:12 +0200
Content-Disposition: inline
In-Reply-To: <xmqqoaxg90y4.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:5054:ff:fec0:8e10
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252487>

Hi Junio,

On Wed, Jun 25, 2014 at 01:41:23PM -0700, Junio C Hamano wrote:
> Uwe Kleine-K=F6nig  <u.kleine-koenig@pengutronix.de> writes:
> > On Wed, Jun 25, 2014 at 05:05:51AM -0700, Linus Torvalds wrote:
> >> On Wed, Jun 25, 2014 at 2:55 AM, Uwe Kleine-K=F6nig
> >> <u.kleine-koenig@pengutronix.de> wrote:
> >> >
> >> >         $ git rev-parse HEAD
> >> >         9e065e4a5a58308f1a0da4bb80b830929dfa90b3
> >> >         $ git ls-remote origin | grep 9e065e4a5a58308f1a0da4bb80=
b830929dfa90b3
> >> >         9e065e4a5a58308f1a0da4bb80b830929dfa90b3        refs/hea=
ds/ukl/for-mainline
> >> >         $ git request-pull origin/master origin HEAD > /dev/null
> >> >         warn: No match for commit 9e065e4a5a58308f1a0da4bb80b830=
929dfa90b3 found at origin
> >> >         warn: Are you sure you pushed 'HEAD' there?
> >>=20
> >> Notice how "HEAD" does not match.
> >>=20
> >> The error message is perhaps misleading. It's not enough to match =
the
> >> commit. You need to match the branch name too. git used to guess t=
he
> >> branch name (from the commit), and it often guessed wrongly. So no=
w
> >> they need to match.
> >>=20
> >> So you should do
> >>=20
> >>     git request-pull origin/master origin ukl/for-mainline
> >>=20
> >> to let request-pull know that you're requesting a pull for "ukl/fo=
r-mainline".
>=20
> Or
>=20
> 	git request-pull origin/master origin HEAD:ukl/for-mainline
>=20
> I am not Linus, and do not speak for him, but FWIW here are some
> comments on the ideas.
>=20
> > I liked git guessing the branch name, maybe we can teach it to gues=
s a
> > bit better than it did before 2.0? Something like:
> >
> >  - if there is a unique match on the remote side, use it.
>=20
> I am on the fence but slightly leaning to the negative side on this
> one.  The branch/ref the object was took from when "git pull" is run
> does matter, because the name is recorded in the merge summary, so
> we cannot say "There are refs that happen to point at the object you
> wanted to be pulled, so we'll pick one of them let the integrator
> pull from that ref we randomly chose" is not something we would
> want.  "If there is a unique one, that must be the one the user has
> meant; there is nothing else possible" feels like a strong argument,
> and I was actually contemplating about doing an enhancement on top
> of Linus's original myself along that line, back when we queued that
> patch exactly for that reason.
>=20
> But a counter-argument, in the context of Linus's change in question
> being primarily to avoid end-user mistakes resulting in a bogus
> request, is that the ref on the remote that happens to match the
> object but is different from what the user named may be a totally
> unrelated branch before the user actually has pushed the set of
> changes the request is going to ask to be pulled.  The mistake that
> this extra strictness tries to avoid is to compose request-pull
> before pushing what to be pulled and then forgetting to push.
Sounds sensible. Then the enhancements that come to my mind are:

Change git-request-pull to explicitly take a remote ref as end. This
makes sure that it is actually there and the right remote name is
picked. Don't require to specify a local ref even if there is no
local matching ref, just use the remote sha1 to generate the diffstat
and summary.

Another thing I'd like to have is to make git-request-pull not generate
the usual output if there is no match. Optionally introduce a -f to get
back the (maybe bogus) output; in this case a local rev would be needed=
=2E

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
