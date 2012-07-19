From: Jeff King <peff@peff.net>
Subject: Re: Feature request: fetch --prune by default
Date: Thu, 19 Jul 2012 07:55:59 -0400
Message-ID: <20120719115558.GC29774@sigill.intra.peff.net>
References: <2C63E314-2EF5-4B8E-B96A-5306E317E045@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alexey Muranov <alexey.muranov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 13:56:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrpKz-0008W4-Bg
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 13:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815Ab2GSL4D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 07:56:03 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:41691
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743Ab2GSL4B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 07:56:01 -0400
Received: (qmail 28427 invoked by uid 107); 19 Jul 2012 11:56:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jul 2012 07:56:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2012 07:55:59 -0400
Content-Disposition: inline
In-Reply-To: <2C63E314-2EF5-4B8E-B96A-5306E317E045@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201733>

On Thu, Jul 19, 2012 at 09:30:59AM +0200, Alexey Muranov wrote:

> i would like
> 
> `git fetch --prune <remote>`
> 
> to be the default behavior of
> 
> `git fetch <remote>`
> 
> In fact, i think this is the only reasonable behavior.
> Keeping copies of deleted remote branches after `fetch` is more confusing than useful.

I agree it would be much less confusing. However, one downside is that
we do not keep reflogs on deleted branches (and nor did the commits in
remote branches necessarily make it into the HEAD reflog). That makes
"git fetch" a potentially destructive operation (you irrevocably lose
the notion of which remote branches pointed where before the fetch, and
you open up new commits to immediate pruning by "gc --auto".

So I think it would be a lot more palatable if we kept reflogs on
deleted branches. That, in turn, has a few open issues, such as how to
manage namespace conflicts (e.g., the fact that a deleted "foo" branch
can conflict with a new "foo/bar" branch).

-Peff
