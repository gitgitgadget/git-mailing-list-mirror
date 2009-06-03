From: Jeff King <peff@peff.net>
Subject: Re: [Patch] Prevent cloning over http from spewing
Date: Wed, 3 Jun 2009 15:44:16 -0400
Message-ID: <20090603194416.GA30333@coredump.intra.peff.net>
References: <20090602174229.GA14455@infidigm.net> <m3vdnda9f7.fsf@localhost.localdomain> <7vmy8p8947.fsf@alter.siamese.dyndns.org> <20090603191050.GB29564@coredump.intra.peff.net> <20090603191555.GL3355@spearce.org> <20090603192420.GA29610@coredump.intra.peff.net> <20090603193205.GM3355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, sparse@infidigm.net,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 21:44:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBwO1-00016M-NU
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 21:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbZFCToY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 15:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbZFCToX
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 15:44:23 -0400
Received: from peff.net ([208.65.91.99]:49664 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311AbZFCToX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 15:44:23 -0400
Received: (qmail 25430 invoked by uid 107); 3 Jun 2009 19:44:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 03 Jun 2009 15:44:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jun 2009 15:44:16 -0400
Content-Disposition: inline
In-Reply-To: <20090603193205.GM3355@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120633>

On Wed, Jun 03, 2009 at 12:32:06PM -0700, Shawn O. Pearce wrote:

> > That's clever, and I think an "object count" would be fine (after all,
> > that is all that git:// fetching provides). However, I'm not sure how it
> > would work in practice. When we follow a walk to a commit in a pack, do
> > we really want to try to pull _just_ that commit?
> 
> No, we pull the whole pack.  So the progress meter would have to
> switch to do a content-length thing for the pack pull, then go back
> to the object queue.
> [...]
> By delaying trees/blobs, I meant delaying them for loose object
> fetch only, not pack based fetch.

Ah, OK, I see. I wonder if that would make a big difference in practice.
I expect repos to be fairly packed these days because of the I/O
benefits (and even if people aren't doing it manually, we auto-gc
working repos and keep pushed packs for publishing repos). So in
practice by the time you got an accurate object count, you would be more
or less done with the fetch (because you would have been grabbing the
related blobs in packs as you grabbed commits and trees).

-Peff
