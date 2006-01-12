From: Andreas Ericsson <ae@op5.se>
Subject: Re: git binary size...
Date: Thu, 12 Jan 2006 14:49:36 +0100
Message-ID: <43C65E70.7090702@op5.se>
References: <Pine.LNX.4.64.0601111021450.5073@g5.osdl.org>	 <43C558FB.3030102@op5.se>	 <Pine.LNX.4.64.0601111134560.5073@g5.osdl.org> <2cd57c900601120215pdb5da27l@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jan 12 14:49:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex2ph-0002Wh-J4
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 14:49:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWALNti (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 08:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWALNti
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 08:49:38 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:47272 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932194AbWALNth
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 08:49:37 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id C93136BD00
	for <git@vger.kernel.org>; Thu, 12 Jan 2006 14:49:36 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <2cd57c900601120215pdb5da27l@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14562>

Coywolf Qi Hunt wrote:
> 2006/1/12, Linus Torvalds <torvalds@osdl.org>:
> 
>>
>>On Wed, 11 Jan 2006, Andreas Ericsson wrote:
>>
>>>strip:
>>>      strip $(PROGRAMS)
>>>
>>>install: strip
>>
>>Well, that ends up shaving some more from the binaries, but at a much
>>bigger cost than just removing "-g".
>>
>>With stripped binaries, you can't really do _anything_. You get a
>>core-file, and you're screwed.
> 
> 
> Are you sure?
> 
> gemini:~> file `which mke2fs`
> /sbin/mke2fs: ELF 32-bit LSB executable, Intel 80386, version 1
> (SYSV), for GNU/Linux 2.2.0, dynamically linked (uses shared libs),
> stripped
> 
> gemini:~> file /lib/libext2fs.so.2.4
> /lib/libext2fs.so.2.4: ELF 32-bit LSB shared object, Intel 80386,
> version 1 (SYSV), stripped
> 
> (gdb) bt
> #0  0xb7f16445 in ext2fs_mark_generic_bitmap () from /lib/libext2fs.so.2
> #1  0xb7f110ed in ext2fs_reserve_super_and_bgd () from /lib/libext2fs.so.2
> #2  0xb7f18353 in ext2fs_initialize () from /lib/libext2fs.so.2
> #3  0x0804b461 in ?? ()
> #4  0xbf84b9ad in ?? ()
> #5  0x00000000 in ?? ()
> 
> So with stripped binary, I still get the backtrace to locate the buggy
> function. IMO, Debian packages are build with -g.
> 

No, you don't. The last three stack-frames resolve to no symbol. 
Libraries always contain symbol names. You wouldn't be able to use them 
if they didn't, because the dynamic linker uses those symbols to look up 
the address of the function to call.

> 
> To make git not tight to Linux, but cross platform, consider autoconf.
> 

git is already fairly portable without the autoconf hackery. It's easy 
enough to move some of the conditional stuff out of the Makefile without 
autoconf, but it would still require GNU Make, so there's no real point 
in doing so.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
