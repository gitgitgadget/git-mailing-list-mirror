From: Christer Weinigel <christer@weinigel.se>
Subject: Re: CRLF problems with Git on Win32
Date: Fri, 11 Jan 2008 20:53:49 +0100
Message-ID: <20080111205349.00ebccd9@weinigel.se>
References: <C3AC3E6F.10D42%jefferis@gmail.com>
	<alpine.LFD.1.00.0801101556380.3148@woody.linux-foundation.org>
	<7EAB1DA8-627D-455E-AA23-C404FDC615D9@zib.de>
	<alpine.LFD.1.00.0801110756260.3148@woody.linux-foundation.org>
	<D36EB89D-11A3-4EAF-BC1C-6100383FCBFC@zib.de>
	<alpine.LFD.1.00.0801110924380.3148@woody.linux-foundation.org>
	<930EC77A-73D1-4DDD-81D4-BF22B248FCB6@zib.de>
	<alpine.LFD.1.00.0801111005360.3148@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Gregory Jefferis <jefferis@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 21:04:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDQ6s-0002iL-T9
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 21:04:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759759AbYAKUDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 15:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760249AbYAKUDm
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 15:03:42 -0500
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:40060 "EHLO
	zoo.weinigel.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759691AbYAKUDl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 15:03:41 -0500
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jan 2008 15:03:41 EST
Received: from localhost.localdomain (grue.localnet [10.128.0.1])
	by zoo.weinigel.se (Postfix) with ESMTP id 9F47D124110F;
	Fri, 11 Jan 2008 20:53:49 +0100 (CET)
In-Reply-To: <alpine.LFD.1.00.0801111005360.3148@woody.linux-foundation.org>
X-Mailer: Claws Mail 3.0.2 (GTK+ 2.12.1; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70195>

On Fri, 11 Jan 2008 10:10:00 -0800 (PST)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 11 Jan 2008, Steffen Prohaska wrote:
> > Ah sorry, I misunderstood you in [1].  I thought your last point
> > "Mixed Windows usage" meant what I have in mind:  A user working
> > in a mixed Windows/Unix environment who creates a file using
> > Windows tools and commits it in the Unix environment.  In this
> > case the CRLF file will be transferred from Windows to Unix
> > without git being involved.  The right thing for git on Unix is
> > to remove CRLF during a commit but still write only LF during
> > check out.  So autocrlf=input is the right choice.
> 
> Oh, ok, I didn't realize.
> 
> But yes, if you use a network share across windows and Unixand
> actually *share* the working tree over it, then yes, you'd want
> "autocrlf=input" on the unix side.
> 
> However, I think that falls under the "0.1%" case, not the "99.9%"
> case.

That's how I work all the time.  My Linux box is a Samba server where I
check things out from perforce (with the "share" settings for end of
line which means that text files are checked out with LF only and CRLF
is converted to LF on checkin).  Having the data on the Linux box is
nice since I can have all the nice Unix tools such as sed, find, grep,
and they run fast on a native Linux system, which is not true about
cygwin on Windows.  

> I realize that people probably do that more often with centralized 
> systems, but with a distributed thing, it probably makes a *ton* more 
> sense to have separate trees. But I could kind of see having a shared 
> development directory and accessing it from different types of
> machines too.

We're working in a mixed environment, and even though I do most of my
development on Linux I usually want to make sure that things build in
Visual Studio before I check in, so the easiest thing to do is to point
Visual Studio at the files on the Samba share.  Same thing when using
Altera's tools to do CPLD development, I run the Altera tools on
Windows (their free version is Windows only) but all the files are on
the Linux box.  My tools that take the SVF file (the "binary image" for
the CPLD) and program the CPLD all run under Linux though.

A lot of my colleagues have Windows on the desktop, and when they
develop on Linux they usually edit the files locally using the Samba
share, and then they have a Putty (ssh) connected to the Linux box
where they build and test the software.

So the shared scenario is actually a very common one for us.

> I'd also bet that crlf behavior of git itself will be the *least* of
> your problems in that situation. You'd have all the *other* tools to
> worry about, and would probably be very aware indeed of any CRLF
> issues. So  at that point, the "automatic" or default behaviour is
> probably not a big deal, because everything _else_ you do likely
> needs special effort too!

Actually I seldom have any problems with CRLF at all.  Sometimes
the Xilinx or Altera editors will insert some stray CRLFs in some files,
but all the tools I use seem to tolerate that.  And as soon as I check
in the CRLFs disappear anyway.  We just have to make sure to turn on
the "share" setting in our Perforce views and everything just works.

  /Christer
