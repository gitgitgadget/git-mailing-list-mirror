From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] push: make non-fast-forward help message
 configurable
Date: Mon, 7 Sep 2009 04:54:05 -0400
Message-ID: <20090907085405.GA17968@coredump.intra.peff.net>
References: <20090906064454.GA1643@coredump.intra.peff.net>
 <20090906064816.GC28941@coredump.intra.peff.net>
 <7v8wgsk0rw.fsf@alter.siamese.dyndns.org>
 <20090906072322.GA29949@coredump.intra.peff.net>
 <7vzl98fr22.fsf@alter.siamese.dyndns.org>
 <20090907094457.6117@nanako3.lavabit.com>
 <20090907082430.GA17997@coredump.intra.peff.net>
 <vpqeiqjf90u.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>, Git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 07 10:54:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkZzO-00030m-2W
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 10:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbZIGIyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 04:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752386AbZIGIyH
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 04:54:07 -0400
Received: from peff.net ([208.65.91.99]:43125 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752295AbZIGIyH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 04:54:07 -0400
Received: (qmail 15907 invoked by uid 107); 7 Sep 2009 08:54:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 07 Sep 2009 04:54:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Sep 2009 04:54:05 -0400
Content-Disposition: inline
In-Reply-To: <vpqeiqjf90u.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127909>

On Mon, Sep 07, 2009 at 10:34:25AM +0200, Matthieu Moy wrote:

> > So really they are two different conceptual types of message. And while
> > I have no problem with an argument of "I _personally_ find this clutter
> > and would like to configure it off", I don't think such an option should
> > go under "advice.*". My patch had "message.all" (which will become
> > "advice.all")
> 
> To me, this is an argument in favor of keeping "message", to allow the
> same mechanism for these different types of messages.
> 
> But I think the individual message.* should not be just true/false
> switch, but could be always/auto/never :
> 
> - always: show the message, regardless of message.all
> - auto (the default): rely on message.all to decide whether to show
>   the message
> - never: never show it.
> 
> So you could say "message.all = false" and "message.resetShowsNewHead
> = always".
> 
> But maybe that's just overkill, dunno...

I'm not sure it solves the problem. The point of "message.all" was to
easily say "I'm an expert, so turn off useless advice". But now I would
have to manually re-enable any messages that I _do_ want to see. And of
course I don't see them to know that I want them, so I have to read
through the config documentation and decide on each one.

At that point, why not just get rid of "message.all" and simply say
"manually turn off the messages you don't like". Then the user can
either go through the config manually as above, or they can wait until
they become annoyed with a particular message and turn it off (and
hopefully our naming is good enough that they can easily figure out
which one it was :) ).

So I think "be verbose, but let the user quiet us" is probably
better than "be quiet, but let the user make us louder", because it is
easier to discover verbose things. Which implies to me that
"message.all", if it exists at all, should be limited in scope to just
advice.

In fact, you could mix many types in the message.* hierarchy and simply
call the umbrella variable message.advice. But that is semantically
equivalent to having advice.{all,*} and other_type_of_message.{all,*}.

-Peff
