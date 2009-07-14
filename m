From: Jeff King <peff@peff.net>
Subject: Re: [commit 4ecbc178704] Incosistency?
Date: Tue, 14 Jul 2009 17:48:52 -0400
Message-ID: <20090714214852.GA2786@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0907142335210.31779@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Unknown <borg@uu3.net>
X-From: git-owner@vger.kernel.org Tue Jul 14 23:49:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQps0-0006nu-AX
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 23:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755595AbZGNVs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 17:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755298AbZGNVs4
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 17:48:56 -0400
Received: from peff.net ([208.65.91.99]:43195 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754824AbZGNVsz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 17:48:55 -0400
Received: (qmail 9007 invoked by uid 107); 14 Jul 2009 21:50:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 14 Jul 2009 17:50:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jul 2009 17:48:52 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0907142335210.31779@cube>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123273>

On Tue, Jul 14, 2009 at 11:41:40PM +0200, Unknown wrote:

> commit 4ecbc178704ca6c1027a38483e98f5fe493b1322
> Author: Jeff King <peff@peff.net>
> Date:   Thu Jul 9 02:37:35 2009 -0400
> 
> bla bla.. some strange SUDO fix (who the hell uses git that way?)
> I dont like it.. git-add in libexecdir was good!

Hmm. I think I wrote a better commit message than that...

> -       { for p in $(filter-out git-add$X,$(BUILT_INS)); do \
> +               ln "$$bindir/git$X" "$$execdir/git$X" 2>/dev/null || \
> +               cp "$$bindir/git$X" "$$execdir/git$X"; } && \
> +       { for p in $(BUILT_INS); do \
>                 $(RM) "$$execdir/$$p" && \
> -               ln "$$execdir/git-add$X" "$$execdir/$$p" 2>/dev/null || \
> -               ln -s "git-add$X" "$$execdir/$$p" 2>/dev/null || \
> -               cp "$$execdir/git-add$X" "$$execdir/$$p" || exit; \
> +               ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
> +               ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
> +               cp "$$execdir/git$X" "$$execdir/$$p" || exit; \
>           done; } && \
>         ./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
> 
> Isnt check_bindir is broken now?
> git-add is no more..

No. Two things you are missing:

  1. "git-add" still goes in exec-dir. It's just not the magic one we do
     separately (see how we no longer need to use filter-out?).

  2. check_bindir is actually about looking for dashed-form commands in
     the $bindir, which would indicate cruft from an older installed
     version of git. We can't use "git" for this, because that is the
     command that is _supposed_ to be in $bindir.

-Peff
