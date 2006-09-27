From: Jeff King <peff@peff.net>
Subject: Re: git and time
Date: Tue, 26 Sep 2006 23:34:59 -0400
Message-ID: <20060927033459.GA27622@coredump.intra.peff.net>
References: <20060926233321.GA17084@coredump.intra.peff.net> <20060927002745.15344.qmail@web51005.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 05:35:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSQCU-0006T2-HB
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 05:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWI0DfE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 23:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWI0DfE
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 23:35:04 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:31388 "HELO
	peff.net") by vger.kernel.org with SMTP id S932274AbWI0DfC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 23:35:02 -0400
Received: (qmail 11209 invoked from network); 26 Sep 2006 23:35:00 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 26 Sep 2006 23:35:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Sep 2006 23:35:00 -0400
To: Matthew L Foster <mfoster167@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20060927002745.15344.qmail@web51005.mail.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27865>

On Tue, Sep 26, 2006 at 05:27:45PM -0700, Matthew L Foster wrote:

> It's true I don't know much about git, what is the difference between
> a changeset and a snapshot?

I think Linus' explanation covered what I meant, but please ask for
clarification if there was something that didn't make sense.

> Are you saying timestamps should be tracked separately or tracked by
> an scm system built on top of git?  Does/should git care about the
> when of a snapshot?

Yes, they could be tracked separately. My point was that git deals in
immutable snapshot objects (commits) and you don't want to change the
commit objects after the fact. You could certainly make an external
mapping of "this commit object entered the repo at local time T" but I
doubt it would be of much use. See below.

> Perhaps my question is directed more toward gitweb.cgi, it seems to me
> the timestamp of when a snapshot was merged into this repository
> should somehow be tracked and that is what gitweb.cgi should default
> to display. For example, if someone wants to know if security bugfix X
> was merged into linus' kernel tree they also want to know when that
> happened, don't they?

Right. So you really want to know not "when did this commit enter this
repo" but rather "when did this head/branch first contain this commit"
(since there may be multiple branches within a repo).  We can find out
"does commit X contain commit Y" by looking at the commit graph. The
reflog system records "head H contained commit X at time T" so between
the two you can find the answer to your question (but it takes some
computation).

I think Junio's email explained this better than I could, but again,
please ask if something is unclear.

-Peff
