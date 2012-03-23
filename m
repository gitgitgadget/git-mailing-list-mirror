From: Jeff King <peff@peff.net>
Subject: Re: odd behavior with git-rebase
Date: Fri, 23 Mar 2012 15:54:56 -0400
Message-ID: <20120323195455.GB15063@sigill.intra.peff.net>
References: <20120323185205.GA11916@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 20:55:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBAZn-0006aV-Dw
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 20:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756310Ab2CWTy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 15:54:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57717
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755550Ab2CWTy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 15:54:59 -0400
Received: (qmail 18667 invoked by uid 107); 23 Mar 2012 19:55:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Mar 2012 15:55:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Mar 2012 15:54:56 -0400
Content-Disposition: inline
In-Reply-To: <20120323185205.GA11916@hmsreliant.think-freely.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193799>

On Fri, Mar 23, 2012 at 02:52:05PM -0400, Neil Horman wrote:

> 	I hit a strange problem with git rebase and I can't quite decide if its
> a design point of the rebase command, or if its happening in error.  When doing
> upstream backports of various kernel components I occasionally run accross
> commits that, for whatever reason, I don't want/need or can't backport.  When
> that happens, I insert an empty commit in my history noting the upstream commit
> hash and the reasoning behind why I skipped it (I use git commit -c <hash>
> --allow-empty).  If I later rebase this branch, I note that all my empty commits
> fail indicating the commit cannot be applied.  I can of course do another git
> commit --allow-empty -c <hash>; git rebase --continue, and everything is fine,
> but I'd rather it just take the empty commit in the rebase if possible.

I think it is even odder than that. If you use plain rebase, the empty
commits are silently omitted. If you do an interactive rebase, you get
the "could not apply" message (and just doing a "continue" creates some
funny error messages and ends up omitting the commit).

I think both of these are bugs. In the first case, the empty commit
appears to be already applied, because it does nothing. But if somebody
bothered to create an empty commit in the first place, they probably
want to keep it, and we should special-case it.

As you've probably guessed, empty commits are not all that common, and I
think this area of git is not well-tested.

-Peff
