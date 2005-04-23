From: Mike Taht <mike.taht@timesys.com>
Subject: Git transfer protocols (was: Re: Git-commits mailing list feed)
Date: Sat, 23 Apr 2005 14:28:59 -0700
Message-ID: <426ABE1B.7000905@timesys.com>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org> <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com> <426A4669.7080500@ppp0.net> <1114266083.3419.40.camel@localhost.localdomain> <426A5BFC.1020507@ppp0.net> <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org> <20050423183406.GD20410@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0504231228480.2344@ppc970.osdl.org> <20050423204957.GA16751@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 23:26:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPS8d-0002cv-Qd
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 23:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVDWVat (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 17:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVDWVat
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 17:30:49 -0400
Received: from mail.timesys.com ([65.117.135.102]:26745 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261958AbVDWVac (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 17:30:32 -0400
Received: from [10.129.129.212] ([67.180.132.225]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Sat, 23 Apr 2005 17:25:34 -0400
X-Accept-Language: en-us, en
To: Jan Harkes <jaharkes@cs.cmu.edu>
In-Reply-To: <20050423204957.GA16751@delft.aura.cs.cmu.edu>
X-OriginalArrivalTime: 23 Apr 2005 21:25:34.0234 (UTC) FILETIME=[FBFC8FA0:01C5484A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jan Harkes wrote:

> rsync works fine for now, but people are already looking at implementing
> smarter (more efficient) ways to synchronize git repositories by
> grabbing missing commits, and from there fetching any missing tree and
> file blobs. However there is no such linkage to discover missing tag
> objects, only a full rsync would be able to get them and for that it has
> to send the name of every object in the repository to the other side to
> check for any missing ones.

I think that one reason why rsync is inefficient for git is that it 
appears to need an acknowledgement after every file. (at least, that's 
what what the rhythm of the packets looked like when I sniffed it 
earlier, I don't know anything else about it) For a series of very small 
files this interacts badly with tcp's flow control mechanisms. Perhaps 
rsync could be modified for a "sliding file acknowledgement window".

Most "swarming protocols" (e.g BitTorrent, eDonkey) work well for one 
big file shared among multiple hosts, but poorly for lots of small files.

*Nothing* out there matches the simplicity of git's sha1 filename 
length... but

Something like robcast or fcast/flute might be of interest:

http://www.inrialpes.fr/planete/people/roca/mcl/mcl_in_short.html

Or one of the multicast netnews experiments:

"mcntp" http://mcntp.sourceforge.net/
"newscaster" http://www.dmn.tzi.org/en/newscaster.html

lastly, Monotone has it's own "netsync" protocol
(via http://www.venge.net/monotone/faq.html)

"[netsync] is a bi-directional pipelined protocol for synchronizing 
collections using a tree of hashed indices. It allows any copy of 
monotone to function as either a client or a server, and rapidly 
synchronize or half-synchronize (push / pull) their database with 
another user. It is somewhat similar in flavor to rsync or Unison, in 
that it quickly and idempotently synchronizes information across the 
network without needing to store any local state; however, it is much 
more efficient than these protocols."



-- 

Mike Taht


