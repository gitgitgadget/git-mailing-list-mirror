From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 0/5] More ref logging
Date: Sat, 20 May 2006 20:50:09 -0400
Message-ID: <20060521005009.GA7179@spearce.org>
References: <20060519091456.GH22257@spearce.org> <20060519071603.11d3be5d.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 02:50:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhc9I-00076l-9J
	for gcvg-git@gmane.org; Sun, 21 May 2006 02:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWEUAuQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 20:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWEUAuQ
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 20:50:16 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:18125 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932161AbWEUAuP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 20:50:15 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fhc8v-0003rY-OK; Sat, 20 May 2006 20:50:01 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BADB3212691; Sat, 20 May 2006 20:50:09 -0400 (EDT)
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20060519071603.11d3be5d.seanlkml@sympatico.ca>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20413>

Sean <seanlkml@sympatico.ca> wrote:
> On Fri, 19 May 2006 05:14:56 -0400
> Shawn Pearce <spearce@spearce.org> wrote:
> 
> > * [PATCH 5/5] Enable ref log creation in git checkout -b.
> > 
> > 	Fix git checkout -b to behave like git branch.
> 
> It seems that the ref log is a new way of tagging commits with some
> extra meta data.  Conceptually this seems very close to what git tags 
> already do.  So... what about using regular git tags rather than
> creating a ref log?  All the regular git-rev-list tools could be
> used to query the tags and prune would delete them automatically etc.

It sort of is a new way of tagging commits with extra data.  But its
also sort of a way of versioning your ref `database'.  Using tags
to save the points in time might be useful but it would generate
a lot of temporary files.  A commit every 5 minutes for a typical
working week would generate 480 tags per week.  That's just too much.

I was actually thinking this morning that another way to do this
is to keep a metadata branch within the repository which records
all of the refs in tree objects, then save the root commit under
the special ref `LOG` in GIT_DIR.  Every update to a logged ref
would cause the tree to be updated and a new commit to be built.
The branch would be a relatively simple string of pearls as its
doubtful you would branch it.

There are a number of downsides to this, not the least of which is
I'd like to put a commit or tag SHA1 into the tree object rather than
writing each ref as a blob (saves space).  Currently commits and tags
aren't permitted in a tree object so that would require some effort.
But on the other hand you could pull (and track!) someone elses
ref log through the standard GIT protocol.

But this is starting to head down into the `bind commit` discussion;
how do we record a number of commits as being related and tie them
up into a single super commit?

-- 
Shawn.
