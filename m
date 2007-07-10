From: Jeff King <peff@peff.net>
Subject: Re: pushing changes to a remote branch
Date: Tue, 10 Jul 2007 18:04:58 -0400
Message-ID: <20070710220458.GA2295@coredump.intra.peff.net>
References: <20070710143614.GA29681@piper.oerlikon.madduck.net> <20070710173401.GB5032@sigill.intra.peff.net> <844FC382-DFB3-4762-93C2-6512612136AC@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 00:05:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8Nq6-0001dh-7n
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 00:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763662AbXGJWFE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 18:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763581AbXGJWFE
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 18:05:04 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1505 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763414AbXGJWFA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 18:05:00 -0400
Received: (qmail 1057 invoked from network); 10 Jul 2007 22:05:24 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 10 Jul 2007 22:05:24 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2007 18:04:58 -0400
Content-Disposition: inline
In-Reply-To: <844FC382-DFB3-4762-93C2-6512612136AC@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52116>

On Tue, Jul 10, 2007 at 02:10:01PM -0400, Brian Gernhardt wrote:

> Perhaps git-commit should also also output a warning?  "Commit made on 
> detached HEAD.  Use "git branch <new_branch_name>" to save your commit"?  
> That's bad wording, but the idea is there.

There was much discussion in this area, and the conclusion (and current
behavior) is:

1. Notify about the state change to detached HEAD, since some commands
   will be subtly different.
2. Don't warn about commiting on detached HEAD, since there is nothing
   technically wrong with it.
3. When moving away from detached HEAD, print the previous HEAD
   position, so the user knows what might have been lost.

See this message (and a bunch of surrounding messages):

  http://article.gmane.org/gmane.comp.version-control.git/38254

It would be nice if we could allow (3) only when commits weren't being
lost, but that would require doing a reachability analysis from all
refs, which is expensive. The reflog for HEAD makes those commits
recoverable, as well.

Personally, I think (2) (commits on detached HEAD) should simply be
disallowed, since it is simple enough to 'git checkout -b newbranch' as
an override (and I have not personally found a need for commits on
detached HEAD, anyway), and it saves the exact newbie error that Martin
ran into. But others obviously disagree.

-Peff
