From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Tue, 13 Mar 2012 17:30:45 -0400
Message-ID: <20120313213045.GD27436@sigill.intra.peff.net>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
 <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
 <1331288715.21444.38.camel@beez.lab.cmartin.tk>
 <4F5A4C45.7070406@xiplink.com>
 <4F5AF1A8.4050604@alum.mit.edu>
 <4F5E12A5.6030701@xiplink.com>
 <vpqzkblixmb.fsf@bauges.imag.fr>
 <20120312183725.GA2187@sigill.intra.peff.net>
 <7vfwddskon.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 22:30:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7ZJ4-0004WA-OK
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 22:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759419Ab2CMVav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 17:30:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48708
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755216Ab2CMVat (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 17:30:49 -0400
Received: (qmail 2351 invoked by uid 107); 13 Mar 2012 21:30:59 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Mar 2012 17:30:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Mar 2012 17:30:45 -0400
Content-Disposition: inline
In-Reply-To: <7vfwddskon.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193070>

On Mon, Mar 12, 2012 at 12:06:48PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... This is not a push.default issue,
> > but I think it is somewhat related, and maybe worth discussing along
> > with the topic of asymmetry. ...
> > I've mostly trained my fingers to type "git push
> > <my-publish-repo>", but I do occasionally forget.
> 
> In an assymmetric set-up, you would typically push into one place
> but update from one or more places, so it might make sense to make
> it easier to say "git push" and "git pull $there".  But that does
> not solve the fundamental issue, I would think.

I think it can even be a bit more complex than that. For example, I
actually _never_ run git-pull. Instead, I fetch, and then use the
upstream config for lots of other operations, like seeing what's in a
topic branch, rebasing, etc.

So to me, it is not just about "symmetry between push and pull", but
that the upstream config is fundamentally about "what is this work based
off of", which may or may not have anything to do with where you are
pushing to.

> > Do other people with
> > asymmetric workflows find this annoying? Do they not care? Or are many
> > fewer people doing asymmetric things than I think?
> 
> I think it is not "they do not care", but "they do not have a good
> solution".  I do not think of anything offhand, either.

The branch.*.pushRemote you mentioned would help with that. But for me,
I would much rather have simply push.defaultRemote. Configuring each
branch independently would be a pain, and I always want to push to my
publishing point (or at least, by default; anything else is a one-off
that can get an option on the command line). It is not a per-branch
thing at all for me.

Speaking of which, I often get annoyed at the per-branch
auto-configuration of upstreams. For example, I find myself doing this:

  [get an idea, read a bug report on the list, etc]
  $ cd git
  $ hack hack hack
  [oh, this is turning into something real. Let's make a branch]
  $ git checkout -b jk/bug-fix
  $ git commit -m 'fix bug'

but now my bug-fix branch is based off of wherever I was (which is
usually some private topic-integration branch I run most of the time).
I wish there was some way to say "No, branches should _always_ consider
origin/master as their upstream, unless I configure them some other
way" (which I do occasionally for building sub-topics on other topics).

Which makes me wonder if perhaps people are using "upstream" to mean
several different thing. I use it to say "this is the branch that this
topic is based off of", which makes "git log @{u}.." helpful, "git
rebase -i" just work, and gives some meaning to the ahead/behind message
(it shows how my topic relates to the main project).

But I think people also use upstream to mean "this is the definitive
version of this branch in some central repo". So they would say that
"jk/bug-fix" is based on "origin/jk/bug-fix". And the ahead/behind
message is about "do I have any local work that needs pushed, or any
remote work that needs pulled?"

And I wonder if this is where some of the debate for
push.default=upstream comes from. Whether that is useful to you or not
would depend on how you set up your branches. In the latter model, I
would think pushing to the upstream would be the right thing.

> Because "upstream" is meant to be "For the branch I am on, you know
> how the branches map between the remote repository, so you already
> know what the right thing to do---do it" mode, the correct "guess"
> in your case is to error out and say "Nah, you are not talking with
> your upstream, so I do not have any clue what branches you want to
> push out and how. As you said that the push.default is upstream, not
> matching, I refuse to even do the matching push in your case.  This
> is an error. Be more specific".

Yeah, I agree that is the only sane thing to do.

> I do not think "the most number of people" is a high-priority issue,
> but "least damage" default may not be necessarily the best.
> 
> Obviously, "nothing" is the least-damage option, and looking at how
> even people on this list cannot decide between current and upstream,
> I actually am very tempted to suggest it as the new default.

I was tempted to suggest that, but it somehow feels too overboard and
unfriendly.  I really like "current", as it seems like the simplest and
unsurprising thing we can do, short of doing nothing at all.

-Peff
