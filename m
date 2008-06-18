From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-rerere observations and feature suggestions
Date: Wed, 18 Jun 2008 13:36:05 +0200
Message-ID: <20080618113605.GA6590@elte.hu>
References: <20080616110113.GA22945@elte.hu> <7vej6xb4lr.fsf@gitster.siamese.dyndns.org> <20080616190911.GA7047@elte.hu> <20080618105731.GA9242@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 13:37:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8vyT-0003df-6x
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 13:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914AbYFRLgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 07:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900AbYFRLgQ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 07:36:16 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:50608 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831AbYFRLgP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 07:36:15 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1K8vxQ-0005bz-Cf
	from <mingo@elte.hu>; Wed, 18 Jun 2008 13:36:14 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 098313E2226; Wed, 18 Jun 2008 13:36:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080618105731.GA9242@elte.hu>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85377>


* Ingo Molnar <mingo@elte.hu> wrote:

> just to demonstrate it, i tried today to do an octopus merge of 87 
> topic branches:
> 
> git-merge build checkme core/checkme core/debugobjects core/futex-64bit 
> core/iter-div core/kill-the-BKL core/locking core/misc core/percpu 
> core/printk core/rcu core/rodata core/softirq core/softlockup 
> core/stacktrace core/topology core/urgent cpus4096 genirq kmemcheck 
> kmemcheck2 mm/xen out-of-tree pci-for-jesse safe-poison-pointers sched 
> sched-devel scratch stackprotector timers/clockevents timers/hpet 
> timers/hrtimers timers/nohz timers/posixtimers tip tracing/ftrace 
> tracing/ftrace-mergefixups tracing/immediates tracing/markers 
> tracing/mmiotrace tracing/mmiotrace-mergefixups tracing/nmisafe 
> tracing/sched_markers tracing/stopmachine-allcpus tracing/sysprof 
> tracing/textedit x86/apic x86/apm x86/bitops x86/build x86/checkme 
> x86/cleanups x86/cpa x86/cpu x86/defconfig x86/delay x86/gart x86/i8259 
> x86/idle x86/intel x86/irq x86/irqstats x86/kconfig x86/ldt x86/mce 
> x86/memtest x86/mmio x86/mpparse x86/nmi x86/numa x86/numa-fixes x86/pat 
> x86/pebs x86/ptemask x86/resumetrace x86/scratch x86/setup x86/smpboot 
> x86/threadinfo x86/timers x86/urgent x86/urgent-undo-ioapic x86/uv 
> x86/vdso x86/xen x86/xsave
> 
> it failed miserably:
> 
>  warning: ignoring 066519068ad2fbe98c7f45552b1f592903a9c8c8; cannot 
>  handle more than 25 refs
>  [...]
>  fatal: merge program failed
>  Automated merge did not work.
>  Should not be doing an Octopus.
>  Merge with strategy octopus failed.
> 
> this wasnt even for purposes of an integration run: all i wanted to do 
> was to pick up 2-3 new commits i have queued into 2-3 topic branches, 
> into the (throw-away) integration branch. All the other branches were 
> unmodified and already merged into the integration branch.
> 
> Hence i believe that the suggestions above by Git that i'm doing 
> something wrong are ... wrong :-)
> 
> My scripting around this would be a lot faster (less than 10 seconds 
> runtime versus a minute currently) and more robust if we could do such 
> higher-order octopus merges.

some hard numbers. Doing a scripted loop of 80 git-merges is 16.2 
seconds:

 earth4:~/tip> time ( for N in $(cat 11 12 13 14); do git-merge $N; done )
 [...]
 Already up-to-date.

 real    0m16.211s
 user    0m10.719s
 sys     0m5.604s

doing the octopus merge of 4x 20 branch octopus merges is 11.6 seconds:

 earth4:~/tip> time ( for N in 1 2 3 4; do git-merge $(cat 1$N); done )
 Already up-to-date. Yeeah!
 Already up-to-date. Yeeah!
 Already up-to-date. Yeeah!
 Already up-to-date. Yeeah!

 real    0m11.580s
 user    0m8.617s
 sys     0m2.895s

a 40% speedup - and would be another 10% faster with an order-of-80 
merge as well i think. Not to be sniffed at.

	Ingo
