From: Petr Baudis <pasky@suse.cz>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 06:50:25 +0200
Message-ID: <20070518045025.GT4489@pasky.or.cz>
References: <200705170539.11402.andyparkins@gmail.com> <7v4pmcauu3.fsf@assigned-by-dhcp.cox.net> <20070517215841.GB29259@mellanox.co.il> <200705180141.06862.Josef.Weidendorfer@gmx.de> <464CF435.1010405@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri May 18 06:50:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HouQG-000386-Gj
	for gcvg-git@gmane.org; Fri, 18 May 2007 06:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870AbXEREu2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 00:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756199AbXEREu2
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 00:50:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58353 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754870AbXEREu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 00:50:27 -0400
Received: (qmail 31970 invoked by uid 2001); 18 May 2007 06:50:25 +0200
Content-Disposition: inline
In-Reply-To: <464CF435.1010405@midwinter.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47570>

On Fri, May 18, 2007 at 02:32:53AM CEST, Steven Grimm wrote:
> For example -- and yes, this is partially a rehash of other people's 
> ideas -- instead of mapping a subproject path directly to revision@URL, 
> instead map it to revision@symbolic name. The symbolic name is then 
> separately mapped to a URL, and it's that symbolic name that can be 
> locally overridden. The mappings of symbolic names to URLs is 
> unversioned; the mapping of subprojects to revision@symbolic is 
> versioned. Local overrides happen at the symbolic->URL mapping.
> 
> So you'd have something like
> 
> version 1: kernel-src/ -> kernel24
> version 2: kernel-src/ -> kernel26
> unversioned:
>    kernel24 -> git://whatever/2.4
>    kernel26 -> git://whatever/2.6
> 
> And then locally, the override is:
> 
>    kernel24 -> git://myhost/2.4

Yes, this would be nice; in one of my first mails in this thread I
devoted a non-trivially large writeup to this, then proceeded to remove
it since this has a serious problem.

Actually, Git already has a nice mechanism to handle these unversionaed
pointers - tags. Just make refs/tags/subproject/kernel24 containing the
URL to fetch. It's even easily overridable locally (and not easily
overridable remotely...).

The problem is ugly too, though - suddenly, you have created a SINGLE
UNIVERSE-WIDE NAMESPACE INSIDE A DISTRIBUTED VCS. And that's not going
to work well. I think I don't have to elaborate too much - the
aforementioned FreeBSD people will have different ideas about kernels
than you, _you_ will have different idea about kernels in few tens of
years than now, then if you need to merge or probably even fetch, you
will get into big trouble.

Notice that we don't have any such namespace right now (except the
D(SHA1) namespace, which is however possible only because it's so huge
_and_ the names are assigned automagically in a way that virtually
guarantees uniqueness across the whole universe) - tags come closest,
but there is nothing that fundamentally breaks when a clash happens
inside the namespace - it's just UI thing. But subproject names are
etched to the history - once you name it, you just can't get rid of it
forever.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
