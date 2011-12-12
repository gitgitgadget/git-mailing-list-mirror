From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 08/51] is_dup_ref(): extract function from
 sort_ref_array()
Date: Mon, 12 Dec 2011 03:33:45 -0500
Message-ID: <20111212083345.GA16106@sigill.intra.peff.net>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
 <1323668338-1764-9-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Dec 12 09:33:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra1Ka-0005rI-N1
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 09:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856Ab1LLIds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 03:33:48 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48064
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748Ab1LLIdr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 03:33:47 -0500
Received: (qmail 30938 invoked by uid 107); 12 Dec 2011 08:40:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 03:40:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 03:33:45 -0500
Content-Disposition: inline
In-Reply-To: <1323668338-1764-9-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186897>

On Mon, Dec 12, 2011 at 06:38:15AM +0100, mhagger@alum.mit.edu wrote:

> +/*
> + * Emit a warning and return true iff ref1 and ref2 have the same name
> + * and the same sha1.  Die if they have the same name but different
> + * sha1s.
> + */
> +static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2)
> +{
> +	if (!strcmp(ref1->name, ref2->name)) {
> +		/* Duplicate name; make sure that the SHA1s match: */
> +		if (hashcmp(ref1->sha1, ref2->sha1))
> +			die("Duplicated ref, and SHA1s don't match: %s",
> +			    ref1->name);
> +		warning("Duplicated ref: %s", ref1->name);
> +		return 1;
> +	} else {
> +		return 0;
> +	}
> +}

As a user, I'm not sure what this message means. If I understand the
context right, this happens when you have duplicate entries in your
packed-refs file?

This would indicate a bug in git, so should this perhaps say "BUG:" in
front, or maybe give some more context so that a user understands it is
not their error, or even a random error on this run, but that git has
accidentally corrupted the packed-refs file (and their best bet is
probably to report the bug to us).

This is obviously not an issue introduced by your patch, as you are
just moving these error messages around. But maybe while the topic is
fresh in your mind it is a good time to improve it. I dunno. AFAICT
nobody has ever actually hit this message, so maybe it doesn't matter.
:)

-Peff
