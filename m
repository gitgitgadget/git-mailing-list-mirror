From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 0/17] Sliding window mmap for packfiles.
Date: Sun, 24 Dec 2006 04:05:08 -0500
Message-ID: <20061224090508.GF7443@spearce.org>
References: <20061223073317.GA9837@spearce.org> <38b2ab8a0612240056k152344ael891e9b0b9f8cbc47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 10:05:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyPIJ-0007ge-WD
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 10:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169AbWLXJFQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 04:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754209AbWLXJFQ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 04:05:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59108 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169AbWLXJFO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 04:05:14 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GyPI6-0001xd-Am; Sun, 24 Dec 2006 04:05:10 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E809E20FB65; Sun, 24 Dec 2006 04:05:08 -0500 (EST)
To: Francis Moreau <francis.moro@gmail.com>
Content-Disposition: inline
In-Reply-To: <38b2ab8a0612240056k152344ael891e9b0b9f8cbc47@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35349>

Francis Moreau <francis.moro@gmail.com> wrote:
> On 12/23/06, Shawn O. Pearce <spearce@spearce.org> wrote:
> >This 17 patch series implements my much discussed, but never produced
> [snip]
> >
> >This series also permits accessing packfiles up to 4 GiB in size,
> >even on systems which permit only 2 GiB of virtual memory within
> >a single process (e.g. Windows and some older UNIXes).  Of course
> 
> Just out of curiosity, do you mean that there are some OS running on
> 32 bits machines which allow 4GiB size of virtual memory within a
> single process ? If so, could you give an example of such OS ?

No.  What I meant was the Git packfile/index format currently
supports up to 4 GiB of data in a single packfile.  But *no*
OS using 32 bit virtual address space would permit us to access
that packfile prior to this series as we would have *no* memory
left for a stack, let alone for parsing commits, etc., as *all*
of the address space would have been dedicated to the packfile.

However with this series even a 32 bit OS which only permits
processes to have at most 2 GiB of address space (2 GiB split
between kernel space and userspace) can access packfiles up
to 4 GiB in size.  That seems to be the split most OSes wind
up using, if they didn't push it out to 3.2 GiB like Linux
and Solaris have done.

This series is a good change because Git can now really make
full use of the space allowed by a single packfile.  :-)

-- 
Shawn.
