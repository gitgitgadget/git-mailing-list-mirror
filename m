From: Jeff King <peff@peff.net>
Subject: Re: Can I fetch an arbitrary commit by sha1?
Date: Thu, 2 Oct 2014 12:10:06 -0400
Message-ID: <20141002161006.GB2505@peff.net>
References: <CAENte7htO13s91UJFNzW4aBhsGxE=LpnvaZfce+vqQU5+a-cYg@mail.gmail.com>
 <CAPBPrnsA4KxNximtKXcC37kuwBHK0Esytdm4nsgLHkrJSg3Ufw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Halstrick <christian.halstrick@gmail.com>,
	Git <git@vger.kernel.org>
To: Dan Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 18:10:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZixL-00062J-9J
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 18:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831AbaJBQKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 12:10:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:54161 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753129AbaJBQKH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 12:10:07 -0400
Received: (qmail 27434 invoked by uid 102); 2 Oct 2014 16:10:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Oct 2014 11:10:07 -0500
Received: (qmail 4930 invoked by uid 107); 2 Oct 2014 16:10:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Oct 2014 12:10:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Oct 2014 12:10:06 -0400
Content-Disposition: inline
In-Reply-To: <CAPBPrnsA4KxNximtKXcC37kuwBHK0Esytdm4nsgLHkrJSg3Ufw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257811>

On Thu, Oct 02, 2014 at 10:22:50AM -0400, Dan Johnson wrote:

> >> git show af00f4c39bcc8dc29ed8f59a47066d5993c279e4
> > fatal: bad object af00f4c39bcc8dc29ed8f59a47066d5993c279e4
> >> git fetch origin af00f4c39bcc8dc29ed8f59a47066d5993c279e4
> > error: no such remote ref af00f4c39bcc8dc29ed8f59a47066d5993c279e4
> >> git fetch origin refs/foo/b1
> > remote: Counting objects: 3, done.
> > remote: Compressing objects: 100% (2/2), done.
> > remote: Total 3 (delta 0), reused 0 (delta 0)
> > Unpacking objects: 100% (3/3), done.
> > From https://github.com/chalstrick/dondalfi
> >  * branch            refs/foo/b1 -> FETCH_HEAD
> >> git fetch origin af00f4c39bcc8dc29ed8f59a47066d5993c279e4
> > From https://github.com/chalstrick/dondalfi
> >  * branch            af00f4c39bcc8dc29ed8f59a47066d5993c279e4 -> FETCH_HEAD
> 
> My understanding is that you are allowed to ask for a SHA1, but most
> git servers refuse the request. But if you already have the SHA
> locally, then git doesn't neet to bother asking the server for it, so
> there's no request to be refused.

That's right. It is the server which enforces the "you cannot fetch an
arbitrary sha1" rule.

But I think Christian is arguing that the client side should complain
that $sha1 is not a remote ref, and therefore not something we can
fetch.  This used to be the behavior until 6e7b66e (fetch: fetch objects
by their exact SHA-1 object names, 2013-01-29). The idea there is that
some refs may be kept "hidden" from the ref advertisement, but clients
who learn about the sha1 out-of-band may fetch the tips of hidden refs.

I'm not sure it is a feature that has been particularly well-used to
date, though.

-Peff
