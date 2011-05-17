From: Jeff King <peff@peff.net>
Subject: Re: [BUG] rebase -p loses commits
Date: Tue, 17 May 2011 01:44:32 -0400
Message-ID: <20110517054432.GC10048@sigill.intra.peff.net>
References: <20110516103354.GA23564@sigill.intra.peff.net>
 <7vfwoel6vw.fsf@alter.siamese.dyndns.org>
 <4DD1C277.9070605@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Tue May 17 07:44:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMD5D-0005rv-R5
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 07:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673Ab1EQFof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 01:44:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50029
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221Ab1EQFoe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 01:44:34 -0400
Received: (qmail 21592 invoked by uid 107); 17 May 2011 05:46:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 May 2011 01:46:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 May 2011 01:44:32 -0400
Content-Disposition: inline
In-Reply-To: <4DD1C277.9070605@sohovfx.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173787>

On Mon, May 16, 2011 at 08:33:59PM -0400, Andrew Wong wrote:

> On 05/16/2011 04:36 PM, Junio C Hamano wrote:
> >    F---*  feature
> >   /   /
> >  B---M    master
> >
> >But what does it mean to rebase that on top of master, preserving merges
> >in the first place? You are already on top of 'master' and '*' itself
> >should be what you should get, no?  IOW, shouldn't you already be
> >up-to-date?
> Since preserve-merge uses the interactive-rebase, I think
> interactive-rebase should still pick the merge commit, which will
> then be consistent with what's happening if we rebase onto "F". So,
> without knowing whether "F" or "M" is the first-parent, I think
> interactive-rebase onto "F" and onto "M" should have the same effect.
> i.e. interactive-rebase picks the merge commit

Is it really the first-parentness here that is important to the
asymmetry? I thought it was more the fact that "feature" has the merge,
but "master" does not.

Therefore, "git rebase -p master feature" knows that there is nothing to
do; we already contain all of "master".

But "git rebase -p feature master" sees that we have an extra commit in
"feature" not in "master", and therefore we must attempt to rewrite on
top of that merge commit. Of course, when we try to do so, there are no
commits that are not already on "feature", so there is nothing to
rewrite.

So the outcomes are the same, but the reasoning is different. And isn't
that what happens with Junio's patch (I tried a simple test and it
seemed to be)?

-Peff
