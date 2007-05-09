From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user
 manual
Date: Wed, 9 May 2007 22:15:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705092208230.4167@racer.site>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site>
 <20070509031803.GA27980@fieldses.org> <Pine.LNX.4.64.0705091414280.4167@racer.site>
 <20070509123205.GN4489@pasky.or.cz> <Pine.LNX.4.64.0705091447110.4167@racer.site>
 <Pine.LNX.4.64.0705091210570.18541@iabervon.org> <Pine.LNX.4.64.0705091822590.4167@racer.site>
 <20070509170725.GB23778@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Petr Baudis <pasky@suse.cz>, kha@treskal.com, junio@cox.net,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed May 09 22:15:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlsZI-0004XZ-Me
	for gcvg-git@gmane.org; Wed, 09 May 2007 22:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbXEIUPU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 16:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754958AbXEIUPU
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 16:15:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:56713 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751311AbXEIUPS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 16:15:18 -0400
Received: (qmail invoked by alias); 09 May 2007 20:15:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 09 May 2007 22:15:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/+olh0eJH+0lUuX0qB6xhyb8BYR0ED+mK1seUREw
	EVhi96UDbO698l
X-X-Sender: gene099@racer.site
In-Reply-To: <20070509170725.GB23778@fieldses.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46778>

Hi,

On Wed, 9 May 2007, J. Bruce Fields wrote:

> On Wed, May 09, 2007 at 06:25:01PM +0200, Johannes Schindelin wrote:
> > None. I only suspected them to be carried out in byte order. From what I 
> > know, there are some shifts involved, which might or might not be helped 
> > by 32-bit arithmetic.
> > 
> > I did not really look into it.
> > 
> > From my prior debugging experiences on Intel, though, I automatically 
> > looked for the least significant bytes at the beginning of those "sha1" 
> > variables, and came up empty.
> 
> So, I'm confused about what you actually mean by "big endian" here.  I
> originally assumed that you meant that SHA1's are defined as bit arrays,
> and that the first bit of the SHA1 is in the high-order bit of the first
> byte.  But if you just meant that the first byte of the SHA1 is stored
> in the first byte of the array...  that kind of goes without saying,
> doesn't it?

Hm.

Let me explain it in this way:

If you parse a number, passed to a program, with strtol(argv[1], NULL, 0) 
you would expect something like this on an Intel processor:

Input 0x1234 -> memory 0x34 0x12 0x00 0x00.

On a big endian machine, you'd expect 0x00 0x00 0x12 0x34.

That is what endianness means.

If you tell Git that it should look for commit e83c6516..., it will store 
the sha1 as 0xe8 0x3c 0x65 0x16 ... in memory, no matter which 
endianness the processor has.

Which was positively confusing for me, since I automatically searched for 
the sequence 0x90 0xf2 0x4a 0x60 ... (which is the tail of that hash).

But if all this sounds too confusing, I agree to delete the 
"(big-endian)".

Ciao,
Dscho
