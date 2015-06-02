From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] config.mak.uname: Darwin: define HAVE_GETDELIM for
 modern OS X releases
Date: Tue, 2 Jun 2015 15:04:03 -0400
Message-ID: <20150602190403.GA12660@peff.net>
References: <1433269138-10890-1-git-send-email-sunshine@sunshineco.com>
 <1433269138-10890-2-git-send-email-sunshine@sunshineco.com>
 <20150602184413.GA11437@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 21:04:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzrU7-0004Fj-2P
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 21:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475AbbFBTEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 15:04:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:39847 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754236AbbFBTEG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 15:04:06 -0400
Received: (qmail 17700 invoked by uid 102); 2 Jun 2015 19:04:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Jun 2015 14:04:06 -0500
Received: (qmail 10693 invoked by uid 107); 2 Jun 2015 19:04:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Jun 2015 15:04:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jun 2015 15:04:03 -0400
Content-Disposition: inline
In-Reply-To: <20150602184413.GA11437@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270586>

On Tue, Jun 02, 2015 at 02:44:13PM -0400, Jeff King wrote:

> > +	ifeq ($(shell expr $(shell expr "$(uname_R)" : '\([0-9][0-9]*\)\.') '>=' 11),1)
> 
> Do you need to spawn two shells? It seems like:
> 
>   $(shell expr `expr "$(uname_R)" : '\([0-9][0-9]*\)'` '>=' 11),1)

Oops, I missed the trailing '.' in the regex there, and it probably
needs double-quotes in case the inner expr fails to match anything.

We could also use "test -gt" instead of the outer expr, which is more
idiomatic shell. But it reports via exit code, so you'd need "&& echo 1"
at the end.

-Peff
