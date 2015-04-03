From: Jeff King <peff@peff.net>
Subject: Re: RFC: git status --amend
Date: Fri, 3 Apr 2015 18:05:46 -0400
Message-ID: <20150403220546.GA14195@peff.net>
References: <551AB64F.4030400@cs-ware.de>
 <20150331180414.GB19206@peff.net>
 <xmqqvbhhqal6.fsf@gitster.dls.corp.google.com>
 <20150401084230.GA12282@gmail.com>
 <xmqqlhibn509.fsf@gitster.dls.corp.google.com>
 <20150403215744.GA39695@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Sven Strickroth <sven@cs-ware.de>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 00:05:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye9is-00023P-2q
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 00:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbbDCWFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 18:05:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:42211 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752112AbbDCWFt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 18:05:49 -0400
Received: (qmail 12932 invoked by uid 102); 3 Apr 2015 22:05:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Apr 2015 17:05:48 -0500
Received: (qmail 26085 invoked by uid 107); 3 Apr 2015 22:06:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Apr 2015 18:06:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Apr 2015 18:05:46 -0400
Content-Disposition: inline
In-Reply-To: <20150403215744.GA39695@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266739>

On Fri, Apr 03, 2015 at 02:57:48PM -0700, David Aguilar wrote:

> > But I discarded it as a useless suggestion before writing it down,
> > primarily because I couldn't come up with an explanation _why_ being
> > able to say "git status --relative-to=next Makefile" is useful when
> > on the 'master' branch.
> 
> Aesthetically it's appealing because it mirrors commands like
> "git diff HEAD^", etc.
> 
> I can see it being useful for script writers but it's a minority
> case that's already handled by having "status --amend" for the
> common case of needing to mimic "commit --amend".
> 
> Beyond that use case, someone could use it to write a butchery
> tool that gets a quick high-level diff of changes for both index
> and worktree against an arbitrary ref, and then apply those
> changes selectively using other git tools.

Hmm. What if you had a tool that created commits out of an alternate
working tree and index, and then committed directly to a branch without
touching HEAD? Then you might run:

  GIT_WORK_TREE=... GIT_INDEX_FILE=... git status --relative-to=mybranch

right before running:

  old=$(git rev-parse refs/heads/mybranch) &&
  tree=$(GIT_INDEX_FILE=... git commit-tree) &&
  commit=$(echo whatever | git commit-tree -p $old $tree) &&
  git update-ref refs/heads/mybranch $old

or similar. That is basically "git-new-workdir", but with no per-workdir
HEAD. Which is probably crazy, but maybe useful for a one-off commit to
another branch or something.

I dunno. I do not have such a tool or plan to work on one, but it is at
least plausible to me.

-Peff
