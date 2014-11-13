From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] approxidate and future ISO-like times
Date: Thu, 13 Nov 2014 06:03:25 -0500
Message-ID: <20141113110325.GD8329@peff.net>
References: <CAPLyDLo+-SebLvHxVKT7RAiER2c8HdeZQUg7_DGrpER1h-BPQA@mail.gmail.com>
 <20141113093606.GC8329@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Colin Smith <colin.webdev@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 12:03:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XosBZ-0006RS-3l
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 12:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbaKMLD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 06:03:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:39813 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932518AbaKMLD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 06:03:28 -0500
Received: (qmail 22625 invoked by uid 102); 13 Nov 2014 11:03:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 05:03:28 -0600
Received: (qmail 23005 invoked by uid 107); 13 Nov 2014 11:03:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 06:03:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Nov 2014 06:03:25 -0500
Content-Disposition: inline
In-Reply-To: <20141113093606.GC8329@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, 2014 at 04:36:06AM -0500, Jeff King wrote:

> On Thu, Nov 13, 2014 at 11:27:06AM +1100, Colin Smith wrote:
> 
> > Apologies if this has already been raised or PEBCAK, but I've noticed
> > a bug where git log with certain date ranges breaks things. It appears
> > to be any --since date with a --until date in the future between
> > 2014-12-01 and 2014-12-09. Dates from 2014-12-10 appear to work, and
> > so does the date 2015-12-01.
> 
> Ugh. Approxidate strikes again:
> 
>   for i in 2014-11-01 2013-12-01 2014-12-01; do
>     ./test-date approxidate $i
>   done
> 
> produces:
> 
>   2014-11-01 -> 2014-11-01 09:35:19 +0000
>   2013-12-01 -> 2013-12-01 09:35:19 +0000
>   2014-12-01 -> 2014-01-12 09:35:19 +0000
> 
> The first two are right, but the fourth one is not.  It's probably
> something simple and stupid.

Less simple and stupid than I thought, but I think I have a fix. It is
not about December specifically, but about the date being in the future.
The first patch is a cleanup to help us more accurately test the bug;
the interesting bits are in the second one.

  [1/2]: pass TIME_DATE_NOW to approxidate future-check
  [2/2]: approxidate: allow ISO-like dates far in the future

-Peff
