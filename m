From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC/PATCH 2/4] Add git-sequencer prototype documentation
Date: Wed, 2 Jul 2008 05:01:35 +0200
Message-ID: <20080702030135.GF5301@leksak.fem-net>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <200807012004.11563.jnareb@gmail.com> <20080701195033.GD5301@leksak.fem-net> <200807020239.41613.jnareb@gmail.com> <7v4p79hyk0.fsf@gitster.siamese.dyndns.org> <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <200807012004.11563.jnareb@gmail.com> <20080701195033.GD5301@leksak.fem-net> <200807020239.41613.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 05:02:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDscC-0006m9-59
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 05:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757484AbYGBDBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 23:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757981AbYGBDBm
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 23:01:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:60028 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754425AbYGBDBl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 23:01:41 -0400
Received: (qmail invoked by alias); 02 Jul 2008 03:01:39 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp055) with SMTP; 02 Jul 2008 05:01:39 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19WcYMTzn5W3WvOYS+t2oMsCVW8y6Q9m9SJomVgOr
	U8iHB5IEcpT9OF
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KDsb9-000697-Ul; Wed, 02 Jul 2008 05:01:35 +0200
Content-Disposition: inline
In-Reply-To: <7v4p79hyk0.fsf@gitster.siamese.dyndns.org> <200807020239.41613.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87081>

On Wed, Jul 02, 2008 at 02:39:40AM +0200, Jakub Narebski wrote:
> On Tue, 1 July 2008, Stephan Beyer wrote:
> > On Tue, Jul 01, 2008 at 08:04:10PM +0200, Jakub Narebski wrote:
[...]
> > No. It is "git-update-ref <ref> HEAD".
> 
> So what do you envision would this be used for?

I think if I had not started on top js/rebase-i-sequencer, I would have
not necessarily added "ref" (or "tag", as it was before).
But js/rebase-i-sequencer introduced a nice feature to
git-rebase-i:
 -t,--preserve-tags ... "update tags to the new commit object"

I think this is worth the feature ;-)

On Tue, Jul 01, 2008 at 06:20:15PM -0700, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> >> No. It is "git-update-ref <ref> HEAD".
> >
> > So what do you envision would this be used for?
> 
> A simple answer and a more elaborate one.
> 
>  * It is the final step of "git rebase" which detaches HEAD while it
>    operates these days.

Ha ;)
That's a quite obvious truth that I have not implemented.
Btw: sequencer does the detaching/attaching when using "--onto <base>"
and <base> is a branch.
IIRC there was a reason that I also kept the detaching/attaching of
git-rebase-i itself but I can't remember. (I think I have to look
over the rebase-i code more carefully later...)

>  * You can drive sequencer backend from a front-end that rewrite history
>    while rewriting tags, like filter-branch does.

Yes.

> >>> What is important is: does it update reflog (correctly)?
> 
> That is not very important question, as reflog updates would happen as
> long as you use update-ref automatically.
> 
> Much more important question you did not ask is how it would interact with
> "sequencer --abort".  Ideally it should rewind the ref update (and without
> relying on the user having reflog on that ref).

Yes, you asked the question in the RFC thread about the spec.

"Rewind the ref update" means:
 - delete new generated refs
 - update overwritten refs to their old commits
So if I keep a list containing <ref> [<oldcommit>], that behavior
is easily reached. But this is not suited for the shell prototype ;)


Btw, also the --skip case can be arguable:

	pick fa1afe1
	pick cedefe1	# conflict, will be "--skip"ped
	ref refs/tags/v1.6.2

Here the question can be, if the "ref" should be skipped, too.
But I think the just-don't-care-strategy is a good one, so
that fa1afe1' will be tagged.

> I however personally feel that this "ref" thing is being a bit too
> ambitious.

I agree that it is no must-have feature but a nice-to-have feature ;)
Especially for the --preserve-tags feature.


Jakub wrote:
> >>>>> +squash [options] --from <mark>::
> > [...]
> >>> Here an example why it is useful for user-editing:
> >>> 
> >>> (on commit f00babe)
> >>> 	mark :1
> >>> 	pick badcebab
> >>> 	patch foo
> >>> 	pick dadadada
> >>> 	squash -m "Foo the cebab" --signoff --from :1
> >>> 
> >>> This squashes all between the mark and the squash into one commit,
> >>> on top of f00babe.
> >>  
> >> Ah, so squash --from <mark> picks up everything since "mark <mark>",
> >> but does not include marked commit!  Clever!  In this case allowing
> >> only <mark> is a good idea, IMVHO.
> > 
> > Good, thanks :)
> 
> Although I guess having example would make it clear from the go...

Yes, I see that the EXAMPLES section is really important and the
squash --from is important therein.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
