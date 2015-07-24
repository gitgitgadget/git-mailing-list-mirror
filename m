From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] log: add log.firstparent option
Date: Fri, 24 Jul 2015 11:13:22 -0700
Message-ID: <20150724181322.GB17730@peff.net>
References: <20150723012343.GA21000@peff.net>
 <xmqqpp3io5km.fsf@gitster.dls.corp.google.com>
 <CA+P7+xoOkTfair3M7HH_TPs9qxBAUR5GodHGDuw8Ux_HaUvvyQ@mail.gmail.com>
 <20150724073415.GD2111@peff.net>
 <xmqqd1zhoave.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org,
	Josh Bleecher Snyder <josharian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 20:13:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIhTO-0002Zo-Us
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 20:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbbGXSN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 14:13:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:34620 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752203AbbGXSNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 14:13:25 -0400
Received: (qmail 9907 invoked by uid 102); 24 Jul 2015 18:13:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jul 2015 13:13:25 -0500
Received: (qmail 22120 invoked by uid 107); 24 Jul 2015 18:13:30 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jul 2015 14:13:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jul 2015 11:13:22 -0700
Content-Disposition: inline
In-Reply-To: <xmqqd1zhoave.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274578>

On Fri, Jul 24, 2015 at 08:04:21AM -0700, Junio C Hamano wrote:

> > I think a really simple example is something like:
> >
> >   1. somebody implements as feature. It needs to handle cases a, b, and
> >      c, but it only handles case a. Therefore it is buggy.
> >
> >   2. During review, somebody notices case b, and a new commit is made to
> >      fix it. Nobody notices case c.
> >
> >   3. The topic is merged.
> >
> >   4. Much later, somebody notices the system is buggy and hunts in the
> >      history.
> [...]
> 
> I actually do not think the above is quite true.  In our kind of
> "clean history, we do not squash 1 & 2.  See Paul's "rewrite am in
> C" series, for example, that starts from a "buggy" (in the sense
> that it does almost nothing in the beginning and then gradually
> builds on).
> 
> Instead, even somebody did not have foresight to realize 'b' when
> she adds code to handle 'a', we would make sure the solution for 'a'
> is sufficiently clearly described in commit #1.

Sometimes. There's definitely human wisdom going into the decision to
squash or make a new commit, which is a good thing. Here's a
counter-example to the am series. When I wrote the object-freshening
code, I accidentally inverted the test for checking whether packs were
fresh. This was noticed in review, and I corrected it by inverting the
is_fresh function. But in doing so, I introduced a new bug, where the
test for loose objects was inverted.

The original fix was squashed in the re-roll, but much later we noticed
and diagnosed that new bug. It was very valuable to me to read the
mailing list archive to see what happened, because the fact that there
_was_ a bug fix was lost in the clean history.

-Peff
