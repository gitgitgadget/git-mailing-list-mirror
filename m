From: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-next: stackprotector tree build failure
Date: Wed, 22 Oct 2008 10:31:39 +0200
Message-ID: <20081022083139.GA4369@elte.hu>
References: <20081022131124.a572b11f.sfr@canb.auug.org.au> <20081022043227.GA31413@elte.hu> <20081022182149.f89fe88d.sfr@canb.auug.org.au> <20081022072923.GC27637@elte.hu> <20081022192725.5f5de711.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-next@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-From: linux-next-owner@vger.kernel.org Wed Oct 22 10:33:46 2008
connect(): Connection refused
Return-path: <linux-next-owner@vger.kernel.org>
Envelope-to: glkn-linux-next@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsZ9z-0005kM-Em
	for glkn-linux-next@gmane.org; Wed, 22 Oct 2008 10:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576AbYJVIb7 (ORCPT <rfc822;glkn-linux-next@m.gmane.org>);
	Wed, 22 Oct 2008 04:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbYJVIb6
	(ORCPT <rfc822;linux-next-outgoing>);
	Wed, 22 Oct 2008 04:31:58 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:53208 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576AbYJVIb5 (ORCPT <rfc822;linux-next@vger.kernel.org>);
	Wed, 22 Oct 2008 04:31:57 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KsZ81-0001Fz-OO
	from <mingo@elte.hu>; Wed, 22 Oct 2008 10:31:49 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 7B7B23E21A3; Wed, 22 Oct 2008 10:31:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20081022192725.5f5de711.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00,DNS_FROM_SECURITYSAGE autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 DNS_FROM_SECURITYSAGE  RBL: Envelope sender in
	blackholes.securitysage.com
Sender: linux-next-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-next.vger.kernel.org>
X-Mailing-List: linux-next@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98843>


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> On Wed, 22 Oct 2008 09:29:23 +0200 Ingo Molnar <mingo@elte.hu> wrote:
> >
> > I've Cc:-ed Junio and the Git list as a general FYI - but it must be 
> > frustrating to get such a bugreport, because i have no reproducer.
> > 
> > git-rerere sometimes seems to be picking up the wrong resolution. VERY 
> > rarely.
> > 
> > It seems random and content dependent. Once it happened to 
> > arch/x86/kernel/traps_32.c and now to kernel/fork.c. Along the ~170 
> > successful resolutions i have in my tree right now. And i do many 
> > conflict resolutions every day - and it happened only once every 6 
> > months or so.
> > 
> > (the arch/x86/kernel/traps_32.c one happened regularly, that's why i 
> > thought it's content sha1 dependent, and not some corruption.)
> > 
> > Next time it happens i'll be on the watchout and will save the complete 
> > tree.
> 
> I think rerere matches preimages on the SHA1 of the conflict (or its 
> reverse), so sufficiently similar pieces of code will match.  I would 
> expect things like ext2/3/4 to be candidates.  Did the traps_32.c one 
> match one for traps_64.c?
> 
> I may be mistaken, but I once followed the code in rerere to try to 
> figure out how to fix a resolution.

the traps_32.c one was that git-rerere put in a traps_64.c end result. 
So i ended up with a 32-bit kernel that tried to build a 64-bit piece of 
code - fireworks. That condition persisted - i had to fix it up manually 
all the time i integrated that portion of the tree. That too was i think 
centered around a header file chunk - perhaps the #include section of 
traps_32.c and traps_64.c was similar enough in that section?

	Ingo
