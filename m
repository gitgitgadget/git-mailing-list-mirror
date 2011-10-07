From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] show git tag output in pager
Date: Fri, 7 Oct 2011 12:16:48 -0400
Message-ID: <20111007161648.GA4399@sigill.intra.peff.net>
References: <20110927134235.GA27478@zelva.suse.cz>
 <vpqehz2cbk4.fsf@bauges.imag.fr>
 <20110929093749.GB27152@zelva.suse.cz>
 <20110930104241.GB24507@sigill.intra.peff.net>
 <vpqwrcmw7ve.fsf@bauges.imag.fr>
 <20111007144438.GA30318@sigill.intra.peff.net>
 <vpqsjn4dfi4.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michal Vyskocil <mvyskocil@suse.cz>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Oct 07 18:16:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCD6X-0003dL-Jg
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 18:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332Ab1JGQQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 12:16:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54982
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203Ab1JGQQw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 12:16:52 -0400
Received: (qmail 23346 invoked by uid 107); 7 Oct 2011 16:16:53 -0000
Received: from 208.177.47.101.ptr.us.xo.net (HELO sigill.intra.peff.net) (208.177.47.101)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 07 Oct 2011 12:16:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Oct 2011 12:16:48 -0400
Content-Disposition: inline
In-Reply-To: <vpqsjn4dfi4.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183083>

On Fri, Oct 07, 2011 at 04:48:35PM +0200, Matthieu Moy wrote:

> > On Mon, Oct 03, 2011 at 02:57:09PM +0200, Matthieu Moy wrote:
> >
> >> I like the try_subcommand_pager idea. Ideally, there would also be a
> >> nice mechanism to set defaults for subcommands, so that "git tag
> >> <whatever>" does the right thing without configuration.
> >
> > That's easy enough. Something like the patch below?
> 
> It may have been better with a big centralized array of configurations
> like
> 
> 	static struct cmd_struct commands[] = {
> 		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
>                 ...
> 
> in git.c, but if we have only a few instances of this, your system is
> probably fine. I like it.

I don't think you can centralize it in the same way, because some of it
will have to be implemented in shell script (unlike the full-command
ones, which we can always trigger at the git.c wrapper layer).

So you could have:

  static struct pager_default subcommands[] = {
          { "tag.list", 1 },
          { "branch.list", 1 },
  };

but you'll never be able to put "stash.list" into that structure (and as
you probably guessed, my patch isn't enough to implement stash.list,
either; it would need a shell implementation of try_subcommand_pager).

-Peff
