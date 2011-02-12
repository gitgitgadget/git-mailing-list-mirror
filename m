From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-gui: give more advice when detaching HEAD
Date: Sat, 12 Feb 2011 03:04:57 -0500
Message-ID: <20110212080456.GA18380@sigill.intra.peff.net>
References: <20110212070538.GA2459@sigill.intra.peff.net>
 <7v8vxlzojs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 09:05:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoATS-0007JH-E2
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 09:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab1BLIEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 03:04:53 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:43106 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720Ab1BLIEv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 03:04:51 -0500
Received: (qmail 32762 invoked by uid 111); 12 Feb 2011 08:04:48 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 12 Feb 2011 08:04:48 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Feb 2011 03:04:57 -0500
Content-Disposition: inline
In-Reply-To: <7v8vxlzojs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166598>

On Fri, Feb 11, 2011 at 11:42:47PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   2. When leaving the detached state, notice that we have commits not
> >      contained in any other ref and pop up an "are you sure you want to
> >      lose these commits" dialog, with an option to create a branch. This
> >      is something we considered and rejected for the CLI, but I wonder
> >      if it makes more sense for git-gui.
> 
> Hmm, I don't recall the discussion on this for the CLI, but it intuitively
> feels like a good thing to do, unless it incurs an unacceptable cost.

I think one of the main concerns was cost, but I'm having trouble coming
up with the exact thread that I recall.

There is some discussion here, including Linus endorsing an exact-ref
check:

  http://article.gmane.org/gmane.comp.version-control.git/36428

There is a lot of back and forth, but I didn't have the patience to read
it all.

There is also this thread:

  http://thread.gmane.org/gmane.comp.version-control.git/94695

where one of the arguments against a leaving-detached safety valve seems
to be "well, we reflog the HEAD these days, so it's no big deal" (and
indeed, in this confused user case, the reflog did end up being the
recovery method).

I have a feeling there is another thread somewhere, but I can't find it.

> Temporarily detaching HEAD by scripts like rebase and am that know what
> they are doing should never have to pay the penalty, but an expert user
> who worked interactively on the detached HEAD can be made to wait for 0.2
> second more.

Is it that cheap? A full reachability check for something that is not in
any ref would involve going to the roots, wouldn't it? On linux-2.6,
that is something like 3s on my fast-ish machine. Though I guess using
commit-time cutoffs could make it really short (which reminds me, I
really need to clean up and post my patches to deal with clock skew).

> Your 1 and 3 both sound like sensible things to do, but I am not a good
> judge on them as I rarely if ever work in GUI.

That's kind of how I feel. I've never actually used git-gui beyond
trying to help users.

-Peff
