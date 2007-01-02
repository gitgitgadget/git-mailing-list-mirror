From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Draft v1.5.0 release notes
Date: Mon, 1 Jan 2007 21:57:48 -0500
Message-ID: <20070102025748.GA27690@spearce.org>
References: <7vlkkm47eg.fsf@assigned-by-dhcp.cox.net> <4599C3E8.5060209@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 03:58:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1Zqu-0000sq-1I
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 03:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181AbXABC57 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 21:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755207AbXABC57
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 21:57:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43106 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181AbXABC56 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 21:57:58 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H1ZqN-0000lp-Vu; Mon, 01 Jan 2007 21:57:40 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 31DCC20FB65; Mon,  1 Jan 2007 21:57:49 -0500 (EST)
To: Steven Grimm <koreth@midwinter.com>
Content-Disposition: inline
In-Reply-To: <4599C3E8.5060209@midwinter.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35765>

Steven Grimm <koreth@midwinter.com> wrote:
> Junio C Hamano wrote:
> > - There is a configuration variable core.legacyheaders that
> >   changes the format of loose objects so that they are more
> >   efficient to pack and to send out of the repository over git
> >   native protocol, since v1.4.2.  However, this format cannot
> >   be read by git older than that version; people fetching from
> >   your repository using older clients over dumb transports
> >   (e.g. http) using older versions of git will also be
> >   affected.  This is not enabled by default.
> >
> > - Since v1.4.3, configuration repack.usedeltabaseoffset allows
> >   packfile to be created in more space efficient format, which
> >   cannot be read by git older than that version.  This is not
> >   enabled by default.
> >  
> 
> For people in non-public development environments where there's 
> absolutely no possibility of someone hitting a repo with an old client, 
> presumably these options should both be enabled.

Or even in public ones, but where access by dumb clients isn't
offered (only anonymous or ssh based git native protocol is used).

> I wonder if it makes 
> sense to add an option to git-init-db to create a configuration file 
> with all the latest stuff enabled -- or better still, something like
> 
> git-init-db --min-version=1.4.2

That's an interesting idea.  Most users don't invoke init-db directly
however, they are using clone to copy someone else's repository.
But that option could easily be offered on both commands, with
clone just passing it through to init-db.
 
> that would enable all the non-backward-compatible stuff in the newly 
> created repository. And then a special case "--min-version=current" to 
> use all the most optimal settings for the current release, useful in 
> environments like corporate LANs where the tool versions are centrally 
> managed.

Actually I wonder if "--min-version=current" shouldn't just be the
default.  Most users are going to init-db or clone locally and use
only the current version of Git (or later) against that repository.

Though that probably would break someone who runs multiple versions
of Git on the same system, because they have some strange reason
for doing so[*1*].  And it would certainly cause problems for
users who then rsync that repository (or scp it) to a webhost and
expect users with older versions of Git to be able to access it
with a commit-walker client.  But that would be less of a problem
if we could teach users to first clone their repository before
publishing it, e.g.:

    git clone --bare --min-version=1.2 . ../myproj.git


*1*: I'm not talking about Git developers here.  I think most Git
     developers run a `production` version of Git that they use for
     actual revisioning, and other versions for testing, and those
     testing versions are only used against testing repositories
     that hold non-live data.

-- 
Shawn.
