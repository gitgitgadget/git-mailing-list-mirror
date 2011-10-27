From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] replace sha1 with another algorithm
Date: Wed, 26 Oct 2011 17:01:17 -0700
Message-ID: <20111027000117.GA24161@sigill.intra.peff.net>
References: <20111026001237.GA22195@sigill.intra.peff.net>
 <7vaa8n35dc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 27 02:01:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJDPR-0005Hh-Qx
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 02:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503Ab1J0ABV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 20:01:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56430
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753470Ab1J0ABU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 20:01:20 -0400
Received: (qmail 28955 invoked by uid 107); 27 Oct 2011 00:07:07 -0000
Received: from 99-189-169-83.lightspeed.snjsca.sbcglobal.net (HELO sigill.intra.peff.net) (99.189.169.83)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Oct 2011 20:07:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Oct 2011 17:01:17 -0700
Content-Disposition: inline
In-Reply-To: <7vaa8n35dc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184280>

On Wed, Oct 26, 2011 at 12:44:15PM -0700, Junio C Hamano wrote:

> > +static void mix_hash(unsigned char *h, unsigned n)
> > +{
> > +	unsigned char out[20];
> > +	unsigned mid = n / 2;
> > +
> > +	if (2*mid < n)
> > +		return;
> > +
> > +	xor_bytes(out, h, h + mid, mid);
> > +	xor_bytes(out + mid, h + mid, h, mid);
> > +	memcpy(h, out, n);
> > +
> > +	/* If a little bit of mixing is good, then a lot must be GREAT! */
> > +	mix_hash(h, mid);
> > +	mix_hash(h + mid, mid);
> > +}
> 
> You seem to want to reduce the hash down to 5-bytes by duplicating the
> same value on the left and right half, and duplicate that four times to
> fill 20-byte buffer, but doesn't this look unnecessarily inefficient way
> to achieve that?

Well, yeah. But when you're writing a really bad hashing algorithm, I
feel like obfuscating the bugs is key.

-Peff
