From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] ref_transaction_commit(): remove the local flags
 variables
Date: Fri, 24 Apr 2015 17:19:33 -0400
Message-ID: <20150424211932.GA10809@peff.net>
References: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu>
 <1429875349-29736-5-git-send-email-mhagger@alum.mit.edu>
 <20150424173005.GC30592@peff.net>
 <553AB25D.9090201@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 24 23:19:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yll0k-0005zO-I1
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 23:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967095AbbDXVTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 17:19:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:49851 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965369AbbDXVTg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 17:19:36 -0400
Received: (qmail 2295 invoked by uid 102); 24 Apr 2015 21:19:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Apr 2015 16:19:36 -0500
Received: (qmail 19380 invoked by uid 107); 24 Apr 2015 21:20:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Apr 2015 17:20:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2015 17:19:33 -0400
Content-Disposition: inline
In-Reply-To: <553AB25D.9090201@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267757>

On Fri, Apr 24, 2015 at 11:15:09PM +0200, Michael Haggerty wrote:

> > Hmm. I think this is losing the distinction of "flags the caller has
> > passed in to us" versus "flags we are using locally only during the
> > transaction_commit routine". If callers look at the flags in the
> > REF_TRANSACTION_CLOSED state, do they care about seeing these new flags?
> > 
> > My guess is probably not in practice, and "leaking" these flags is an
> > acceptable tradeoff for keeping the transaction_commit function simpler.
> > But I haven't looked that closely.
> 
> "struct ref_update" is opaque to callers outside of the refs module, and
> ref_update::flags is not read anywhere outside of
> ref_transaction_commit() (and its value is passed to
> lock_ref_sha1_basic()). So I don't think we have to be shy about storing
> our own internal information there.
> 
> In fact, REF_DELETING, REF_ISPRUNING, REF_HAVE_NEW, and REF_HAVE_OLD are
> also private to the refs module.

Thanks for checking. If nobody is affected (and is not likely to be), I
agree it's not worth worrying about.

> I suppose we could mask out all the "private" bits in the flags
> parameter passed by the caller, to make sure that the caller hasn't
> accidentally set other bits. I think that would be more defensive than
> our usual practice, but I don't mind doing it if people think it would
> be prudent.

I don't think it's necessary.

-Peff
