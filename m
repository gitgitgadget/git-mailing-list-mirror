From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: protect against disappearing packs
Date: Fri, 14 Oct 2011 09:02:48 -0400
Message-ID: <20111014130247.GA7808@sigill.intra.peff.net>
References: <20111014012320.GA4395@sigill.intra.peff.net>
 <alpine.LFD.2.02.1110132234210.17040@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, git-dev@github.com,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 15:02:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REhPd-0005GH-5f
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 15:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756553Ab1JNNCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 09:02:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60512
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756515Ab1JNNCw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 09:02:52 -0400
Received: (qmail 8708 invoked by uid 107); 14 Oct 2011 13:02:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Oct 2011 09:02:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Oct 2011 09:02:48 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1110132234210.17040@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183570>

On Thu, Oct 13, 2011 at 10:42:28PM -0400, Nicolas Pitre wrote:

> > ---
> 
> you should put your SOB above that line I would think.

Thanks. I cheated and wrote my "---" cover letter in the commit message
locally, knowing that it would get included by format-patch but stripped
by am on Junio's end.  Which does work, except that "format-patch -s"
puts the SOB in the wrong place. :)

> Acked-by: Nicolas Pitre <nico@fluxnic.net>

Thanks for reviewing.

> > We're seeing this at GitHub because we prune pretty
> > aggressively. We let pushes go into individual repositories,
> > but then we kick off a job to move the resulting objects
> > into the repository's "network" repo, which is basically a
> > big alternates repository for related repos.
> 
> While this patch certainly has value, it doesn't provide 100% 
> reliability for that use case.  Maybe the github infrastructure should 
> simply skip any auto-repack on push if some other object maintenance 
> operation is ongoing, possibly via the pre-auto-gc hook.

I'm not sure I understand the problem.  We already serialize the
re-packing jobs in a queue, so you won't have two repacks going at once.
The problematic pack-objects is the one started by upload-pack when
somebody fetches. Or do you mean turning off receive.autogc? I'd have to
check if we do that, but we definitely should; it's useless to us
(though it would be unlikely to trigger anyway, because we are manually
repacking so frequently).

-Peff
