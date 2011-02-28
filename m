From: Jeff King <peff@peff.net>
Subject: Re: remote's HEAD not detected correctly
Date: Mon, 28 Feb 2011 16:42:07 -0500
Message-ID: <20110228214207.GA5854@sigill.intra.peff.net>
References: <AANLkTimWieViK4JcJQuTDiRiAdyvHuwkwy8fL+XUV+i-@mail.gmail.com>
 <AANLkTimqTa24QSWACFX9GErt-Tn+wLda1s_AvH7dzEpm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeffrey Middleton <jefromi@gmail.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 28 22:42:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuAr8-0003zH-1U
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 22:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165Ab1B1VmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 16:42:07 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:37413 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752948Ab1B1VmG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 16:42:06 -0500
Received: (qmail 28829 invoked by uid 111); 28 Feb 2011 21:42:06 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 28 Feb 2011 21:42:06 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Feb 2011 16:42:07 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimqTa24QSWACFX9GErt-Tn+wLda1s_AvH7dzEpm@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168151>

On Mon, Feb 28, 2011 at 01:01:08PM -0800, Shawn O. Pearce wrote:

> On Mon, Feb 28, 2011 at 12:52, Jeffrey Middleton <jefromi@gmail.com> wrote:
> >
> > So somehow, the clone misses the fact that origin's HEAD is pu, not
> > master, and git remote is only partially aware of this. It looks like
> > this only happens when the two branches in question are pointing to
> > the same commit; perhaps git is trying to guess what HEAD is via the
> > SHA1? I know that ls-remote prints an SHA1, not a refname, for HEAD -
> > is it not actually possible to get that information through a general
> > transport protocol?
> 
> Right. The transport protocol doesn't expose the name that a symbolic
> reference points to, only its current value. Thus clients are forced
> to guess by looking for another reference whose current SHA-1 is the
> same. If there is more than one, its taking a best guess.
> 
> There have been a few attempts to expand the protocol and include the
> current symbolic reference target name, but thus far it hasn't gotten
> much beyond the idea stage.

It depends on the transport protocol. It actually works over dumb http,
though I suspect that is not getting used much these days. I also
implemented a quick-and-dirty patch for local repositories here:

  http://article.gmane.org/gmane.comp.version-control.git/110049

which would make Jeffrey's test pass, but I have a feeling it was just a
simple test case and that he actually cares about real remotes.

-Peff

PS I think the "send-HEAD-explicitly" patch series was here:

     http://thread.gmane.org/gmane.comp.version-control.git/102039

   I had some complaints at the time, but re-reading it I don't see
   anything that would prevent us from revisiting the topic now.
