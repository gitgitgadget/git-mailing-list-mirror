From: Jeff King <peff@peff.net>
Subject: Re: Portability of git shell scripts?
Date: Wed, 4 May 2016 17:20:28 -0400
Message-ID: <20160504212028.GG21259@sigill.intra.peff.net>
References: <CALR6jEh5dAcnqiyo4kXkj+8imfQQd0nT=baPOW_qbJpJwmFsyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Armin Kunaschik <megabreit@googlemail.com>
X-From: git-owner@vger.kernel.org Wed May 04 23:20:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay4Dl-0006yx-NE
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 23:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754236AbcEDVUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 17:20:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:34234 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753028AbcEDVUb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 17:20:31 -0400
Received: (qmail 4746 invoked by uid 102); 4 May 2016 21:20:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 17:20:30 -0400
Received: (qmail 14180 invoked by uid 107); 4 May 2016 21:20:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 17:20:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 May 2016 17:20:28 -0400
Content-Disposition: inline
In-Reply-To: <CALR6jEh5dAcnqiyo4kXkj+8imfQQd0nT=baPOW_qbJpJwmFsyw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293594>

On Wed, May 04, 2016 at 08:17:38PM +0200, Armin Kunaschik wrote:

> I'm trying to compile/test/use git 2.8.2 on AIX 6.1 with no bash available.
> /bin/sh is a hard link to /bin/ksh which is a ksh88, a posix shell.
> Is this supposed to work?

We aim for a practical subset of Bourne shells, including bash, dash,
ash, ksh, etc. There's at least one Bourne-ish shell known not to work,
which is Solaris /bin/sh[1]. POSIX is usually a good guide, but we aim
for practical portability more than adhering strictly to the standards
document.

I've tested with mksh in the past (though it's possible that we've
introduced a regression since then). But I think we've run into problems
with ksh93[2]. I don't know about ksh88, or what construct it doesn't
like.  It may or may not be easy to work around.

> As an example: make test fails on nearly every t34* test and on tests
> which contain rebase.
> The installation of bash (and manually changing the shebang to
> /bin/bash) "fixes" all rebase test failures. So obviously git-rebase
> is not portable at some point.

Right. Any modern-ish Bourne shell will do, so moving to bash is one way
to fix it.

> Does it make any sense to put work into making these scripts portable,
> that is, work with posix shells?

Maybe. :) If you can find what it is that ksh88 is unhappy with, we can
see how painful it is to adapt to. But given my looking into ksh93 in
[2], I suspect it will be easier to just use a more modern shell.

> And, as last resort, is it possible to configure git use bash in some
> or all shell scripts?

You can set SHELL_PATH in your config.mak file.

-Peff

[1] Solaris /bin/sh doesn't even understand $(), so we declared it as
    hopeless long ago. I think most people just replace it with bash,
    but I suspect /usr/xpg6/bin/sh probably works, too.

[2] http://thread.gmane.org/gmane.comp.version-control.git/268657/focus=268666
