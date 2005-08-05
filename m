From: Linus Torvalds <torvalds@osdl.org>
Subject: gitk "hyperlinks" (was Re: Display of merges in gitk)
Date: Fri, 5 Aug 2005 07:37:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508050710460.3258@g5.osdl.org>
References: <17130.56620.137642.941175@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0508050658260.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 05 16:40:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E13LZ-0002Ac-0z
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 16:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVHEOi1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Aug 2005 10:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVHEOiS
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Aug 2005 10:38:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15280 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262481AbVHEOh6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2005 10:37:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j75EbgjA000507
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 5 Aug 2005 07:37:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j75Ebf5p016983;
	Fri, 5 Aug 2005 07:37:42 -0700
To: Paul Mackerras <paulus@samba.org>,
	Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <Pine.LNX.4.58.0508050658260.3258@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


[ Also Kay Sievers, because the clickability thing sounds like a 
  potentially good thing for webgit too.. ]

For 2.6.13 we've been reverting some stuff lately, to make sure we get a 
stable release. That's fine, and when I revert something I try to mention 
the commit ID of the thing I revert in the message. Apparently others do 
too, as indicated by a patch I just got from Petr Vandovec. So we've got 
for example:

	889371f61fd5bb914d0331268f12432590cf7e85:
	Author: Linus Torvalds <torvalds@g5.osdl.org>  2005-07-30 13:41:56
	Committer: Linus Torvalds <torvalds@g5.osdl.org>  2005-07-30 13:41:56

    Revert "yenta free_irq on suspend"
    
    ACPI is wrong.  Devices should not release their IRQ's on suspend and
    re-aquire them on resume.  ACPI should just re-init the IRQ controller
    instead of breaking most drivers very subtly.
    
    Breakage reported by Hugh Dickins <hugh@veritas.com>
    
    Undo: d8c4b4195c7d664baf296818bf756775149232d3
    
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

and

	403fe5ae57c831968c3dbbaba291ae825a1c5aaa:
	Author: Petr Vandrovec <vandrove@vc.cvut.cz>  2005-08-05 06:50:07
	Committer: Linus Torvalds <torvalds@g5.osdl.org>  2005-08-05 06:57:44

    [PATCH] rtc: msleep() cannot be used from interrupt
    
    Since the beginning of July my Opteron box was randomly crashing and
    being rebooted by hardware watchdog.  Today it finally did it in front
    of me, and this patch will hopefully fix it.
    
    The problem is that at the end of June (the 28th, to be exact: commit
    47f176fdaf8924bc83fddcf9658f2fd3ef60d573, "[PATCH] Using msleep()
    instead of HZ") rtc_get_rtc_time ...

and when I use gitk, it would be just too damn cool for words if I could 
easily follow the SHA1's mentioned in the commit message.

I can just cut-and-paste the SHA1, and I've verified that it works fine. 
However, as you'v enoticed, I'm of the whiny kind, and I thought it could 
be easier. So I'm whining again.

<whine>Mommy, mommy, can you make my life easier</whine>

So I noticed that I really would like two things:

 - "clickable" SHA1's in commit messages would be really really cool if 
   something like that is even possible with tcl/tk.

   Now, if you can highlight them when showing the message, that would be 
   extra cool, but even without any highlighing, the thing actually 
   _almost_ works fine already: you can double-click the SHA1, and it will 
   select it. You then have to move the mouse to the "goto" window, and 
   paste in the SHA1 there. And this is where it would be good if this 
   sequence could be simplified a bit.

   Even if it's something as simple as accepting the SHA1 paste into the 
   same window (not having to go to the "goto" window: just double-click 
   on the SHA1, and then right-click to "paste it back").

 - I'd like to have a "back button". Not just for the above kind of thing, 
   but in general too: when searching for something, it would just be very 
   nice if gitk just kept a list of the <n> last commits that have 
   been selected, and there was a web-browser-like button that went 
   back/forward in history.

   But especially when looking at a revert, I just want to first go to the 
   thing we revert, see what's going on there (get the "historical 
   perspective" - commit log for why the original was done etc), and then 
   I'd want to go back (and possibly forth and back again ;). And while 
   the revert mentioned the thing it reverted (so I could cut-and-paste), 
   the thing it reverted obviously does _not_ mention the thing that 
   reverted it, so now I have to manually just scroll back.

   This same thing happens for a failed search (I search for xyz, and it 
   actually finds it, and I realize that that was the wrong search, but
   now I'm two months back..)

<whine>Mommy, mommy, pleeeease</whine>

			Linus
