From: Jeff King <peff@peff.net>
Subject: Re: [bug] git checkout lies about number of ahead commits when
 switching from detached HEAD
Date: Sun, 20 Mar 2011 05:01:11 -0400
Message-ID: <20110320090111.GA15641@sigill.intra.peff.net>
References: <4D8525C9.2060203@gmail.com>
 <20110319222852.GB7116@sigill.intra.peff.net>
 <20110319224726.GC7116@sigill.intra.peff.net>
 <7vy64avdba.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 10:01:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1EVk-0002sk-IL
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 10:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596Ab1CTJBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 05:01:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59860
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592Ab1CTJBO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 05:01:14 -0400
Received: (qmail 24486 invoked by uid 107); 20 Mar 2011 09:01:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 20 Mar 2011 05:01:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Mar 2011 05:01:11 -0400
Content-Disposition: inline
In-Reply-To: <7vy64avdba.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169492>

On Sat, Mar 19, 2011 at 05:35:37PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > but I'm not quite sure if this is the right place. Is it the
> > responsibility of the checkout-orphan-warning code to clean up after
> > itself, or is it the responsibility of a revision walker to clean up
> > before itself?
> 
> Usually it is the former; the latter is generally impossible (unless it is
> willing to clear everything), but the former knows where it started
> traversal from.

For the case of 2 traversals, I suspect that clearing everything between
is not so different from clearing from the tips, since most everything
parsed was probably from the first traversal. But as we lib-ify more, we
may end up with more and more traversals in a single program, so it's
probably better to go the more efficient route from the beginning.

So how about this?

  [1/3]: checkout: add basic tests for detached-orphan warning
  [2/3]: checkout: clear commit marks after detached-orphan check
  [3/3]: checkout: tweak detached-orphan warning format

3/3 is only somewhat related, but I had been meaning to do it anyway. We
can break it off into a separate topic if there's a lot of discussion
around the 2nd patch.

-Peff
