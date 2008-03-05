From: Jeff King <peff@peff.net>
Subject: Re: [RFC] improve 'bad default revision' message for empty repo
Date: Wed, 5 Mar 2008 04:25:56 -0500
Message-ID: <20080305092555.GA18591@sigill.intra.peff.net>
References: <3f4fd2640803011140o38ba0830l7775c8528f812779@mail.gmail.com> <20080303081021.GA6578@sigill.intra.peff.net> <3f4fd2640803041351k6debe788xbf5e818951f70146@mail.gmail.com> <20080305010701.GB20007@sigill.intra.peff.net> <7v7igh51rm.fsf@gitster.siamese.dyndns.org> <20080305043319.GA9074@sigill.intra.peff.net> <7vwsoho8t4.fsf@gitster.siamese.dyndns.org> <20080305091051.GA18377@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Reece Dunn <msclrhd@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 10:26:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWptZ-00014z-3v
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 10:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757505AbYCEJ0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 04:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757364AbYCEJ0A
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 04:26:00 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3742 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757429AbYCEJZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 04:25:58 -0500
Received: (qmail 28073 invoked by uid 111); 5 Mar 2008 09:25:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 05 Mar 2008 04:25:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Mar 2008 04:25:56 -0500
Content-Disposition: inline
In-Reply-To: <20080305091051.GA18377@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76204>

On Wed, Mar 05, 2008 at 04:10:51AM -0500, Jeff King wrote:

> Hrm. Thinking about it a bit more, what should be done with a --default
> like "HEAD^^"? It currently works fine, but parsing it down to "HEAD"
> requires the magic of get_sha1_with_mode. I think anyone using anything
> but an unadorned refname for --default is probably insane, though. Would
> it be acceptable to formally disallow it?

Hrm. Even if we took this down to the level of resolve_ref(), there
still is no distinction being made between "does not exist" and other
errors. So restricting what is allowed in --default doesn't solve
anything anyway (though it does make the call stack much smaller, which
makes a modifiction to pass an error/not-found condition back a less
painful change).

But given that no distinction is made currently for something like "git
show foobar" between "you don't have foobar" and "foobar is somehow
corrupt", I am inclined to just say "any errors in default lookup are
ignored."

-Peff
