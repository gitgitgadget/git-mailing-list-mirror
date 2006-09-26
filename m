From: Jeff King <peff@peff.net>
Subject: Re: git and time
Date: Tue, 26 Sep 2006 19:33:22 -0400
Message-ID: <20060926233321.GA17084@coredump.intra.peff.net>
References: <20060926232316.98065.qmail@web51009.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 01:33:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSMQa-00032C-BA
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 01:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWIZXdZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 19:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWIZXdZ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 19:33:25 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:16033 "HELO
	peff.net") by vger.kernel.org with SMTP id S932499AbWIZXdY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 19:33:24 -0400
Received: (qmail 29556 invoked from network); 26 Sep 2006 19:33:22 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 26 Sep 2006 19:33:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Sep 2006 19:33:22 -0400
To: Matthew L Foster <mfoster167@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20060926232316.98065.qmail@web51009.mail.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27838>

On Tue, Sep 26, 2006 at 04:23:16PM -0700, Matthew L Foster wrote:

> After seeing how git currently accepts a remote repository's timestamp
> it occurred to me that git should probably instead prefer the time a
> particular changeset was committed to _this_ repository. Perhaps I

If you fetch a commit from a remote repository, it does not get
"committed" to the local repository. It is simply copied. Keep in mind
that the act of making a commit means making an immutable SHA1 object.
If, when you fetched that commit, you changed some aspect of it (like
the timestamp), it would cease to have the same SHA1, and thus the DAG
of your history would differ from the remote end.

During operations where the original commit isn't preserved (e.g.,
applying patches from an email), git applies the current timestamp as
the committer timestamp (but uses the email date as the author
timestamp).

> don't know enough about git but it seems to me the important
> information is when a particular changeset was committed to this
> repository, all other remote/sub/parent repositories' timestamps are
> secondary (or at least should be tracked separately).

That information is not tracked in the commit objects (because they are
never "committed" in the local repository, only copied); however, Shawn's
reflog implementation gives some indication of when each ref changed,
which shows when some (but not all) commits made it into the local
repository.

Keep in mind that git doesn't really CARE about timestamps to do most
operations; it operates on the graph created by parentage. Think of the
timestamps more as comments; when a commit is created, we comment who
did it and when, both accordinging to their local information.

-Peff

PS Nit: Git doesn't work with changesets, it works with snapshots,
building a directed graph of snapshots. Maybe that is the source of your
confusion?
