From: Jeff King <peff@peff.net>
Subject: Re: "git pull --rebase" fails if pager.pull is true, after producing
 a colorized diff it cannot apply
Date: Mon, 10 Aug 2015 01:19:01 -0400
Message-ID: <20150810051901.GA9262@sigill.intra.peff.net>
References: <CAP=KgsTp=D1cSPmudDVEe32Q8gHhfSfuL7+V9YGZ65F1ZDUFiA@mail.gmail.com>
 <20150809234238.GB25769@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 07:19:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOfUe-000582-Uk
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 07:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbbHJFTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 01:19:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:42768 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751005AbbHJFTH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 01:19:07 -0400
Received: (qmail 14579 invoked by uid 102); 10 Aug 2015 05:19:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 00:19:07 -0500
Received: (qmail 2075 invoked by uid 107); 10 Aug 2015 05:19:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 01:19:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 01:19:01 -0400
Content-Disposition: inline
In-Reply-To: <20150809234238.GB25769@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275562>

On Sun, Aug 09, 2015 at 07:42:38PM -0400, Jeff King wrote:

> It looks like the use of a pager is fooling our "should we colorize the
> diff" check when generating the patches. Usually we check isatty(1) to
> see if we should use color, so "git format-patch >patches" does the
> right thing. But if a pager is in use, we have to override that check
> (since stdout goes to the pager, but the pager is going to a tty). That
> propagates to children via the GIT_PAGER_IN_USE environment variable.

Here's the fix I came up with. The first patch is just a tiny
refactoring; second one is the interesting bit.

  [1/2]: pager_in_use: use git_env_bool
  [2/2]: pager_in_use: make sure output is still going to pager

-Peff
