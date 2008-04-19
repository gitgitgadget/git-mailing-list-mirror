From: Roman Shaposhnik <rvs@sun.com>
Subject: Re: Git performance on OS X
Date: Sat, 19 Apr 2008 16:35:55 -0700
Message-ID: <A07C1A99-084B-4DFC-90CB-B8BDAF7E72EF@sun.com>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl>
 <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org>
 <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl>
 <m3od85qxcl.fsf@localhost.localdomain>
 <alpine.LFD.1.10.0804191547320.2779@woody.linux-foundation.org>
 <alpine.LFD.1.10.0804191551540.2779@woody.linux-foundation.org>
 <0BE9BBE3-EA9D-4A66-A086-A2A1B289B0DD@ai.rug.nl>
 <alpine.LFD.1.10.0804191619240.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 20 01:36:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnMbz-0003b2-4D
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 01:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbYDSXgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 19:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403AbYDSXgD
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 19:36:03 -0400
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:43630 "EHLO
	brmea-mail-4.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbYDSXgB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 19:36:01 -0400
Received: from fe-amer-10.sun.com ([192.18.109.80])
	by brmea-mail-4.sun.com (8.13.6+Sun/8.12.9) with ESMTP id m3JNa0gU021971
	for <git@vger.kernel.org>; Sat, 19 Apr 2008 23:36:00 GMT
Received: from conversion-daemon.mail-amer.sun.com by mail-amer.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JZL00901IRM5H00@mail-amer.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Sat, 19 Apr 2008 17:36:00 -0600 (MDT)
Received: from [192.168.0.100] ([129.150.64.103])
 by mail-amer.sun.com (Sun Java System Messaging Server 6.2-8.04 (built Feb 28
 2007)) with ESMTPSA id <0JZL00948IVYIM90@mail-amer.sun.com>; Sat,
 19 Apr 2008 17:36:00 -0600 (MDT)
In-reply-to: <alpine.LFD.1.10.0804191619240.2779@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79936>

On Apr 19, 2008, at 4:26 PM, Linus Torvalds wrote:
> This is the WebKit archive, right?
>
> For me, doing a "time git status ." on the WebKit thing I just  
> cloned from
> git://git.webkit.org/WebKit.git is much faster: 1.264s (and it goes  
> down
> by maybe 5-10% with my lstat-avoidance patch).
>
> Is there any system-level profiler for OS X to get a clue where  
> that cost
> is, in case it's not the lstat() at all?

If it happens on Leopard, DTrace would be a perfect way to query the  
system:

   $ dtrace -n 'syscall::*:entry /pid==$target/ { @[probefunc] = count 
(); }' -c "git <do stuff>"

E.g.:

$ dtrace -n 'syscall::*:entry /pid==$target/ { @[probefunc] = count 
(); }' -c "echo Hello World"
dtrace: description 'syscall::*:entry ' matched 234 probes
Hello World
dtrace: pid 1325 has exited

   fstat64                                                           1
   getpid                                                            1
   getrlimit                                                         1
   ioctl                                                             1
   mmap                                                              1
   munmap                                                            1
   rexit                                                             1
   sysi86                                                            1
   setcontext                                                        2
   write                                                             2


Thanks,
Roman.
