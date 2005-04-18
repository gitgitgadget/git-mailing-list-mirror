From: Andy Isaacson <adi@hexapodia.org>
Subject: Re: SHA1 hash safety
Date: Mon, 18 Apr 2005 00:43:23 -0700
Message-ID: <20050418074323.GA29765@hexapodia.org>
References: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz> <20050416123155.GA19908@elte.hu> <Pine.LNX.4.62.0504160542190.21837@qynat.qvtvafvgr.pbz> <4261132A.3090907@khandalf.com> <Pine.LNX.4.61.0504161040310.29343@cag.csail.mit.edu> <4261852B.6090507@khandalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 09:40:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNQr5-0006lW-Mv
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 09:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVDRHnd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 03:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVDRHnd
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 03:43:33 -0400
Received: from pirx.hexapodia.org ([199.199.212.25]:62605 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S261889AbVDRHnY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 03:43:24 -0400
Received: by pirx.hexapodia.org (Postfix, from userid 22448)
	id 5D27541C; Mon, 18 Apr 2005 00:43:23 -0700 (PDT)
To: omb@bluewin.ch
Content-Disposition: inline
In-Reply-To: <4261852B.6090507@khandalf.com>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[trimmed cc list, nobody wants to read this noise]

On Sat, Apr 16, 2005 at 11:35:39PM +0200, Brian O'Mahoney wrote:
> >> (1) I _have_ seen real-life collisions with MD5, in the context of
> >>    Document management systems containing ~10^6 ms-WORD documents.
> > 
> > Dude!  You could have been *famous*!  Why the
> > aitch-ee-double-hockey-sticks didn't you publish this when you found it?
> > Seriously, man.
> 
> The MD5 has was fine, or at least the code (a) produced the correct
> results on the published test cases, and, (b) was properly applied to
> all bytes of the file(s). I was surprised when it happened, which is why
> I bothered to post to this list at this time, so I make two more points

OK, I guess it's time for some remedial math.

There are 2^128 = 340282366920938463463374607431768211456 different MD5
hashes.

You are suggesting that you found a collision using ~1e6 = ~1,000,000
plaintexts.

Let's suppose there were actually 100,000,000 = 1e8 plaintexts, just in
case you underestimated the number.

Applying the birthday paradox, we have a 50% probability that you'd find
one collision if there were ~7,213,475,309,916,173 possible hash values.
If you extend the birthday argument ("what is the probability of a
collision if you take N samples from a set of size M?") you get the
following results, with N = 1e8:

50% (1 in 2) probability of collision in           7,213,475,309,916,173.
1% (1 in 100) probability of collision in        497,496,027,172,833,194.
.05% (1 in 1845) probability of collision in   9,223,372,036,854,775,806.

That's where my quick-and-dirty solver craps out, but we're still a
really long ways from

                     340,282,366,920,938,463,463,374,607,431,768,211,456.

A simple linear extrapolation (certainly wrong, but not by more than a
few dozen orders of magnitude) says that the odds would be
1 in 68,056,473,384,187,692,692 for the full MD5 hash (I'm not even
going to dignify that with a percentage).

I'm not going to do the sums, but I would hazard a guess that it's more
likely your PC suffered a cosmic-ray-induced memory fault - EACH OF THE
FOUR TIMES YOU TESTED IT - causing it to report the same MD5, than that
you actually discovered a collision with a measly million (or even
hundred million) plaintexts.

(Of course, I don't know how many tests of the hash you actually did.
But the point stands.)

Hell, if you're *that* lucky, what are you doing in IT?  You could be
making a killing at the roulette table.

Or, even more likely, there was some other factor in the system (most
likely that it was only using a few bits, probably 32, of the hash
when looking for collisions) that resulted in a false alarm.

If you had actual evidence of a collision, I'd love to see it - even if
it's just the equivalent of
% md5 foo
d3b07384d113edec49eaa6238ad5ff00 foo
% md5 bar
d3b07384d113edec49eaa6238ad5ff00 bar
% cmp foo bar
foo bar differ: byte 25, line 1
%

But in the absence of actual evidence, we have to assume (just based on
the probabilities) that there was some error in your testing.

-andy
