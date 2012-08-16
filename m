From: Jeff King <peff@peff.net>
Subject: Re: Your branch and 'origin/master' have diverged
Date: Thu, 16 Aug 2012 12:24:18 -0400
Message-ID: <20120816162417.GD2853@sigill.intra.peff.net>
References: <CAE1pOi1WTbMSK8dOus6pFCa2C9vGA8QNE3+8w0LFmGkvcfq5fg@mail.gmail.com>
 <87zk5x6fox.fsf@thomas.inf.ethz.ch>
 <CAE1pOi1YFe9GB1L_==RTecEAipdTKj2-ixpwTnrmOgkkV8rkYw@mail.gmail.com>
 <7v628lbdcw.fsf@alter.siamese.dyndns.org>
 <CAE1pOi2DZNkYYwkH1MFh0m708T=DEdJawZCQgvk1HTGrqjkz2w@mail.gmail.com>
 <87lihh8c7s.fsf@thomas.inf.ethz.ch>
 <7vr4r98ah5.fsf@alter.siamese.dyndns.org>
 <87sjbo63pl.fsf@thomas.inf.ethz.ch>
 <7vfw7o6p1g.fsf@alter.siamese.dyndns.org>
 <7va9xw55aj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 18:24:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T22s9-0008DG-Ct
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 18:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932944Ab2HPQYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 12:24:24 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39228 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932897Ab2HPQYV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 12:24:21 -0400
Received: (qmail 18613 invoked by uid 107); 16 Aug 2012 16:24:31 -0000
Received: from 1153ahost247.starwoodbroadband.com (HELO sigill.intra.peff.net) (12.144.188.247)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Aug 2012 12:24:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Aug 2012 12:24:18 -0400
Content-Disposition: inline
In-Reply-To: <7va9xw55aj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2012 at 12:22:28PM -0700, Junio C Hamano wrote:

> > The updated rule would be more complex.  If a remote nickname is
> > used, and a refspec given from the command line is without colon, a
> > new special rule overrides the current behaviour and tries to match
> > with a configured refspec.  You would need to desribe what happens
> > in that case.
> 
> It would be something like this.
> 
> When you tell "git fetch" to fetch one or more refs from a
> configured remote by explicitly listing them on the command line,
> e.g.
> 
>     git fetch <remote> <name>...
> 
> each <name>... goes through the following process:
> 
>     - The <name> is turned into the full ref at the remote that
>       starts from refs/ form by applying the usual fetch dwimmery
>       (if <name> is a name of a branch, "refs/heads/<name>" would
>       likely to be the one that is fetched).
> 
>     - Then, configured fetch refspecs for <remote> is looked up from
>       remote.<remote>.fetch configuration variable(s), or "Pull: "
>       line(s) of .git/remotes/<remote> file.
> 
>     - If the LHS of a refspec found in the previous step matches the
>       full ref we computed in the first step, then the ref at the
>       RHS of the refspec (i.e. remote tracking branch), if any, is
>       updated.
> 
> If there is no configured refspecs that match the name given from
> the command line, no remote tracking ref is updated.

That is almost exactly what my patch does, except I am not sure that it
respects the "without a colon" bit from your first message. In other
words, any time it sees that we have fetched a ref from a particular
remote, it applies the mapping from the config and adds the result to
the list of refs to be updated.

-Peff
