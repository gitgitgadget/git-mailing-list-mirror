From: Jeff King <peff@peff.net>
Subject: Re: git cherry-pick --strategy=resolve segfaults if picking a root
 commit
Date: Thu, 12 May 2011 07:08:55 -0400
Message-ID: <20110512110855.GA5240@sigill.intra.peff.net>
References: <iqgbvs$pm5$1@dough.gmane.org>
 <20110512104558.GA22108@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 13:09:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKTlP-00063w-Qe
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 13:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988Ab1ELLI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 07:08:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53671
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169Ab1ELLI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 07:08:58 -0400
Received: (qmail 12661 invoked by uid 107); 12 May 2011 11:10:55 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 May 2011 07:10:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 May 2011 07:08:55 -0400
Content-Disposition: inline
In-Reply-To: <20110512104558.GA22108@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173457>

On Thu, May 12, 2011 at 06:45:58AM -0400, Jeff King wrote:

> So probably we should:
> 
>   1. Pass the empty tree along to merge-resolve. This will take a little
>      bit of refactoring, but more importantly, it means we will be
>      passing a tree-ish and not a commit-ish to a merge strategy. Is
>      that OK?
> 
>   2. Consider lifting the restriction on reverting root commits. If we
>      can cherry-pick it, we can revert it, so I suspect this would
>      already work with merge-recursive, but I didn't try. I don't care
>      too much either way, though; I doubt it's something people would do
>      a lot. It just seems like an unnecessary restriction.

This turned out to be quite easy. git-merge-resolve handles the tree-ish
argument just fine. But it's possible other merge helpers might not be
so happy. I dunno.

The series is:

  [1/3]: cherry-pick: handle root commits with external strategies
  [2/3]: revert: allow reverting a root commit
  [3/3]: t3503: test cherry picking and reverting root commits

-Peff
