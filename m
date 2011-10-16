From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Oct 2011, #05; Fri, 14)
Date: Sun, 16 Oct 2011 13:27:06 -0400
Message-ID: <20111016172706.GA17348@sigill.intra.peff.net>
References: <7vd3dzximu.fsf@alter.siamese.dyndns.org>
 <20111016165329.GA14226@sigill.intra.peff.net>
 <7vvcrorh49.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 19:35:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFUcq-0004tY-9x
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 19:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870Ab1JPR1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 13:27:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33483
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754714Ab1JPR1I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 13:27:08 -0400
Received: (qmail 31871 invoked by uid 107); 16 Oct 2011 17:27:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 16 Oct 2011 13:27:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Oct 2011 13:27:06 -0400
Content-Disposition: inline
In-Reply-To: <7vvcrorh49.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183728>

On Sun, Oct 16, 2011 at 10:17:10AM -0700, Junio C Hamano wrote:

> >> * jk/pull-rebase-with-work-tree (2011-10-13) 1 commit
> >>  - pull,rebase: handle GIT_WORK_TREE better
> >> 
> >> Looked reasonable.
> >> Will merge to 'next'.
> >
> > I'm not so sure. Didn't you demonstrate that cd_to_toplevel as-is will
> > not actually go to the toplevel if we're outside of the work tree?
> >
> > And changing it is non-trivial, because there may be weird cases that
> > rely on staying there? See my final note in the thread:
> >
> >   http://article.gmane.org/gmane.comp.version-control.git/183519
> 
> Hmm, I might be mistaken, but my impression was that sane people do not do
> so, that the discussion that originated this proposed patch was not such a
> use case, and most importantly that fixing unsane ones is just the matter
> for them to set GIT_WORKING_TREE correctly. So if anything, wouldn't
> getting this in as early as possible to 'master' or at least 'next' help
> catching a flaw in the above logic and possible downside in the real
> world?

Hmm. I thought there were two separate problems:

  1. my analysis was wrong, and "git rev-parse --show-toplevel" did not
     actually show the root of the work tree when we were outside it
     (and therefore cd_to_toplevel did not actually go anywhere)

  2. some people might be outside of the work tree, set GIT_DIR
     explicitly, but not bother setting GIT_WORK_TREE

But I was wrong on (1). If GIT_WORK_TREE is set, we _will_ actually go
to its work tree, which is what we want. If it's not set, then we go
nowhere, and assume the cwd is the work tree. Which is compatible with
current behavior, and makes (2) still work.

So I was thinking there was more problem then there is. I agree we
should let it go to 'next' to shake out any bugs.

Sorry for the noise.

-Peff
