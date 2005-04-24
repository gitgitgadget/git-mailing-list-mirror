From: Ray Heasman <lists@mythral.org>
Subject: Re: Hash collision count
Date: Sat, 23 Apr 2005 18:01:08 -0700
Message-ID: <1114304468.10043.45.camel@maze.mythral.org>
References: <426AAFC3.800@pobox.com>
	 <1114297231.10264.12.camel@maze.mythral.org>  <426AD835.5070404@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 02:56:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPVQE-0001tq-0H
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 02:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbVDXBBQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 21:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVDXBBQ
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 21:01:16 -0400
Received: from soggy199.drizzle.com ([216.162.199.199]:20742 "EHLO mythral.org")
	by vger.kernel.org with ESMTP id S262213AbVDXBBL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 21:01:11 -0400
Received: (qmail 32364 invoked from network); 23 Apr 2005 18:01:09 -0700
Received: from dsl254-013-025.sea1.dsl.speakeasy.net (HELO maze.mythral.org) (authuser@216.254.13.25)
  by 192.168.0.8 with RC4-MD5 encrypted SMTP; 23 Apr 2005 18:01:09 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <426AD835.5070404@pobox.com>
X-Mailer: Evolution 2.0.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-23 at 19:20 -0400, Jeff Garzik wrote:
> Ray Heasman wrote:
> > On Sat, 2005-04-23 at 16:27 -0400, Jeff Garzik wrote:
> > 
> >>Ideally a hash + collision-count pair would make the best key, rather 
> >>than just hash alone.
> >>
> >>A collision -will- occur eventually, and it is trivial to avoid this 
> >>problem:
> >>
> >>	$n = 0
> >>	attempt to store as $hash-$n
> >>	if $hash-$n exists (unlikely)
> >>		$n++
> >>		goto restart
> >>	key = $hash-$n
> >>
> > 
> > 
> > Great. So what have you done here? Suppose you have 32 bits of counter
> > for n. Whoopee, you just added 32 bits to your hash, using a two stage
> > algorithm. So, you have a 192 bit hash assuming you started with the 160
> > bit SHA. And, one day your 32 bit counter won't be enough. Then what?
> 
> First, there is no 32-bit limit.  git stores keys (aka hashes) as 
> strings.  As it should.

Oh great, now we have variable length id strings too. And we'll have to
pretend the OS can store infinite length file names.

> Second, in your scenario, it's highly unlikely you would get 4 billion 
> sha1 hash collisions, even if you had the disk space to store such a git 
> database.

Er. So your so-unlikely-the-sun-will-burn-out-first scenario beats my
so-unlikely-the-sun-will-burn-out-first scenario? Why am I not worried?

> > You aren't solving anything. You're just putting it off, and doing it in
> > a way that breaks all the wonderful semantics possible by just assuming
> > that the hash is unique. All of a sudden we are doing checks of data
> > that we never did before, and we have to do the check trillions of times
> > before the CPU time spent pays off.
> 
> First, the hash is NOT unique.

Nooooo. Really?

Why not just use a 8192 bit hash for each 1KiB of data? We could store a
zero length file and store all the data in the filename. Guaranteed, no
hash collisions that way.

We make an assumption that we know is right most of the time, and we use
it because we know our computer will crash from random quantum
fluctuations before we have a chance of bumping into the problem. You do
know that metastability means that every logic gate in your computer
hardware is guaranteed to fail every "x" operations, where x is defined
by process size, voltage and temperature? Sure, any failures in git
would be data dependent rather than random, but that just means we don't
get to store carefully crafted blocks invented by hypothetical
cryptographers that have completely broken SHA.

> Second, you lose data if you pretend it is unique.  I don't like losing 
> data.

You lose data either way. Just we get to burn out a few extra suns
before yours dies, and I can burn out whole galaxies before mine dies by
using a 256 bit hash, anyway.

> Third, a data check only occurs in the highly unlikely case that a hash 
> already exists -- a collision.  Rather than "trillions of times", more 
> like "one in a trillion chance."

Heh. I calculate it has a 50% probability of happening after you have
seen 10^24 input blocks. So, you are off by a factor of a trillion or
so.

Assuming we store 1 KiB blocks with a 160-bit hash, we would be able to
store 1000 Trillion Terabytes before the chance of hitting a collision
goes to 50%. To use marketing units, that is around 10 Trillion
Libraries of Congress. Every 2 bits we add to the hash doubles the
amount of data we can store before we hit a 50% probability of
collision.

I'm not sure how I could convince you that we're arguing about the
number of angels that could dance on a pin.

Ciao,
Ray

