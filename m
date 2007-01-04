From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Wed, 3 Jan 2007 19:13:40 -0800
Message-ID: <20070104031340.GA15094@localdomain>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com> <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org> <20070104023350.GA1194@localdomain> <86ps9vbjlp.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Lee <chris133@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Shawn Pearce <spearce@spearce.org>,
	Sasha Khapyorsky <sashak@voltaire.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 04 04:14:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2J35-0002xM-CT
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 04:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbXADDNo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 22:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbXADDNo
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 22:13:44 -0500
Received: from hand.yhbt.net ([66.150.188.102]:60142 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932266AbXADDNn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 22:13:43 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id B4E237DC094;
	Wed,  3 Jan 2007 19:13:41 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 03 Jan 2007 19:13:41 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86ps9vbjlp.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35914>

"Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> >>>>> "Eric" == Eric Wong <normalperson@yhbt.net> writes:
> 
> Eric> Part of it is Perl, which (as far as I know) never frees allocated
> Eric> memory back to the OS (although Perl can reuse the allocated memory for
> Eric> other things).
> 
> It does on Linux, of all things.  That's because Linux has a smarter
> malloc/free that uses mmap(2) for the large chunks.  On Linux, Perl memory
> size can apparently grow and shrink nicely.  The "old school" advice about
> Perl comes from sbrk(2)-driven malloc/free.
> 
> Try:
> 
>         $x[1e6] = "0";
>         sleep 10; # do a ps here
>         @x = ();
>         sleep 30; # do a ps here
> 
> and watch the process on Linux.  If I'm right, this should show a large
> process,  then a smaller one.

Nope, not happening to me.  I'm using Perl 5.8.8-7 and glibc 2.3.6.ds1-8
on a Debian Etch machine.  The kernel is a vanilla 2.6.18.1 from
kernel.org.

strace shows an mmap2 call, but no corresponding mumap.  I've added a
sleep loop to the end of the above program and had it print
something every 10 seconds; but so far, there's still no munmap.

while (1) {
        print "hi\n" if ((time % 10) == 0);
	sleep 1;
}

Trying to allocate a bigger chunk (1e7) doesn't show anything different,
either.  I've also conducted similar experiments with Ruby in the past
and noticed the same things...

-- 
Eric Wong
