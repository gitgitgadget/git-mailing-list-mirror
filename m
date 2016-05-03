From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/14] remote.h: add get_remote_capabilities,
 request_capabilities
Date: Tue, 3 May 2016 01:33:38 -0400
Message-ID: <20160503053337.GA17986@sigill.intra.peff.net>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
 <1461972887-22100-7-git-send-email-sbeller@google.com>
 <1462215463.4123.70.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 03 07:34:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axSyV-0000EQ-Qq
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 07:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbcECFdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 01:33:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:60845 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750735AbcECFdl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 01:33:41 -0400
Received: (qmail 13612 invoked by uid 102); 3 May 2016 05:33:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 01:33:40 -0400
Received: (qmail 23303 invoked by uid 107); 3 May 2016 05:33:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 01:33:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 May 2016 01:33:38 -0400
Content-Disposition: inline
In-Reply-To: <1462215463.4123.70.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293328>

On Mon, May 02, 2016 at 02:57:43PM -0400, David Turner wrote:

> On Fri, 2016-04-29 at 16:34 -0700, Stefan Beller wrote:
>  
> > +const char *known_capabilities[] = {
> > +	"multi_ack",
> > +	"thin-pack",
> > +	"side-band",
> > +	"side-band-64k",
> > +	"ofs-delta",
> > +	"shallow",
> > +	"no-progress",
> > +	"include-tag",
> > +	"multi_ack_detailed",
> > +	"allow-tip-sha1-in-want",
> > +	"allow-reachable-sha1-in-want",
> > +	"no-done",
> > +};
> 
> I wonder if it is possible to not repeat the list from upload-pack.c?
> It seems unfortunate to have to add the same string in two places
> whenever you add a capability.

I think that in general, we'd stop adding capabilities to v1. If you
have a client which speaks the new capability, then it should also be
speaking the new protocol. That's not strictly true if other non-git.git
implementations want to learn capability X but not protocol v2, but I
think in practice it's not an unreasonable world view.

I guess there may be a grey area for a while, though, where even
v2-capable clients don't end up speaking it, because they don't yet know
that a particular server can handle it. So any capabilities added in
that grey area may want to go to both v1 and v2.

-Peff
