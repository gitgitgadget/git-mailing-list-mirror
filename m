From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase: ignore failures from "gc --auto"
Date: Wed, 13 Jan 2016 13:50:52 -0500
Message-ID: <20160113185052.GA5786@sigill.intra.peff.net>
References: <20160113184718.GA5647@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 19:51:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJQVf-0005GC-E6
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 19:51:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756502AbcAMSvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 13:51:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:53130 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756388AbcAMSuz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 13:50:55 -0500
Received: (qmail 8628 invoked by uid 102); 13 Jan 2016 18:50:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jan 2016 13:50:55 -0500
Received: (qmail 30952 invoked by uid 107); 13 Jan 2016 18:51:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jan 2016 13:51:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jan 2016 13:50:52 -0500
Content-Disposition: inline
In-Reply-To: <20160113184718.GA5647@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283966>

On Wed, Jan 13, 2016 at 01:47:18PM -0500, Jeff King wrote:

> This bit me just now. The real blocker was "you have too many loose
> objects, run 'git prune'" left in the gc.log file.

Which was of course annoying in itself. I was running a scripted set of
rebases, so even with this fix, my terminal got spammed with the
"whoops, we can't auto-gc" message over and over.

The worst part is that when I looked at .git/objects, there were a lot
of objects, but most of them could be cleaned up! I wonder if
too_many_loose_objects() should take into account the prune time of the
objects it finds. I also wonder how I got into that situation, since
that check should come right _after_ we've finished running "gc". I
wonder if I had two backgrounded auto-gc's racing or something.

-Peff
