From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow update hooks to update refs on their own
Date: Wed, 28 Nov 2007 15:22:50 -0500
Message-ID: <20071128202250.GA12777@coredump.intra.peff.net>
References: <7vmysy5h5k.fsf@gitster.siamese.dyndns.org> <20071128194159.GA25977@midwinter.com> <20071128194919.GC11396@coredump.intra.peff.net> <C1321BD5-8F6B-47F9-9BDB-C2BF819D6F17@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 21:23:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxTRC-0002BF-Gv
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 21:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756452AbXK1UWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 15:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756272AbXK1UWy
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 15:22:54 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2106 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756237AbXK1UWx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 15:22:53 -0500
Received: (qmail 13986 invoked by uid 111); 28 Nov 2007 20:22:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 28 Nov 2007 15:22:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2007 15:22:50 -0500
Content-Disposition: inline
In-Reply-To: <C1321BD5-8F6B-47F9-9BDB-C2BF819D6F17@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66421>

On Wed, Nov 28, 2007 at 12:16:27PM -0800, Steven Grimm wrote:

> Well, actually, I would still like opinions on one thing: What do people 
> think of having git-push do a fetch if the remote side changes a ref to 
> point to a revision that doesn't exist locally? Is there a situation where 
> you'd ever want to *not* do that?

It can be slow, since you have to make another connection to the server,
so clearly it should only be done when you detect an update (which I
think is what you're proposing).

A raw "git-fetch" might pull a lot of extra cruft that you didn't want
to get right now. So if you did do it, I think it would make sense to
construct a set of refspecs that match only the ones which need pulling
(i.e., in update_tracking_ref, rather than doing the update, construct a
refspec of "local:tracking", and then hand all such refspecs to
git-fetch).

-Peff
