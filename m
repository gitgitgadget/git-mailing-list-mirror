From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] git-config: git-config --list fixed when GIT_CONFIG
 value starts with ~/
Date: Fri, 14 Nov 2014 15:04:20 -0500
Message-ID: <20141114200419.GB11581@peff.net>
References: <1415989760-20259-1-git-send-email-kuleshovmail@gmail.com>
 <CAPig+cTpUyfKYj4VTK1AT-ga6UvupJrERsTHWTEzNP-Ogc4ujQ@mail.gmail.com>
 <20141114193049.GB10860@peff.net>
 <87vbmh8syq.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alex Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 21:04:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpN6Y-0003Vl-5m
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 21:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161794AbaKNUEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 15:04:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:40467 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161783AbaKNUEV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 15:04:21 -0500
Received: (qmail 13843 invoked by uid 102); 14 Nov 2014 20:04:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Nov 2014 14:04:21 -0600
Received: (qmail 16248 invoked by uid 107); 14 Nov 2014 20:04:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Nov 2014 15:04:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Nov 2014 15:04:20 -0500
Content-Disposition: inline
In-Reply-To: <87vbmh8syq.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 15, 2014 at 01:38:36AM +0600, Alex Kuleshov wrote:

> > Yeah, I'd agree it is a little unexpected to expand here. The "~" is
> > mostly a shell thing, and doing:
> >
> >   GIT_CONFIG=~/.gitconfig git config --list
> >
> > from the shell generally works, because the shell will expand the "~"
> > before it even hits git. If you're not using a shell to set the
> > variable, you probably should be pre-expanding it yourself.
> 
> Yes, you're right here, but i put GIT_CONFIG=~/.gitconfig to my .bashrc
> and it doesn't work so.

Weird. It seems to work fine for me (though I admit I only did a pretty
cursory test).

> > Probably the right place would be the if/else chain around
> > builtin/config.c:514, where we convert a relative path into an absolute
> > one. But I'm not convinced it's a good thing to be doing in the first
> > place.
> >
> What if we'll put path expanding right after getting value of file path,
> after given_config_source.file = getenv(CONFIG_ENVIRONMENT); at 451?

That is a good place to put it if you want to impact $GIT_CONFIG but not
"--file". I am not sure if that is sensible. But then, I am not sure
that I am convinced that we should be making any change at all.

-Peff
