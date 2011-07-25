From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] Pro-Git thanks, Control-flow bug report
Date: Mon, 25 Jul 2011 13:49:48 -0600
Message-ID: <20110725194947.GA14659@sigill.intra.peff.net>
References: <20110725125037.GA24198@sherwood.local>
 <20110725162548.GA7071@sigill.intra.peff.net>
 <20110725193941.GA95001@sherwood.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 21:49:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlRA4-0006vQ-7q
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 21:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385Ab1GYTtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 15:49:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49607
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360Ab1GYTtu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 15:49:50 -0400
Received: (qmail 12033 invoked by uid 107); 25 Jul 2011 19:50:20 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Jul 2011 15:50:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jul 2011 13:49:48 -0600
Content-Disposition: inline
In-Reply-To: <20110725193941.GA95001@sherwood.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177813>

On Mon, Jul 25, 2011 at 09:39:41PM +0200, Steffen Daode Nurpmeso wrote:

> @ Jeff King <peff@peff.net> wrote (2011-07-25 18:25+0200):
> > Hmm. What's old is new again, I guess. I posted a patch to fix this
> > almost exactly 3 years ago:
> > 
> >   http://article.gmane.org/gmane.comp.version-control.git/90427
> 
> Unfortunately your patch from then seems no longer be sufficient
> (i.e., from my point of view, say), since this is also coloured:
> 
>   ?0%0[steffen@sherwood git.git]$ ./git -c color.ui=auto -c color.pager=false log

Yeah, it only covers the "diff" case. And that is why the special-casing
is a bad solution: you have to do it everywhere that you do late pager
setup. (Side note: at the time the original patch was written, log
actually didn't have this problem; it was introduced much later by
1fda91b). I wouldn't be surprised if there are others.

I think my patch also has the problem that:

  git -c color.ui=auto -c color.pager=false diff --color

will not properly override the config.

So probably the only sane solution is to push the "do we want color" bit
into a function, rather than keeping a static variable, and then call it
at the last possible minute.

-Peff
