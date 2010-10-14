From: Jeff King <peff@peff.net>
Subject: Re: false positives from git diff-index when used with --git-dir
Date: Thu, 14 Oct 2010 13:02:28 -0400
Message-ID: <20101014170227.GA14429@sigill.intra.peff.net>
References: <AANLkTimyeE=OLdC0Zzdnidr_dssFfkMzS+r_39dYUVxz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 19:02:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6RC0-0003IG-Q5
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 19:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755615Ab0JNRCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 13:02:05 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:46123 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752342Ab0JNRCE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 13:02:04 -0400
Received: (qmail 9532 invoked by uid 111); 14 Oct 2010 17:02:02 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 14 Oct 2010 17:02:02 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Oct 2010 13:02:28 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimyeE=OLdC0Zzdnidr_dssFfkMzS+r_39dYUVxz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159057>

On Thu, Oct 14, 2010 at 06:40:51PM +0400, Alexander Gladysh wrote:

> I'm *sometimes* (once in about ten times I use it -- repository
> changes between invocations of course) getting false positives from
> git diff-index when I invoke git from another directory:
> 
> git --git-dir=path/to/.git --work-tree=path/to update-index -q --refresh
> git --git-dir=path/to/.git --work-tree=path/to diff-index --exit-code
> --quiet HEAD
> 
> This is *really* annoying and really kills the benifits from my
> workflow automation scripts.
> 
> Unfortunately I can't find a reproducible use case for this bug.
> 
> Is there anything I can do to help catch it?

Can it reproduce over a large number of trials? I.e., something like:

  while true; do
    git ... update-index ...
    git ... diff-index ... || echo failed
  done

If so, try adding a "sleep 1" between the two commands. If that fixes
it, it implies a race condition in git.

You could also try running under valgrind to see if there are any bad
memory accesses, which could also produce intermittent buggy behavior.

-Peff
