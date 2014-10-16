From: Jeff King <peff@peff.net>
Subject: Re: fsck option to remove corrupt objects - why/why not?
Date: Thu, 16 Oct 2014 08:25:33 -0400
Message-ID: <20141016122533.GA8451@peff.net>
References: <20141015234637.9B4FC781EFB@mail110.syd.optusnet.com.au>
 <543F0DAE.2050205@optusnet.com.au>
 <CALKQrgda8mVbqP5=Ag8juN9HMQp7iQ9eDJETfRJe1b0taAFGkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Aveling <bena.001@optusnet.com.au>,
	Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 14:25:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xek7g-00054Y-HN
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 14:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbaJPMZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 08:25:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:59183 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750902AbaJPMZg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 08:25:36 -0400
Received: (qmail 5171 invoked by uid 102); 16 Oct 2014 12:25:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Oct 2014 07:25:35 -0500
Received: (qmail 31690 invoked by uid 107); 16 Oct 2014 12:25:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Oct 2014 08:25:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Oct 2014 08:25:33 -0400
Content-Disposition: inline
In-Reply-To: <CALKQrgda8mVbqP5=Ag8juN9HMQp7iQ9eDJETfRJe1b0taAFGkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 16, 2014 at 11:04:04AM +0200, Johan Herland wrote:

> I simply copied the packfile containing the good copy into the
> corrupted repo, and then ran a "git gc", which "happened" to use the
> good copy of the corrupted object and complete successfully (instead
> of barfing on the bad copy). The GC then removed the old
> (now-obsolete) packfiles, and thus the corruption was gone.
> 
> However, exactly _why_ git happened to prefer the good copy in my
> copied packfile instead of the bad copy in the existing packfile, I do
> not know. I suspect some amount of pure luck was involved.

I'm not sure that it is luck, but more like 8eca0b4 (implement some
resilience against pack corruptions, 2008-06-23) working as intended[1].
Generally, git should be able to warn about corrupted objects and look
in other packs for them (both for regular operations, and for
repacking).

-Peff

[1] That's just one of the many commits dealing with this. Try running
    "git log --author=Nicolas.Pitre --grep=corrupt" for more. :)
