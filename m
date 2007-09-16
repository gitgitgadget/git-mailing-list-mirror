From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: db/fetch-pack topic (was: What's cooking in git.git (topics))
Date: Sun, 16 Sep 2007 00:03:21 -0400
Message-ID: <20070916040321.GC3099@spearce.org>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org> <7v1wd1d0le.fsf@gitster.siamese.dyndns.org> <20070914183028.GV3099@spearce.org> <20070915074759.GA3099@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 06:03:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWlM3-0005Ed-Nh
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 06:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbXIPED0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 00:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbXIPED0
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 00:03:26 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41554 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbXIPEDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 00:03:25 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IWlLi-0005oG-VB
	for git@vger.kernel.org; Sun, 16 Sep 2007 00:03:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DB98720FBAE; Sun, 16 Sep 2007 00:03:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070915074759.GA3099@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58295>

> "Shawn O. Pearce" <spearce@spearce.org> wrote:
> > Junio C Hamano <gitster@pobox.com> wrote:
> > > * db/fetch-pack (Fri Sep 14 03:31:25 2007 -0400) 22 commits
> > ...
> > > This is Daniel's fetch-pack in C plus fixups from Shawn.
> > > Unfortunately the fixups breaks t3200 ("*** glibc detected ***
> > > fetch: free(): invalid pointer xxx ***"), which I haven't looked
> > > into yet.

With all of my fixups applied I took some performance measurements
today from two of my larger day-job repositories:

  A.git (356 branches):
    Current Fetch             New "Builtin" Fetch
    ------------------        --------------------
    real    3m19.921s         real    0m9.969s
    user    1m58.050s         user    0m1.449s
    sys     2m4.747s          sys     0m4.465s

  B.git (24 branches):
    Current Fetch             New "Builtin" Fetch
    ------------------        --------------------
    real    0m21.250s         real    0m4.735s
    user    0m10.981s         user    0m0.510s
    sys     0m12.387s         sys     0m1.481s

All runs were a no-op fetch over SSH on the LAN.  The system running
git-fetch was a Cygwin/Windows 2000 box and the server was Solaris 9.
Just starting an SSH connection (`ssh solsrv echo hi`) takes me on
average 1 second so a 4.7s no-op fetch on the smaller repository
is very respectable.

3m19s vs. 9s?  I'll take 9s, thankyouverymuch.  Even if I have
more testing and debugging to do.  Especially since the two repos
above are only a sampling of the actual set I have to deal with on
a daily basis.

-- 
Shawn.
