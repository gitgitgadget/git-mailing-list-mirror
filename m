From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] ref_transaction_commit(): remove the local flags
 variables
Date: Fri, 24 Apr 2015 13:30:05 -0400
Message-ID: <20150424173005.GC30592@peff.net>
References: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu>
 <1429875349-29736-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 24 19:30:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlhQe-0004Pk-Q5
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 19:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966362AbbDXRaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 13:30:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:49723 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S966979AbbDXRaI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 13:30:08 -0400
Received: (qmail 25066 invoked by uid 102); 24 Apr 2015 17:30:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Apr 2015 12:30:07 -0500
Received: (qmail 17329 invoked by uid 107); 24 Apr 2015 17:30:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Apr 2015 13:30:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2015 13:30:05 -0400
Content-Disposition: inline
In-Reply-To: <1429875349-29736-5-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267746>

On Fri, Apr 24, 2015 at 01:35:48PM +0200, Michael Haggerty wrote:

> Instead, work directly with update->flags. This has the advantage that
> the REF_DELETING bit, set in the first loop, can be read in the third
> loop instead of having to compute the same expression again. Plus, it
> was kindof confusing having both update->flags and flags, which
> sometimes had different values.

Hmm. I think this is losing the distinction of "flags the caller has
passed in to us" versus "flags we are using locally only during the
transaction_commit routine". If callers look at the flags in the
REF_TRANSACTION_CLOSED state, do they care about seeing these new flags?

My guess is probably not in practice, and "leaking" these flags is an
acceptable tradeoff for keeping the transaction_commit function simpler.
But I haven't looked that closely.

-Peff
