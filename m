From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Mozilla .git tree
Date: Sat, 2 Sep 2006 13:51:25 -0400
Message-ID: <20060902175125.GC27826@spearce.org>
References: <20060829232007.GC22935@spearce.org> <9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com> <20060830015122.GE22935@spearce.org> <9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com> <20060830031029.GA23967@spearce.org> <Pine.LNX.4.64.0608300124550.9796@xanadu.home> <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <7vr6yw58xp.fsf@assigned-by-dhcp.cox.net> <20060902020426.GF24234@spearce.org> <7v3bba1qg5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 19:52:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJZfZ-00064m-EG
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 19:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWIBRvz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 13:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWIBRvz
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 13:51:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:65484 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751252AbWIBRvx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 13:51:53 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GJZeh-0002Ly-2n; Sat, 02 Sep 2006 13:51:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7241020FB7F; Sat,  2 Sep 2006 13:51:25 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bba1qg5.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26348>

Junio C Hamano <junkio@cox.net> wrote:
> > I think we probably should have done this when the binary headers
> > were introduced into loose objects.
> 
> No.  That was purely .pack format and did not affect .idx
> format.  Honestly .idx is purely a local matter and not as
> important to keep stable as the .pack format.

I think you missed the point of my comment.  I apologize for it
not being clear the first time.

The loose objects have format #1 (legacy text format compressed as
one big zlib stream) and now format #2 (pack object header followed
by data-only zlib stream).

In looking at this dictionary packing code that I'm working on right
now I may be introducing format #3 (dictionary based compression
rather than zlib compression).

We have no easy way to mark the version number of the loose objects.
I'm sure we can shoehorn in something though.
 
> > Sure the scheme you outlined allows a 64 bit difference but
> > uncompressed objects already can't be larger than 2**32-1...
> 
> Where do we have that limitation?

sha1_file.c uses "unsigned long" a lot to deal with size of an
object, deflated.  iirc unsigned long is only 32 bits even in many
64 bit architectures.  Or am I wrong?

> I think your "allow zlib to eat the remainder of the current
> window and slide window when it exhausts the current window"
> logic is a very good on and makes it unnecessary to know the
> tail of each object.

I'll send patches to sha1_file.c probably later tonight.  My last
round of offset changes was the start of that, this next round
should finish it.  Its mostly a copy-n-paste from fast-import.c
so it should go quickly.

-- 
Shawn.

-- 
VGER BF report: U 0.960524
