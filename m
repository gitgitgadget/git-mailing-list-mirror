From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] imap-send.c: implements the GIT_CURL_DEBUG
 environment variable
Date: Wed, 6 Apr 2016 02:16:50 -0400
Message-ID: <20160406061650.GA18208@sigill.intra.peff.net>
References: <1459507482-36678-1-git-send-email-gitter.spiros@gmail.com>
 <CAPig+cRrmdiz4fHAX3xg6CinSOPBv207RZLaacRBkoDNHLaPwA@mail.gmail.com>
 <CA+EOSBmL8oHo_wWUzyBq=4Z7fFoFj5Gnf7UveOyiNMS3yhH8Uw@mail.gmail.com>
 <CAPig+cSR6CQ6Q=TOaTgqwC0nOkB_khDLevWDPZsOwKbGrjptKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elia Pinto <gitter.spiros@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 08:17:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anglx-0005Fh-Bv
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 08:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809AbcDFGQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 02:16:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:44978 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752763AbcDFGQz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 02:16:55 -0400
Received: (qmail 30596 invoked by uid 102); 6 Apr 2016 06:16:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 06 Apr 2016 02:16:54 -0400
Received: (qmail 12887 invoked by uid 107); 6 Apr 2016 06:16:55 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 06 Apr 2016 02:16:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Apr 2016 02:16:50 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cSR6CQ6Q=TOaTgqwC0nOkB_khDLevWDPZsOwKbGrjptKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290824>

On Wed, Apr 06, 2016 at 01:53:35AM -0400, Eric Sunshine wrote:

> On Tue, Apr 5, 2016 at 6:21 AM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> > 2016-04-01 22:25 GMT+02:00 Eric Sunshine <sunshine@sunshineco.com>:
> >> In addition to review comments by others, why are the new curl_dump()
> >> and curl_trace() functions duplicated in both patches rather than
> >> factored out to a shared implementation?
> >
> > It's right. Do you think i can use some existing file or should I
> > create a new object file ?
> 
> Peff or Junio would be more qualified to answer, but perhaps the
> shared implementation could go in http.c?

Yeah. If it is linking with curl it must be in one of the objects that
gets compiled only when NO_CURL is not set. Which is currently http.c,
http-walker.c, and remote-curl.c. Of the three, the only one that makes
sense is http.c.

A new file would be OK (provided it gets added to the OBJECTS line in
Makefile:1921) but I think it fits well in http.c, which is essentially
our bucket of curl-related wrappers.

-Peff
