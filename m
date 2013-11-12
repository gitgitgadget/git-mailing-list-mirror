From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/86] replace prefixcmp() with has_prefix()
Date: Tue, 12 Nov 2013 03:32:40 -0500
Message-ID: <20131112083240.GA1684@sigill.intra.peff.net>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
 <5281012D.4060708@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Max Horn <max@quendi.de>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Nov 12 09:32:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg9P0-0005V2-G4
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 09:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272Ab3KLIco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 03:32:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:37682 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754242Ab3KLIcm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 03:32:42 -0500
Received: (qmail 18280 invoked by uid 102); 12 Nov 2013 08:32:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Nov 2013 02:32:42 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Nov 2013 03:32:40 -0500
Content-Disposition: inline
In-Reply-To: <5281012D.4060708@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237704>

On Mon, Nov 11, 2013 at 05:09:17PM +0100, Andreas Ericsson wrote:

> On 2013-11-09 08:05, Christian Couder wrote:
> >Here is a big patch series to replace prefixcmp() with a new
> >has_prefix() function.
> >
> 
> Seems like totally useless codechurn to me. Besides, prefixcmp()
> ties in nicely with strcmp() and memcmp() (and returns 0 on a
> match just like its namesakes), whereas your function must return
> non-zero on match and thus can't be used as a qsort() callback.
> Granted, prefixcmp() lends itself poorly to that as well, but at
> least it's consistent with the other *cmp() functions.

I think you missed the earlier threads that let up to this, but the
summary is that prefixcmp does not really make any sense as a qsort
callback. Consider that comparing "foobar" and "foo" would yield 0, but
"foo" and "foobar" would be positive.

I am ambivalent on the code churn, but if we do apply it, we should
probably leave off the final patch (dropping prefixcmp) for a cycle to
let topics in flight catch up to the change. Just diffing "master" and
"next", I see some new uses of prefixcmp which will need adjusted, along
with spots where the patches themselves will cause textual conflicts.

-Peff
