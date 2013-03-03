From: Jeff King <peff@peff.net>
Subject: Re: [bug report] git-am applying maildir patches in reverse
Date: Sun, 3 Mar 2013 01:32:44 -0500
Message-ID: <20130303063244.GB23221@sigill.intra.peff.net>
References: <20130301222018.GA839@WST420>
 <7vwqtqeox7.fsf@alter.siamese.dyndns.org>
 <20130301225231.GB862@sigill.intra.peff.net>
 <20130301230508.GC862@sigill.intra.peff.net>
 <7vlia6em9x.fsf@alter.siamese.dyndns.org>
 <20130301233548.GA13422@sigill.intra.peff.net>
 <7v1ubyek9n.fsf@alter.siamese.dyndns.org>
 <20130302004120.GB14936@sigill.intra.peff.net>
 <m28v66198o.fsf@igel.home>
 <7vtxotc895.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	William Giokas <1007380@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 03 07:33:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UC2Ty-0002QJ-Mc
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 07:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255Ab3CCGcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 01:32:50 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40395 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752080Ab3CCGct (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 01:32:49 -0500
Received: (qmail 16157 invoked by uid 107); 3 Mar 2013 06:34:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 03 Mar 2013 01:34:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Mar 2013 01:32:44 -0500
Content-Disposition: inline
In-Reply-To: <7vtxotc895.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217338>

On Sat, Mar 02, 2013 at 10:22:46PM -0800, Junio C Hamano wrote:

> Andreas Schwab <schwab@linux-m68k.org> writes:
> 
> > You should always cast to unsigned char when determining the order of
> > characters, to be consistent with strcmp/memcmp.
> 
> We treat runs of digits as numbers, so it is not even similar to
> strcmp.  As long as it is internally consistent (i.e. the return
> value inside the loop (*a - *b) must match the last return), it
> should be OK, no?

I almost responded and said something similar, but we also do byte-wise
comparisons for non-numeric elements, and we would want those to match
what other programs may do (and what git used to do).

I highly doubt that it matters in practice, as it would mean:

  1. The sorting of a maildir's filenames are dependent on the sorting
     of non-numeric bits. We can't rule out such a scheme, but I'd guess
     implementations either use numbers, or their sort order is
     meaningless (and that is what I found in the ones I looked at).

  2. The importantly-sorted bits contain non-ascii characters (the
     difference is only seen when we go outside the signed range).

but it doesn't hurt to be thorough (and to set a good example).

-Peff
