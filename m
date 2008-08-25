From: Ingo Molnar <mingo@elte.hu>
Subject: Re: nicer frontend to get rebased tree?
Date: Mon, 25 Aug 2008 11:36:45 +0200
Message-ID: <20080825093645.GA7741@elte.hu>
References: <20080822174655.GP23334@one.firstfloor.org> <alpine.LFD.1.10.0808221053080.3487@nehalem.linux-foundation.org> <20080822182718.GQ23334@one.firstfloor.org> <alpine.LFD.1.10.0808221233100.3487@nehalem.linux-foundation.org> <20080823071014.GT23334@one.firstfloor.org> <alpine.LFD.1.10.0808230853170.3363@nehalem.linux-foundation.org> <20080823164546.GX23334@one.firstfloor.org> <alpine.LFD.1.10.0808231054400.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>, git@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 11:38:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXYWU-0000IC-Ck
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 11:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212AbYHYJhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 05:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754199AbYHYJhA
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 05:37:00 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:46955 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753833AbYHYJg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 05:36:59 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KXYVE-0006zu-Ou
	from <mingo@elte.hu>; Mon, 25 Aug 2008 11:36:54 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 765213E2192; Mon, 25 Aug 2008 11:36:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808231054400.3363@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 23 Aug 2008, Andi Kleen wrote:
> > > 
> > > A lot of the trees don't rebase. The rest of the trees may not realize 
> > 
> > That's not my experience, sorry (even on other other trees than linux-next,
> > linux-next was just an example).  e.g. the original ACPI tree did it,
> > the x86 tree jungle does it, most of the other architecture trees do it,

[ thanks for the lovely charecterisation of -tip, it's appreciated.
  </sarcasm> ]

> > the networking tree does it. etc.etc.
> 
> So _complain_ to those people. Tell them that they are making your 
> life harder. Let them know.
> 
> I sure as hell let people know when they are making _my_ life harder. 
> It has helped. The networking tree stopped rebasing, and the x86 tree 
> doesn't do it for the topic branches (although I think it re-creates 
> the "common" branches all the time, kind of like linux-next).

Correct - we keep all topic branches append-only. (We rebase a topic 
only in exceptional cases: if there's a complete restart from scratch, 
when the history is so messy or uninteresting that no-one would care 
about it.)

And we do more than that: even tip/master is becoming more and more 
append-only. We are set up in a way that makes rebasing of a topic 
branch painful for _us_ integrators already. That is because tip/master 
is a "consumer" of all the topic trees, in form of 'delta-integration', 
which just merges all updated topic branches ontop of tip/master.

If a topic tree is rebased, we feel the pain in tip/master: no easy 
delta-integration run is possible anymore, we get a ton of conflicts due 
to the changed sha1's and due to the slightly changed content and the 
whole topic tree has to be undone and re-merged. It's also harder to 
track changes and it's harder to trust the quality of a stream of 
changes if they get rebased - etc.

Alas, we dont rebase when we can avoid it.

We periodically 'reintegrate' the whole thing to create the linux-next 
output branches and to get rid of the uninteresting hundreds of 
criss-cross merges, but that's on a relatively slow scale of 1-2 weeks.

( which is still too frequent for this to be truly append-only, but
  dependable enough for short-term development and obviously good for
  testing and regression-bisection activities. )

When people ask me "what should I use for development, tip/master?", i 
suggest them to use -git or a specific topic branch they are interested 
in. (and each topic branch is based on upstream -git as well.)

Sometimes if they are working in an area where there's known overlap 
with multiple topics, people will send patches/pull-requests against 
tip/master. In that case we maintainers sort those out and 'spread' them 
into individual topic branches - i.e. turn them into an append-only flow 
of changes.

But arch/x86 development is also a bit special: in the past year it has 
gathered almost as many developers and per kernel cycle commits as the 
networking tree, but compressed into a highly critical and hard to 
debug/test ~190 KLOC codebase.

The networking tree is an order of magnitude larger at 1.5 MLOC, which 
makes it statistically a lot less likely that commits would overlap in 
it - and makes it far more feasible to handle conflicts in the simplest 
and most robust way: by doing hierarchical maintenance with strict 
boundaries and thus _avoiding_ conflicts.

Hence we've set up the x86 tree as this 'forest of 160+ trees' which 
topic trees iteract with each other intelligently and which get 
integrated into a single "kitchen sink" test branch, tip/master.

	Ingo
