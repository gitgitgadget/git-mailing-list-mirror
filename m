From: Bill Lear <rael@zopyra.com>
Subject: Re: git 1.5.3.5 error over NFS
Date: Mon, 12 Nov 2007 09:39:15 -0600
Message-ID: <18232.29603.856766.275854@lisa.zopyra.com>
References: <18228.32091.865519.312011@lisa.zopyra.com>
	<20071109232106.GA3435@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 16:39:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrbO2-0000Gb-5r
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 16:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbXKLPj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 10:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbXKLPj0
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 10:39:26 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61956 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbXKLPjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 10:39:25 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id lACFdMY28787;
	Mon, 12 Nov 2007 09:39:22 -0600
In-Reply-To: <20071109232106.GA3435@steel.home>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64641>

On Saturday, November 10, 2007 at 00:21:06 (+0100) Alex Riesen writes:
>Bill Lear, Fri, Nov 09, 2007 16:31:39 +0100:
>> I've brought this up before, but I don't recall a resolution to it.
>> 
>> We have an NFS-mounted filesystem, and git pull is choking on it.
>> 
>> % uname -a
>> Linux uhlr.zopyra.com 2.6.9-42.0.2.ELsmp #1 SMP Wed Aug 23 13:38:27 BST 2006 x86_64 x86_64 x86_64 GNU/Linux
>> 
>> % git --version
>> git version 1.5.3.5
>> 
>> % git pull
>> remote: Generating pack...
>> remote: Done counting 998 objects.
>> remote: Result has 836 objects.
>> remote: Deltifying 836 objects.
>> remote:  100% (836/836) done
>> Indexing 836 objects...
>> remote: Total 836 (delta 526), reused 688 (delta 380)
>>   100% (836/836) done
>> Resolving 526 deltas...
>> fatal: cannot pread pack file: No such file or directory
>
>Could you please strace it? With strace -ff?
>
>> fatal: index-pack died with error code 128
>> fatal: Fetch failure: git://source/repo
>> 
>> I looked through the archives of this list and did not see a final
>> resolution, other than a suspected bug in the OS NFS code.
>
>Strace, just to be on the safe side

Ok, I've done the strace -ff.  It has generated 176 strace.out.<pid>
files.  I have placed a tarball of these files on my home server:

  http://www.zopyra.com/~rael/git/git-trace.tar.bz2

The file strace.out.25526 has, at the very end:

[...]
open("/etc/mtab", O_RDONLY)             = 4
fstat64(0x4, 0xffff6810)                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0x1000) = 0xfffffffff7ffd000
read(4, "/dev/sda1 / ext3 rw 0 0\nnone /pr"..., 4096) = 503
close(4)                                = 0
munmap(0xf7ffd000, 4096)                = 0
open("/proc/meminfo", O_RDONLY)         = 4
fstat64(0x4, 0xffff6c7c)                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0x1000) = 0xfffffffff7ffd000
read(4, "MemTotal:     16396892 kB\nMemFre"..., 1024) = 672
close(4)                                = 0
munmap(0xf7ffd000, 4096)                = 0
write(2, "Resolving 551 deltas.\n", 22)                               = 22
pread64(3, "", 242, 541) = 0
write(2, "fatal: ", 7)                  = 7
write(2, "cannot pread pack file: Success", 31) = 31
write(2, "\n", 1)                       = 1
exit_group(128)                         = ?

Here is the clipped output of running the strace command:

[...]
[ Process PID=25347 runs in 32 bit mode. ]
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
[ Process PID=25347 runs in 64 bit mode. ]
[ Process PID=25349 runs in 32 bit mode. ]
[...]
[ Process PID=25366 runs in 64 bit mode. ]
[ Process PID=25365 runs in 32 bit mode. ]
ptrace: umoven: Input/output error
[ Process PID=25366 runs in 64 bit mode. ]
[ Process PID=25365 runs in 32 bit mode. ]
[...]
[ Process PID=25365 runs in 32 bit mode. ]
[ Process PID=25366 runs in 64 bit mode. ]
ptrace: umoven: Input/output error
[ Process PID=25365 runs in 32 bit mode. ]
[ Process PID=25366 runs in 64 bit mode. ]
[...]
[ Process PID=25385 runs in 32 bit mode. ]
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
[...]
[ Process PID=25385 runs in 64 bit mode. ]
[ Process PID=25482 runs in 32 bit mode. ]
[ Process PID=25396 runs in 64 bit mode. ]
[ Process PID=25524 runs in 32 bit mode. ]
remote: Generating pack...
remote: Done counting 1052 objects.
remote: Result has 882 objects.
remote: Deltifying 882 objects.
  100% (882/882) done82) done
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
umovestr: Input/output error
Indexing 882 objects.
  100% (882/882) done
Resolving 551 deltas.
remote: Total 882 (delta 551), reused 716 (delta 387)
fatal: cannot pread pack file: Success
fatal: index-pack died with error code 128
[ Process PID=25522 runs in 64 bit mode. ]
Fetch failure: git://source/fusion


Bill
