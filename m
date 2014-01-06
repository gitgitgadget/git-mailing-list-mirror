From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Mon, 6 Jan 2014 15:55:26 -0500
Message-ID: <20140106205526.GC643@sigill.intra.peff.net>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
 <1389028732-27760-3-git-send-email-artagnon@gmail.com>
 <xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
 <CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
 <xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
 <20140106201854.GA28162@sigill.intra.peff.net>
 <xmqq1u0kj16h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 21:55:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0HCv-0006YY-1w
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 21:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755479AbaAFUz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 15:55:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:56104 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754645AbaAFUz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 15:55:28 -0500
Received: (qmail 17745 invoked by uid 102); 6 Jan 2014 20:55:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Jan 2014 14:55:28 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Jan 2014 15:55:26 -0500
Content-Disposition: inline
In-Reply-To: <xmqq1u0kj16h.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240063>

On Mon, Jan 06, 2014 at 12:38:30PM -0800, Junio C Hamano wrote:

> > I wonder if it is too late to try to clarify this dual usage. It kind of
> > seems like the push config is "this is the place I publish to". Which,
> > in many workflows, just so happens to be the exact same as the place you
> > forked from. Could we introduce a new branch.*.pushupstream variable
> > that falls back to branch.*.merge? Or is that just throwing more fuel on
> > the fire (more sand in the pit in my analogy, I guess).
> >
> > I admit I haven't thought it through yet, though. And even if it does
> > work, it may throw a slight monkey wrench in the proposed push.default
> > transition.
> 
> Yeah, when I say "upstream", I never mean it as "where I publish".
> Your upstream is where you get others' work from.

That's my thinking, as well, but it means the "upstream" push.default is
nonsensical. I've thought that all along, but it seems like other people
find it useful. I guess because they are in a non-triangular,
non-feature-branch setup (I suppose you could think of a central-repo
feature-branch workflow as a special form of triangular setup, where
the remote is bi-directional, but the branch names are triangular).

If we want to declare "push -u" and "push.default=upstream" as tools for
certain simple bi-directional workflows, that makes sense. But I suspect
it may cause extra confusion when people make the jump to using a
triangular workflow.

> For a "push to somewhere for safekeeping or other people to look at"
> triangular workflow, it does not make any sense to treat that "I
> publish there" place as an upstream (hence having branch.*.remote
> pointing at that publishing point).

You _might_ treat it the same way we treat the upstream, in some special
cases. For example, when you say "git status", it is useful to see how
your topic and the upstream have progressed (i.e., do I need to pull
from upstream?). But you may _also_ want to know how your local branch
differs from its pushed counterpart (i.e., do I have unsaved commits
here that I want to push up?).

So having two config options might help with that. Of course, your "push
upstream" (or whatever you want to call it) does not logically have one
value. You may push to several places, and would want to compare to
each.

> Once you stop doing that, and
> instead using branch.*.remote = origin, and branch.*.merge = master,
> where 'origin' is not your publishing point, @{u} will again start
> making sense, I think.
> 
> And I thought that is what setting "remote.pushdefault" to the
> publishing point repository was about.

If that were sufficient, then we would just need "push.default =
current", and not "upstream" (nor "simple"). I lobbied for that during
the discussion, but people seemed to think that "upstream" was
better/more useful. Maybe it was just because remote.pushdefault did not
exist then.

-Peff
