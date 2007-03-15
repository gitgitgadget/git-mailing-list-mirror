From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/5] diff --quiet
Date: Wed, 14 Mar 2007 23:47:42 -0700
Message-ID: <7vy7lz3svl.fsf@assigned-by-dhcp.cox.net>
References: <7vwt1j8z0e.fsf@assigned-by-dhcp.cox.net>
	<7vodmv7bza.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703141614m70f4a565qc001e06e60b0ffd5@mail.gmail.com>
	<7v8xdz5qn0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703141728350.9690@woody.linux-foundation.org>
	<7v4pon5mg3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 15 07:47:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRjka-00087e-GQ
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 07:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422859AbXCOGrp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 02:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422857AbXCOGrp
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 02:47:45 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:61764 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422859AbXCOGro (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 02:47:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070315064744.WAFP748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 15 Mar 2007 02:47:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aunj1W0031kojtg0000000; Thu, 15 Mar 2007 02:47:43 -0400
In-Reply-To: <7v4pon5mg3.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 14 Mar 2007 18:23:40 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42271>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> Personally, I think it's more interesting if this can make a difference 
>> for something like
>>
>> 	git log v2.6.12.. -- drivers/ > /dev/null
>>
>> but that would require that we actually understand that we can stop early 
>> if we ever get to REV_TREE_DIFFERENT. I didn't check if you actually did 
>> that optimization.
>
> The code is supposed to be there, but I haven't benched.

Now I have.

In the kernel repository, I ran this with 'master' version and 'next'
version.  The latter uses the --quick mechanism in try_to_simplify.

$ /usr/bin/time git log -r --raw v2.6.19..master -- drivers/ | wc -l

Three runs on a reasonably quiescent machine (hot cache).

* next (i.e. with the --quick)

5.50user 0.10system 0:05.61elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+15191minor)pagefaults 0swaps

5.50user 0.08system 0:05.58elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+15191minor)pagefaults 0swaps

5.42user 0.07system 0:05.49elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+15192minor)pagefaults 0swaps

* master (without)

7.50user 0.08system 0:07.59elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+15487minor)pagefaults 0swaps

7.70user 0.06system 0:07.77elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+15487minor)pagefaults 0swaps

7.51user 0.08system 0:07.60elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+15487minor)pagefaults 0swaps
