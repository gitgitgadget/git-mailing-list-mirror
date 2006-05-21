From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH 0/5] More ref logging
Date: Sat, 20 May 2006 22:43:44 -0400
Message-ID: <BAYC1-PASMTP1190ADCE746F3E0BEEC69BAEA50@CEZ.ICE>
References: <20060519091456.GH22257@spearce.org>
	<20060519071603.11d3be5d.seanlkml@sympatico.ca>
	<20060521005009.GA7179@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 04:49:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhe0m-0006TD-Gd
	for gcvg-git@gmane.org; Sun, 21 May 2006 04:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWEUCtf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 22:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWEUCtf
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 22:49:35 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:33361 "EHLO
	BAYC1-PASMTP11.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751438AbWEUCte (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 22:49:34 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP11.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 20 May 2006 19:54:22 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 38A9A644C28;
	Sat, 20 May 2006 22:49:32 -0400 (EDT)
To: Shawn Pearce <spearce@spearce.org>
Message-Id: <20060520224344.7ebca48b.seanlkml@sympatico.ca>
In-Reply-To: <20060521005009.GA7179@spearce.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 21 May 2006 02:54:22.0937 (UTC) FILETIME=[DD23BC90:01C67C81]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 20 May 2006 20:50:09 -0400
Shawn Pearce <spearce@spearce.org> wrote:

> It sort of is a new way of tagging commits with extra data.  But its
> also sort of a way of versioning your ref `database'.  Using tags
> to save the points in time might be useful but it would generate
> a lot of temporary files.  A commit every 5 minutes for a typical
> working week would generate 480 tags per week.  That's just too much.

But isn't that just an implementation detail?  I've actually run
into another situation where tags would be perfect if only they weren't
so expensive (ie. entire repo was in a 50Mb pack including tag objects,
but the .git/refs/tags directory was over 100Mb).

So, if we found a way to store tags more efficiently your 480 tags per
week shouldn't be a problem at all.   The main point being to extend
and optimize the existing infrastructure rather than bolting on a new
class of objects (ie. ref log) which only serves a narrow (albeit
important) purpose.
 
> I was actually thinking this morning that another way to do this
> is to keep a metadata branch within the repository which records
> all of the refs in tree objects, then save the root commit under
> the special ref `LOG` in GIT_DIR.  Every update to a logged ref
> would cause the tree to be updated and a new commit to be built.
> The branch would be a relatively simple string of pearls as its
> doubtful you would branch it.
>
> There are a number of downsides to this, not the least of which is
> I'd like to put a commit or tag SHA1 into the tree object rather than
> writing each ref as a blob (saves space).  Currently commits and tags
> aren't permitted in a tree object so that would require some effort.
> But on the other hand you could pull (and track!) someone elses
> ref log through the standard GIT protocol.
 
Yes, Linus proposed something similar earlier to hold meta data.
But i've come to see tags as a place to store any arbitrary meta
data associated with a commit.   If their implementation was more
efficient you could use them for your project and they could be used
for any number of other purposes as well.

> But this is starting to head down into the `bind commit` discussion;
> how do we record a number of commits as being related and tie them
> up into a single super commit?

Well, a tag that allowed the listing of multiple heads....

Sean
