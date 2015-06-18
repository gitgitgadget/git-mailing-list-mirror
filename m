From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] format-patch: introduce format.outputDirectory
 configuration
Date: Thu, 18 Jun 2015 16:22:05 -0400
Message-ID: <20150618202205.GA16517@peff.net>
References: <1434626280-4610-1-git-send-email-kuleshovmail@gmail.com>
 <xmqq616ley7y.fsf@gitster.dls.corp.google.com>
 <20150618195751.GA14550@peff.net>
 <xmqqoakceq8s.fsf@gitster.dls.corp.google.com>
 <xmqqk2v0eq75.fsf@gitster.dls.corp.google.com>
 <20150618201323.GB14550@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 22:22:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5gKC-0006jS-WD
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614AbbFRUWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:22:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:48425 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753609AbbFRUWH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:22:07 -0400
Received: (qmail 25183 invoked by uid 102); 18 Jun 2015 20:22:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Jun 2015 15:22:07 -0500
Received: (qmail 8284 invoked by uid 107); 18 Jun 2015 20:22:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Jun 2015 16:22:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Jun 2015 16:22:05 -0400
Content-Disposition: inline
In-Reply-To: <20150618201323.GB14550@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272066>

On Thu, Jun 18, 2015 at 04:13:23PM -0400, Jeff King wrote:

> > > You would also need to remove the "oh you gave me -o twice?" check,
> > > and change the semantics to "later -o overrides an earlier one",
> > > wouldn't you?  Otherwise you would never be able to override what
> > > you read from the config, I am afraid.
> > 
> > By the way, I actually think "later -o overrides an earlier one" is
> > a good change by itself, regardless of this new configuration.
> 
> Ah, I didn't realize we did that. Yeah, I think we should switch to
> "later overrides earlier". There is no need for "-o" to behave
> completely differently than all of our other options.

Much worse, though, is that we also have to interact with "--stdout". We
currently treat "--stdout -o foo" as an error; you need a separate
config_output_directory to continue to handle that (and allow "--stdout"
to override the config).

If I were designing from scratch, I would consider making "-o -" output
to stdout, and letting it override a previous "-o" (or vice versa). We
could still do that (and make "--stdout" an alias for that), but I don't
know if it is worth the trouble (it does change the behavior for anybody
who wanted a directory called "-", but IMHO it is more likely to save
somebody a headache than create one).

-Peff
