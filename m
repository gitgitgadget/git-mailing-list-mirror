From: Jeff King <peff@peff.net>
Subject: Re: rebase --continue confusion
Date: Sun, 6 Jun 2010 18:46:01 -0400
Message-ID: <20100606224601.GB11424@coredump.intra.peff.net>
References: <4C01B855.7080409@gmail.com>
 <m3bpbo1f3f.fsf@winooski.ccs.neu.edu>
 <20100606221853.GG6993@coredump.intra.peff.net>
 <19468.8730.59682.76355@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Mon Jun 07 00:54:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLOk1-0000Vd-SG
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 00:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567Ab0FFWqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 18:46:08 -0400
Received: from peff.net ([208.65.91.99]:47499 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997Ab0FFWqG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 18:46:06 -0400
Received: (qmail 13967 invoked by uid 107); 6 Jun 2010 22:46:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 06 Jun 2010 18:46:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jun 2010 18:46:01 -0400
Content-Disposition: inline
In-Reply-To: <19468.8730.59682.76355@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148561>

On Sun, Jun 06, 2010 at 06:32:58PM -0400, Eli Barzilay wrote:

> > >   $ git add foo
> > >   $ git status -s
> > >   M  foo
> > >   $ git commit --amend foo
> > >   # On branch master
> > >   # No changes
> > >   $ git status -s
> > >   M  foo
> > 
> > I'm confused. Is there some context for when you are issuing these
> > commands?  Because the "git commit --amend foo" should actually
> > commit foo, and does for me.
> 
> Heh, in that case it was more effective than I thought...  My point in
> the previous posts was also about missing information (in that case,
> make `git add' tell you when adding it canceled previously added
> changes, and also make `git status' tell you if you're in the middle
> of a merge or rebase and in a clean state).
> 
> In any case, here's the prelude to the above:
> 
>   $ mkdir t; cd t; git init
>   $ echo foo > foo; git add foo; git commit -m foo
>   $ echo bar > foo; git commit -o foo -m bar
>   $ echo foo > foo

Ah, I see. Your problem has nothing to do with explicit pathnames (which
I thought was the interesting bit from your snippet), but rather that
you are amending it to the same as HEAD^.

Probably it would be helpful in the case of an amend to indicate what
has happened (you have no changes, but it is not immediately obvious
that you have no changes against HEAD^, not HEAD). We could even
suggest "git reset HEAD^", which is probably what you want (the only
other thing you could want is to create a commit with no changes, which
we generally try to avoid).

-Peff
