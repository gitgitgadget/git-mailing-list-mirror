From: Jeff King <peff@peff.net>
Subject: Re: Re-Transmission of blobs?
Date: Thu, 12 Sep 2013 05:23:40 -0400
Message-ID: <20130912092339.GA30702@sigill.intra.peff.net>
References: <20130910130837.GA14259@raven.wolf.lan>
 <xmqqsixcy395.fsf@gitster.dls.corp.google.com>
 <20130911112758.GB14259@raven.wolf.lan>
 <xmqqsixbth4h.fsf@gitster.dls.corp.google.com>
 <20130912074241.GC14259@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 12 11:23:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK37w-0002gK-Io
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 11:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579Ab3ILJXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 05:23:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:53356 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279Ab3ILJXs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 05:23:48 -0400
Received: (qmail 8914 invoked by uid 102); 12 Sep 2013 09:23:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Sep 2013 04:23:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Sep 2013 05:23:40 -0400
Content-Disposition: inline
In-Reply-To: <20130912074241.GC14259@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234632>

On Thu, Sep 12, 2013 at 09:42:41AM +0200, Josef Wolf wrote:

> > >> There are some work being done to optimize this further using
> > >> various techniques, but they are not ready yet.
> > 
> > And this still stands.
> 
> Do you have a pointer or something? I'd like to check out whether I can
> contribute to this work.

I think Junio is referring to the reachability bitmap work. We may know
that the other side has commit "E" (and therefore every object reachable
from it), but we do not walk the graph to find the complete set of
reachable objects. Doing so requires a lot of CPU and I/O, and in most
cases does not help much.

However, if we had an index of reachable objects (e.g., a bitmap) for
each commit, then we could very cheaply compute the set difference
between what the other side wants and what they have.

JGit has support for pack bitmaps already. There was a patch series a
few months ago to implement a similar functionality for C git, but the
on-disk format was not compatible with JGit's. That series has been
reworked off-list to be compatible with the JGit implementation.

Those patches need a little cleanup before they are ready for the list,
but hopefully that should happen soon-ish.

-Peff
