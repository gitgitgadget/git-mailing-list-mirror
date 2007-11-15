From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Improved and extended t5404
Date: Wed, 14 Nov 2007 23:35:14 -0500
Message-ID: <20071115043513.GA10193@sigill.intra.peff.net>
References: <20071112213823.GB2918@steel.home> <20071112213938.GC2918@steel.home> <20071113075240.GA21799@sigill.intra.peff.net> <20071113194731.GC3268@steel.home> <20071113194909.GD3268@steel.home> <20071113230234.GI3268@steel.home> <7vmythr8xf.fsf@gitster.siamese.dyndns.org> <20071114071929.GA2942@steel.home> <20071115041801.GA9794@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 05:35:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsWS5-0001LJ-He
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 05:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864AbXKOEfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 23:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754433AbXKOEfV
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 23:35:21 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4567 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756583AbXKOEfT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 23:35:19 -0500
Received: (qmail 5971 invoked by uid 111); 15 Nov 2007 04:35:18 -0000
Received: from ppp-216-106-96-30.storm.ca (HELO sigill.intra.peff.net) (216.106.96.30)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 14 Nov 2007 23:35:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2007 23:35:14 -0500
Content-Disposition: inline
In-Reply-To: <20071115041801.GA9794@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65056>

On Wed, Nov 14, 2007 at 11:18:01PM -0500, Jeff King wrote:

> My goal with the recent patches is that _any_ failure will cause a non-0
> exit code (but you have to read the stderr output to find out which, if
> any, refs were successful).

BTW, since there seems to be some debate on how this _should_ work, I
think the "signal failure if anything failed" approach is the better.

Why?

Because either way you do it, there is an ambiguity, and I would rather
that ambiguity lie with the "failure" case. If I see exit code '0', I
_know_ that all of my refs were updated. If I see exit code '1', then
there was some failure detected, but my refs might or might not have
been updated. But that ambiguity _already_ exists. Consider the case
where we send refs, but the connection dies in the middle. We have to
signal error, then, but for all we know the other side was about to
"successfully updated all refs". So you can only ever _know_ success,
and with failure, you simply guess (and presumably retry).

-Peff
