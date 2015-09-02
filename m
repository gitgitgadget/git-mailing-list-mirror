From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/2] date: make "local" orthogonal to date format
Date: Wed, 2 Sep 2015 23:07:40 +0100
Message-ID: <20150902220740.GN30659@serenity.lan>
References: <20150831204444.GA4385@sigill.intra.peff.net>
 <20150831204831.GB10338@sigill.intra.peff.net>
 <xmqq37ywoh0x.fsf@gitster.mtv.corp.google.com>
 <20150902213013.GB21612@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 03 00:08:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXGCS-00089p-0o
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 00:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989AbbIBWHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 18:07:50 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:39576 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794AbbIBWHt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 18:07:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 89293217FD;
	Wed,  2 Sep 2015 23:07:48 +0100 (BST)
X-Quarantine-ID: <vl+8p99U9YPa>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vl+8p99U9YPa; Wed,  2 Sep 2015 23:07:47 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 39FC9217FA;
	Wed,  2 Sep 2015 23:07:42 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20150902213013.GB21612@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277132>

On Wed, Sep 02, 2015 at 05:30:14PM -0400, Jeff King wrote:
> On Wed, Sep 02, 2015 at 10:41:34AM -0700, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > +	/* historical alias */
> > > +	if (!strcmp(format, "local"))
> > > +		format = "default-local";
> > > +
> > > +	mode->type = parse_date_type(format, &p);
> > > +	mode->local = 0;
> > > +
> > > +	if (skip_prefix(p, "-local", &p)) {
> > > +		if (mode->type == DATE_RELATIVE)
> > > +			die("relative-local date format is nonsensical");
> > > +		mode->local = 1;
> > > +	}
> > 
> > I notice that we give something funny like this:
> > 
> >     $ git show --date=short-locale
> >     fatal: unknown date-mode modifier: e
> 
> Yeah, that's not ideal.
> 
> > What is the intention here?  In other words, what kind of things can
> > plausibly follow "--date=short-local" in enhanced versions of Git in
> > the future?  "--date=short-local:some other magic"?
> 
> I had assumed it would be "short-local-othermagic", since ":" is already
> the separator for "format:". But I admit I have no idea what other
> modifiers would be interesting.
> 
> I think the error message would be a lot nicer if we indicate that "-"
> is syntactically interesting, and say:
> 
>   fatal: unknown date-mode modifier: locale

I wonder if we'd be better just saying:

	fatal: unknown date format: short-locale

I'm not sure users will consider "local" to be a modifier, there is
simply a list of formats that happens to include pairs of matching
"-local" and "not -local" variants.

That has the benefit of keeping the code simple, otherwise we have to
worry about "shorter" as well (in the patch as it stands that gives
"unknown date-mode modifier: er").
