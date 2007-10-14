From: Eli Zaretskii <eliz@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 00:41:38 +0200
Message-ID: <u7ilpjp3x.fsf@gnu.org>
References: <1192293466.17584.95.camel@homebase.localnet>
	<uy7e6keyv.fsf@gnu.org>
	<1192381040.4908.57.camel@homebase.localnet>
	<1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
	<47125F74.9050600@op5.se>
	<Pine.LNX.4.64.0710141934310.25221@racer.site>
	<47126957.1020204@op5.se>
	<Pine.LNX.4.64.0710142112540.25221@racer.site>
	<20071014221446.GC2776@steel.home>
Reply-To: Eli Zaretskii <eliz@gnu.org>
Cc: git@vger.kernel.org, ae@op5.se, Johannes.Schindelin@gmx.de,
	make-w32@gnu.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org Mon Oct 15 00:42:39 2007
Return-path: <make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org>
Envelope-to: gnu-make-w32@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhCAE-00006w-5T
	for gnu-make-w32@m.gmane.org; Mon, 15 Oct 2007 00:42:26 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1IhCA7-0002fZ-Io
	for gnu-make-w32@m.gmane.org; Sun, 14 Oct 2007 18:42:19 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1IhC9p-0002Qp-7B
	for make-w32@gnu.org; Sun, 14 Oct 2007 18:42:01 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1IhC9o-0002Pu-Lh
	for make-w32@gnu.org; Sun, 14 Oct 2007 18:42:00 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1IhC9o-0002Pi-55
	for make-w32@gnu.org; Sun, 14 Oct 2007 18:42:00 -0400
Received: from romy.inter.net.il ([213.8.233.24])
	by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <eliz@gnu.org>) id 1IhC9n-0004W6-OB
	for make-w32@gnu.org; Sun, 14 Oct 2007 18:41:59 -0400
Received: from HOME-C4E4A596F7 (IGLD-80-230-5-89.inter.net.il [80.230.5.89])
	by romy.inter.net.il (MOS 3.7.3-GA)
	with ESMTP id JCP88932 (AUTH halo1);
	Mon, 15 Oct 2007 00:41:28 +0200 (IST)
In-reply-to: <20071014221446.GC2776@steel.home> (message from Alex Riesen on
	Mon, 15 Oct 2007 00:14:46 +0200)
X-detected-kernel: by monty-python.gnu.org: FreeBSD 4.7-5.2 (or MacOS X
	10.2-10.4) (2)
X-BeenThere: make-w32@gnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: Discussion of Windows-specific issues with GNU make <make-w32.gnu.org>
List-Unsubscribe: <http://lists.gnu.org/mailman/listinfo/make-w32>,
	<mailto:make-w32-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/make-w32>
List-Post: <mailto:make-w32@gnu.org>
List-Help: <mailto:make-w32-request@gnu.org?subject=help>
List-Subscribe: <http://lists.gnu.org/mailman/listinfo/make-w32>,
	<mailto:make-w32-request@gnu.org?subject=subscribe>
Sender: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org
Errors-To: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60923>

> Date: Mon, 15 Oct 2007 00:14:46 +0200
> From: Alex Riesen <raa.lkml@gmail.com>
> Cc: Andreas Ericsson <ae@op5.se>, Benoit SIGOURE <tsuna@lrde.epita.fr>,
> 	git list <git@vger.kernel.org>, Eli Zaretskii <eliz@gnu.org>,
> 	Make Windows <make-w32@gnu.org>
> 
> Re "functional". Have to remind something (besides the fork):

That's a 20-20 hindsight: if you deliberately write a program to rely
heavily on Posix-isms, don't be surprised when you discover that it
cannot be easily ported to other platforms.

> - no proper VFS

I'm not sure what you are talking about.  What VFS do you use on
GNU/Linux that cannot work on Windows, and why do you use it?

> - no proper filename semantics (case-insensitivity and stupid rules for
>   allowed characters in filenames, like ":" in filenames in
>   cross-platform projects)

There's a flag on Windows to open files case-sensitively, if you need
that.  In any case, I don't see how this can be of any real relevance
to porting GIT.  As for ":" in file names, simply don't use it, like
you don't use white space or characters below 32 decimal: it's
inconvenient, even if it's allowed.

> - no acceptable level of performance in filesystem and VFS (readdir,
>   stat, open and read/write are annoyingly slow)

With what libraries?  Native `stat' and `readdir' are quite fast.
Perhaps you mean the ported glibc (libgw32c), where `readdir' is
indeed painfully slow, but then you don't need to use it.

> - it is the only OS in the world with multi-root (/a/b/c and /a/b/c
>   can be not the same, depending on what current "drive" is)

So what? on Unix "a/b/c" can be not the same.  Both cases are simply
not complete file names, that's all.  No one said there must be a
single root for all volumes, it's the Posix jingoism creeping in
again.

>   and multi-cwd

No longer a problem on Windows versions since 2000.

> - no real "mmap" (which kills perfomance and complicates code)

You only need mmap because you are accustomed to use it on GNU/Linux.

> Interprocess communication:
> 
> - no reliable text environment (I'm programming in the damn thing for
>   10 years and I still don't know how to pass an environment variable
>   _for_sure_)
> 
> - it has only one argument (limited in size) passed to started
>   programs, which means that there is no possible way to safely pass
>   file and text arguments on command line (more than one, that is)

Not enough context, so I cannot talk intelligently about this.  Why do
you need interprocess communication in the first place? why not simply
give birth to a subsidiary process and pass it a command line (which
can be up to 32KB)?
