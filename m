From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] implement metadata cache subsystem
Date: Mon, 6 Aug 2012 16:31:54 -0400
Message-ID: <20120806203154.GA11977@sigill.intra.peff.net>
References: <20120804170905.GA19267@sigill.intra.peff.net>
 <20120804171146.GF19378@sigill.intra.peff.net>
 <7vk3xe8dc1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 22:32:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyTy8-0003LK-He
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 22:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756419Ab2HFUb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 16:31:58 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53674 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756338Ab2HFUb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 16:31:57 -0400
Received: (qmail 19141 invoked by uid 107); 6 Aug 2012 20:32:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Aug 2012 16:32:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2012 16:31:54 -0400
Content-Disposition: inline
In-Reply-To: <7vk3xe8dc1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202983>

On Sat, Aug 04, 2012 at 03:49:12PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > There are some calculations that git makes repeatedly, even
> > though the results are invariant for a certain input (e.g.,
> > the patch-id of a certain commit). We can make a space/time
> > tradeoff by caching these on disk between runs.
> >
> > Even though these may be immutable for a certain commit, we
> > don't want to directly store the results in the commit
> > objects themselves, for a few reasons:
> >
> >   1. They are not necessarily used by all algorithms, so
> >      bloating the commit object might slow down other
> >      algorithms.
> >
> >   2. Because they can be calculated from the existing
> >      commits, they are redundant with the existing
> >      information. Thus they are an implementation detail of
> >      our current algorithms, and should not be cast in stone
> >      by including them in the commit sha1.
> >
> >   3. They may only be immutable under a certain set of
> >      conditions (e.g., which grafts or replace refs we are
> >      using). Keeping the storage external means we can
> >      invalidate and regenerate the cache whenever those
> >      conditions change.
> 
> 4. The algorithm used to compute such values could improve over
> time.  The same advantage argument as 3 applies to this case.

Yeah, agreed. That commit message is a year old, and was written for an
earlier iteration of the patch which was used for caching commit
generations. There's not really a better algorithm there, but your
comment certainly applies to rename similarities.

-Peff
