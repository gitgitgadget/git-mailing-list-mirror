From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Hash collision count
Date: Sat, 23 Apr 2005 19:20:21 -0400
Message-ID: <426AD835.5070404@pobox.com>
References: <426AAFC3.800@pobox.com> <1114297231.10264.12.camel@maze.mythral.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 01:16:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPTrp-0003MJ-IO
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 01:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVDWXVH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 19:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVDWXVH
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 19:21:07 -0400
Received: from 216-237-124-58.infortech.net ([216.237.124.58]:31129 "EHLO
	mail.dvmed.net") by vger.kernel.org with ESMTP id S262170AbVDWXU0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 19:20:26 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.50 #1 (Red Hat Linux))
	id 1DPTvE-0002cv-F8; Sat, 23 Apr 2005 23:20:25 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Ray Heasman <lists@mythral.org>
In-Reply-To: <1114297231.10264.12.camel@maze.mythral.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ray Heasman wrote:
> On Sat, 2005-04-23 at 16:27 -0400, Jeff Garzik wrote:
> 
>>Ideally a hash + collision-count pair would make the best key, rather 
>>than just hash alone.
>>
>>A collision -will- occur eventually, and it is trivial to avoid this 
>>problem:
>>
>>	$n = 0
>>	attempt to store as $hash-$n
>>	if $hash-$n exists (unlikely)
>>		$n++
>>		goto restart
>>	key = $hash-$n
>>
> 
> 
> Great. So what have you done here? Suppose you have 32 bits of counter
> for n. Whoopee, you just added 32 bits to your hash, using a two stage
> algorithm. So, you have a 192 bit hash assuming you started with the 160
> bit SHA. And, one day your 32 bit counter won't be enough. Then what?

First, there is no 32-bit limit.  git stores keys (aka hashes) as 
strings.  As it should.

Second, in your scenario, it's highly unlikely you would get 4 billion 
sha1 hash collisions, even if you had the disk space to store such a git 
database.


>>Tangent-as-the-reason-I-bring-this-up:
>>
>>One of my long-term projects is an archive service, somewhat like 
>>Plan9's venti:  a multi-server key-value database, with sha1 hash as the 
>>key.
>>
>>However, as the database grows into the terabyte (possibly petabyte) 
>>range, the likelihood of a collision transitions rapidly from unlikely 
>>-> possible -> likely.
>>
>>Since it is -so- simple to guarantee that you avoid collisions, I'm 
>>hoping git will do so before the key structure is too ingrained.
> 
> 
> You aren't solving anything. You're just putting it off, and doing it in
> a way that breaks all the wonderful semantics possible by just assuming
> that the hash is unique. All of a sudden we are doing checks of data
> that we never did before, and we have to do the check trillions of times
> before the CPU time spent pays off.

First, the hash is NOT unique.

Second, you lose data if you pretend it is unique.  I don't like losing 
data.

Third, a data check only occurs in the highly unlikely case that a hash 
already exists -- a collision.  Rather than "trillions of times", more 
like "one in a trillion chance."

	Jeff



