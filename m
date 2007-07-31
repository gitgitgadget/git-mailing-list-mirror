From: Craig Boston <craig@olyun.gank.org>
Subject: Re: Efficient way to import snapshots?
Date: Tue, 31 Jul 2007 08:53:32 -0500
Message-ID: <20070731135332.GA58867@nowhere>
References: <20070730180710.GA64467@nowhere> <alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org> <20070730192922.GB64467@nowhere> <alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org> <20070730222028.GE64467@nowhere> <alpine.LFD.0.999.0707301629230.4161@woody.linux-foundation.org> <20070731011707.GA91930@nowhere> <alpine.LFD.0.999.0707301825130.4161@woody.linux-foundation.org> <20070731042347.GG25876@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 31 15:53:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFsAO-00009u-Ph
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 15:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755758AbXGaNxh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 09:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755343AbXGaNxh
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 09:53:37 -0400
Received: from ion.gank.org ([69.55.238.164]:1135 "EHLO ion.gank.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755739AbXGaNxf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 09:53:35 -0400
Received: by ion.gank.org (Postfix, from userid 1001)
	id 472FC11246; Tue, 31 Jul 2007 08:53:33 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070731042347.GG25876@thunk.org>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54351>

On Tue, Jul 31, 2007 at 12:23:47AM -0400, Theodore Tso wrote:
> On Mon, Jul 30, 2007 at 06:44:13PM -0700, Linus Torvalds wrote:
> > 
> > Oh, ok. Solaris.

For reference, as I mentioned to Linus & Junio in an excessively
verbose, and probably uninteresting to most of the git-list members,
message about the performance characteristics of ZFS, I'm actually
running FreeBSD-current with the experimental port of ZFS.

So, even less tested & tuned than it is on Solaris.  Part of what I'm
doing is stress testing the filesystem on machines with less than the
recommended memory.  Even if performance is suboptimal, it should at
least not break anything.

> Craig, it might be interesting to see what sort of results you get if
> you use UFS instead of ZFS in your low-memory constrained
> environment...

I just so happen to be rebuilding the zfs pool on that server this
morning in order to add more swap, so your wish(1tcl) is my rcmd(3).

Same machine, on a UFS filesystem (single disk, since zfs was doing the
RAID), with the cache tuning parameters reset back to defaults:

First 'git status' after a reboot:
git status  2.23s user 2.23s system 17% cpu 24.987 total

Second:
git status  1.81s user 1.34s system 98% cpu 3.188 total

Third:
git status  1.76s user 1.45s system 98% cpu 3.252 total

So I definitely think the problem is just that with its increased
overhead, ZFS simply can't keep all the metadata in the cache with the
available memory.

Craig
