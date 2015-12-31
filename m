From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] avoid shifting signed integers 31 bits
Date: Thu, 31 Dec 2015 00:20:29 -0500
Message-ID: <20151231052029.GA10238@sigill.intra.peff.net>
References: <20151229063449.GA28755@sigill.intra.peff.net>
 <20151229063545.GA30340@sigill.intra.peff.net>
 <CACsJy8CAAqZFQCfadUov7DFhSgh=dtGfE-onbXZQXO-0Y2652g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 06:20:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEVfB-0001EQ-3a
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 06:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbbLaFUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2015 00:20:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:47415 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750909AbbLaFUc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2015 00:20:32 -0500
Received: (qmail 10704 invoked by uid 102); 31 Dec 2015 05:20:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Dec 2015 00:20:32 -0500
Received: (qmail 4109 invoked by uid 107); 31 Dec 2015 05:20:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Dec 2015 00:20:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Dec 2015 00:20:29 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8CAAqZFQCfadUov7DFhSgh=dtGfE-onbXZQXO-0Y2652g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283226>

On Thu, Dec 31, 2015 at 12:10:33PM +0700, Duy Nguyen wrote:

> On Tue, Dec 29, 2015 at 1:35 PM, Jeff King <peff@peff.net> wrote:
> > We sometimes use 32-bit unsigned integers as bit-fields.
> > It's fine to access the MSB, because it's unsigned. However,
> > doing so as "1 << 31" is wrong, because the constant "1" is
> > a signed int, and we shift into the sign bit, causing
> > undefined behavior.
> >
> > We can fix this by using "1U" as the constant.
> 
> We have this in cache.h, should it be fixed as well?
> 
> /* CE_EXTENDED2 is for future extension */
> #define CE_EXTENDED2         (1 << 31)

Sort of. We don't actually use it, and since it's a macro, that means it
never even hits the compiler proper itself. So it's not a bug, but it's
a bug waiting to happen. :)

-Peff
