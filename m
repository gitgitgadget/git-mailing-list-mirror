From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] push: fix local refs update if already up-to-date
Date: Tue, 4 Nov 2008 10:05:19 +0100
Message-ID: <20081104090519.GB22530@localhost>
References: <20081104000745.GA28480@localhost> <20081104042643.GA31276@coredump.intra.peff.net> <7v7i7jsx6a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 10:06:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxHrr-0006Jm-2x
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 10:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248AbYKDJFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 04:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754042AbYKDJFM
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 04:05:12 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:41995 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248AbYKDJFI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 04:05:08 -0500
Received: from darc.dyndns.org ([84.154.77.179]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 4 Nov 2008 10:05:06 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1KxHqh-0005yC-Kl; Tue, 04 Nov 2008 10:05:19 +0100
Content-Disposition: inline
In-Reply-To: <7v7i7jsx6a.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 04 Nov 2008 09:05:07.0018 (UTC) FILETIME=[6E98A2A0:01C93E5C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100062>

On Tue, Nov 04, 2008 at 12:38:37AM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > Though I am not happy that we have to look up the tracking ref for every
> > uptodate ref. I think it shouldn't be a big performance problem with
> > packed refs, though, since they are cached (i.e., we pay only to compare
> > the hashes, not touch the filesystem for each ref).
> 
> It is either (1) the user pays the cost of finding what remote tracking
> branch we are mirroring when you push for all up-to-date refs, like you
> did in your "here is an improvement" patch; or (2) the user pays the cost
> of fetching from there, immediately after pushing.  I'd imagine that the
> cost to do (1) would be smaller than (2).  The question is if seeing stale
> tracking branches is such a big deal, as next "git fetch" from there will
> update them anyway.  If it is a big deal, (1) would be a price worth
> paying.

Right. I think it is a big deal. I found out about this bug, because a user
on #git was confused by the fact that push reported "Everything up-to-date",
even though there were changes. A fetch fixed that, of course. But it is
confusing and inconsistent with normal push behavior. So I really think it's
worth a small performance hit.

> Clemens, care to reroll the patch?

I will do so later today.
