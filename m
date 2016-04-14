From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] fsck: detect and warn a commit with embedded NUL
Date: Thu, 14 Apr 2016 14:25:45 -0400
Message-ID: <20160414182544.GC22068@sigill.intra.peff.net>
References: <20160414180709.28968-1-gitster@pobox.com>
 <20160414180709.28968-2-gitster@pobox.com>
 <20160414182102.GB22068@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 20:25:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqlxf-0006dZ-IU
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 20:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755302AbcDNSZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 14:25:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:49568 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754680AbcDNSZr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 14:25:47 -0400
Received: (qmail 15064 invoked by uid 102); 14 Apr 2016 18:25:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 14:25:47 -0400
Received: (qmail 1391 invoked by uid 107); 14 Apr 2016 18:25:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 14:25:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2016 14:25:45 -0400
Content-Disposition: inline
In-Reply-To: <20160414182102.GB22068@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291551>

On Thu, Apr 14, 2016 at 02:21:03PM -0400, Jeff King wrote:

> So yet another alternative would be to include this check in
> verify_headers(). It would parse to the end of the headers as now, and
> then from there additionally look for a NUL in the body.

Hmm. Looking at verify_headers(), I think it has another bug.

It wants to "return report(...)" as soon as it sees a problem, and stops
looking for other ones. But the new model for reporting errors is that
report() might ignore a problem if configured to do so.

So I think if you were to ignore NUL_IN_HEADER, then a commit with
NUL_IN_HEADER could still pass fsck, even though it should trigger
UNTERMINATED_HEADER.

-Peff
