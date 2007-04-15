From: Alan Larkin <nobrow@eircom.net>
Subject: Re: fatal: Out of memory, malloc failed
Date: Sun, 15 Apr 2007 20:06:53 +0100
Message-ID: <462277CD.5020609@eircom.net>
References: <461FBD02.6050105@eircom.net> <Pine.LNX.4.64.0704131143130.28042@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Apr 15 21:07:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdA4E-0001zu-El
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 21:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbXDOTGr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 15:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753381AbXDOTGr
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 15:06:47 -0400
Received: from mail02.svc.cra.dublin.eircom.net ([159.134.118.18]:12629 "HELO
	mail02.svc.cra.dublin.eircom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753376AbXDOTGr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Apr 2007 15:06:47 -0400
Received: (qmail 89464 messnum 5242090 invoked from network[86.42.230.88/unknown]); 15 Apr 2007 19:06:45 -0000
Received: from unknown (HELO ?192.168.1.6?) (86.42.230.88)
  by mail02.svc.cra.dublin.eircom.net (qp 89464) with SMTP; 15 Apr 2007 19:06:45 -0000
User-Agent: Thunderbird 1.5.0.10 (X11/20070330)
In-Reply-To: <Pine.LNX.4.64.0704131143130.28042@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44505>

Linus Torvalds wrote:
> 
> On Fri, 13 Apr 2007, Alan Larkin wrote:
>> Its not a huge push Im trying to do here (<about 150Mb) but always malloc fails!
> 
> Any huge objects?
> 
> Also, it might be interesting to run it under gdb, and put a breakpoint on 
> the "die" function, so that it stops where it runs out of memory. Then. at 
> that point, you can:
> 
>  - do a "where" in gdb to see what allocation it is (and ask it how big 
>    it was by printing out the value of "size").
> 
>    It may be something totally uninteresting (just some random object that 
>    happened to push things over the limit), but statistically, malloc 
>    failures tend to happen to big objects, and sometimes just because 
>    somebody needed a huge area that won't fit in the virtual address 
>    space.
> 
>  - check with "ps" what the size of the process is. Maybe you even just 
>    have some process limit set that causes brk/mmap to return failure 
>    earlier than necessary..
> 
>    (It can also be interesting to look at /proc/<pid>/maps, in case
>    there are big mmaps that fill up the VM etc)
> 
> Sometimes it's also a good idea to have a swap file.  You may not even
> *need* to actually page, but it gives thew VM layer much more freedom,
> especially if your distro has set the flags to disable memory "overcommit".
> 
> 		Linus
> 
> 

There were a couple of big files. I removed a 72Mb one (making 47Mb the biggest one left in the
project) and made the push and it worked. I later pulled the project down to a different machine,
added the 72Mb file back in, and pushed to the server and it worked. So apparently it's a platform
specific problem. If anybody's particularly interested I could replicate it under gdb and pass on
any info, but if not I wont ... job's done, Im happy.
