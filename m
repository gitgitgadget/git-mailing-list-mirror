From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Avoid running lstat(2) on the same cache entry.
Date: Sun, 20 Jan 2008 16:10:52 +0100
Message-ID: <15ECE22B-FCBB-4F12-919B-694E48D48E0D@zib.de>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org> <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org> <alpine.LSU.1.00.0801200142170.5731@racer.site>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 20 16:10:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGbot-0002PG-Je
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 16:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754311AbYATPKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 10:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754277AbYATPKQ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 10:10:16 -0500
Received: from mailer.zib.de ([130.73.108.11]:54911 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754181AbYATPKO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 10:10:14 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0KF9pL1012736;
	Sun, 20 Jan 2008 16:09:51 +0100 (CET)
Received: from [192.168.178.21] (brln-4db91f4c.pool.einsundeins.de [77.185.31.76])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0KF9nYI011940
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 20 Jan 2008 16:09:50 +0100 (MET)
In-Reply-To: <alpine.LSU.1.00.0801200142170.5731@racer.site>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71177>


On Jan 20, 2008, at 2:48 AM, Johannes Schindelin wrote:

> On Sat, 19 Jan 2008, Linus Torvalds wrote:
>
>
>> Best time before:
>>
>> 	[torvalds@woody linux]$ time git commit > /dev/null
>> 	real    0m0.399s
>> 	user    0m0.232s
>> 	sys     0m0.164s
>>
>> Best time after:
>>
>> 	[torvalds@woody linux]$ time git commit > /dev/null
>> 	real    0m0.254s
>> 	user    0m0.140s
>> 	sys     0m0.112s
>
> Wow.
>
>> I bet you'll see a much bigger performance improvement from this on
>> Windows in particular.
>
> I bet so, too.  Traditionally, filesystem calls are painfully slow on
> Windows.
>
> But I cannot test before Monday, so I would not be mad if somebody  
> else
> could perform some tests on Windows.

Here are timings for Windows XP running in a virtual machine on a
Laptop.  The work tree contains 7k files.  I stripped user and
sys times because they are apparently meaningless for MINGW.

Best time before:

     $ time git commit >/dev/null
     real    0m1.662s

Best time after:

     $ time git commit >/dev/null
     real    0m1.196s

The absolute time improvement is obviously larger, although the
relative improvement is slightly smaller than in Linus' example.


And here are the timings for the host system, which is Mac OS X,
on the same work tree.

Best time before:

     $ time git commit >/dev/null
     real    0m0.571s
     user    0m0.332s
     sys     0m0.237s

Best time after:

     $ time git commit >/dev/null
     real    0m0.463s
     user    0m0.273s
     sys     0m0.186s

Interestingly, the relative improvements are even smaller on Mac
OS X.

	Steffen
