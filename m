From: Jeff King <peff@peff.net>
Subject: Re: Confusing git pull error message
Date: Mon, 5 Oct 2009 15:12:57 -0400
Message-ID: <20091005191257.GA24305@coredump.intra.peff.net>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
 <20090912211119.GA30966@coredump.intra.peff.net>
 <7v1vmar353.fsf@alter.siamese.dyndns.org>
 <4AC9D952.3050108@viscovery.net>
 <20091005115308.GA2122@coredump.intra.peff.net>
 <7vljjpacax.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 21:18:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mut59-0001Ef-Cd
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 21:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbZJETNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 15:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753643AbZJETNn
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 15:13:43 -0400
Received: from peff.net ([208.65.91.99]:43039 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753519AbZJETNm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 15:13:42 -0400
Received: (qmail 19530 invoked by uid 107); 5 Oct 2009 19:16:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 05 Oct 2009 15:16:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Oct 2009 15:12:57 -0400
Content-Disposition: inline
In-Reply-To: <7vljjpacax.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129579>

On Mon, Oct 05, 2009 at 12:08:38PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So I think we need something like this. I wasn't able to figure out a
> > test case to trigger the first code path below, though. It may not be
> > possible; if we give a refspec on the command line, either it will be a
> > candidate for merging or, if it does not exist, fetch will barf. So it
> > may be that we can just collapse it down to a single case.
> 
> I think you are right.

Nope, I'm not. I figured out one more case that it needs to handle.
Revised patch coming up in a few minutes.

> By the way, I think the other case arms in the case statement that has the
> sole caller of this function are never reached, no?
> 
> Back when you added the check in a74b170 (git-pull: disallow implicit
> merging to detached HEAD, 2007-01-15), $? referred to the error status of
> reading HEAD as a symbolic-ref so the check did make sense, but cd67e4d
> (Teach 'git pull' about --rebase, 2007-11-28) made a stupid mistake that
> nobody noticed.

Hmm. I'm not sure. I don't see how $? could not be zero, though, because
the last thing we run is a subshell with sed and tr. But beyond that, we
actually handle the detached case in error_on_no_merge_candidates
already. So I think that case statement can simply be collapsed to the
first case.

-Peff
