From: Ray Heasman <lists@mythral.org>
Subject: Re: Hash collision count
Date: Sat, 23 Apr 2005 16:00:31 -0700
Message-ID: <1114297231.10264.12.camel@maze.mythral.org>
References: <426AAFC3.800@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 00:56:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPTXm-0001aL-C6
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 00:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVDWXAr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 19:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVDWXAr
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 19:00:47 -0400
Received: from soggy199.drizzle.com ([216.162.199.199]:20232 "EHLO mythral.org")
	by vger.kernel.org with ESMTP id S262163AbVDWXAg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 19:00:36 -0400
Received: (qmail 1584 invoked from network); 23 Apr 2005 16:00:34 -0700
Received: from dsl254-013-025.sea1.dsl.speakeasy.net (HELO maze.mythral.org) (authuser@216.254.13.25)
  by 192.168.0.8 with RC4-MD5 encrypted SMTP; 23 Apr 2005 16:00:34 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <426AAFC3.800@pobox.com>
X-Mailer: Evolution 2.0.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-23 at 16:27 -0400, Jeff Garzik wrote:
> Ideally a hash + collision-count pair would make the best key, rather 
> than just hash alone.
> 
> A collision -will- occur eventually, and it is trivial to avoid this 
> problem:
> 
> 	$n = 0
> 	attempt to store as $hash-$n
> 	if $hash-$n exists (unlikely)
> 		$n++
> 		goto restart
> 	key = $hash-$n
> 

Great. So what have you done here? Suppose you have 32 bits of counter
for n. Whoopee, you just added 32 bits to your hash, using a two stage
algorithm. So, you have a 192 bit hash assuming you started with the 160
bit SHA. And, one day your 32 bit counter won't be enough. Then what?

> Tangent-as-the-reason-I-bring-this-up:
> 
> One of my long-term projects is an archive service, somewhat like 
> Plan9's venti:  a multi-server key-value database, with sha1 hash as the 
> key.
> 
> However, as the database grows into the terabyte (possibly petabyte) 
> range, the likelihood of a collision transitions rapidly from unlikely 
> -> possible -> likely.
> 
> Since it is -so- simple to guarantee that you avoid collisions, I'm 
> hoping git will do so before the key structure is too ingrained.

You aren't solving anything. You're just putting it off, and doing it in
a way that breaks all the wonderful semantics possible by just assuming
that the hash is unique. All of a sudden we are doing checks of data
that we never did before, and we have to do the check trillions of times
before the CPU time spent pays off.

If you want to use a bigger hash then use a bigger hash, but don't fool
yourself into thinking that isn't what you are doing.

Ciao,
Ray



