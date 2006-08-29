From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Packfile can't be mapped
Date: Tue, 29 Aug 2006 00:52:39 -0400
Message-ID: <20060829045239.GB24479@spearce.org>
References: <9e4733910608271804j762960a8ud83654c78ebe009a@mail.gmail.com> <20060828024720.GD24204@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 29 06:55:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHvbq-0000k7-J2
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 06:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWH2Ews (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 00:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWH2Ews
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 00:52:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45285 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750809AbWH2Ewr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Aug 2006 00:52:47 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GHvad-0003Fl-OC; Tue, 29 Aug 2006 00:52:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5C34420FB7F; Tue, 29 Aug 2006 00:52:40 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060828024720.GD24204@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26188>

Shawn Pearce <spearce@spearce.org> wrote:
> I'm going to try to get tree deltas written to the pack sometime this
> week.

I was able to implement and with Jon Smirl's help debug the tree
delta code in fast-import.
 
Earlier this evening Jon sent me the following:
> git-fast-import statistics:
> ---------------------------------------------------------------------
> Alloc'd objects:    1980000 (         0 overflow  )
> Total objects:      1967527 (     41856 duplicates                  )
>       blobs  :       633842 (         0 duplicates     576219 deltas)
>       trees  :      1131208 (     41856 duplicates    1019741 deltas)
>       commits:       200921 (         0 duplicates          0 deltas)
>       tags   :         1556 (         0 duplicates          0 deltas)
> Total branches:        1600 (      2228 loads     )
>       marks:        1048576 (    200921 unique    )
>       atoms:          56803
> Memory total:         75213 KiB
>        pools:         13338 KiB
>      objects:         61875 KiB
> Pack remaps:            658
> Pack size:           895983 KiB
> Index size:           46114 KiB
> ---------------------------------------------------------------------

Compared to our last attempt:
> > Pack size:          1713200 KiB
> > Index size:           46114 KiB

This tree delta version came out pretty good.  The pack with tree
deltas is 874 MiB.  Quite a reduction in size.  fast-import takes
about 20 minutes to convert its 20 GiB input file into this 874 MiB
pack.  Producing the 20 GiB input file from the 3 GiB CVS ,v
files takes about 4 hours with Jon's modified cvs2svn.

Jon has started a `git-repack -a -f` with aggressive depth and
window sizes.  He estimated it may need another 2.5 hours to process.
Hopefully I'll hear more details tomorrow.

-- 
Shawn.
