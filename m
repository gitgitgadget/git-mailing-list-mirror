From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC/PATCH 1/4] Add git-sequencer shell prototype
Date: Fri, 4 Jul 2008 02:38:57 +0200
Message-ID: <20080704003857.GG6677@leksak.fem-net>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807031142540.9925@racer> <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <20080703210950.GC6677@leksak.fem-net> <alpine.DEB.1.00.0807040138090.2849@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 04 02:40:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEZLI-0003Ia-Nb
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 02:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947AbYGDAjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 20:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbYGDAjF
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 20:39:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:42430 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753900AbYGDAjD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 20:39:03 -0400
Received: (qmail invoked by alias); 04 Jul 2008 00:39:01 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp012) with SMTP; 04 Jul 2008 02:39:01 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+N5ghrCFON+iaXMsOdFMrCOKnOIvTPpiBWzoRrU/
	mMPoXFvxPwa53I
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KEZKD-0006vl-18; Fri, 04 Jul 2008 02:38:57 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807040138090.2849@eeepc-johanness>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87347>

Hi,

On Fri, Jul 04, 2008 at 01:53:21AM +0200, Johannes Schindelin wrote:
> On Thu, 3 Jul 2008, Stephan Beyer wrote:
> > Btw, another root commit problem is btw that it's not possible to 
> > cherry-pick root commits.
> 
> That is a problem to be fixed in cherry-pick, not in sequencer.  Care to 
> take care of that?

Not at the moment but that's one of the things I note down for later ;-)

And btw, somehow it is still open for me if builtin sequencer should be
a git-cherry-pick user (for pick) or if git-cherry-pick should be a
sequencer user (which would result in a change of usage on cherry-pick
conflicts).

> > Johannes Schindelin wrote:
> > > > > +# Usage: pick_one (cherry-pick|revert) [-*|--edit] sha1
> > > > > +pick_one () {
> > > > > +	what="$1"
> > > > > +	# we just assume that this is either cherry-pick or revert
> > > > > +	shift
> > > > > +
> > > > > +	# check for fast-forward if no options are given
> > > > > +	if expr "x$1" : 'x[^-]' >/dev/null
> > > > > +	then
> > > > > +		test "$(git rev-parse --verify "$1^")" = \
> > > > > +			"$(git rev-parse --verify HEAD)" &&
> > > > > +			output git reset --hard "$1" &&
> > > > > +			return
> > > > > +	fi
> > > > > +	test "$1" != '--edit' -a "$what" = 'revert' &&
> > > > > +		what='revert --no-edit'
> > > > 
> > > > This looks somewhat wrong.
> > > > 
> > > > When the history looks like ---A---B and we are at A, cherry-picking B can
> > > > be optimized to just advancing to B, but that optimization has a slight
> > > > difference (or two) in the semantics.
> > > > 
> > > >  (1) The committer information would not record the user and time of the
> > > >      sequencer operation, which actually may be a good thing.
> > > 
> > > This is debatable.  But I think you are correct, for all the same reasons 
> > > why a merge can result in a fast-forward.
> > 
> > Dscho, you mean me by referring to 'you' here, right?
> 
> Nope.
> 
> > Otherwise I'm a bit confused: "For the same reasons why a merge can 
> > result in a fast-forward we should not do fast forward here" ;-)
> 
> What I meant: there is no use here to redo it.  It has already be done, 
> and redoing just pretends that the girl calling sequencer tried to pretend 
> that she did it.
> 
> If the merge has been done already, it should not be redone.
> 
> Only if the user _explicitely_ specified a merge strategy, there _might_ 
> be a reason to redo the merge, but I still doubt it.

I don't get the light bulb.  You're talking about "the merge", I am
talking about fast-forward on picks.
Perhaps I got Junio wrong, too.

I try a simple example just to go sure that we're talking about the
same.

We have commits

  A ---- B ---- C ---- D
       HEAD

A is parent of B, B of C, C of D.

Now we do:
	pick C
	pick --signoff D
(Assume that the Signed-off-by: line is missing on D)

Without fast-forward, we get

  A ---- B ---- C ---- D
          \
           `--- C'---- D'
                     HEAD

C' differs in C only in the committer data, perhaps only committer date.

With fast-forward, we get:

  A ---- B ---- C ---- D
                 \
                  `--- D'
                     HEAD

If Junio meant with
>  (1) The committer information would not record the user and time of the
>      sequencer operation, which actually may be a good thing.
that he thinks the first variant is the way to go, I strongly disagree.
But perhaps I'm getting everyone wrong these days ;)


> > > >  (2) When $what is revert, this codepath shouldn't be exercised, 
> > > >  should it?
> > > 
> > > Yes.
> > 
> > I haven't done a check intentionally, but there was a stupid thinko.
> > So you're right.
> > 
> > But: this will only be a bug if the commit that _comes next in the
> > original history_ is to be reverted.
> 
> Does not matter.  It's a bug.
> 
> A bug is almost always in the details, a corner-case, but it almost always 
> needs fixing nevertheless.

Of course ;)

> > Nonetheless, purely tested:
> 
> "Nevertheless", maybe?  "untested", maybe?

No, I tested it once. ;-)
(For the new single-quoted variant I've changed the author name in
t3350).

> > Johannes Schindelin wrote:
> > > I'd not check in sequencer for the strategy.  Especially given that we 
> > > want to support user-written strategies in the future.
> > 
> > I don't know how this is planned to look like, but perhaps 
> > --list-strategies may make sense here, too.
> 
> No.  You just do not check for strategies.  Period.  git-merge does that, 
> and you can easily abort a rebase if you explicitely asked for an invalid 
> strategy.

Hmm, my dream of the "robust sequencing after sanity check passed" is
dead with your "period".
So I'll have to check what happens, when e.g. "--strategy=hours" is used.
(I mean, you should be in a safe state to do git sequencer --edit and
correct "hours" to "ours'.)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
