From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] Advertise the ability to abort a commit
Date: Thu, 31 Jul 2008 07:09:26 -0400
Message-ID: <20080731110926.GA23234@sigill.intra.peff.net>
References: <20080730051059.GA4497@sigill.intra.peff.net> <1217440391-13259-1-git-send-email-mail@cup.kalibalik.dk> <20080731055024.GA17652@sigill.intra.peff.net> <7vwsj23896.fsf@gitster.siamese.dyndns.org> <20080731073609.GA8049@sigill.intra.peff.net> <20080731105539.GM32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 31 13:10:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOW3B-0002M1-4M
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 13:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbYGaLJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 07:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbYGaLJ2
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 07:09:28 -0400
Received: from peff.net ([208.65.91.99]:1898 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbYGaLJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 07:09:28 -0400
Received: (qmail 23344 invoked by uid 111); 31 Jul 2008 11:09:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 31 Jul 2008 07:09:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jul 2008 07:09:26 -0400
Content-Disposition: inline
In-Reply-To: <20080731105539.GM32184@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90926>

On Thu, Jul 31, 2008 at 12:55:39PM +0200, Petr Baudis wrote:

> >  		if (cleanup_mode == CLEANUP_ALL)
> > -			fprintf(fp, "not be included)\n");
> > +			fprintf(fp,
> > +				" Lines starting\n"
> > +				"# with '#' will be ignored, and an empty"
> > +				" message aborts the commit.\n");
> >  		else /* CLEANUP_SPACE, that is. */
> > -			fprintf(fp, "be kept.\n"
> > -				"# You can remove them yourself if you want to)\n");
> > +			fprintf(fp,
> > +				" Lines starting\n"
> > +				"# with '#' will be kept; you may remove them"
> > +				" yourself if you want to.\n"
> > +				"# An empty message aborts the commit.\n");
> >  		if (only_include_assumed)
> >  			fprintf(fp, "# %s\n", only_include_assumed);
> >  
> 
> This is rather funny-looking; you print _one_ fragment of the common
> string by a common fprintf, but then repeat _second_ fragment of the
> still-common string in a per-case fprintf. Can't we at least split this
> on the line boundary, if not do something loosely like this?

I just broke it by sentence, thinking that followed the semantics more
clearly (i.e., the first fprintf says one thing, then the second says
another; however, we must say the second one differently depending on
the case). I almost just split the whole paragraph by cleanup case,
allowing each to be worded and wrapped as most appropriate.

> 		fprintf(fp,
> 			"\n"
> 			"# Please enter the commit message for your "
> 			"changes. Lines starting\n"
> 			"# with a '#' will be %s "
> 			"and an empty message aborts the commit\n",
> 			cleanup_mode == CLEANUP_ALL ? "ignored,"
> 			/* CLEANUP_SPACE */ : "kept (you may remove them "
> 				"yourself if you want to)\n#");

I did something like that before submitting, but decided against it
because:

  - I found mine more readable, since it is hard to see in yours exactly
    where there will be a linebreak.

  - I actually changed the phrasing for the second one. Since we
    introduce another clause into the sentence in the CLEANUP_SPACE
    case, it makes sense to start another sentence for the final point.

-Peff
