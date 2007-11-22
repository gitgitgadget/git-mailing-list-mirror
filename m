From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] Let git-add--interactive read colors from
	configuration
Date: Thu, 22 Nov 2007 17:30:50 -0500
Message-ID: <20071122223050.GC3620@sigill.intra.peff.net>
References: <20071023042702.GB28312@coredump.intra.peff.net> <20071023035221.66ea537f@danzwell.com> <20071102224100.71665182@paradox.zwell.net> <20071104045735.GA12359@segfault.peff.net> <7v640ivagv.fsf@gitster.siamese.dyndns.org> <20071104054305.GA13929@sigill.intra.peff.net> <20071110180109.34febc3f@paradox.zwell.net> <20071122045606.0232fc2d@paradox.zwell.net> <20071122121836.GG12913@sigill.intra.peff.net> <7v63zu3r7h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Zwell <dzwell@zwell.net>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 23:31:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvKZi-0005Yx-2O
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 23:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbXKVWax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 17:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753149AbXKVWaw
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 17:30:52 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1899 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752882AbXKVWaw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 17:30:52 -0500
Received: (qmail 26754 invoked by uid 111); 22 Nov 2007 22:30:50 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 Nov 2007 17:30:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2007 17:30:50 -0500
Content-Disposition: inline
In-Reply-To: <7v63zu3r7h.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65855>

On Thu, Nov 22, 2007 at 01:28:34PM -0800, Junio C Hamano wrote:

> I think the "config_bool with default" also makes sense but it
> needs to be coded a bit carefully.  Issues to consider:

Yes. It is not strictly necessary for this patch series, but I think it
is nice to stake out a claim on the third argument of config_* functions
for consistency sake. But perhaps in the name of avoiding regression, it
should come later, when somebody actually wants to use it.

>  (1) Non default form "$r->config_bool('key')" should keep the
>      original semantics; missing key in the configuration is the
>      same as false (i.e. "undef" in scalar, () in list context).

Yes, this is obviously the most important thing.

>  (2) What should be the second parameter in the form to default
>      to true?  '1'?  'true'?  Any kind of "true" value in Perl
>      should be accepted?
> 
>  (3) Same question as (2) but for defaulting to false.  Any kind
>      of "false"?

Hmm. I am tempted to say "yes, any true or any false value" in that the
point of config_* is to convert git config values to native perl
representations. OTOH, the moral equivalent of

  config_color('my.key', 'bold red');

is probably more appropriately

  config_bool('my.key', 'true');

so I am fine doing it that way, as well (though I think it makes us
duplicate the "translate these strings into bools" code into perl).

-Peff
