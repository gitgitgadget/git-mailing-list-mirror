From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] mark_reachable_objects(): optionally collect broken
 refs
Date: Thu, 24 Sep 2015 13:56:15 -0400
Message-ID: <20150924175615.GA15117@sigill.intra.peff.net>
References: <cover.1443085919.git.johannes.schindelin@gmx.de>
 <bcceeae4c8f7f690502651dd6cc537b2f4918fac.1443085919.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 24 19:56:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfAkq-00053e-AY
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 19:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757112AbbIXR4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 13:56:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:35795 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755361AbbIXR4T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 13:56:19 -0400
Received: (qmail 32240 invoked by uid 102); 24 Sep 2015 17:56:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 12:56:18 -0500
Received: (qmail 27623 invoked by uid 107); 24 Sep 2015 17:56:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 13:56:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 13:56:15 -0400
Content-Disposition: inline
In-Reply-To: <bcceeae4c8f7f690502651dd6cc537b2f4918fac.1443085919.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278549>

On Thu, Sep 24, 2015 at 11:13:52AM +0200, Johannes Schindelin wrote:

> The behavior of `mark_reachable_objects()` without this patch is that it
> dies if it encounters a broken ref. This is sometimes undesirable, e.g.
> when garbage collecting in a repository with a stale remote HEAD.
> 
> So let's introduce an optional parameter to collect such broken refs. The
> behavior of the function is unchanged if that parameter is `NULL`.

Similar comment to the last one. :)

I suspect the issues you are seeing are largely new due to the
ref-paranoia work I did (merged in 05e816e37). We used to ignore broken
refs at the for_each_ref() level, but now we feed them to the calling
code (which generally chokes).

So in that sense, a simpler fix than your series would be to simply
revert 8d42299 and ff4056bbc. :)

But I think those new checks are valuable, and we really just need to
gracefully ignore the dangling-symref case (which is _a_ breakage, but
not a dangerous one).

-Peff
