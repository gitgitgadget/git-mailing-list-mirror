From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] add basic branch display tests
Date: Wed, 18 Feb 2009 22:45:04 -0500
Message-ID: <20090219034504.GA19862@coredump.intra.peff.net>
References: <20090219033329.GA13666@coredump.intra.peff.net> <20090219033444.GA18970@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 04:46:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZzry-0003QI-NL
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 04:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbZBSDpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 22:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbZBSDpI
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 22:45:08 -0500
Received: from peff.net ([208.65.91.99]:38323 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078AbZBSDpH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 22:45:07 -0500
Received: (qmail 19093 invoked by uid 107); 19 Feb 2009 03:45:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 18 Feb 2009 22:45:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2009 22:45:04 -0500
Content-Disposition: inline
In-Reply-To: <20090219033444.GA18970@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110616>

On Wed, Feb 18, 2009 at 10:34:44PM -0500, Jeff King wrote:

> We were not testing the output of "git branch" anywhere.

There is one thing that occurred to me while writing these tests that I
wanted to mention.

When we show a remote symref with "git branch -r", it looks like this:

> +cat >expect <<'EOF'
> +  origin/HEAD -> origin/branch-one
> +  origin/branch-one
> +  origin/branch-two
> +EOF
> +test_expect_success 'git branch -r shows remote branches' '
> +	git branch -r >actual &&
> +	test_cmp expect actual
> +'

which makes sense. <remote>/<symref> -> <remote>/<branch>

> +cat >expect <<'EOF'
> +  branch-one
> +  branch-two
> +* master
> +  remotes/origin/HEAD -> origin/branch-one
> +  remotes/origin/branch-one
> +  remotes/origin/branch-two
> +EOF
> +test_expect_success 'git branch -a shows local and remote branches' '
> +	git branch -a >actual &&
> +	test_cmp expect actual
> +'

But here we stick the "remotes/" head on, since we are showing both
types. But the right hand side of the symref doesn't get the same
treatment.

I don't think it's a big deal, but I wasn't sure if it was intentional,
a bug, or simply that nobody cares (and since I have now codified it in
a test script, it seems like we should make sure it is intentional).

I also had a brief thought that reprinting the <remote> is pointless.
That is, printing

  origin/HEAD -> master

shows what is happening with less text due to the context (i.e., we
already know we are talking about remote "origin" -- and if it isn't in
origin, we already show more). But that is probably a bad idea; that
context is missing if you were to try to do something like "git show";
<remote>/<branch> would work, but <branch> wouldn't.

-Peff
