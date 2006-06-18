From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Sun, 18 Jun 2006 15:36:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606181532130.5498@g5.osdl.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com> 
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com> 
 <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com> 
 <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org> 
 <Pine.LNX.4.64.0606111747110.2703@localhost.localdomain> 
 <Pine.LNX.4.64.0606181223580.5498@g5.osdl.org>
 <46a038f90606181440q4fd03bebl9495ace131eb958@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Jon Smirl <jonsmirl@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 19 00:37:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fs5t9-0000NN-I2
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 00:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWFRWhA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 18:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWFRWhA
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 18:37:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27077 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750856AbWFRWg7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 18:36:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5IMargt005538
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Jun 2006 15:36:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5IMaqKY006288;
	Sun, 18 Jun 2006 15:36:53 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606181440q4fd03bebl9495ace131eb958@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22109>



On Mon, 19 Jun 2006, Martin Langhoff wrote:
> 
> No problems here with my latest import run. fsck-objects --full comes
> clean, takes 14m:
>
> /usr/bin/time git-fsck-objects --full
> 737.22user 38.79system 14:09.40elapsed 91%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (20807major+19483471minor)pagefaults 0swaps

It takes much less than that for me: 

	408.40user 32.56system 7:22.07elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (145major+13455672minor)pagefaults 0swaps

and in particular note the much lower minor pagefaults number (which is a 
very good approximation of total RSS). Mine is with all the memory 
optimizations in place, but I didn't see _that_ big of a difference, so 
there's something else in addition.

However, the fact that I get "SHA1 mismatch with itself" is strange. The 
re-pack will always re-generate the SHA1, so I worry that this is perhaps 
some PPC-specific bug in SHA1 handling (and it's entirely possible that 
it's triggered by doing a SHA1 over a 500+MB area).

The fact that you don't see it is indicative that it's somehow specific to 
my setup.

> BTW, that import (with the latest code Junio has) took 37hs even with
> the aggressive repack -a -d. I want to bench it dropping the -a from
> the recurrring repack, and doing a final repack -a -d.

Yeah, that's probably the right thing to do. The "-a" is ok with tons of 
memory, and I'm trying to make it ok with _less_ memory, but it's probably 
just not worth it.

		Linus
