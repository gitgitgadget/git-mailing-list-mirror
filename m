From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 02:53:32 -0400
Message-ID: <20070726065332.GB18114@spearce.org>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com> <46A73015.7020306@midwinter.com> <a1bbc6950707251956h3db847c9v8db438f4c665b2cf@mail.gmail.com> <20070726031546.GN32566@spearce.org> <08588116-8E66-4F40-BC77-E0B272BE7776@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 08:53:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDxEG-000799-1Z
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 08:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758092AbXGZGxj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 02:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757296AbXGZGxj
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 02:53:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42534 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385AbXGZGxh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 02:53:37 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IDxE6-0007yD-FF; Thu, 26 Jul 2007 02:53:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7A02D20FBAE; Thu, 26 Jul 2007 02:53:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <08588116-8E66-4F40-BC77-E0B272BE7776@zib.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53790>

Steffen Prohaska <prohaska@zib.de> wrote:
> On Jul 26, 2007, at 5:15 AM, Shawn O. Pearce wrote:
> >git-gui is fairly well supported under Cygwin, as I use it a lot
> >in my day-job.  As do a lot of my coworkers.  Which actually gives
> >me a pretty good testing ground; ~20 people all beating on git-gui
> >all day long is a pretty sizable testing group.  I actually wonder
> >some days if git-gui is better tested on Cygwin than it is on Linux.
> 
> So apparently you're working in a reasonably sized group of people all
> testing git on cygwin. I'd be completely satisfied if git ran rock solid
> on cygwin.

It is just as rock solid as it is on Mac OS X (my real Git
development system) and Solaris.  If your Cygwin DLL does not
support pread() you do need to compile with NO_PREAD=1, but that's
a minor issue.  Personally I build Git on Cygwin with pread() and
mmap() enabled and it runs fine.  Of course we only use it on local
drives, and only on NTFS drives.

As has been stated already, Git's checksums work nicely to make
sure data hasn't been corrupted.  I've seen one user have trouble
with checksums failing in his repository.  Usually he recopies it
from another user and picks up where he left off.  Twice I've seen
his packfile corrupted and Git caught the corruption.  We seriously
suspect some bad blocks on his drive.  But budget says we cannot
replace the disk for another 4 years.
 
> I found the following list of warnings about cygwin in the wiki
> entry WindowsInstall [1]. Some points look quite scary to me.
> 
> What is your real-world experience? Are the warning still valid?
> Must I really fear to break cygwin if I press Ctrl-C?

Its not that Cygwin breaks.  Its that sometimes pressing Ctrl-C
doesn't actually stop the process, e.g. the signal isn't sent or
just gets ignored.  So its annoying because you can't abort things
as readily as you might on a good UNIX.  Sometimes you get weird
stack traces from a Git process when you Ctrl-C it.  But I also see
this same garbage out of a native Windows JVM when I Ctrl-C it from
a Cygwin bash.  Its just general Cygwin-ism or something.

Despite those failures I've never seen that stack dump actually
corrupt Git data.  Think about it.  Git needs to be safe on any
platform, even if the running Git program terminates unexpectedly
in the middle of an operation, such as because of an OOM from the
kernel, or an angry admin `kill -9`ing it.  So this little stack
spew is just annoying more than anything.
 
> Do I really need to reboot regularly? I don't think this is an
> option. Nowadays our Windows boxes run for months, too. I can't
> seriously tell people that they need to regularly reboot if they
> want to use git.

I *never* reboot my Windows system at day-job.  Except when our
local adminstration staff shoves some Microsoft uber-patch down
onto our systems and that patch forces us to reboot the machine.
So I never reboot for Cygwin (or Git's) sake.  Ever.

> Here's the list, copied from http://git.or.cz/gitwiki/WindowsInstall
> 
>    * Use git on local NTFS disks -- Network drives disks don't  
> support the filesystem semantics GIT needs; for interoperability  
> purposes you can store bare repositories on FAT32 disks.

Still true.  Network drives have some issues as the SMB protocol
doesn't support everything nicely.  NTFS locally is fine.  FAT32 has
issues with mmap() not being well supported.  If you must use
FAT32 compile Git with NO_MMAP.  Which is the default on Cygwin,
as a lot of people still use FAT32.

>    * Be careful with the case in filenames. Similarly, avoid special  
> chars in filenames.

This is true.  Git doesn't like getting file names with case only
differences on such a platform.  E.g. just today I wanted to do
the following:

  git mv foo.c Foo.c

but had to instead do:

  git mv foo.c CRAP && git mv CRAP Foo.c

because the former won't work on a filesystem that ignores case.
I have the same problem on my Mac OS X HFS+ volume as it also
ignores case.

>    * Run git gc early and often. There are slowdowns with many  
> unpacked objects. Be careful to not create very big packfiles (bigger  
> than 2 Gb).

Both of these are still true.  git-gui on Windows suggests a repack
if you have ~256 loose objects, on UNIX platforms it suggest a repack
at ~2048 loose objects.  The problem is really just a performance
issue, the more files we have to open to access data the slower
things go.  The loose objects tend to be the really recent stuff
(that's why they aren't packed yet) and the really recent stuff
tends to be what is accessed most.

Opening 200 files takes time on Windows.  Its just a limitation
of the OS apparently.  And its a fundamental property of the Git
object store that we always write to loose objects first, as its
fast and easy to make safe.

Another aside to this is `git grep --cached` or `git grep ... TREE`
is *always* faster for me then grepping the working directory.
The first two will return nearly instantly (tiny lag) while the
working directory grep will take days.  On Linux and Mac OS X the
exact reverse is true, the working directory grep is usually faster
if the disk cache is hot.

>    * Avoid using ActiveState Perl if possible. Ask in the  
> MailingLists if you must.

Yea, we've had some issues with that.  This comes from one particular
user (Alex Riesen) who uses Cygwin but for strange reasons is
not allowed to use the Cygwin perl and instead must only use the
ActiveState Perl.  We've had some issues in the past with our Perl
scripts running on that perl port.  Alex has fixed many of them,
but some may still be lurking.

>    * Try to avoid interrupting (Ctrl-C) processes - it breaks cygwin.

Already talked about above.

>    * Consider setting core.fileMode to false (git repo-config  
> core.fileMode false) if file modes are frequently the only  
> differences detected by Git. Many Windows applications make the  
> execute bit be set in Cygwin when they save a file. Besides Cygwin  
> detects file mode by stupid combination of content analysis, file  
> name extension and moon phase.

We currently default core.fileMode to false on Cygwin, for this
very reason.  We used to not do that.  We got smarter and realized
that although Cygwin itself (and all Cygwin tools) will properly
handle the executable bit on NTFS native Windows tools (e.g. Eclipse)
won't.  Users use the native Windows tools, then blame Git.  So we
disable it.

>    * Insert "set CYGWIN=tty binmode" after the first line of C: 
> \cygwin\cygwin.bat, so you can use Ctrl-z in cygwin's bash to suspend  
> a program.

Oooooh.  I did not know this tip.  I still just cuss at Cygwin
anytime I want to suspend a job and cannot.

>    * Windows usually writes end-of-line as CRLF, while Unix/POSIX  
> writes LF. This can cause a variety of problems. There are current  
> efforts to address this.

See the crlf feature in gitattributes.  You can now have Git create
working tree files in CRLF format, but check them into the object
database with only LF.

>    * Setup binary mode for cygwin (there is an option in cygwin's  
> setup program), otherwise Cygwin mangles everything read and written  
> (Git repos have binary files in control structures).

I think binary mode is the default now on Cygwin.  It used to not
be.  Because of this problem.

>    * Avoid big repos.

Yea, sort of.  I'm using about 180M (fully packed as best as I can
make Git do) and its fine.  I don't know what a definition of "big"
is.

>    * Avoid big blobs (very big files. Basically anything larger than  
> 10Mb is too big).

This I can't speak to.  All of my blobs are source code, so they
are small-ish.

>    * Avoid big trees (directories with many files in them).

Probably true.  Most of my trees are reasonably well distributed
(they aren't that big).  I think my largest is 900 files in the
same directory.

>    * Avoid deep hierarchies.

I/use/java/programs/on/windows/and/much/of/my/source/is/in/that/format.
:-)  I don't really have issues with deep trees, and I have some
pretty darn deep source code trees.

>    * Reboot regularly (memory fragmentation)

Don't see that.

>    * Defragment often (filesystems fragmentation)

Yes!  Very much so.  The packfiles are the first things to fragment,
and what with all of the small files that Git creates, especially
with frequent branch switching, and then the small object files
that my build system creates, my drive is almost always completely
fragmented.

Which reminds me, I need to defrag again...

-- 
Shawn.
