From: Geert Bosch <bosch@adacore.com>
Subject: Re: RFC: New diff-delta.c implementation
Date: Mon, 24 Apr 2006 14:44:24 -0400
Message-ID: <A175169A-0875-4DEF-BE97-C556325EB6DB@adacore.com>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com> <444A2334.3030501@lsrfire.ath.cx> <20060424025741.GA636@adacore.com> <Pine.LNX.4.64.0604232327500.3603@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 24 20:44:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FY62t-00020X-NW
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 20:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWDXSoY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 14:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWDXSoY
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 14:44:24 -0400
Received: from nile.gnat.com ([205.232.38.5]:6588 "EHLO nile.gnat.com")
	by vger.kernel.org with ESMTP id S1750705AbWDXSoY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Apr 2006 14:44:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 7E81A48CC5A;
	Mon, 24 Apr 2006 14:44:23 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 21579-01-2; Mon, 24 Apr 2006 14:44:23 -0400 (EDT)
Received: from [205.232.38.124] (potomac.gnat.com [205.232.38.124])
	by nile.gnat.com (Postfix) with ESMTP id 5200948CC13;
	Mon, 24 Apr 2006 14:44:23 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0604232327500.3603@localhost.localdomain>
To: Nicolas Pitre <nico@cam.org>
X-Mailer: Apple Mail (2.749.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19100>


On Apr 24, 2006, at 01:27, Nicolas Pitre wrote:
> But here comes the sad part.  Even after simplifying the code as  
> much as
> I could, performance is still significantly worse than the current
> diff-delta.c code.  Repacking again the same Linux kernel repository
> with the current code:

Changing the level parameter in the call to init_idx to 0
gives a significant speedup. After that, by far the most
time is spent computing hashes. I have some ideas of
cutting down on that for this test case.
> The final pack is smaller with your code but not significantly:
> 117867049 bytes vs 118824550 bytes with the current code, i.e. less  
> than
> 1% difference.

I'm doing tests on the git.git repository now, and even though
I see similar performance, I noted that the new algorithm packs
more files, so the pack size is not the only thing to look at.
Still, it remains the case that when you compare two files with
just one or two changes, the simplest algorithm is still good
enough.

It will be very interesting how things will work out when
comparing 10 files at a time. Then the extra cost of building the
index isn't that significant, and the higher quality of the index
may then pay off.

   -Geert
