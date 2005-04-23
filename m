From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: Git transfer protocols (was: Re: Git-commits mailing list feed)
Date: Sat, 23 Apr 2005 18:22:33 -0400
Message-ID: <20050423222226.GB16751@delft.aura.cs.cmu.edu>
References: <20050422002922.GB6829@kroah.com> <426A4669.7080500@ppp0.net> <1114266083.3419.40.camel@localhost.localdomain> <426A5BFC.1020507@ppp0.net> <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org> <20050423183406.GD20410@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0504231228480.2344@ppc970.osdl.org> <20050423204957.GA16751@delft.aura.cs.cmu.edu> <426ABE1B.7000905@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Harkes <jaharkes@cs.cmu.edu>,
	Linus Torvalds <torvalds@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 00:18:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPSx6-0006xL-GK
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 00:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVDWWWy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 18:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVDWWWy
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 18:22:54 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:19932 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S262149AbVDWWWm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 18:22:42 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DPT1F-0005GX-00; Sat, 23 Apr 2005 18:22:33 -0400
To: Mike Taht <mike.taht@timesys.com>
Mail-Followup-To: Mike Taht <mike.taht@timesys.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	Linus Torvalds <torvalds@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <426ABE1B.7000905@timesys.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 23, 2005 at 02:28:59PM -0700, Mike Taht wrote:
> Jan Harkes wrote:
> 
> >rsync works fine for now, but people are already looking at implementing
> >smarter (more efficient) ways to synchronize git repositories by
> >grabbing missing commits, and from there fetching any missing tree and
> >file blobs. However there is no such linkage to discover missing tag
> >objects, only a full rsync would be able to get them and for that it has
> >to send the name of every object in the repository to the other side to
> >check for any missing ones.

Actually I just realized that I personally probably wouldn't care about
most of the tags that people might add to their trees. Maybe once in a
while, but the tag would probably be obtained through email or the web.

> I think that one reason why rsync is inefficient for git is that it 
...
> lastly, Monotone has it's own "netsync" protocol
> (via http://www.venge.net/monotone/faq.html)

Interesting, probably something like any of these might end up useful to
replace rsync for mirroring full git repositories.

I'm actually more selfish than that and am thinking on how I expect to
use git.

See, I don't care about most of the objects in the repository. In
practice I would probably pull only the latest 'head' once in a while
look for missing commits to give me a quick overview of what has
changed. Then if a diff between the new head and my current tree shows
that anything might have changed in an area I actually do care about,
such as the VFS, I'd want something that does a quick binary search to
identify the commits where the changes occured. But for that I only
need to look at a limited number of tree objects.

As long as I know that someone, somewhere is archiving the whole
repository I can always come back later and fill in the blanks.

HTTP/1.1 with persistent connections and some request interleaving is
probably the fastest and most server friendly way to grab those objects
I really care about.

Jan

