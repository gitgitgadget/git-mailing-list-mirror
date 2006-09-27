From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 00:28:50 -0400
Message-ID: <20060927042850.GB9460@spearce.org>
References: <20060926233321.GA17084@coredump.intra.peff.net> <20060927002745.15344.qmail@web51005.mail.yahoo.com> <20060927033459.GA27622@coredump.intra.peff.net> <20060926234309.b16aa44e.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Matthew L Foster <mfoster167@yahoo.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 06:29:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSR2r-0006QB-8Q
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 06:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWI0E24 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 00:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWI0E24
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 00:28:56 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:63126 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932264AbWI0E2z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 00:28:55 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GSR2T-0007SF-3I; Wed, 27 Sep 2006 00:28:53 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9E19520FB28; Wed, 27 Sep 2006 00:28:50 -0400 (EDT)
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20060926234309.b16aa44e.seanlkml@sympatico.ca>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27868>

Sean <seanlkml@sympatico.ca> wrote:
> On Tue, 26 Sep 2006 23:34:59 -0400
> Jeff King <peff@peff.net> wrote:
> 
> > Right. So you really want to know not "when did this commit enter this
> > repo" but rather "when did this head/branch first contain this commit"
> > (since there may be multiple branches within a repo).
> 
> Even though it's being a bit pedantic, I have to disagree with you here.
> The question the user is asking is exactly, "When did this commit enter
> _this_ repo?".
> 
> Because of the design of git, such a question must be converted into a
> question regarding reflogs and head/branch values etc...  But the user
> doesn't care anything about all that.  They're just interested in the
> date/time the commit was published in the repository in question, not
> the date time the commit was originally created in some distant
> repo.

And with the completely distributed nature of Git I have to say
that's a useful question to get an answer to.  Though I believe
Junio pointed out that may be incorrect by several hours for
Linus' public tree due to the mirroring that occurs on kernel.org.
However so long as the existance of that lag is publically stated
I don't really see a problem.

As Junio correctly pointed out answering that question is rather
compute intensive (as Git things go) as you need to compare both
the reflog for the branch in question (or all branches!) against
the commit chain(s) and find where that commit became visible.
Not cheap certainly but possible with the data we have.


However people are ignoring the fact that receive-pack doesn't
update the reflog.  As of current `next` its *still* doing the ref
updates by hand, rather than going through the common library code
in refs.c.  As a consequence its bypassing the reflog implementation.
This means that `git-push` does not update the reflog.  Which means
there's no way Linus' public repository could have a reflog.

Maybe if I (or someone else) fixed receive-pack.c Linus might
consider enabling reflog, and maybe someone could fix gitweb.cgi to
perform the computation - but possibly server owners wouldn't want
that feature running due to its high computation cost.  Especially
if gitweb.cgi doesn't have a native C executable to do most of the
work for it.

For what its worth I keep meaning to get around to fix receive-pack.c
but I just haven't done it yet.

-- 
Shawn.
