From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] Let git-add--interactive read colors from
	configuration
Date: Fri, 23 Nov 2007 04:09:18 -0500
Message-ID: <20071123090918.GC5196@sigill.intra.peff.net>
References: <20071102224100.71665182@paradox.zwell.net> <20071104045735.GA12359@segfault.peff.net> <7v640ivagv.fsf@gitster.siamese.dyndns.org> <20071104054305.GA13929@sigill.intra.peff.net> <20071110180109.34febc3f@paradox.zwell.net> <20071122045606.0232fc2d@paradox.zwell.net> <20071122121836.GG12913@sigill.intra.peff.net> <7v63zu3r7h.fsf@gitster.siamese.dyndns.org> <20071122223050.GC3620@sigill.intra.peff.net> <474665E0.1010104@zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Dan Zwell <dzwell@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 10:09:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvUXe-0007jY-Hk
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 10:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbXKWJJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 04:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752965AbXKWJJX
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 04:09:23 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3314 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752955AbXKWJJW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 04:09:22 -0500
Received: (qmail 29677 invoked by uid 111); 23 Nov 2007 09:09:19 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 23 Nov 2007 04:09:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Nov 2007 04:09:18 -0500
Content-Disposition: inline
In-Reply-To: <474665E0.1010104@zwell.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65878>

On Thu, Nov 22, 2007 at 11:32:16PM -0600, Dan Zwell wrote:

> Further, I think that we could return the default variable directly, without 
> parsing it at all. It would be much simpler, and there would need to be no 
> special cases for dealing with undef or 'false'. It's a perl function, being 
> called with perl arguments, so a user should not be that surprised when 
> 'false' does what perl says it should do.

I think that is more elegant for config_bool, but it means that
config_bool and config_color have slightly different behaviors (the
difference being that it is easy to feed a native perl value as the
default to config_bool, but to get the same behavior for config_color,
you would call Git::color_to_ansi_code manually, which is a pain).

In this instance, I am inclined to sacrifice consistency for convenience
and make it:

   my $bool = config_bool('my.key', 0);
   my $color = config_color('my.key', 'bold red');

Note that there is one tricky part of config_bool, which is what
config_bool('my.key', undef) should do (is it "default false" or "no
default"?).

-Peff
