From: Jeff King <peff@peff.net>
Subject: Re: Subject: [PATCH 2/3] Let git-add--interactive read colors from
	.gitconfig
Date: Tue, 13 Nov 2007 02:26:29 -0500
Message-ID: <20071113072629.GA21769@sigill.intra.peff.net>
References: <20071023035221.66ea537f@danzwell.com> <20071102224100.71665182@paradox.zwell.net> <20071104045735.GA12359@segfault.peff.net> <7v640ivagv.fsf@gitster.siamese.dyndns.org> <20071104054305.GA13929@sigill.intra.peff.net> <20071110202351.7b4544aa@paradox.zwell.net> <7vve89f6qy.fsf@gitster.siamese.dyndns.org> <47390050.1020907@zwell.net> <7v4pfq27tx.fsf@gitster.siamese.dyndns.org> <47391211.5000606@zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Dan Zwell <dzwell@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 08:26:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrqAZ-0008Aw-Na
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 08:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbXKMH0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 02:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbXKMH0c
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 02:26:32 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4846 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698AbXKMH0b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 02:26:31 -0500
Received: (qmail 18076 invoked by uid 111); 13 Nov 2007 07:26:30 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 13 Nov 2007 02:26:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2007 02:26:29 -0500
Content-Disposition: inline
In-Reply-To: <47391211.5000606@zwell.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64758>

On Mon, Nov 12, 2007 at 08:55:13PM -0600, Dan Zwell wrote:

> Anyway, I preferred the regex version for readability, though I should have 
> used the /x modifier--it would still take two lines, but it would not need 

Your regex is wrong, because it doesn't anchor at the beginning and end
of the string (so /red/ will match "supercaliredfragilistic", which is
probably not what you want). So you probably want /^red$/, which is
equivalent to using 'eq' with 'red'. Or, as Junio noted, you are overall
trying to say "is element $word in this list"; the canonical perl way of
doing that is to make the list a hash for quick lookup.

> to attempt two matches. As for misconfigured color configurations, should we 
> catch that? I wrote this with the intent that it should ignore invalid color 
> names, but it would probably be more useful to print a warning.

Your patch doesn't just ignore; sometimes it accidentally matches
invalid input (the example above is obviously silly, but consider what
accidentally omitting the space in "blinkblack" would do).

-Peff
