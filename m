From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] introduce "format" date-mode
Date: Tue, 30 Jun 2015 15:22:15 -0400
Message-ID: <20150630192215.GB6845@peff.net>
References: <20150625165341.GA21949@peff.net>
 <20150625165545.GC23503@peff.net>
 <20150629222247.GA31607@flurp.local>
 <20150630102055.GA11928@peff.net>
 <CAPig+cTXc_RXbOAOaF2MFjrg+DSet=g0XQMZY0ErMYAmNVSV+g@mail.gmail.com>
 <20150630175852.GB5349@peff.net>
 <CAPig+cSJXZjrZ=OcV+C6bkCEHQFrw35-cjQ3At_Qo5KrpYxaQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 21:22:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZA16t-0000aj-LR
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 21:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbbF3TWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 15:22:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:53942 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751422AbbF3TWS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 15:22:18 -0400
Received: (qmail 9484 invoked by uid 102); 30 Jun 2015 19:22:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Jun 2015 14:22:18 -0500
Received: (qmail 18209 invoked by uid 107); 30 Jun 2015 19:22:22 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Jun 2015 15:22:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Jun 2015 15:22:15 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cSJXZjrZ=OcV+C6bkCEHQFrw35-cjQ3At_Qo5KrpYxaQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273098>

On Tue, Jun 30, 2015 at 02:13:53PM -0400, Eric Sunshine wrote:

> Sorry, I meant that the interpolation expense of "%s ". A cheaper (but
> more verbose) alternative might be:
> 
>     size_t n = strlen(fmt);
>     const char *f = xmalloc(n + 2);
>     strcpy(f, fmt);
>     f[n] = ' ';
>     f[n + 1] = '\0';
>     ...
>     free(f);
> 
> or something similar.

I think you're probably getting into premature optimization here. Using
strbuf_vaddf should be within the same order of magnitude of
instructions (and I think we should almost never hit this code path
anyway, because we'll be reading into a static strbuf generally which
will come pre-sized to hold a date).

-Peff
