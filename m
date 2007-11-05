From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [bug in next ?] git-fetch/git-push issue
Date: Mon, 5 Nov 2007 18:59:15 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711051846140.7357@iabervon.org>
References: <20071105175654.GD6205@artemis.corp> <Pine.LNX.4.64.0711051259580.7357@iabervon.org>
 <20071105210711.GA9176@sigill.intra.peff.net> <Pine.LNX.4.64.0711051620230.7357@iabervon.org>
 <20071105225540.GA10988@sigill.intra.peff.net> <7vhck0mg5y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Pierre Habouzit <madcoder@debian.org>,
	Nicolas Pitre <nico@cam.org>, Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 00:59:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpBqy-0006RI-7M
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 00:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218AbXKEX7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 18:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755217AbXKEX7S
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 18:59:18 -0500
Received: from iabervon.org ([66.92.72.58]:39546 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755193AbXKEX7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 18:59:16 -0500
Received: (qmail 32194 invoked by uid 1000); 5 Nov 2007 23:59:15 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Nov 2007 23:59:15 -0000
In-Reply-To: <7vhck0mg5y.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63596>

On Mon, 5 Nov 2007, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Which I guess is what you were trying to accomplish by removing the
> > peer_ref, though I think that doesn't distinguish between "didn't match
> > a remote ref" and "had an error." Perhaps we just need an error flag in
> > the ref struct?
> 
> I agree that makes the most sense.
> 
> As Steffen has been advocating on another thread, depending on
> your workflow, you do not care about some classes of push errors
> per pushed refs.  The update of the remote and local tracking
> refs should be done in sync (i.e. if the remote wasn't updated,
> never update the corresponding local), but it can depend on the
> nature of the failure if a failure to update a remote ref should
> result in the non-zero exit status from git-push as a whole.
> 
> And to implement that, per-ref error flag would be a good way to
> go, methinks.

I think dropping peer_ref may be the clearest semantics. If push decides 
not to actually perform a push, we can just remove it from the list of 
operations we're performing. Independant of this, we can decide whether to 
signal an error, and whether an error means that the remote end will have 
done nothing at all (in which case, we must not update tracking refs).

That is, on top of my changes in other email, Steffan would have the 
strictly behind case just not have the "ret = -2" and everything else 
would be fine.

	-Daniel
*This .sig left intentionally blank*
