From: Theodore Tso <tytso@mit.edu>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Sun, 7 May 2006 21:26:32 -0400
Message-ID: <20060508012632.GD17138@thunk.org>
References: <7v1wv92u7o.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605050806370.3622@g5.osdl.org> <e3fqb9$hed$1@sea.gmane.org> <Pine.LNX.4.64.0605050848230.3622@g5.osdl.org> <46a038f90605052323o29f8bfadr7426f97d8dfc2319@mail.gmail.com> <7vbqubvdbr.fsf@assigned-by-dhcp.cox.net> <46a038f90605062308x53995076k7bf45f0aebcae0c6@mail.gmail.com> <20060507075631.GA24423@coredump.intra.peff.net> <20060508003338.GB17138@thunk.org> <Pine.LNX.4.64.0605071744210.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 03:26:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcuWN-000568-Qx
	for gcvg-git@gmane.org; Mon, 08 May 2006 03:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWEHB0o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 21:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWEHB0o
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 21:26:44 -0400
Received: from thunk.org ([69.25.196.29]:23262 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932245AbWEHB0n (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 21:26:43 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1FcuWI-0007jX-Bb; Sun, 07 May 2006 21:26:42 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.60)
	(envelope-from <tytso@thunk.org>)
	id 1FcuW8-0006QD-TH; Sun, 07 May 2006 21:26:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605071744210.3718@g5.osdl.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19742>

On Sun, May 07, 2006 at 05:50:42PM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 7 May 2006, Theodore Tso wrote:
> >> 
> > If there are 233338 objects, then the average wasted space due to
> > internal fragmentation is 233338 * 2k, or 466676 kilobytes, or only
> > 36% of the wasted space.
> 
> That's not necessarily true.
> 
> That assumes a randomly distributed filesize. File sizes are _not_ random, 
> and in particular if you have the distribution leaning towards <2kB being 
> common, you can actually get >50% fragmentation.
> 
> Btw, I hit this when some people argued that the page size should be made 
> 64kB. The above (incorrect) logic implies that you waste 32kB on average 
> per file. That's not true, if a large fraction of your files are small, in 
> which case you may actually be wastign closer to 60kB on average from 
> using a big page-size, because about half of the kernel files are actually 
> smaller than 4kB (or something. I forget the exact statistics, I did them 
> with a script at some point).
> 
> Anyway, with inode overhead and a lot of objects being just a couple of 
> hundred bytes, I think I estimated at some point that you actually lost 
> closer to 3kB per object.

I just ran the numbers on filesizes of a kernel tree I had handy,
which happened to be 2.6.16.11.  With no object files, git files,
etc. the average loss was 2351 bytes --- not that far away from the
average of 2048 bytes.  Granted, it may be there is more different
versions of small objects causing a skewing of the distributions of
git objects in the 2.6 tree, but I'm not familiar enough with the git
porcelain to be able to make it disgorge the sizes of the repository
to do the math.

						- Ted
