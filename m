From: John Keeping <john@keeping.me.uk>
Subject: Re: Test failures with GNU grep 2.23
Date: Fri, 19 Feb 2016 19:23:11 +0000
Message-ID: <20160219192311.GB1766@serenity.lan>
References: <20160207162540.GK29880@serenity.lan>
 <20160219115928.GA10204@sigill.intra.peff.net>
 <xmqqmvqwd2ie.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 20:23:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWqeF-0002eA-CY
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 20:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948779AbcBSTXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 14:23:23 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:53161 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1948329AbcBSTXW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 14:23:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 191C9866002;
	Fri, 19 Feb 2016 19:23:22 +0000 (GMT)
X-Quarantine-ID: <6WRyA-HyNqfc>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6WRyA-HyNqfc; Fri, 19 Feb 2016 19:23:21 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id EBABCCDA5B2;
	Fri, 19 Feb 2016 19:23:13 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <xmqqmvqwd2ie.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286745>

On Fri, Feb 19, 2016 at 09:38:17AM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > Yeah, I'd worry that "-a" is not portable. OTOH, BSD grep seems to have
> > it, so between that and GNU, I think most systems are covered. We could
> > do:
> >
> >   test_lazy_prereq GREP_A '
> > 	echo foo | grep -a foo
> >   '
> >
> > and mark these tests with it. I'd also be happy to skip that step and
> > just do it if and when somebody actually complains about a system
> > without it (I wouldn't be surprised if most people on antique systems
> > end up installing GNU grep anyway).
> >
> > Another option might be using "sed -ne '/^author/p'" or similar. But
> > that may very well just be trading one portability problem for another.
> 
> Would $PERL help, I wonder?

I suspect that any grep that lacks "-a" also lacks binary file handling
that will break these tests.  I found a Solaris grep that doesn't
support "-a" and it treats these files as text.

>From that perspective, it would be better to have a central place that
deals with figuring out how to get grep to work for us.  Perhaps we need
test_grep to get this right.  We already have test_cmp_bin() as a thin
wrapper around cmp so I don't think this is completely unprecedented.
