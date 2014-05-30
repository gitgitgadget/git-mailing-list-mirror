From: Jeff King <peff@peff.net>
Subject: Re: Git stash gpg prompting
Date: Fri, 30 May 2014 16:24:14 -0400
Message-ID: <20140530202413.GD5513@sigill.intra.peff.net>
References: <CALp-zYGRLKJfC5rVygRg8adjsxP0h2dguNSYsvmcZxq7tcEQfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eddie Monge <eddie@eddiemonge.com>
X-From: git-owner@vger.kernel.org Fri May 30 22:24:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqTLg-0004az-OI
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 22:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932948AbaE3UYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 16:24:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:34418 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752209AbaE3UYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 16:24:16 -0400
Received: (qmail 30144 invoked by uid 102); 30 May 2014 20:24:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 May 2014 15:24:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 May 2014 16:24:14 -0400
Content-Disposition: inline
In-Reply-To: <CALp-zYGRLKJfC5rVygRg8adjsxP0h2dguNSYsvmcZxq7tcEQfg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250477>

On Fri, May 30, 2014 at 01:07:16PM -0700, Eddie Monge wrote:

> Git stash is prompting for passphrase to try to "sign" the changes
> being stashed.
> 
> Reproduce:
> Add to global gitconfig with signing key:
> ```
> [commit]
>   gpgsign = true
> ```
> Go to a repo, make some changes, and then run `git stash`
> 
> Expected: stash the changes as normal
> Actual: git prompts for passphrase (if set)

Well, yeah...stash is making a commit (two, actually), so it wants you
to sign it. :)

I suspect that using "git notes" has a similar problem. I can see an
argument for not signing stashes, as they are meant to be temporary and
not shared. I do think notes probably should be signed.

However, I wonder if it is really ever going to be sane to set
commit.gpgsign and not use something like gpg-agent. For example, if you
were to ever "git rebase" a patch series (or even just use "git rebase
-i" to refactor commits), you would be prompted for your passphrase to
sign each individual patch.

-Peff
