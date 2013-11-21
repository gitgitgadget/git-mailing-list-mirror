From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Thu, 21 Nov 2013 17:41:51 -0500
Message-ID: <20131121224151.GA11258@sigill.intra.peff.net>
References: <20131120203350.GA31139@kitenet.net>
 <20131120213348.GA29004@sigill.intra.peff.net>
 <20131120222805.GC26468@kitenet.net>
 <20131121114157.GA7171@sigill.intra.peff.net>
 <20131121114837.GB7171@sigill.intra.peff.net>
 <CACsJy8B5xY1FZyhPdct8Nt6Gad2cveRvmOXTXJP=uCaG2_0KuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 21 23:41:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjcwg-0000yn-9J
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 23:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078Ab3KUWly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 17:41:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:43461 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753983Ab3KUWly (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 17:41:54 -0500
Received: (qmail 10244 invoked by uid 102); 21 Nov 2013 22:41:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Nov 2013 16:41:53 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Nov 2013 17:41:51 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8B5xY1FZyhPdct8Nt6Gad2cveRvmOXTXJP=uCaG2_0KuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238160>

On Thu, Nov 21, 2013 at 07:43:03PM +0700, Duy Nguyen wrote:

> > -       if (experimental_loose_object(map)) {
> 
> Perhaps keep this..
> 
> > -               /*
> > -                * The old experimental format we no longer produce;
> > -                * we can still read it.
> > -                */
> > -               used = unpack_object_header_buffer(map, mapsize, &type, &size);
> > -               if (!used || !valid_loose_object_type[type])
> > -                       return -1;
> > -               map += used;
> > -               mapsize -= used;
> > -
> > -               /* Set up the stream for the rest.. */
> > -               stream->next_in = map;
> > -               stream->avail_in = mapsize;
> > -               git_inflate_init(stream);
> > -
> > -               /* And generate the fake traditional header */
> > -               stream->total_out = 1 + snprintf(buffer, bufsiz, "%s %lu",
> > -                                                typename(type), size);
> > -               return 0;
> 
> and replace all this with
> 
> die("detected an object in obsolete format, please repack the
> repository using a version before XXX");

That would eliminate the second part of my purpose, which is to not
die() on a corrupted object because we incorrectly guess that it is
experimental.

If we think these objects are in the wild, the right thing to do would
be to warn() and continue. But I really find it hard to believe any such
objects exist at this point.

-Peff
