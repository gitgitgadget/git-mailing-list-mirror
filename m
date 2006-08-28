From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Packfile can't be mapped
Date: Mon, 28 Aug 2006 01:33:01 -0400
Message-ID: <20060828053301.GA25285@spearce.org>
References: <9e4733910608271804j762960a8ud83654c78ebe009a@mail.gmail.com> <20060828024720.GD24204@spearce.org> <Pine.LNX.4.64.0608280014190.3683@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 28 07:33:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHZkx-00046R-SK
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 07:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWH1Fds (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 01:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWH1Fds
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 01:33:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57750 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750746AbWH1Fds (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Aug 2006 01:33:48 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GHZki-0005U8-7I; Mon, 28 Aug 2006 01:33:40 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E0A2620FB7F; Mon, 28 Aug 2006 01:33:01 -0400 (EDT)
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608280014190.3683@localhost.localdomain>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26141>

Nicolas Pitre <nico@cam.org> wrote:
> On Sun, 27 Aug 2006, Shawn Pearce wrote:
> 
> > I'm going to try to get tree deltas written to the pack sometime this
> > week. That should compact this intermediate pack down to something
> > that git-pack-objects would be able to successfully mmap into a
> > 32 bit address space.  A complete repack with no delta reuse will
> > hopefully generate a pack closer to 400 MB in size.  But I know
> > Jon would like to get that pack even smaller.  :)
> 
> One thing to consider in your code (if you didn't implement that 
> already) is to _not_ attempt any delta on any object whose size is 
> smaller than 50 bytes, and then limit the maximum delta size to 
> object_size/2 - 20 (use that for the last argument to diff-delta() and 
> store the undeltified object when diff-delta returns NULL).  This way 
> you'll avoid creating delta objects that are most likely to end up being 
> _larger_ than the undeltified object.

I haven't tried this.  Should be trivial to implement.  Thanks for
the suggestion.

> > I should point out that the input stream to fast-import was 20 GB
> > (completely decompressed revisions from RCS) plus all commit data.
> > The original CVS ,v files are around 3 GB.  An archive .tar.gz'ing
> > the ,v files is around 550 MB.  Going to only 1.7 GB without tree
> > or commit deltas is certainly pretty good.  :)
> 
> Good job indeed.  Oh and you probably should not bother trying to 
> deltify commit objects at all since that would be a waste of time.

I wasn't going to bother even trying to delta the commits.  In this
import the 200k commits isn't a very large percentage of the data.
As I'm sure you are well aware its pretty much a waste time to try
with the commits, especially with an "intermediate" pack such as
this one.

-- 
Shawn.
