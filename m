From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/4] builtin/verify-tag: move verification code to
 tag.c
Date: Sun, 3 Apr 2016 00:45:03 -0400
Message-ID: <20160403044502.GC1519@sigill.intra.peff.net>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
 <1459638975-17705-4-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: santiago@nyu.edu
X-From: git-owner@vger.kernel.org Sun Apr 03 06:45:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amZuS-0001Sh-G2
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 06:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbcDCEpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 00:45:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:43241 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751140AbcDCEpF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 00:45:05 -0400
Received: (qmail 30192 invoked by uid 102); 3 Apr 2016 04:45:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 03 Apr 2016 00:45:04 -0400
Received: (qmail 9163 invoked by uid 107); 3 Apr 2016 04:45:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 03 Apr 2016 00:45:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Apr 2016 00:45:03 -0400
Content-Disposition: inline
In-Reply-To: <1459638975-17705-4-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290627>

On Sat, Apr 02, 2016 at 07:16:14PM -0400, santiago@nyu.edu wrote:

> From: Santiago Torres <santiago@nyu.edu>
> 
> The PGP verification routine for tags could be accessed by other
> commands that require it. We do this by moving it to the common tag.c
> code. We rename the verify_tag() function to pgp_verify_tag() to avoid
> conflicts with the mktag.c function.

One nit: even though GPG is just an implementation of PGP, and
technically the standard and formats are called PGP, we tend to name
everything GPG in the code. So this probably should be gpg_verify_tag().

> -	len = parse_signature(buf, size);
> -
> -	if (size == len) {
> -		if (flags & GPG_VERIFY_VERBOSE)
> -			write_in_full(1, buf, len);
> -		return error("no signature found");
> -	}
> [...]
> +	payload_size = parse_signature(buf, size);
> +
> +	if (size == payload_size) {
> +		write_in_full(1, buf, payload_size);
> +		return error("No PGP signature found in this tag!");
> +	}

I'm happy to see the more readable variable name here. I wonder if we
should leave the error message as-is, though, as this is just supposed
to be about code movement (and if we are changing it, it should adhere
to our usual style of not starting with a capital letter, and not ending
in punctuation).

-Peff
