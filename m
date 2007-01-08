From: Theodore Tso <tytso@mit.edu>
Subject: Re: How git affects kernel.org performance
Date: Mon, 8 Jan 2007 09:17:55 -0500
Message-ID: <20070108141755.GF32756@thunk.org>
References: <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org> <20070107085526.GR24090@1wt.eu> <20070107011542.3496bc76.akpm@osdl.org> <20070108030555.GA7289@in.ibm.com> <20070108125819.GA32756@thunk.org> <20070108134147.GB5291@linuxtv.org> <20070108135622.GD32756@thunk.org> <20070108135952.GF25857@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Stezenbach <js@linuxtv.org>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Willy Tarreau <w@1wt.eu>,
	Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 08 15:23:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3vOr-0001Pa-E2
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 15:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161313AbXAHOWv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 09:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161314AbXAHOWu
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 09:22:50 -0500
Received: from thunk.org ([69.25.196.29]:49386 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161312AbXAHOWt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 09:22:49 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1H3vOU-0003rw-7U; Mon, 08 Jan 2007 09:22:34 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1H3vJz-0005qW-5c; Mon, 08 Jan 2007 09:17:55 -0500
To: Pavel Machek <pavel@ucw.cz>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, Pavel Machek <pavel@ucw.cz>,
	Johannes Stezenbach <js@linuxtv.org>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Willy Tarreau <w@1wt.eu>,
	Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070108135952.GF25857@elf.ucw.cz>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36264>

On Mon, Jan 08, 2007 at 02:59:52PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > Would e2fsck -D help? What kind of optimization
> > > does it perform?
> > 
> > It will help a little; e2fsck -D compresses the logical view of the
> > directory, but it doesn't optimize the physical layout on disk at all,
> > and of course, it won't help with the lack of readahead logic.  It's
> > possible to improve how e2fsck -D works, at the moment, it's not
> > trying to make the directory be contiguous on disk.  What it should
> > probably do is to pull a list of all of the blocks used by the
> > directory, sort them, and then try to see if it can improve on the
> > list by allocating some new blocks that would make the directory more
> > contiguous on disk.  I suspect any improvements that would be seen by
> > doing this would be second order effects at most, though.
> 
> ...sounds like a job for e2defrag, not e2fsck...

I wasn't proposing to move other data blocks around in order make the
directory be contiguous, but just a "quick and dirty" try to make
things better.  But yes, in order to really fix layout issues you
would have to do a full defrag, and it's probably more important that
we try to fix things so that defragmentation runs aren't necessary in
the first place....

						- Ted
