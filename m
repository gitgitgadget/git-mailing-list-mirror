From: Jeff King <peff@peff.net>
Subject: Re: Pull is Mostly Evil
Date: Fri, 2 May 2014 17:48:17 -0400
Message-ID: <20140502214817.GA10801@sigill.intra.peff.net>
References: <5363BB9F.40102@xiplink.com>
 <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
 <5363edc954f8e_70ef0f30c24@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 23:48:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgLJg-00060L-4o
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 23:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbaEBVsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 17:48:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:43876 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751501AbaEBVsT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 17:48:19 -0400
Received: (qmail 26268 invoked by uid 102); 2 May 2014 21:48:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 May 2014 16:48:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 May 2014 17:48:17 -0400
Content-Disposition: inline
In-Reply-To: <5363edc954f8e_70ef0f30c24@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247987>

On Fri, May 02, 2014 at 02:11:05PM -0500, Felipe Contreras wrote:

> Junio C Hamano wrote:
> > If we step back a bit, because we are forcing him to differentiate
> > these two pulls in his mental model anyway, perhaps it may help
> > people (both new and old) if we had a new command to make the
> > distinction stand out more.  What if the command sequence were like
> > this instead?
> > 
> >     $ git checkout maint
> >     $ git update [ origin maint ]
> > 
> >     $ git pull [--no-ff] developer-remote topic-branch
> >     $ git push [ origin maint ]
> > 
> > where the new command 'update' enforces the '--ff-only' update.  And
> > then we would stop telling "'git pull' first" when a push does not
> > fast-forward.
> 
> In addition to barf when it's not a fast-forward, such command can
> switch the parents, so it appears 'maint' was merged to 'origin/maint'.
> Many people have complained about this order.

I realize this has veered off into talking about an "update" command,
and not necessarily "pull", but since there a lot of proposals floating
around, I wanted to make one point: if we are going to do such a switch,
let's please make it something the user explicitly turns on.

One common workflow for GitHub users is to back-merge master into a
topic, because they want the final "integrated" version on the topic
branch. That lets it get review, run tests, and even get test-deployed
from there before merging to master (and then when it does merge to
master, we know the result will be a trivial merge).  This workflow
helps spread out the load (there is no central "integration" person or
script, and the merge itself becomes a possible part of the review/test
cycle).  Some projects will do this by rebasing the topic, but that has
its own complications (like making collaboration harder because the
commits are being frequently rewritten).

Such users are going to run "git pull origin master" or just "git pull"
to get that merge. A switch to disallowing non-ff is going to disrupt
that workflow.  I think we can live with that, as they should be able to
stop and say "no, my workflow wants these merges", set a config
variable, and be done.

But I think that is the same moment they should probably be deciding on
whether their workflow wants "regular" or "reverse" merges. And I do not
think the decision between the two has an obvious split over which is
better. So it makes sense to me to take the opportunity when the user is
thinking about their workflow to have them specify one or the other.

-Peff
