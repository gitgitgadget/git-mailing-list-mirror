From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 25 Nov 2007 23:08:55 +0000
Message-ID: <20071125230855.GE23820@fieldses.org>
References: <7vabpctx3b.fsf@gitster.siamese.dyndns.org> <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org> <20071123103003.GB6754@sigill.intra.peff.net> <Pine.LNX.4.64.0711231319220.27959@racer.site> <20071124113814.GA17861@sigill.intra.peff.net> <alpine.LFD.0.99999.0711241042011.9605@xanadu.home> <7vtznbqx2w.fsf@gitster.siamese.dyndns.org> <20071125215128.GC23820@fieldses.org> <7v63zqj6bj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 00:09:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwQbM-0001r7-8l
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 00:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240AbXKYXJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 18:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754549AbXKYXJE
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 18:09:04 -0500
Received: from mail.fieldses.org ([66.93.2.214]:42412 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754719AbXKYXJD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 18:09:03 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IwQat-0000jO-CK; Sun, 25 Nov 2007 23:08:55 +0000
Content-Disposition: inline
In-Reply-To: <7v63zqj6bj.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66024>

On Sun, Nov 25, 2007 at 02:42:08PM -0800, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> > Anyway, here's a first draft.
> >
> > --b.
> >
> > diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> > index 8355cce..7544715 100644
> > --- a/Documentation/user-manual.txt
> > +++ b/Documentation/user-manual.txt
> > ...
> > +Normally whenever a branch head in a public repository is modified, it
> > +is modified to point to a descendent of the commit that it pointed to
> > +before.  By forcing a push in this situation, you break that convention.
> > +(See <<problems-with-rewriting-history>>).
> > +
> > +Nevertheless, this is a common practice for people that need a simple
> > +way to publish a work-in-progress patch series, and it is an acceptable
> > +compromise as long as you warn other developers that this is how you
> > +intend to manage the branch.
> 
> Note that modern git allows repository owners to forbid such a forced
> non fast forward push at the receiving end.  In such a case, you cannot
> even force a push.
> 
> Instead, you would need to fetch the current branch tip from the remote
> and merge it into the branch you were tring to push, possibly using the
> "ours" merge strategy, before pushing it again.  Use of "ours" merge in
> such a case:
> 
>  - makes the next fetch by other people properly fast-forwarding;
> 
>  - records your admission of guilt: "I screwed up the last push and
>    this is a replacement --- this is what I really should have pushed
>    the last time".
> 
>  - makes the resulting tree exactly the same as what you tried to push
>    unsuccessfully.  This is a valid substitute to a forced push in that
>    it reverts the mistakes _you_ made with the previous push.

OK, that's interesting.  In a similar vein, I've been experimenting with
"merge -s ours" lately as a way to keep track of the "meta-history" of
an unsubmitted patch series in progress.  It seems a little hairy right
now, but maybe it'll turn out to be The Right Thing to do.

I don't want to deal with this in the manual yet.  For the sake of
keeping things simple, I'd rather first stick to the case of a public
repository set up by the user which the user controls.  And I think that
kind of use of "-s ours" is worth documenting but I'm not sure how to
deal with it yet.

--b.
