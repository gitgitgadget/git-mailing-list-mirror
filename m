From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Add a 'source' decorator for commits
Date: Tue, 28 Oct 2008 15:46:43 -0400
Message-ID: <20081028194642.GB752@sigill.intra.peff.net>
References: <alpine.LFD.2.00.0810271256470.3386@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810271305500.3386@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810271306230.3386@nehalem.linux-foundation.org> <20081028054539.GA23195@sigill.intra.peff.net> <20081028131116.GA8272@artemis.googlewifi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Oct 28 20:48:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuuXs-00075Z-Tw
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 20:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbYJ1Tqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 15:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752434AbYJ1Tqv
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 15:46:51 -0400
Received: from peff.net ([208.65.91.99]:1922 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355AbYJ1Tqu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 15:46:50 -0400
Received: (qmail 23242 invoked by uid 111); 28 Oct 2008 19:46:48 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 28 Oct 2008 15:46:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Oct 2008 15:46:43 -0400
Content-Disposition: inline
In-Reply-To: <20081028131116.GA8272@artemis.googlewifi.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99317>

On Tue, Oct 28, 2008 at 02:11:16PM +0100, Pierre Habouzit wrote:

> Actually I tried to do that (and you meant name-rev --contains rather
> than describe actually ;p), and I stopped because it's too slow. I

I think we are both wrong, since it's "git describe --contains". ;)
But yes, that was what I meant.

> believe the proper way to do that is to help git-log knowing which are
> the short (topic) branches, and to crawl incrementally using a
> date-based hack. This would basically work a bit like this. Let's
> imaging you want to crawl "next" in git and know which topics from pu
> are in it. You would say e.g.:

Hmm. Why a date-based hack to see what's on the topic branch? Why not
just give an option to walk the graph twice, giving name-rev style
annotations, and just let it be slow. People will mostly look at it by
specifying just their topic branches anyway. IOW:

  git log ^origin/master my/topic1 my/topic2 my/topic3

and by virtue of the fact that you are vastly limiting the size of the
tree, it won't actually end up too slow. So you haven't said so much
"these are my topic branches" as "I am just not interested in things
that are already upstream."

Or maybe I'm misunderstanding something here:

> Then one has to know which are the heads of every topic branches first,
> then crawl next the usual way, except that when you arrive to a point
> that is a topic branch head, you don't look that way. You remember the
> date of that point, and continue to crawl "next" a bit further so that
> you can start annotating the topic's commits you've stumbled upon. And
> you do that, you look at jd/topic (as in John Doe topic branch) and mark
> all the commits as being from jd/topic, until you either go back to some
> commit from next, or your current commit date is younger than your
> current "next" crawling front. In the former case, you're done with that
> topic, in the latter you must continue to preprocess "next" a bit more.

When you say "heads of topic branches" do you mean we actually have the
topic branches? Or do you mean you want to crawl next, pulling the names
of the topic branches from the merge messages?

-Peff
