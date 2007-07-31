From: Theodore Tso <tytso@mit.edu>
Subject: Re: Efficient way to import snapshots?
Date: Tue, 31 Jul 2007 00:23:47 -0400
Message-ID: <20070731042347.GG25876@thunk.org>
References: <20070730180710.GA64467@nowhere> <alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org> <20070730192922.GB64467@nowhere> <alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org> <20070730222028.GE64467@nowhere> <alpine.LFD.0.999.0707301629230.4161@woody.linux-foundation.org> <20070731011707.GA91930@nowhere> <alpine.LFD.0.999.0707301825130.4161@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Craig Boston <craig@olyun.gank.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 06:24:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFjHI-0005bn-K6
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 06:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976AbXGaEYH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 00:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754497AbXGaEYG
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 00:24:06 -0400
Received: from thunk.org ([69.25.196.29]:33749 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbXGaEYD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 00:24:03 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IFjPN-0001fw-9V; Tue, 31 Jul 2007 00:32:33 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1IFjGt-0005xi-9I; Tue, 31 Jul 2007 00:23:47 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707301825130.4161@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54319>

On Mon, Jul 30, 2007 at 06:44:13PM -0700, Linus Torvalds wrote:
> > 1st or maybe 2nd-gen Willamette CPU
> > 512MB memory (stupid motherboard that won't accept more)
> > Slow disks in RAID-5 configuration
> > Running ZFS with less than half of the recommended minimum memory, to
> > the point where I had to reduce the number of vnodes that the kernel is
> > allowed to cache to avoid running out of KVA
> 
> Oh, ok. Solaris.
> 
> With slow pathname lookup, and hard limits on the inode cache sizes.
> 
> Git really normally avoids reading the data, so even in 512M you should 
> _easily_ be able to cache the metadata (directory and inodes), which is 
> all you need. But yeah, Linux will probably do that a whole lot more 
> aggressively than Solaris does.

I also have a suspicion that ZFS's "never overwrite metadata" is
causing its inodes to be be scattered all over the disk, so the lack
of cacheing is hurting even more than it would for other filesystems.
(Put another way, there's probably a really good reason for ZFS's
minimum memory recommendations.)

Craig, it might be interesting to see what sort of results you get if
you use UFS instead of ZFS in your low-memory constrained
environment...

						- Ted
