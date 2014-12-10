From: Jeff King <peff@peff.net>
Subject: Re: filter-branch performance
Date: Wed, 10 Dec 2014 09:37:07 -0500
Message-ID: <20141210143706.GA2996@peff.net>
References: <548744F1.9000902@gmx.de>
 <20141209185933.GC31158@peff.net>
 <CAFY1edYYC9TZmLE6b3=QAoTB1zQHi_Y97rHL-5wk5Pbpa_oj_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Henning Moll <newsScott@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 15:37:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyiOE-0004KB-1v
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 15:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757415AbaLJOhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 09:37:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:51067 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755993AbaLJOhK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 09:37:10 -0500
Received: (qmail 7973 invoked by uid 102); 10 Dec 2014 14:37:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 08:37:09 -0600
Received: (qmail 9840 invoked by uid 107); 10 Dec 2014 14:37:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 09:37:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Dec 2014 09:37:07 -0500
Content-Disposition: inline
In-Reply-To: <CAFY1edYYC9TZmLE6b3=QAoTB1zQHi_Y97rHL-5wk5Pbpa_oj_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261213>

On Wed, Dec 10, 2014 at 02:18:24PM +0000, Roberto Tyley wrote:

> Depending on how much time you can sink into improving the performance
> (versus just allowing the process to run to completion), you could
> also look into a non-forking solution, as well as not bothering to
> load the commit trees. To me non-forking means putting everything into
> the JVM by using JGit, like the BFG does, though libgit2 might also be
> an option.
> 
> Changing the BFG's code to do the transformation in your script is
> absolutely trivial - define a commit-node cleaner like this:
> 
> object SetCommitterToAuthor extends CommitNodeCleaner {
>   override def fixer(kit: CommitNodeCleaner.Kit) = c =>
> c.copy(committer = c.author) // PersonIdent class holds name, email &
> time
> }

Thanks. I _almost_ mentioned BFG in the original email, but I didn't
think it could do arbitrary fixes like this. Can you monkey-patch in
arbitrary code, or do you have to rebuild all of BFG to include the
snippet above?

> ...trivial if you don't mind compiling Scala with SBT that is, and I'm
> sure some people do! A DSL for non-Scala people to define their own
> BFG scripts would be good, I must get on that some day.

That would be cool.  Even if the DSL was just Java, if you could do
something like:

  vi fix.java
  javac fix.java
  bfg --filter=fix.class

that would be very useful (and I am probably showing my lack of Java chops
by getting the compilation command or filenames wrong :) ).

> I started running the same test some time ago using filter-branch,
> unfortunately that test has not completed yet - the BFG appears to be
> substantially faster.

No fair if you didn't run filter-branch on a PC and BFG on a Raspberry
Pi. You have to give us a fighting chance. :)

-Peff
