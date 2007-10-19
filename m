From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing
	objects'
Date: Thu, 18 Oct 2007 22:34:25 -0400
Message-ID: <20071019023425.GB8298@coredump.intra.peff.net>
References: <20071019004527.GA12930@spearce.org> <20071019021255.GD3290@coredump.intra.peff.net> <20071019022154.GY14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 04:34:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iihh9-0001yg-Uw
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 04:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763575AbXJSCe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 22:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763538AbXJSCe2
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 22:34:28 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2206 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763569AbXJSCe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 22:34:27 -0400
Received: (qmail 7724 invoked by uid 111); 19 Oct 2007 02:34:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 22:34:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 22:34:25 -0400
Content-Disposition: inline
In-Reply-To: <20071019022154.GY14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61610>

On Thu, Oct 18, 2007 at 10:21:54PM -0400, Shawn O. Pearce wrote:

> My eyes have gotten used to "Deltifying" but I have to admit that
> in my early Git days I thought it looked damn odd.  Today I'm far
> too familiar with Git to really notice this as a problem now.

OK, I will confess I found it a little odd at first, but I think it's a
straightforward and playful extension of the language, which is
something I like. But you know, we have the corporate git customers to
think about these days. ;)

> I really don't have an opinion either way.  Actually I think the
> entire progress system of git-pack-objects should be reduced even
> further so that users aren't exposed to the internal phases we
> are going through.  Most of them just don't care.  They just
> want to know when its going to be done[*1*].

On a similar note, some complaints with progress meters, even after
recent patches:
  - When fetching, one progress meter says "Indexing" which, while
    technically true, is almost certainly blocking on "Downloading". In
    fact, it is not clear from the existing messages exactly _when_ we
    are downloading, and when we are just computing, which is something
    I think a user might want to know. Objections to changing this
    (though perhaps index-pack will need to be told when it is
    downloading and when it is just indexing)? Objections to a
    throughput indicator?
  - Running git-gc, we now get something like:
      Counting objects: 62317, done.
      Deltifying objects: 100% (18042/18042), done.
      Writing objects: 100% (62317/62317), done.
      Total 62317 (delta 43861), reused 61404 (delta 43036)
      Pack pack-32f8ac40c1a5ec146e45c657cb16f53fdd354095 created.
      Removing unused objects 100%...
      Done.
    Can we get rid of total statistics (I think this is useful for some
    power users, but perhaps there should be a verbosity level), the
    name of the pack file (same deal), and the totally useless "Done."?

-Peff
