From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] git-compat-util.h: implement a different ARRAY_SIZE
 macro for for safely deriving the size of array
Date: Tue, 28 Apr 2015 01:42:37 -0400
Message-ID: <20150428054237.GI24580@peff.net>
References: <1430140269-11784-1-git-send-email-gitter.spiros@gmail.com>
 <xmqq1tj5xxo1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 07:42:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmyI9-00050Y-PK
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 07:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbbD1Fml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 01:42:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:50975 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751348AbbD1Fmk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 01:42:40 -0400
Received: (qmail 18823 invoked by uid 102); 28 Apr 2015 05:42:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 00:42:40 -0500
Received: (qmail 11802 invoked by uid 107); 28 Apr 2015 05:43:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 01:43:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Apr 2015 01:42:37 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1tj5xxo1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267898>

On Mon, Apr 27, 2015 at 10:56:30AM -0700, Junio C Hamano wrote:

> Elia Pinto <gitter.spiros@gmail.com> writes:
> 
> > This is the second version of this patch.  It had not been
> > discussed before. In the second version, I just tried to clarify
> > the comment in the commit. I resend it just in case you missed
> 
> I do not recall seeing it before.  No discussion usually means no
> interest, so I'll see what happens this time on the list for a few
> days before picking it up.

I'm in favor of any method for improving compile-time bug-checking,
provided that:

  1. It does not carry a maintenance cost that spreads throughout the
     code base (e.g., here the cost is localized to making ARRAY_SIZE a
     bit more complex, but callers do not have to care about the extra
     checking).

  2. It gracefully degrades when using older compilers (i.e., we can
     fall back to the existing ARRAY_SIZE definition when the magic
     builtin is not available).

I think this is OK for both points. It would be nice if we could
auto-detect the presence of the builtin without using autoconf. I think
most git developers do not use autoconf at all, and the feature does not
help much if nobody turns it on. Is there a __GNUC__ or similar
feature-test macro we could use for this?

> > +#define _array_size_chk(arr) 0
> > +#endif
> 
> Wouldn't there be a more sensible name?  _chk does not tell us
> anything about what is being checked, and the only thing this name
> gives us is "what uses it" (i.e. it is some magic used by array-size
> and does not say what it checks and what for).
> 
> I think you are checking arr is an array and not a pointer.  Perhaps
> "#define is_an_array(arr)" or something along that line may be a
> more descriptive name for it.
> 
> I doubt the leading underscore is particularly a good idea, though.

Agreed on the naming (modulo the "not" from your follow-on email). Also,
should it be in ALL_CAPS like the other added macros? We are slightly
inconsistent about that in our code-base.

-Peff
