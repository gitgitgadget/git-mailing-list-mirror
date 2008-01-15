From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file descriptor
Date: Tue, 15 Jan 2008 11:26:03 -0600
Message-ID: <478CECAB.2030906@nrlssc.navy.mil>
References: <4787E981.7010200@nrlssc.navy.mil> <478C1D7A.6090103@nrlssc.navy.mil> <alpine.LFD.1.00.0801142140560.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, drafnel@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 15 18:28:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEpa9-0004V5-6J
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 18:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbYAOR1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 12:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbYAOR1o
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 12:27:44 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33818 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbYAOR1n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 12:27:43 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0FHQ33W013180;
	Tue, 15 Jan 2008 11:26:04 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 15 Jan 2008 11:26:03 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LFD.1.00.0801142140560.2806@woody.linux-foundation.org>
X-OriginalArrivalTime: 15 Jan 2008 17:26:03.0669 (UTC) FILETIME=[B44F1C50:01C8579B]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15666001
X-TM-AS-Result: : Yes--14.788700-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1NzA0Mi03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwNDI1Ny03MDE5MzctNzA1NTg0LTcwNTg2MS03?=
	=?us-ascii?B?MDE0MDMtNzAzNzQ3LTcwMTQ1NS03MDM3MTItNzAwNjE4LTcwNzgy?=
	=?us-ascii?B?NS0xMDU2MzAtNzAxMzA1LTEzOTUwNC03MDM3ODgtNzAyOTQyLTcw?=
	=?us-ascii?B?ODI1Ny03MDQyNDctNzExOTUzLTcwMjYzOC03MDE3MDgtNzAwMzI0?=
	=?us-ascii?B?LTcxMDczOS0xMzc3MTctNzA0OTI3LTcwMzUyOS03MDAyNjQtMTg4?=
	=?us-ascii?B?MDE5LTcwMDk3MS03MDAzOTgtNzA2NDU0LTcwMDg2OS0xNDgwMzkt?=
	=?us-ascii?B?MTQ4MDUxLTIwMDQy?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70537>

Linus Torvalds wrote:
> 
> On Mon, 14 Jan 2008, Brandon Casey wrote:
>> To reiterate, I only have problems with the builtin-commit,
>> i.e. 1.5.4.*, the 1.5.3.* series works correctly. Of course
>> if this is a memory corruption issue, then it could just be
>> that the pattern of memory accesses in 1.5.3 does not tweak
>> the problem.
> 
> Can you do an strace of the failure case and put it up on some public 
> place (it's likely going to be too big to send as email)?

I did the strace. Below is the last screenful of lines.

Do you have a suggestion for a public place to upload? I do not have
one of my own, and I've never used any of the 'free' services. The
strace log is about 8.5MB, compressed to about 500K.

$ git --version
git version 1.5.4.rc3.11.g4e67

Not that it's important, but looks like the file descriptor that
is closed too soon is 3. I got 6 when running under gdb. This is
also using the latest version of git. The results are the same
with either version (including the fd#) so I just used this one.

Junio C Hamano wrote:
> What platform is this on?

$ cat /etc/redhat-release
CentOS release 4.5 (Final)

i686

> Does it reliably reproduce for any commit in the repository, or
> reliably reproduce for one particular commit, or sometimes
> reprooduce for one particular commit?

Reliably for one particular commit.

Additional commits on top of this commit complete successfully.

If this commit is amended without error by amending with '-C HEAD'
or by using a 1.5.3 version, then additional amends or commits
will not produce the error.

-brandon


16170 mmap2(NULL, 417, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb1699000
16170 close(3)                          = 0
16170 munmap(0xb1699000, 417)           = 0
16170 stat64("/home/casey/auto_v3.5/src_temp2/.git/objects/67/981a61208756cf4973
7ec065e7bc0d7ff1a89d", {st_mode=S_IFREG|0444, st_size=417, ...}) = 0
16170 open("/home/casey/auto_v3.5/src_temp2/.git/objects/67/981a61208756cf49737e
c065e7bc0d7ff1a89d", O_RDONLY|O_LARGEFILE) = 3
16170 mmap2(NULL, 417, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb1699000
16170 close(3)                          = 0
16170 munmap(0xb1699000, 417)           = 0
16170 stat64("/home/casey/auto_v3.5/src_temp2/.git/objects/4e/7c1178482f4b3c52e8
afce15db3bc8419530d2", {st_mode=S_IFREG|0444, st_size=417, ...}) = 0
16170 open("/home/casey/auto_v3.5/src_temp2/.git/objects/4e/7c1178482f4b3c52e8af
ce15db3bc8419530d2", O_RDONLY|O_LARGEFILE) = 3
16170 mmap2(NULL, 417, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb1699000
16170 close(3)                          = 0
16170 munmap(0xb1699000, 417)           = 0
16170 stat64("/home/casey/auto_v3.5/src_temp2/.git/objects/02/3777b3c0e5f7697deb
2ce738c6b38b1ec2b17c", {st_mode=S_IFREG|0444, st_size=417, ...}) = 0
16170 open("/home/casey/auto_v3.5/src_temp2/.git/objects/02/3777b3c0e5f7697deb2c
e738c6b38b1ec2b17c", O_RDONLY|O_LARGEFILE) = 3
16170 mmap2(NULL, 417, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb1699000
16170 close(3)                          = 0
16170 munmap(0xb1699000, 417)           = 0
16170 mmap2(NULL, 996168, PROT_READ, MAP_PRIVATE, 3, 0) = -1 EBADF (Bad file des
criptor)
16170 munmap(0xb56bd000, 33554432)      = 0
16170 mmap2(NULL, 996168, PROT_READ, MAP_PRIVATE, 3, 0) = -1 EBADF (Bad file des
criptor)
16170 write(2, "fatal: Out of memory? mmap faile"..., 55) = 55
16170 write(1, "Created commit ", 15)   = 15
16170 exit_group(128)                   = ?
