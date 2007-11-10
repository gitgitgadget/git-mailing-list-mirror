From: bob <kranki@mac.com>
Subject: Re: git packs
Date: Sat, 10 Nov 2007 01:00:27 -0500
Message-ID: <FC175E4F-D9BE-42CC-B0BB-561B2EDCD941@mac.com>
References: <F6DD8DCD-416B-4DDF-B384-7213C9ED5565@mac.com> <alpine.LFD.0.9999.0711100011150.21255@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 10 07:00:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqjOp-0004o9-Ux
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 07:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbXKJGAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 01:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbXKJGAh
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 01:00:37 -0500
Received: from smtpoutm.mac.com ([17.148.16.81]:56237 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341AbXKJGAg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 01:00:36 -0500
Received: from mac.com (asmtp007-s [10.150.69.70])
	by smtpoutm.mac.com (Xserve/smtpout018/MantshX 4.0) with ESMTP id lAA60aKT005239
	for <git@vger.kernel.org>; Fri, 9 Nov 2007 22:00:36 -0800 (PST)
Received: from [192.168.2.23] (c-66-176-54-4.hsd1.fl.comcast.net [66.176.54.4])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp007/MantshX 4.0) with ESMTP id lAA60YvU001342
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Fri, 9 Nov 2007 22:00:35 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0711100011150.21255@xanadu.home>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64305>

When you say toolchain, are you referring to the compiler
and associated libraries or are you referring to OS programs
such as ls, md5, cat, etc or both?

The reason that I ask is that I have been playing different
scenarios using git 1.5.3.5 under MacOSX 10.4.10 mostly
all day and every time that

A) 	a file approaches or exceeds 2gig on an 'add', it
	results in:
	
	fatal: Out of memory? mmap failed: Cannot allocate memory



B) 	the repository size less the .git subdirectory approaches
	4gig on a 'fetch' it results in:

	Resolving 3356 deltas...
	fatal: serious inflate inconsistency: -3 (unknown compression method)
	fatal: index-pack died with error code 128
	fatal: Fetch failure: ../rmwHtmlOld

	Under B, building the initial repository works fine.

(I added a patch the Linus Torvalds gave out when a previous inflate  
problem
was being researched.)  Also, I have been looking in the source
in particular in builtin-add.c builtin-pack-objects.c and associated  
headers
and see int and unsigned long being used a lot, but not any unsigned  
long
longs.  I have been testing on my laptop which has a 32-bit Intel  
Core Duo.
Also, I have run the same tests on a dual quad-core Intel processor
which is 64 bit, (but not sure that Apple uses the 64 bits in  
10.4.10).  I
get the same results as above.

The zlib is at the latest revision of 1.2.3 and gcc is at 4.0.1
which from what I can tell supports large files, because 'off_t' is 8  
bytes
which is the size used for a 'stat' file size.

I am just wondering if these size limitations exist for MacOSX
or maybe I am doing something wrong (which is probably
the case).


On Nov 10, 2007, at 12:13 AM, Nicolas Pitre wrote:

> On Fri, 9 Nov 2007, bob wrote:
>
>> When a repository is packed such as for a clone or fetch, is there  
>> just one
>> pack file created that is used for the transfer?
>
> Yes.
>
> And modern Git is able to handle packs larger than 4GB too,  
> assuming it
> is compiled using a toolchain with large file support.
>
>
> Nicolas
> -
