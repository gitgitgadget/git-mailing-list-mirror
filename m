From: Christopher Faylor <me@cgf.cx>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 2 Mar 2006 10:00:16 -0500
Message-ID: <20060302150016.GC2781@trixie.casa.cgf.cx>
References: <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com> <7vwtfmihts.fsf@assigned-by-dhcp.cox.net> <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com> <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com> <43FD84EB.3040704@op5.se> <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com> <43FDB8CC.5000503@op5.se> <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com> <20060226195552.GA30735@trixie.casa.cgf.cx> <81b0412b0603020610q41d0ec98x80d112b7daa179fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Mar 02 16:01:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEpHx-0004IM-Oa
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 16:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWCBPAS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 10:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWCBPAS
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 10:00:18 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:11502 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1751360AbWCBPAR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 10:00:17 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id 6C2CA5A800C; Thu,  2 Mar 2006 10:00:16 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <81b0412b0603020610q41d0ec98x80d112b7daa179fa@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17075>

On Thu, Mar 02, 2006 at 03:10:30PM +0100, Alex Riesen wrote:
>Christopher, I'm terribly sorry for the long delays,
>but that is something I can't change at this moment.
>
>On 2/26/06, Christopher Faylor <me@cgf.cx> wrote:
>> >>>It's not activestate perl actually.  It's only one platform it also
>> >>>_has_ to support.  Is it worth supporting Windows?
>> >>
>> >>With or without cygwin?  With cygwin, I'd say "yes, unless it makes
>> >>things terribly difficult to maintain and so long as we don't take
>> >>performance hits on unices".  Without cygwin, I'd say "What?  It runs
>> >>on windows?".
>> >
>> >There not much difference with or without cygwin.  The penalties of
>> >doing any kind of support for it will pile up (as they started to do
>> >with pipes).  Someday we'll have to start dropping features on Windows
>> >or restrict them beyond their usefullness.  The fork emulation in
>> >cygwin isn't perfect,
>>
>> If the speed of cygwin's fork is an issue then I'd previously suggested
>> using spawn*.  The spawn family of functions were designed to emulate
>> Windows functions of the same name.  They start a new process without
>> the requirement of forking.
>
>The effort of porting git to spawn-like interface has already started,
>so there's no much left to say about the fork's speed...
>
>> >signals do not work reliably (if at all),
>>
>> I'm not sure if you're mixing cygwin with windows here but if signals do
>> not work reliably in Cygwin then that is something that we'd like to
>> know about.  Signals *obviously* have to work fairly well for programs
>> like ssh, bash, and X to work, however.
>
>That's not enough.
>Try interrupting busy processes. Like "git pull", "git clone" or make.

Are you saying that typing CTRL-C doesn't work when you use "git pull"?
If so, give me a real bug report that I can look into.  I interrupt
"busy" processes on cygwin all of the time so I'm not going to spend a
few hours typing "git pull" on my system only to find out that you are
talking about an environment that uses ActiveState perl on Windows 95
using Netware.

If you are reporting a problem you need to provide details.

>> Native Windows, OTOH, hardly has any signals at all and deals with
>> signals in a way that is only vaguely like linux.
>
>That makes the rest of installed system kind of useless in cygwin
>environment. After interrupting a build process, which uses java
>(don't ask) only make stops. The rest of the process runs happily
>away.

This sounds like a java bug which is entirely unrelated to git.

>Now, I know that windows has no signals at all and nothing which
>even closely resembles them.

Actually, Windows does understand CTRL-C and any native windows console
program should honor CTRL-C in a manner similar to UNIX, i.e., if the
program doesn't trap SIGINT with 'signal()', it will cause the program
to terminate.  There are also other mechanisms for a native windows
program to deal with CTRL-C so this really shouldn't be an issue for
any well-written program.

>I wont be pressing anyone to implement them in windows, having the
>knowledge.  What I'd actually suggest is to drop their implementation
>entierly, returning ENOSYS,

You're not being clear again, but if you are actually promoting the
notion of cygwin not implementing signals then that is a really daft
idea.  Really.  Go to the Cygwin web site and look at all of the
packages which have been ported.  Now think about how they would work if
Cygwin didn't support signals.  bash wouldn't work, openssh, X wouldn't
work.

>so that programs are not fooled into believing that the system will
>work as expected.  It never will.  "Ctrl-C" in windows console is just
>a shortcut to TerminateProcess, live with that.

Let me say it again since it isn't clear that you are getting it.  If
signals in a pure cygwin environment don't work then that is *a bug*.
If you are running pure windows programs in the mix with cygwin programs
then if *they* don't stop when you hit CTRL-C, that is undoubtedly a bug
in that pure windows program.

If you find that a pure windows program terminates when run from a
windows command prompt but keeps running when run by a cygwin program
then that is likely a cygwin problem that can be reported to the cygwin
mailing list.

>>>filesystem is slow and locked down, and exec-attribute is NOT really
>>>useful even on NTFS (it is somehow related to execute permission and
>>>open files.  I still cannot figure out how exactly are they related).
>>
>>Again, it's not clear if you're talking about Windows or Cygwin but
>>under Cygwin, in the default configuration, the exec attribute means
>>the same thing to cygwin as it does to linux.
>
>I'm talking about git and native windows interaction:

I'd suggest that using git with native windows programs should probably
be considered "unsupported" since you seem to be having so much trouble
with it.

>I cannot use umask, because I have to use stupid windows programs, and
>they always create "executable" *.c and *.h, and I cannot blindly
>remove it with something like "chmod -R -x", because it'd remove it
>also from executables.

  find . -name '*.[ch]' | xargs chmod a-x

>The poor executables lose their _rights_ to be executed (why does
>cygwin use windows permissions?  They cannot correlate to unix
>attributes, can they?)

Please read the Cygwin user's guide for a discussion about how file
permissions are implemented.  And, then, when you are outraged about how
unclear that documentation is please send comments and improvements to
the cygwin mailing list.

I don't see why it is appropriate to be discussing how Cygwin implements
UNIX permissions in this mailing list unless the implementation affects
git somehow.

cgf
