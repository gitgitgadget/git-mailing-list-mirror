From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re: Merge with git-pasky II.
Date: Sun, 17 Apr 2005 10:34:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171014430.7211@ppc970.osdl.org>
References: <7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504141728590.7211@ppc970.osdl.org>
 <1113559330.12012.292.camel@baythorne.infradead.org>
 <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org> <20050416014442.GW4488@himi.org>
 <Pine.LNX.4.62.0504160518310.21837@qynat.qvtvafvgr.pbz> <20050416155536.GX4488@himi.org>
 <20050416160333.GF19099@pasky.ji.cz> <Pine.LNX.4.58.0504160913180.7211@ppc970.osdl.org>
 <20050417145232.GA5289@elte.hu> <20050417152841.GA6157@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Simon Fowler <simon@himi.org>,
	David Lang <david.lang@digitalinsight.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 19:30:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNDae-0007Fk-ID
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 19:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVDQRde (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 13:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVDQRde
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 13:33:34 -0400
Received: from fire.osdl.org ([65.172.181.4]:62678 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261368AbVDQRdZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 13:33:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HHX0s4005235
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 10:33:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3HHWwrN027361;
	Sun, 17 Apr 2005 10:32:59 -0700
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050417152841.GA6157@elte.hu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, Ingo Molnar wrote:
> 
> in fact, this attack cannot even be proven to be malicious, purely via 
> the email from Malice: it could be incredible bad luck that caused that 
> good-looking patch to be mistakenly matching a dangerous object.

I really hate theoretical discussions. 

The fact is, a lot of _crap_ engineering gets done because of the question
"what if?". It results in over-engineering, often to the point where the 
end result is quite a lot measurably worse than the sane results.

You are _literally_ arguing for the equivalent of "what if a meteorite hit
my plane while it was in flight - maybe I should add three inches of
high-tension armored steel around the plane, so that my passengers would
be protected".

That's not engineering. That's five-year-olds discussing building their
imaginary forts ("I want gun-turrets and a mechanical horse one mile high,
and my command center is 5 miles under-ground and totally encased in 5
meters of lead").

I absolutely _hate_ doing engineering on the principle of "this might be
possible in theory", and I'm violently opposed to it. So far, I have not
heard a single argument that I consider even _remotely_ likely.

The thing is, even if you can force a hash collission by sending somebody 
a patch, it's really pretty much almost guaranteed that the patch is not 
just "a few strange characters", unless sha1 is really broken to the point 
where it's not cryptographically secure _at_all_.

In other words, unless somebody finds a way to make sha1 appear as nothing
more than a complicated set of parity bits, all brute-force "get the same
sha1" is likely to be about generating a really strange blob based on the
thing you want to replace - and by "really strange" I mean total binary
crap. And likely _much_ bigger too. And by "much bigger" I mean "possibly
gigabytes of data".

And the thing is, _if_ somebody finds a way to make sha1 act as just a
complex parity bit, and comes up with generating a clashing object that
actually makes sense, then going to sha256 is likely pointless too - I
think the algorithm is basically the same, just with more bits. If you've
broken sha1 to the point where it's _that_ breakable, then you've likely
broken sha256 too. Nobody has ever proven that you couldn't break sha256 
with some really clever algorithm...

So if you start playing "what if?" games, dammit, I can play mine.

If we want to have any kind of confidence that the hash is reall
yunbreakable, we should make it not just longer than 160 bits, we should
make sure that it's two or more hashes, and that they are based on totally
different principles.

And we should all digitally sign every single object too, and we should
use 4096-bit PGP keys and unguessable passphrases that are at least 20
words in length. And we should then build a bunker 5 miles underground,
encased in lead, so that somebody cannot flip a few bits with a ray-gun, 
and make us believe that the sha1's match when they don't. Oh, and we need 
to all wear aluminum propeller beanies to make sure that they don't use 
that ray-gun to make us do the modification _outselves_.

And the thing is, that's just crazy talk. The difference between a crazy
person and an intelligent one is that the crazy one doesn't realize what
makes sense in the world. The goal of good engineering is not to ask "what
if?", but to ask "how do I make this work as well as possible".

So please stop with the theoretical sha1 attacks. It is simply NOT TRUE
that you can generate an object that looks halfway sane and still gets you
the sha1 you want. Even the "breakage" doesn't actually do that.  And if
it ever _does_ become true, it will quite possibly be thanks to some
technology that breaks other hashes too.

So until proven otherwise, I worry about accidental hashes, and in 160
bits of good hashing, that just isn't an issue either. Anybody who
compares a 128-bit md5-sum to a 160-bit sha1 doesn't understand the math.  
It didn't get "slightly less likely" to happen. It got so _unbelievably_
less likely to happen that it's not even funny.

				Linus
