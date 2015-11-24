From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] ff-refs: builtin command to fast-forward local refs
Date: Tue, 24 Nov 2015 17:39:03 -0500
Message-ID: <20151124223903.GG29185@sigill.intra.peff.net>
References: <1447207885-10911-1-git-send-email-rappazzo@gmail.com>
 <56431B69.9010007@drmicha.warpmail.net>
 <CANoM8SV77Jg8qYsn7UZ=a18WvrA_ayAWCnAjN9Tf6Re=r1Ggsg@mail.gmail.com>
 <CANoM8SWxMeDjwy-GwVc+En8D7N8LyzzsBKtX_MbiS4Z49DjD7g@mail.gmail.com>
 <564B47AC.7070609@drmicha.warpmail.net>
 <CANoM8SXrRmXPZQotQgJNNonJcb3rs5LM=JwOYoh4mX4nw2XB-g@mail.gmail.com>
 <alpine.DEB.1.00.1511181052130.1686@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Rappazzo <rappazzo@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 24 23:39:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1MFD-00068g-7k
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 23:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbbKXWjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 17:39:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:33515 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932116AbbKXWjG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 17:39:06 -0500
Received: (qmail 27841 invoked by uid 102); 24 Nov 2015 22:39:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 16:39:06 -0600
Received: (qmail 19404 invoked by uid 107); 24 Nov 2015 22:39:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 17:39:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 17:39:03 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1511181052130.1686@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281643>

On Wed, Nov 18, 2015 at 10:56:02AM +0100, Johannes Schindelin wrote:

> > For me I use this command more as a post-fetch:
> > 
> > git fetch --all --prune && git-ff-refs
> > 
> > I imagine that the big difference is in the number of branches that I
> > maintain, and perhaps in the way that I use gitk to visualize them.  I
> > would be happy to add another option to git-fetch for --ff-refs as an
> > alternative if that would feel better than a full-on builtin.
> 
> I would much prefer, say, `git fetch --all --prune
> --fast-forward-tracking-branches` (with maybe `-T` as short option for
> `--fast-forward-tracking-branches` and/or a shorter `--ff-tracking`) to a
> new builtin.

FWIW, that makes a lot more sense to me, as it would presumably touch
only branches which track whatever we just updated, and not other random
refs.

I have to admit that I'm a little wary of something like ff-refs meeting
all needs, though. I have custom scripts that match my workflow and tell
me when a branch could be updated. I could replace part of them with
"ff-refs --dry-run", but that is really not much code. Basically:

  git for-each-ref --format='%(refname) %(upstream)' refs/heads |
  while read ref upstream; do
    git merge-base --is-ancestor $ref $upstream &&
      echo "$ref can fast-forward"
  done

-Peff
