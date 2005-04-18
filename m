From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Re: Merge with git-pasky II.
Date: Mon, 18 Apr 2005 09:42:32 +0200
Message-ID: <20050418074232.GA20119@elte.hu>
References: <1113559330.12012.292.camel@baythorne.infradead.org> <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org> <20050416014442.GW4488@himi.org> <Pine.LNX.4.62.0504160518310.21837@qynat.qvtvafvgr.pbz> <20050416155536.GX4488@himi.org> <20050416160333.GF19099@pasky.ji.cz> <Pine.LNX.4.58.0504160913180.7211@ppc970.osdl.org> <20050417145232.GA5289@elte.hu> <20050417152841.GA6157@elte.hu> <Pine.LNX.4.58.0504171014430.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Simon Fowler <simon@himi.org>,
	David Lang <david.lang@digitalinsight.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 09:39:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNQqQ-0006ei-Qx
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 09:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVDRHmx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 03:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVDRHmx
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 03:42:53 -0400
Received: from mx1.elte.hu ([157.181.1.137]:20107 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261887AbVDRHmu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 03:42:50 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 05A15320478;
	Mon, 18 Apr 2005 09:41:55 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 248CB1FC2; Mon, 18 Apr 2005 09:42:36 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504171014430.7211@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> On Sun, 17 Apr 2005, Ingo Molnar wrote:
> > 
> > in fact, this attack cannot even be proven to be malicious, purely via 
> > the email from Malice: it could be incredible bad luck that caused that 
> > good-looking patch to be mistakenly matching a dangerous object.
> 
> I really hate theoretical discussions.

i was only replying to your earlier point:

> > > Almost all attacks on sha1 will depend on _replacing_ a file with 
> > > a bogus new one. So guys, instead of using sha256 or going 
> > > overboard, just make sure that when you synchronize, you NEVER 
> > > import a file you already have.

which point i still believe is subtly wrong. You were suggesting to 
concentrate on file replacement to counter most of the practical 
attacks, while i pointed out an attack _using the same basic mechanism 
that your point above supposed_.

[ if you can replace a file with a known hash, with a bogus new one, and 
  you still have enough control over the contents of your bogus new file 
  that it is 1) a valid file that builds 2) compromises the kernel, then 
  you likely have the same amount of control my 'theoretical' attack
  requires. ]

> And the thing is, _if_ somebody finds a way to make sha1 act as just a 
> complex parity bit, and comes up with generating a clashing object 
> that actually makes sense, then going to sha256 is likely pointless 
> too [...]

yes, that's why i suggested to not actually trust the hash to be 
cryptographically secure, but to just assume it's a good generic hash we 
can design a DB around, and to turn -DCOLLISION_CHECK on and enforce 
consistency rules on boundaries.

[ it's not bad to keep sha1 because even my suggested enhancement still
  leaves 'content-less trust-pointers to untrusted content via email'
  vectors open against attack (maintainer sends you an email that commit
  X in Malice's repository Y is fine to pull, and you pull it blindly,
  while the attacker has replaced his content with the compromised one
  meanwhile), but it at least validates the bulk traffic that goes into
  the DB: patches via emails and trusted repositories. ]

so all i was suggesting was to extend your suggested 'overwrite 
collision check' to a stricter 'content we throw away and use the sha1 
shortcut for needs to be checked against the in-DB content as well'.

in other words, your suggested 'rename check' is checking for 'positive 
duplicate content', while my addition would also check for 'negative 
duplicate content' as well.

but as usual, i could be wrong, so dont take this too serious :-)

	Ingo
