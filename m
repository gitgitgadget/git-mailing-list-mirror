From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] refs: write packed_refs file using stdio
Date: Wed, 10 Sep 2014 15:14:54 -0400
Message-ID: <20140910191453.GB23655@peff.net>
References: <20140910100352.GA12164@peff.net>
 <54103437.2090305@alum.mit.edu>
 <20140910113948.GA16224@peff.net>
 <CAL=YDW=uWP2kWB31MEvJvVP7yUdwoh95PvfEYT6LT1x2UXpAvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 21:15:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRnM4-0007ge-Di
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 21:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbaIJTO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 15:14:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:46652 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752839AbaIJTO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 15:14:56 -0400
Received: (qmail 8922 invoked by uid 102); 10 Sep 2014 19:14:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Sep 2014 14:14:56 -0500
Received: (qmail 19168 invoked by uid 107); 10 Sep 2014 19:15:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Sep 2014 15:15:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Sep 2014 15:14:54 -0400
Content-Disposition: inline
In-Reply-To: <CAL=YDW=uWP2kWB31MEvJvVP7yUdwoh95PvfEYT6LT1x2UXpAvg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256761>

On Wed, Sep 10, 2014 at 07:32:17AM -0700, Ronnie Sahlberg wrote:

> Even better could be to build an iovec for all the data and use writev() ?
> (now without gmail adding formatting)

I'm not sure that would make anything easier. We're literally
sprintf-ing (and calling sha1_to_hex) into a buffer so we can write()
it. That seems like a solid case for using fprintf instead.

We can't just writev() a bunch of buffers we have already. We'd
literally have to make an array of buffers to format into. It's much
simpler (and probably faster) to just format directly into stdio's
buffers.

-Peff
