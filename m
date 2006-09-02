From: Junio C Hamano <junkio@cox.net>
Subject: Re: Mozilla .git tree
Date: Fri, 01 Sep 2006 21:01:49 -0700
Message-ID: <7v8xl23oia.fsf@assigned-by-dhcp.cox.net>
References: <20060829190548.GK21729@spearce.org>
	<9e4733910608291252q130fc723r945e6ab906ca6969@mail.gmail.com>
	<20060829232007.GC22935@spearce.org>
	<9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com>
	<20060830015122.GE22935@spearce.org>
	<9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
	<20060830031029.GA23967@spearce.org>
	<Pine.LNX.4.64.0608300124550.9796@xanadu.home>
	<7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net>
	<7vr6yw58xp.fsf@assigned-by-dhcp.cox.net>
	<20060902011950.GB24234@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 06:02:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJMhh-0008LD-2i
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 06:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWIBEBv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 00:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWIBEBv
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 00:01:51 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:46055 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750781AbWIBEBu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 00:01:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060902040149.BHTS21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Sat, 2 Sep 2006 00:01:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HG1q1V0041kojtg0000000
	Sat, 02 Sep 2006 00:01:50 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060902011950.GB24234@spearce.org> (Shawn Pearce's message of
	"Fri, 1 Sep 2006 21:19:50 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26320>

Shawn Pearce <spearce@spearce.org> writes:

> What I did in fast-import was give inflate whatever was left in
> the current mapping; then if I got a Z_OK or Z_BUF_ERROR back from
> inflate I move the mapping to the next 128 MiB chunk and reset my
> z_stream's next_in/avail_in accordingly, then recall inflate.

Makes sense.

> But having the length or ending offset in the index will help with
> copying the object during a repack as well as prevent us from needing
> to guess during accesses.

Actually pack-objects already builds the reverse index without
the help from the updated .idx file format, so while having it
pre-built in .idx may help, it is not necessary for it.  With
your "feed until the end of the current window and if we need
more map in the next window" logic, we do not even need to know
the length of each entry at runtime either.

So I am inclined to chuck the previous patch that records the
next object number in each entry.  We could keep the 64-bit
offset, which would make an entry to be 28-byte instead of
32-byte.


-- 
VGER BF report: U 0.5
