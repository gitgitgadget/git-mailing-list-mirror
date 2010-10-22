From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fix color.pager = false with "git diff"
Date: Thu, 21 Oct 2010 21:49:07 -0400
Message-ID: <20101022014907.GA30532@sigill.intra.peff.net>
References: <20101021150244.GA18426@sigill.intra.peff.net>
 <7vzku7rwcv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 03:48:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P96kB-0007C5-01
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 03:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754445Ab0JVBs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 21:48:26 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:40576 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416Ab0JVBsY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 21:48:24 -0400
Received: (qmail 14375 invoked by uid 111); 22 Oct 2010 01:48:24 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 22 Oct 2010 01:48:24 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Oct 2010 21:49:07 -0400
Content-Disposition: inline
In-Reply-To: <7vzku7rwcv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159631>

On Thu, Oct 21, 2010 at 03:53:36PM -0700, Junio C Hamano wrote:

> > Original discussion here:
> >
> >   http://thread.gmane.org/gmane.comp.version-control.git/89599
> >
> > I have mixed feelings on this one. It's kind of a hack. A more elegant
> > solution would be totally rewriting the color code to check for the
> > pager at first output.
> >
> > In favor of this patch:
> >
> >   1. It fixes a real bug.
> >
> >   2. Perfect is the enemy of the good, and I don't care enough about
> >      this case to refactor the color code.
> 
> Hmm, with "[color] pager = false", what should
> 
>     $ git diff --color
> 
> do?

Ugh. It should definitely turn color on, which my patch breaks. And
there's currently no way to know at that point in the code whether the
COLOR_DIFF bit came from --color or from the config.

So we would need to start keeping that information through the
callchain, or we need to refactor the color code to push the color
decision until later (probably first use). The latter is the right way,
I think, but it's going to take some surgery.

Either way, let's scrap my patch. The bug it introduces is just as bad
as the bug it fixes.

Thanks for noticing.

-Peff
