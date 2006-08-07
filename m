From: Shawn Pearce <spearce@spearce.org>
Subject: Re: fast-import and unique objects.
Date: Mon, 7 Aug 2006 19:02:58 -0400
Message-ID: <20060807230258.GA19067@spearce.org>
References: <9e4733910608060532w51fca2c0r8038828df0d41eeb@mail.gmail.com> <9e4733910608060853ua0eabc1w9b35b8414d3c9bae@mail.gmail.com> <20060806180323.GA19120@spearce.org> <20060807075744.GB15477@h4x0r5.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 08 01:27:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAEVW-0007qS-Qr
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 01:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWHGX1d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 19:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWHGX1d
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 19:27:33 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57496 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932343AbWHGX1c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 19:27:32 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GAEV9-0000iY-Q2; Mon, 07 Aug 2006 19:27:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 92C9D20FB77; Mon,  7 Aug 2006 19:02:58 -0400 (EDT)
To: Ryan Anderson <ryan@michonline.com>
Content-Disposition: inline
In-Reply-To: <20060807075744.GB15477@h4x0r5.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25054>

Ryan Anderson <ryan@michonline.com> wrote:
> On Sun, Aug 06, 2006 at 02:03:24PM -0400, Shawn Pearce wrote:
> > 
> >   - It expects an estimated object count as its second parameter.
> >     In your case this would be something around 760000.  This tells
> >     it how large of an object table to allocate, with each entry
> >     being 24 bytes + 1 pointer (28 or 32 bytes).  Overshooting
> > 	this number will cause it to degrade by allocating one
> > 	overflow entry at a time from malloc.
> 
> Hrm, you're allocating a big table and then assigning consecutive
> entries out of it, as pointers.
> 
> Why not just malloc a big block, and assign offsets into it, as if it
> were a really big array.  Every time it runs out, realloc it to double
> the current size, and update the base pointer.

Because I didn't want to move a 24 MB block of memory.  :-)

I'm probably going to clean that section of code up tonight and
allocate a large block at the beginning then allocate overflow blocks
at about 5000 entries at a time.  There's no need for the blocks to
be contiguous in memory, I just didn't want to have a high overhead
from malloc when there would be a large number of them...

-- 
Shawn.
