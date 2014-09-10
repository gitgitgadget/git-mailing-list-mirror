From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 00/32] Lockfile correctness and refactoring
Date: Wed, 10 Sep 2014 06:30:14 -0400
Message-ID: <20140910103014.GA15461@peff.net>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
 <20140910081358.GB16413@peff.net>
 <CACsJy8AO5Ni1BNJGa1Wy5ZdX=HNE1UuVM-gnwtHBw01sfcZNrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 12:30:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRfAN-0003yi-Ri
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 12:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbaIJKaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 06:30:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:46458 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751040AbaIJKaR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 06:30:17 -0400
Received: (qmail 19178 invoked by uid 102); 10 Sep 2014 10:30:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Sep 2014 05:30:17 -0500
Received: (qmail 15542 invoked by uid 107); 10 Sep 2014 10:30:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Sep 2014 06:30:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Sep 2014 06:30:14 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8AO5Ni1BNJGa1Wy5ZdX=HNE1UuVM-gnwtHBw01sfcZNrg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256732>

On Wed, Sep 10, 2014 at 05:25:36PM +0700, Duy Nguyen wrote:

> On Wed, Sep 10, 2014 at 3:13 PM, Jeff King <peff@peff.net> wrote:
> > I was running pack-refs on a repository with a very large number of
> > loose refs (about 1.8 million). Needless to say, this ran very slowly
> > and thrashed the disk, as that's almost 7G using 4K inodes. But it did
> > eventually generate a packed-refs file, at which point it tried to prune
> > the loose refs.
> 
> Urghh.. ref advertisment for fetch/push would be unbelievably large.
> Gotta look at the "git protocol v2" again soon..

Yes, we don't let normal fetchers see these repos. They're only for
holding shared objects and the ref tips to keep them reachable. So we
never fetch from them, even locally. We only fetch to them from normal
repos (and never push to or from them at all).

It's still rather painful just to do normal things, though. Every git
operation loads the whole packed-refs file into memory. I'm biding my
time on the ref-backend patches that are being worked on. :)

-Peff
