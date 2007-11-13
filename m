From: Bill Lear <rael@zopyra.com>
Subject: Re: git 1.5.3.5 error over NFS
Date: Tue, 13 Nov 2007 08:49:20 -0600
Message-ID: <18233.47472.890658.729250@lisa.zopyra.com>
References: <18228.32091.865519.312011@lisa.zopyra.com>
	<20071109232106.GA3435@steel.home>
	<18232.29603.856766.275854@lisa.zopyra.com>
	<20071112233309.GI2918@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 15:50:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irx5a-0007vw-Aw
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 15:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986AbXKMOte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 09:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754478AbXKMOte
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 09:49:34 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60789 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753977AbXKMOtd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 09:49:33 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id lADEnVL18073;
	Tue, 13 Nov 2007 08:49:31 -0600
In-Reply-To: <20071112233309.GI2918@steel.home>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64805>

On Tuesday, November 13, 2007 at 00:33:09 (+0100) Alex Riesen writes:
>This is the almost same message I cced to lk and nfs, but with
>Git-interasting parts added.
>
>Bill Lear, Mon, Nov 12, 2007 16:39:15 +0100:
>> On Saturday, November 10, 2007 at 00:21:06 (+0100) Alex Riesen writes:
>> >Bill Lear, Fri, Nov 09, 2007 16:31:39 +0100:
>> >> I've brought this up before, but I don't recall a resolution to it.
>> >> 
>> >> We have an NFS-mounted filesystem, and git pull is choking on it.
>> >> 
>> >> % uname -a
>> >> Linux uhlr.zopyra.com 2.6.9-42.0.2.ELsmp #1 SMP Wed Aug 23 13:38:27 BST 2006 x86_64 x86_64 x86_64 GNU/Linux
>
>It is a really old kernel... Maybe you could try with some of the
>recent ones?

I'll see if we can: the machine in question is a high security one,
and not easy to change.  We haven't seen this sort of problem
elsewhere on our newer systems as far as I know.

>I extend the part you quoted. The file is opened here:
>...
>This is strange. The current git should not produce anything like
>this (and does not, here). ...

You are absolutely correct.  My comrade ran this with 1.5.0.1 by
mistake.  He reran the strace with 1.5.3.5, and I have replaced
the tarball on my server:

    http://www.zopyra.com/~rael/git/git-trace.tar.bz2

With this minor correction (!), here is the last part from
the last file (strace.out.26001):

[...]
write(2, "\n", 1)                       = 1
write(3, "\335\365\205\262RY\360=^h\357\372\274\374_\177\317\357"..., 3712) = 3712
fstat(0, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
open("/etc/mtab", O_RDONLY)             = 4
fstat(4, {st_mode=S_IFREG|0644, st_size=503, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2a955fa000
read(4, "/dev/sda1 / ext3 rw 0 0\nnone /pr"..., 4096) = 503
close(4)                                = 0
munmap(0x2a955fa000, 4096)              = 0
open("/proc/meminfo", O_RDONLY)         = 4
fstat(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2a955fa000
read(4, "MemTotal:     16396892 kB\nMemFre"..., 1024) = 672
close(4)                                = 0
munmap(0x2a955fa000, 4096)              = 0
write(2, "Resolving 562 deltas...\n", 24) = 24
rt_sigaction(SIGALRM, {0x40f610, [], SA_RESTORER|SA_RESTART, 0x32c512e2b0}, NULL, 8) = 0
setitimer(ITIMER_REAL, {it_interval={1, 0}, it_value={1, 0}}, NULL) = 0
pread(3, "", 242, 1268)                 = 0
write(2, "fatal: ", 7)                  = 7
write(2, "cannot pread pack file: No such "..., 49) = 49
write(2, "\n", 1)                       = 1
exit_group(128)                         = ?

Sorry for the mistake.  I think Linus once commented on an alarm
that he found curious in a previous strace I sent for this some
time ago ...


Bill
