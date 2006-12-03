X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: jgit performance update
Date: Sun, 3 Dec 2006 17:47:26 -0500
Message-ID: <20061203224726.GC15965@spearce.org>
References: <20061203045953.GE26668@spearce.org> <Pine.LNX.4.64.0612030938140.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 3 Dec 2006 22:47:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612030938140.3476@woody.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33147>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr07R-0007Rw-NJ for gcvg-git@gmane.org; Sun, 03 Dec
 2006 23:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757484AbWLCWra (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 17:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759941AbWLCWra
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 17:47:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48328 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1757484AbWLCWra
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 17:47:30 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gr070-0000D6-2o; Sun, 03 Dec 2006 17:47:06 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 B49E220FB7F; Sun,  3 Dec 2006 17:47:26 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> Very good. Are we any closer to actually having an eclipse plugin then?

We have some parts in place.  But nothing that's user-ready.
 
> > Walking the 50,000 most recent commits from the Mozilla trunk[1]:
> 
> Now, the _interesting_ case in many ways is not "--max-count", but the 
> revision limiter. It _should_ be equally fast, but if you've done 
> something wrong, it won't be.

We haven't implemented a rev-list equivalent yet.  That's a major
feature which is missing.  The --max-count test was simple to put
together.  I really need to start thinking about replicating some
of the features of the revision functions in core Git.

> > One of the biggest annoyances has been the fact that although Java
> > 1.4 offers a way to mmap a file into the process, the overhead to
> > access that data seems to be far higher than just reading the file
> > content into a very large byte array, especially if we are going
> > to access that file content multiple times.
> 
> That must suck for big packed repositories. What JVM and other environment 
> are you using?

Mac OS 10.4.8 / Java 1.4.2.  It appears as though Sun isn't going
to fix the mmap performance problems as they can't do it "securely".
So its likely to be an issue anywhere jgit gets used...

> Also, I have to say, one of the reasons I'm interested in your project is 
> that I've never done any Java programming, because quite frankly, I've 
> never had any reason what-so-ever to do so. But if there is some simple 
> setup, and you have jgit exposed somewhere as a git archive, I'd love to 
> take a look, if only to finally learn more about Java.

Of course its in Git.  :-)

There's no webpage here, but you can clone it:

  http://www.spearce.org/projects/scm/egit.git

The code you would recognize most is in org.spearce.jgit/.../lib.
E.g.  BinaryDelta.java came from patch-delta.c in core Git.
Repository has some of the functionality of sha1_file.c, the pack
reading code is in PackFile.java.

-- 
