From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 09:44:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710150936070.25221@racer.site>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710150039120.25221@racer.site> <E1IhIwR-0006be-Ki@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: raa.lkml@gmail.com, ae@op5.se, tsuna@lrde.epita.fr,
	git@vger.kernel.org, make-w32@gnu.org
To: Eli Zaretskii <eliz@gnu.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 10:44:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhLYu-0003Le-F9
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 10:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565AbXJOIoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 04:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755455AbXJOIoV
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 04:44:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:60393 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755452AbXJOIoT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 04:44:19 -0400
Received: (qmail invoked by alias); 15 Oct 2007 08:44:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 15 Oct 2007 10:44:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+TkLFXdPCTMNCdpIbatzO/GQeKZbKPd46nIPG0n3
	0elIXZEUVxn4H0
X-X-Sender: gene099@racer.site
In-Reply-To: <E1IhIwR-0006be-Ki@fencepost.gnu.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60963>

Hi,

On Mon, 15 Oct 2007, Eli Zaretskii wrote:

> > Date: Mon, 15 Oct 2007 00:45:47 +0100 (BST)
> > From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > cc: Alex Riesen <raa.lkml@gmail.com>, ae@op5.se, tsuna@lrde.epita.fr, 
> >     git@vger.kernel.org, make-w32@gnu.org
> > 
> > The problem is not so much opening, but determining if an existing file 
> > and a file in the index have the same name.
> > 
> > For example, "README" in the index, but "readme" in the working directory, 
> > will be handled as "deleted/untracked" by the current machinery.  IOW git 
> > will not know that what it gets from readdir() as "readme" really is the 
> > same file as "README" in the index.
> 
> That's because you think file names are simple strings and can be
> compared by simple string comparison.

Almost...

> This na?ve view is not true even on POSIX systems: "foo/bar" and 
> "/a/b/foo/bar" can be the same file, as well as "/a/b/c/d" and "/x/y/z", 
> given the right symlinks.

... not quite, ah ...

> But for some reason that eludes me, people who are accustomed to POSIX
> stop right there and in effect say "file names are strings, if we only
> make them absolute and resolve links".

... yes!  There you have it.  Absolute filenames, resolved by readlink() 
are assumed to be the unique (!) identifiers for the contents.

_Note:_ absolute paths _without_ readlink() resolving are _still_ unique 
identifiers; this time for files/symlinks.

Things like this utter rubbish that two different file names (which are 
the keys in the keystore that a filesystem really is) make Windows' 
filesystem operations so slow.

I wonder when Windows heads will realise that this "convenience" is just 
another reason why Windows is easily outperformed by other OSes (yes, the 
last one is a plural).

> > > > - no acceptable level of performance in filesystem and VFS 
> > > >   (readdir, stat, open and read/write are annoyingly slow)
> > > 
> > > With what libraries?  Native `stat' and `readdir' are quite fast. 
> > > Perhaps you mean the ported glibc (libgw32c), where `readdir' is 
> > > indeed painfully slow, but then you don't need to use it.
> > 
> > No, native.
> 
> Can you show a test case where this penalty is clearly visible?  I'm 
> curious to see the numbers.  TIA

No, I cannot.  I will not go and buy a copy of Windows just to show you 
the numbers.

Since quite some time I only run Linux on my machine(s), and the reason 
was a very unscientific experiment: I kept with the OS that did not freeze 
and let me do nothing for more than one second.

Now, that is my _personal_ decision.  If _you_ have no problem with 
Windows, just stick with it.  (I always thought this goes without saying, 
but Windows users tend to be very religious about this issue, thinking 
just because I hate Windows that I want to make them switch.  Hahaha, no.)

Ciao,
Dscho
