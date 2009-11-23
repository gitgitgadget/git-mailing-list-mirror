From: Jeff King <peff@peff.net>
Subject: Re: how to suppress progress percentage in git-push
Date: Mon, 23 Nov 2009 14:28:48 -0500
Message-ID: <20091123192848.GB1607@coredump.intra.peff.net>
References: <20091122145352.GA3941@debian.b2j>
 <20091123145959.GA13138@sigill.intra.peff.net>
 <20091123155043.GA28963@machine.or.cz>
 <20091123164319.GA23011@sigill.intra.peff.net>
 <20091123170547.GC26996@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: bill lam <cbill.lam@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
	git <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Nov 23 20:28:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCeam-0002Q3-DD
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 20:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499AbZKWT2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 14:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753990AbZKWT2o
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 14:28:44 -0500
Received: from peff.net ([208.65.91.99]:53023 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501AbZKWT2n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 14:28:43 -0500
Received: (qmail 4350 invoked by uid 107); 23 Nov 2009 19:33:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 23 Nov 2009 14:33:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Nov 2009 14:28:48 -0500
Content-Disposition: inline
In-Reply-To: <20091123170547.GC26996@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133527>

On Mon, Nov 23, 2009 at 06:05:47PM +0100, Petr Baudis wrote:

> > You wouldn't need to do anything that drastic. You would just need to
> > pass "--progress --all-progress" instead of only --all-progress. But you
> > have provided the data point that such a change would break at least one
> > user.
> > 
> > We could also leave --all-progress as-is and add new option to mean "if
> > you are already doing progress, do all progress".
> 
> Hmm, maybe I'm confused - I just call
> 
> 	git remote update
> 
> and don't pass any progress switches - would your change still affect
> me? Can I pass --progress to `git remote update`?

Oh, I misunderstood; I thought you were calling pack-objects directly.
So you are actually relying on the "even though isatty(2) is not true,
we always print progress messages" behavior? I think that behavior is
buggy. It hurts everybody pushing via cron, and it violates the usual
rule for when we show progress messages.

I don't think you can get a --progress pushed all the way down to the
pack-objects in this case; we would need to add code to override the
isatty check.

That being said, your example of "remote update" means you are dealing
with fetch, and we are not touching the fetch code path at all.

-Peff
