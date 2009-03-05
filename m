From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2009, #02; Thu, 05)
Date: Thu, 5 Mar 2009 11:28:24 -0500
Message-ID: <20090305162824.GA4213@coredump.intra.peff.net>
References: <7vbpsg2sgx.fsf@gitster.siamese.dyndns.org> <20090305110051.GA17921@coredump.intra.peff.net> <49AFED56.3030102@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Heiko Voigt <git-list@hvoigt.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 05 17:30:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfGSN-0005i0-SL
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 17:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230AbZCEQ23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 11:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753461AbZCEQ23
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 11:28:29 -0500
Received: from peff.net ([208.65.91.99]:59548 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753313AbZCEQ23 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 11:28:29 -0500
Received: (qmail 32002 invoked by uid 107); 5 Mar 2009 16:28:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 05 Mar 2009 11:28:29 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Mar 2009 11:28:24 -0500
Content-Disposition: inline
In-Reply-To: <49AFED56.3030102@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112316>

On Thu, Mar 05, 2009 at 04:18:46PM +0100, Michael Haggerty wrote:

> In all of these cases *the git content is objectively wrong*.  These are
> not quality-of-conversion quibbles, they are egregious correctness
> problems that will occur in most nontrivial CVS repositories.

Thanks for the detailed descriptions. I don't think anyone is denying
that the results are objectively wrong; it is clear that cvsimport
doesn't handle complex cases well.

> IMHO there are only two intellectually honest alternatives:
> 
> 1. Commit the new tests in the hope that somebody will try to fix them,
> which probably requires ditching cvsps and starting almost from scratch.
>  Until they are fixed add a disclaimer, in big red letters, to the
> git-cvsimport documentation, saying that it *should not be trusted* to
> make accurate conversions (though it might be useful in very restricted
> scenarios requiring incremental synchronization with a CVS repo).  In
> this case the tests should be retained as documentation, though perhaps
> they should not be run unless the user turns on a particular flag.

I think committing the tests and putting a big warning onto cvsimport
are two separate things. I don't want to hide the fact that cvsimport
sucks, and I don't think anyone does. But I also don't want to bog down
the test suite with useless cruft that nobody is actually going to look
at.

I think your suggestion of disabling the tests unless flagged is
reasonable. The tests themselves don't take up much space in the
repository, it's only running them that is painful.

As far as marking cvsimport with a disclaimer, I don't have an objection
to warning people in the documentation. It seems like most people who
come to the list with a cvsimport problem end up getting the advice to
try something else, and then they end up happy. Putting a
not-inflammatory disclaimer into the documentation to check results and
to consider some other options would save the list a little work.

> 2. Remove the git-cvsimport command altogether.

I don't think this is a good idea. It still has two uses which make it
better than nothing:

  1. It's the only (AFAIK) importer that is incremental. When you are
     tracking relatively simple development on an existing CVS repo,
     it is the only choice. Taking that choice away seems
     counterproductive.

  2. It _does_ work on relatively mundane cases, and there _are_ mundane
     CVS repositories. Yes, other tools can also handle these cases, but
     using the bundled cvsimport is much easier using an intermediate
     svn.

I am less sure of (2) above, because naive users might not _know_ that
they're screwing up their repository. So safety would dictate spending
the extra effort (which is the point you were making, I think).

But certainly cvsimport should hang around for (1), even it is with a
disclaimer.

For how long, I don't know. It seems like most people are putting their
CVS repos to rest at this point, moving at least to SVN. I know there
will be people hanging on to CVS for at least a decade, but I'm not sure
at what point we say "there are not enough of you to care; go use a less
convenient one-time tool". cvsimport is already suffering from bit-rot
as people who like git enough to work on it converted their repos years
ago.

-Peff
