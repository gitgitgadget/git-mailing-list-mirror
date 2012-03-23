From: Jeff King <peff@peff.net>
Subject: Re: Listing commits that are _exclusively_ available on a given
 branch
Date: Fri, 23 Mar 2012 13:06:41 -0400
Message-ID: <20120323170640.GA12881@sigill.intra.peff.net>
References: <CALKQrge-=XExhwxuC14uynpuuO3W+f4YO4=X7kFUx33F3HtnyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 18:06:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB7wv-0003Lm-Tk
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 18:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757136Ab2CWRGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 13:06:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57557
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757060Ab2CWRGo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 13:06:44 -0400
Received: (qmail 16246 invoked by uid 107); 23 Mar 2012 17:07:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Mar 2012 13:07:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Mar 2012 13:06:41 -0400
Content-Disposition: inline
In-Reply-To: <CALKQrge-=XExhwxuC14uynpuuO3W+f4YO4=X7kFUx33F3HtnyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193771>

On Fri, Mar 23, 2012 at 03:36:33PM +0100, Johan Herland wrote:

> I'm trying to figure out how to list commits on a given branch that
> are not available on any other branch, i.e. the commits that are
> exclusive to my branch.
> 
> So far I only have this somewhat brute-force alternative:
> 
>   git rev-list refs/heads/mybranch --not $(git show-ref --heads | grep
> -v refs/heads/mybranch)
> 
> Is it possible to phrase this query in a simpler manner? Preferably by
> not having to list all refs and then run grep on it...

No, I think that is the only way to do it. The algorithm run by rev-list
in that case should be optimal, so there is nothing to improve there.
Syntactically, it's a little bit of a pain because there is no way to
tell rev-list "--all, except for this one branch" short of using grep.
We could add a new syntax for that, but I'm not sure what it would look
like (or if it would be any easier on the eyes than what you have).

You might consider using "git rev-list --stdin" to avoid running into
limits on the command-line length.

-Peff
