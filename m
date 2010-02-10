From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix signal handler
Date: Wed, 10 Feb 2010 12:35:27 -0500
Message-ID: <20100210173527.GB5091@coredump.intra.peff.net>
References: <4B684F5F.7020409@web.de>
 <20100202205849.GA14385@sigill.intra.peff.net>
 <4B71A2EE.8070708@web.de>
 <4B72E81B.3020900@web.de>
 <20100210171406.GE2747@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Markus Elfring <Markus.Elfring@web.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 10 18:35:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfGTO-0006qd-JO
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 18:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010Ab0BJRf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 12:35:26 -0500
Received: from peff.net ([208.65.91.99]:46992 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755028Ab0BJRfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 12:35:25 -0500
Received: (qmail 6306 invoked by uid 107); 10 Feb 2010 17:35:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 10 Feb 2010 12:35:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Feb 2010 12:35:27 -0500
Content-Disposition: inline
In-Reply-To: <20100210171406.GE2747@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139527>

On Wed, Feb 10, 2010 at 09:14:06AM -0800, Shawn O. Pearce wrote:

> > +	early_output_function = &log_show_early;
> ...
> > -volatile show_early_output_fn_t show_early_output;
> > +sig_atomic_t show_early_output = 0;
> > +show_early_output_fn_t early_output_function = NULL;
> ...
> > +		if (show_early_output) {
> > +			(*early_output_function)(revs, newlist);
> > +			show_early_output = 0;
> > +		}
> 
> The function pointer isn't necessary.  AFAIK its only called in
> this one call site.  So you can make a direct reference to the
> log_show_early function.

I disagree. The original intent was to decrease coupling between the
library-like revision walker and the actual log command. We aren't using
that flexibility now, but I don't see any reason to decrease it
(especially since it is so easy to keep it).

-Peff
