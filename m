From: Theodore Tso <tytso@mit.edu>
Subject: Re: Linus' sha1 is much faster!
Date: Sat, 15 Aug 2009 20:06:40 -0400
Message-ID: <20090816000640.GA7554@mit.edu>
References: <4A85F270.20703@draigBrady.com> <3e8340490908151302y33a97d50t38ad0a8a788f1cee@mail.gmail.com> <43d8ce650908151312o6a43416el27965c4b0ab8d83d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Donlan <bdonlan@gmail.com>,
	=?iso-8859-1?Q?P=E1draig?= Brady <P@draigbrady.com>,
	Bug-coreutils@gnu.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 16 02:12:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McTLz-00081o-US
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 02:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbZHPAGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 20:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbZHPAGu
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 20:06:50 -0400
Received: from thunk.org ([69.25.196.29]:40039 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803AbZHPAGu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 20:06:50 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1McTGj-000095-Vd; Sat, 15 Aug 2009 20:06:42 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1McTGi-0002sx-7L; Sat, 15 Aug 2009 20:06:40 -0400
Content-Disposition: inline
In-Reply-To: <43d8ce650908151312o6a43416el27965c4b0ab8d83d@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126045>

On Sat, Aug 15, 2009 at 09:12:58PM +0100, John Tapsell wrote:
> 2009/8/15 Bryan Donlan <bdonlan@gmail.com>:
> > coreutils is licensed under GPLv3, and git under GPLv2 (only), so
> > you'd need permission from all contributors to the implementation in
> > order to relicense under GPLv3. A quick grep of the history suggests
> > these contributors to be:
> 
> X11 also requires a fast SHA1 implementation.  It uses this to check
> if two pixmaps are the same.  So it would be really nice to relicense
> under a liberal enough license that xorg can use it.

If the checksum isn't being exposed in the protocol (i.e., it's just
internal to the X server), one possibility for X11 is to consider to
use the SHA-3 candidate Skein instead.  After receiving a large amount
of evaluation by cryptographic experts, it was one of the 18
algorithms (our of an original 64 entries) that have made it the 2nd
round of the NIST competition.  It's also *substantially* faster than
SHA:

    One exception to this is Skein, created by several well-known
    cryptographers and noted pundit Bruce Schneier. It was designed
    specifically to exploit all three of the Core 2 execution units
    and to run at a full 64-bits. This gives it roughly four to 10
    times the logic density of competing submissions.

    This is what I meant by the Matrix quote above. They didn't bend
    the spoon; they bent the crypto algorithm. They moved the logic
    operations around in a way that wouldn't weaken the crypto, but
    would strengthen its speed on the Intel Core 2.

    In their paper (PDF), the authors of Skein express surprise that a
    custom silicon ASIC implementation is not any faster than the
    software implementation. They shouldn't be surprised. Every time
    you can redefine a problem to run optimally in software, you will
    reach the same speeds you get with optimized ASIC hardware. The
    reason software has a reputation of being slow is because people
    don't redefine the original problem.

    http://www.darkreading.com/blog/archives/2008/11/bending_skein_c.html

For more information and some optimized implementation, see:

	http://www.skein-hash.info/

							- Ted
