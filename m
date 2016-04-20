From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 4/6] transport: add refspec list parameters to
 functions
Date: Wed, 20 Apr 2016 16:57:26 -0400
Message-ID: <20160420205726.GA17876@sigill.intra.peff.net>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
 <1460747949-3514-5-git-send-email-dturner@twopensource.com>
 <xmqqa8kq69i5.fsf@gitster.mtv.corp.google.com>
 <20160419071403.GA22577@sigill.intra.peff.net>
 <1461102001.5540.125.camel@twopensource.com>
 <20160419232243.GF18255@sigill.intra.peff.net>
 <1461109391.5540.138.camel@twopensource.com>
 <20160420011740.GA29839@sigill.intra.peff.net>
 <1461185215.5540.180.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 22:57:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aszBm-0003Iy-FQ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 22:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbcDTU5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 16:57:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:53213 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751324AbcDTU5a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 16:57:30 -0400
Received: (qmail 14119 invoked by uid 102); 20 Apr 2016 20:57:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Apr 2016 16:57:29 -0400
Received: (qmail 2839 invoked by uid 107); 20 Apr 2016 20:57:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Apr 2016 16:57:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Apr 2016 16:57:26 -0400
Content-Disposition: inline
In-Reply-To: <1461185215.5540.180.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292076>

On Wed, Apr 20, 2016 at 04:46:55PM -0400, David Turner wrote:

> As you note, it appears that git-daemon does sort-of have support for
> extra args -- see parse_host_arg.  So it wouldn't be hard to add
> something here. Unfortunately, current versions of git die on unknown
> args.  So this change would not be backwards-compatible.  We could put
> a decider on it so that clients would only try it when explicitly
> enabled.  Or we could have clients try it with, and in the event of an
> error, retry without.  Neither is ideal, but both are possible.

Right. This ends up being the same difficulty that the v2 protocol
encountered; how do you figure out what you can speak without resorting
to expensive fallbacks, when do you flip the switch, do you remember the
protocol you used last time with this server, etc.

Which isn't to say it's necessarily a bad thing. Maybe the path forward
instead of v2 is to shoe-horn this data into the pre-protocol
conversation, and go from there. The protocol accepts that "somehow" it
got some extra data from the transport layer, and acts on its uniformly.

> If I read this code correctly, git-over-ssh will pass through arbitrary
> arguments.  So this should be trivial.

It does if you are ssh-ing to a real shell-level account on the server,
but if you are using git-shell or some other wrapper to restrict clients
from running arbitrary commands, it will likely reject it.

-Peff
