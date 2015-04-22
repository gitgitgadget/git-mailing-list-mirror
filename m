From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/9] strbuf_getwholeline: use getdelim if it is available
Date: Wed, 22 Apr 2015 14:06:29 -0400
Message-ID: <20150422180628.GA3535@peff.net>
References: <20150416084733.GA17811@peff.net>
 <20150416090138.GG17938@peff.net>
 <CAPig+cSKtMPQGxp1Y2GinVRh2y--QyJh_nxhDez2CGFPP6B=xg@mail.gmail.com>
 <alpine.DEB.1.00.1504222000040.28561@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <ericsunshine@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 22 20:06:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykz2j-0006Cp-F7
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 20:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbbDVSGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 14:06:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:48679 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751095AbbDVSGc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 14:06:32 -0400
Received: (qmail 3664 invoked by uid 102); 22 Apr 2015 18:06:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 13:06:31 -0500
Received: (qmail 12405 invoked by uid 107); 22 Apr 2015 18:06:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 14:06:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2015 14:06:29 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1504222000040.28561@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267605>

On Wed, Apr 22, 2015 at 08:00:55PM +0200, Johannes Schindelin wrote:

> On 2015-04-17 12:16, Eric Sunshine wrote:
> > On Thu, Apr 16, 2015 at 5:01 AM, Jeff King <peff@peff.net> wrote:
> >> We spend a lot of time in strbuf_getwholeline in a tight
> >> loop reading characters from a stdio handle into a buffer.
> >> The libc getdelim() function can do this for us with less
> >> overhead.
> 
> Just for the record: Git for Windows cannot lean on `getdelim()`, as
> it is not available on Windows. Do not let that stop you; if it turns
> out to impact performance, we will just have to come up with our own
> implementation of that function.

Hopefully the earlier patch in the series to avoid locking will help
on Windows. After the end of the series, it isn't used anymore on Linux,
but I kept it in exactly for those less-fortunate systems.

If you can find a Windows equivalent that does the same thing as
getdelim, it should be pretty easy to drop it into an alternate
strbuf_getwholeline implementation (or just provide a compat "getdelim"
if it is close enough to have the same interface).

-Peff
