From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/8] staging: et131x: Remove ununsed statistics
Date: Sat, 13 Sep 2014 16:36:45 -0400
Message-ID: <20140913203645.GB24854@peff.net>
References: <1410472786-14552-1-git-send-email-mark.einon@gmail.com>
 <1410472786-14552-5-git-send-email-mark.einon@gmail.com>
 <20140913093746.GD6600@mwanda>
 <20140913154556.GA12361@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
	Mark Einon <mark.einon@gmail.com>, devel@driverdev.osuosl.org,
	git@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Sat Sep 13 22:37:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSu43-0007YC-ME
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 22:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbaIMUgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 16:36:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:47816 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752070AbaIMUgr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 16:36:47 -0400
Received: (qmail 9565 invoked by uid 102); 13 Sep 2014 20:36:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Sep 2014 15:36:47 -0500
Received: (qmail 10350 invoked by uid 107); 13 Sep 2014 20:37:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Sep 2014 16:37:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Sep 2014 16:36:45 -0400
Content-Disposition: inline
In-Reply-To: <20140913154556.GA12361@kroah.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256976>

On Sat, Sep 13, 2014 at 08:45:56AM -0700, Greg KH wrote:

> On Sat, Sep 13, 2014 at 12:37:46PM +0300, Dan Carpenter wrote:
> > On Thu, Sep 11, 2014 at 10:59:42PM +0100, Mark Einon wrote:
> > > >From struct ce_stats; unicast_pkts_rcvd, unicast_pkts_xmtd,
> > > multicast_pkts_xmtd, broadcast_pkts_rcvd and broadcast_pkts_xmtd
> > 
> > For some reason something adds a '>' to the start of lines which start
> > with 'From'.  I don't know what it is...
> 
> It's an email protocol requirement, some RFC dictates it as "From" at
> the start of the line is an email "start" flag.

It's not an RFC thing. It's a side effect of the mbox format, which
squashes together multiple messages with "From " lines to mark their
starts. So many mbox implementations will quote them as ">From" (others
introduce a Content-Length header, or are simply more careful about
making sure that the line looks like a real "From " line, which should
contain a date).

If somebody's MUA is actually transmitting emails with the quoting,
that's wrong. It is a local storage problem, and they should not be
spreading the quoting disease to other systems.

> > When I apply this patch with 'git am' then it just removes the From
> > line.
> 
> As it should :)

That seems wrong. We should either leave it as-is (i.e., assume the
writer used no quoting and really did mean ">From") or strip the ">" to
turn it into "From" (i.e., assume the writer did use quoting). In some
implementations, a literal ">From" gets quoted to ">>From" and so on. So
we could even strip one level of quoting from such things (if we assume
the writer was such an implementation).

I don't think we can make this 100% foolproof without knowing which mbox
variant the writer used. But dropping the line is probably the worst
possible thing, as it does not match _any_ variants. :)

-Peff
