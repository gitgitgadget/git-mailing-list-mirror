From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 00/12] add --ff option to cherry-pick
Date: Thu, 4 Mar 2010 03:06:16 +0100
Message-ID: <201003040306.16580.chriscool@tuxfamily.org>
References: <20100228222038.2260.25016.chriscool@tuxfamily.org> <201003010800.13996.chriscool@tuxfamily.org> <7v635g4ec2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 03:06:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn0SQ-0000A3-O8
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 03:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699Ab0CDCGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 21:06:30 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:58676 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752379Ab0CDCG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 21:06:29 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 00FAA818057;
	Thu,  4 Mar 2010 03:06:19 +0100 (CET)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D67DB818049;
	Thu,  4 Mar 2010 03:06:16 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31-19-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <7v635g4ec2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141506>

On Monday 01 March 2010 09:48:45 Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > On Monday 01 March 2010 04:49:12 Junio C Hamano wrote:
> >> Thanks, but this seems to conflict with too many things in flight (it
> >> applies cleanly on top of 'pu' but not on top of 'next').
> >>
> >> Given that "rebase--interactive", which is the sole in-tree user of
> >> cherry-pick, has its own fast-forwarding logic to skip call to it, it
> >> seems to take too much time out of me to deal with the code churn for
> >> dubious benefit---the series does not seem to solve any real problem.
> >>
> >> After other topics have either graduated to 'master' or dropped out of
> >> 'pu', things might look differently, though.
> >
> > Ok I will wait for something like a week, and then rebase on top of next
> > and resend.
> 
> Actually, waiting, rebasing and resending, without any simplification,
> would be the worst thing you could do.  Perhaps the "waiting" time can be
> used to think how this can be simplified not to be such a big churn.

Ok, I removed some refactoring that was not really needed for this.

> For example, why wouldn't the core of a "cherry-pick --ff" be something
> like the attached patch, which obviously does not have "fast_forward_to"
> yet, but whose implementation should be obvious (the code should already
> be in "merge --ff" fast forward codepath, although I didn't look)?

I tried to use the checkout_fast_forward() function from builtin/merge.c but 
unfortunately it doesn't work. It gives an error like that in the tests :

error: Your local changes to 'file1' would be overwritten by merge.  Aborting.
Please, commit your changes or stash them before you can merge.

and I don't really understand why. (Though I didn't spend a lot of time on 
this.)

So the next version still refactors builtin/reset.c to create and then use a 
reset() function.

Thanks,
Christian.
