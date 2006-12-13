X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: GIT - releases workflow
Date: Wed, 13 Dec 2006 06:14:50 -0500
Message-ID: <20061213111450.GB31177@spearce.org>
References: <89b129c60612121444t18ba94ecv57eea4c72be1663a@mail.gmail.com> <Pine.LNX.4.63.0612122353320.2807@wbgn013.biozentrum.uni-wuerzburg.de> <1166001019.19098.4.camel@localhost.localdomain> <Pine.LNX.4.63.0612131133160.3635@wbgn013.biozentrum.uni-wuerzburg.de> <20061213105614.GB9484@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 11:15:17 +0000 (UTC)
Cc: Matthias Kestenholz <lists@spinlock.ch>,
	Sean Kelley <sean.v.kelley@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061213105614.GB9484@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34209>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuS4p-0002tZ-MU for gcvg-git@gmane.org; Wed, 13 Dec
 2006 12:15:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964834AbWLMLO5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 06:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWLMLO5
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 06:14:57 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60258 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964834AbWLMLO4 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 06:14:56 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GuS4X-0000VO-Ah; Wed, 13 Dec 2006 06:14:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 922A720FB6E; Wed, 13 Dec 2006 06:14:50 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > On Tue, 12 Dec 2006, Sean Kelley wrote:
> > > > 
> > > > > I was wondering if anyone could share ideas on how best to use GIT to 
> > > > > handle releases for those working with a remote GIT repository?  Do you 
> > > > > create a branch and push it to the remote?  Thus you have a new branch 
> > > > > referencing the particular release?
> > 
> > BTW, if the maintenance releases are sparse and long between, you can 
> > actually create the branch from the tag, fix, and tag with the new version 
> > number. No need to start the branches early.
> 
> Indeed.
[snip]
> The script is really meant for QA people to take in topic branches
> from developers and apply them to a specific version, test that new
> version, then ship that new version.  Some of the QA people I work
> with aren't developers and have a somewhat difficult time making
> a build from source; this script makes it a pretty simple process.
> 
> The version number incrementor is smart; its based off commit
> lineage.  It can automatically create a "2.0.1" tag when "2.1"
> has already been made but "2.0.1" is a bugfix of "2" or "2.0".

What I really should have said was the general idea here is that
we never even have a trunk.

Developers work on topic branches and share/merge those individual
branches as necessary to evolve a topic.  When its suitably cooked
in developer land it gets sent off to testing by being pushed into
a someewhat descriptive ref under refs/heads/ready.

Testing can then accept topics by merging them together and creating
tags via the described script.

Developers update their still cooking topic branches when necessary
by pulling in the tags. git merge is smart enough to dereference the
tag and generate the merge.  Normally this is held off to the latest
possible moment, and only to make sure there aren't any unexpected
surprises from the merge waiting for the unsuspecting QA person.

Developers start new topic branches off the relevent tag they need
to work on.  New features are often made off the latest tag from QA;
bug fixes are often off the tag currently in production.

So like I said, we're basically trunkless and happy.  Tag happy.
Thank you Linus, et.al. for packed refs!

-- 
