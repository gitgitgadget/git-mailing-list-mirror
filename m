From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Subject: Re: Linux 2.6.27-rc3: kernel BUG at mm/vmalloc.c - bisected
Date: Fri, 22 Aug 2008 15:47:16 -0400
Message-ID: <48AF17C4.4060606@hp.com>
References: <48A36838.3050309@hp.com> <20080819124602.9e8e69f7.akpm@linux-foundation.org> <48AEDD3D.4060507@hp.com> <20080822092549.ddcb7e79.akpm@linux-foundation.org> <20080822171651.GP10544@machine.or.cz> <20080822105136.a8432875.akpm@linux-foundation.org> <20080822193730.GA1598@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020308070009090704040704"
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Baudis <pasky@suse.cz>, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 22 21:48:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWcca-0000sA-Ru
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 21:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823AbYHVTr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 15:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752874AbYHVTr0
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 15:47:26 -0400
Received: from g1t0029.austin.hp.com ([15.216.28.36]:24542 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbYHVTrY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 15:47:24 -0400
Received: from g5t0030.atlanta.hp.com (g5t0030.atlanta.hp.com [16.228.8.142])
	by g1t0029.austin.hp.com (Postfix) with ESMTP id E52063818D;
	Fri, 22 Aug 2008 19:47:21 +0000 (UTC)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by g5t0030.atlanta.hp.com (Postfix) with ESMTP id 3BE8C24065;
	Fri, 22 Aug 2008 19:47:21 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl.fc.hp.com (Postfix) with ESMTP id D3F5D39C06D;
	Fri, 22 Aug 2008 13:47:20 -0600 (MDT)
X-Virus-Scanned: Debian amavisd-new at ldl.fc.hp.com
Received: from ldl.fc.hp.com ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cvkbD5jhVhTH; Fri, 22 Aug 2008 13:47:18 -0600 (MDT)
Received: from [127.0.0.1] (squirrel.fc.hp.com [15.11.146.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ldl.fc.hp.com (Postfix) with ESMTP id EA0BE39C00C;
	Fri, 22 Aug 2008 13:47:16 -0600 (MDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <20080822193730.GA1598@atjola.homenet>
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93351>

This is a multi-part message in MIME format.
--------------020308070009090704040704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Björn Steinbrink wrote:
> On 2008.08.22 10:51:36 -0700, Andrew Morton wrote:
>> On Fri, 22 Aug 2008 19:16:51 +0200 Petr Baudis <pasky@suse.cz> wrote:
>>> On Fri, Aug 22, 2008 at 09:25:49AM -0700, Andrew Morton wrote:
>>>> One (probably wrong) approach is to run
>>>>
>>>> 	gitk 1c89ac55017f982355c7761e1c912c88c941483d
>>>>
>>>> then peer at the output, work out which real commits were in that
>>>> merge.
>>>>
>>>> It looks like the merge ended with
>>>> b1b135c8d619cb2c7045d6ee4e48375882518bb5 and started with
>>>> 40c42076ebd362dc69210cccea101ac80b6d4bd4, so perhaps you can do
>>>>
>>>> 	git bisect bad b1b135c8d619cb2c7045d6ee4e48375882518bb5
>>>> 	git bisect good 40c42076ebd362dc69210cccea101ac80b6d4bd4
>>> ...I don't quite get this - according to the bisection log,
>>>
>>> 	# good: [b1b135c8d619cb2c7045d6ee4e48375882518bb5] fix spinlock recursion in hvc_console
>>>
>>> and now you want to mark it as bad?
>> <what bisection log?>
> 
> Alan provided his bisection log as an attachment to the original bug
> report.
> 
>> I assume that Alan's bisection search ended up saying that the merge
>> commit (1c89ac55017f982355c7761e1c912c88c941483d) was the first bad
>> commit.
> 
> Yep, and that's totally correct as far as bisect is concerned. The
> parents of that merge commit are:
> 88fa08f67bee1a0c765237bdac106a32872f57d2
> b1b135c8d619cb2c7045d6ee4e48375882518bb5
> 
> And Alan marked both of them as good.
> 
> So, unless Alan made a mistake during his bisection, each of the
> branches is correct, but the merge did not lead to a correct result. So
> while there were no textual conflicts, there were still incompatible
> changes regarding the code semantics and compatibility was not restored
> during the merge.

It's important to note that even if I did make a mistake during the
bisection process (and I certainly wouldn't discount that), recent
kernels still fail: but when I take out that commit from a recent
kernel, it fails.

I put in Andrew's suggested patch (to help find things), and now I
repeatedly get the problems in the attached log.

Not being an x86 knowledgeable person, I'm a bit concerned about the RSP
value?! (I enabled stack overflow checking, but that didn't stop things.)

Alan

--------------020308070009090704040704
Content-Type: text/plain;
 name="new_prob.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="new_prob.txt"

Loading, please wait...
Begin: Loading essential drivers... ...
[    6.604300] fuse init (API version 7.9)
[    6.625529] ACPI: SSDT CFFD0D0A, 08C4 (r1 HPQOEM  CPU_TM2        1 MSFT  100000E)
[    6.631954] BUG: unable to handle kernel NULL pointer dereference at 0000000000000858
[    6.640583] IP: [<ffffffff8025e282>] debug_mutex_add_waiter+0x32/0x80
[    6.640583] PGD 21a84f067 PUD 21ad55067 PMD 0 
[    6.642421] Oops: 0002 [1] SMP 
[    6.642421] CPU 2 
[    6.642421] Modules linked in: processor(+) fan thermal_sys fuse
[    6.642421] Pid: 1259, comm: modprobe Not tainted 2.6.27-rc3 #26
[    6.642421] RIP: 0010:[<ffffffff8025e282>]  [<ffffffff8025e282>] debug_mutex_add_waiter+0x32/0x80
[    6.642421] RSP: 0018:ffff88021a1a5998  EFLAGS: 00010002
[    6.642421] RAX: 0000000000000000 RBX: ffff88021a1a59d8 RCX: 0000000000000000
[    6.642421] RDX: 0000000000000001 RSI: ffff88021a1a59d8 RDI: ffffffffa0091a60
[    6.642421] RBP: ffff88021a1a59b8 R08: ffffffff811deea0 R09: ffff8800a6fed000
[    6.642421] R10: ffffffffa008f524 R11: 0000000000000002 R12: ffffffffa0091a60
[    6.642421] R13: ffff88021a1a4000 R14: ffff88021a34c0a0 R15: ffffffffa0091a98
[    6.642421] FS:  00007f2c513606e0(0000) GS:ffff88022fc02e00(0000) knlGS:0000000000000000
[    6.642421] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[    6.642421] CR2: 0000000000000858 CR3: 000000021a8f7000 CR4: 00000000000006e0
[    6.642421] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    6.642421] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[    6.642421] Process modprobe (pid: 1259, threadinfo ffff88021a1a4000, task ffff88021a34c0a0)
[    6.642421] Stack:  0000000000000000 ffffffffa0091a60 0000000000000246 ffffffffa008f524
[    6.642421]  ffff88021a1a5a38 ffffffff8049f556 ffffffffa008f524 ffffffffa0091a18
[    6.642421]  ffff88021a1a59d8 ffff88021a1a59d8 1111111111111111 1111111111111111
[    6.642421] Call Trace:
[    6.642421]  [<ffffffffa008f524>] ? get_idr+0x44/0xa0 [thermal_sys]
[    6.642421]  [<ffffffff8049f556>] mutex_lock_nested+0xa6/0x250
[    6.642421]  [<ffffffffa008f524>] ? get_idr+0x44/0xa0 [thermal_sys]
[    6.642421]  [<ffffffff80363584>] ? idr_pre_get+0x44/0x90
[    6.642421]  [<ffffffffa008f524>] get_idr+0x44/0xa0 [thermal_sys]
[    6.642421]  [<ffffffffa008fe43>] thermal_cooling_device_register+0x83/0x250 [thermal_sys]
[    6.642421]  [<ffffffffa019b2a3>] acpi_processor_start+0x64b/0x774 [processor]
[    6.642421]  [<ffffffff8031a90b>] ? __sysfs_add_one+0x6b/0xa0
[    6.642421]  [<ffffffff8031b9fc>] ? sysfs_do_create_link+0xbc/0x150
[    6.642421]  [<ffffffff803a7f1e>] acpi_start_single_object+0x2d/0x52
[    6.642421]  [<ffffffff803a9516>] acpi_device_probe+0x7e/0x92
[    6.642421]  [<ffffffff803dd3ab>] driver_probe_device+0x9b/0x1a0
[    6.642421]  [<ffffffff803dd536>] __driver_attach+0x86/0x90
[    6.642421]  [<ffffffff803dd4b0>] ? __driver_attach+0x0/0x90
[    6.642421]  [<ffffffff803dc8fd>] bus_for_each_dev+0x5d/0x90
[    6.642421]  [<ffffffff803dd1ec>] driver_attach+0x1c/0x20
[    6.642421]  [<ffffffff803dcf39>] bus_add_driver+0x1e9/0x260
[    6.642421]  [<ffffffffa0222000>] ? acpi_processor_init+0x0/0x107 [processor]
[    6.642421]  [<ffffffff803dd70f>] driver_register+0x5f/0x140
[    6.642421]  [<ffffffffa0222000>] ? acpi_processor_init+0x0/0x107 [processor]
[    6.642421]  [<ffffffff803a9826>] acpi_bus_register_driver+0x3e/0x40
[    6.642421]  [<ffffffffa0222094>] acpi_processor_init+0x94/0x107 [processor]
[    6.642421]  [<ffffffff80209040>] _stext+0x40/0x180
[    6.642421]  [<ffffffff802a88d1>] ? __vunmap+0xa1/0x110
[    6.642421]  [<ffffffff80267642>] sys_init_module+0x142/0x1dc0
[    6.642421]  [<ffffffff80367ad6>] ? __up_read+0x46/0xb0
[    6.642421]  [<ffffffff8048e530>] ? cpu_down+0x0/0x70
[    6.642421]  [<ffffffff8020c34b>] system_call_fastpath+0x16/0x1b
[    6.642421] 
[    6.642421] 
[    6.642421] Code: 20 48 89 5d e8 4c 89 65 f0 48 89 f3 4c 89 6d f8 8b 47 08 49 89 d5 49 89 fc 89 c2 25 ff ff 00 00 c1 ea 10 39 c2 74 1d 49 8b 4 
[    6.652421] RIP  [<ffffffff8025e282>] debug_mutex_add_waiter+0x32/0x80
[    6.652421]  RSP <ffff88021a1a5998>
[    6.652421] CR2: 0000000000000858
[    6.652421] ---[ end trace 53d26a9a6cd6aa38 ]---
[    6.991546] ------------[ cut here ]------------
[    6.996188] kernel BUG at kernel/sched.c:1155!
[    7.005292] invalid opcode: 0000 [2] SMP 
[    7.005292] CPU 2 
[    7.005292] Modules linked in: processor(+) fan thermal_sys fuse
[    7.011541] Pid: 1259, comm: modprobe Tainted: G      D   2.6.27-rc3 #26
[    7.011541] RIP: 0010:[<ffffffff8022cc2b>]  [<ffffffff8022cc2b>] resched_task+0x6b/0x70
[    7.011541] RSP: 0018:ffff88022f0efe98  EFLAGS: 00010046
[    7.011541] RAX: 00000000000006ee RBX: ffff880028092e00 RCX: ffffffff81046000
[    7.011541] RDX: 00000000000006ee RSI: ffff88021a34c0a0 RDI: ffffffff805ee660
[    7.011541] RBP: ffff88022f0efe98 R08: 0000000000000000 R09: 0000000000000001
[    7.011541] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88021a34c0a0
[    7.011541] R13: 0000000000000001 R14: ffff880028092e98 R15: ffff88021a34c0d8
[    7.011541] FS:  00007f2c513606e0(0000) GS:ffff88022fc02e00(0000) knlGS:0000000000000000
[    7.011541] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[    7.011541] CR2: 0000000000000858 CR3: 000000021a8f7000 CR4: 00000000000006e0
[    7.011541] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    7.011541] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[    7.011541] Process modprobe (pid: 1259, threadinfo ffff88021a1a4000, task ffff88021a34c0a0)
[    7.011541] Stack:  ffff88022f0efed8 ffffffff8023774f ffff88022f0efed8 ffff8800280b6e00
[    7.011541]  ffffffff80238510 ffff8800280b2b20 ffff8800280b2aa0 7fffffffffffffff
[    7.011541]  ffff88022f0efef8 ffffffff8023855d ffff8800280b2aa0 ffff8800280b7660
[    7.011541] Call Trace:
[    7.011541]  <IRQ>  [<ffffffff8023774f>] task_tick_fair+0xbf/0xd0
[    7.011541]  [<ffffffff80238510>] ? hrtick+0x0/0x90
[    7.011541]  [<ffffffff8023855d>] hrtick+0x4d/0x90
[    7.011541]  [<ffffffff80254f65>] __run_hrtimer+0x95/0xb0
[    7.011541]  [<ffffffff80255c4b>] hrtimer_interrupt+0x11b/0x190
[    7.011541]  [<ffffffff8021d643>] smp_apic_timer_interrupt+0x83/0xc0
[    7.011541]  [<ffffffff8020d0e6>] apic_timer_interrupt+0x66/0x70
[    7.011541]  <EOI>  [<ffffffff804a12eb>] ? _spin_unlock_irq+0x2b/0x30
[    7.011541]  [<ffffffff804a0b75>] ? __down_read+0xa5/0xb7
[    7.011541]  [<ffffffff8026fad5>] ? acct_collect+0x45/0x1d0
[    7.011541]  [<ffffffff8049fb57>] ? down_read+0x37/0x40
[    7.011541]  [<ffffffff8026fad5>] ? acct_collect+0x45/0x1d0
[    7.011541]  [<ffffffff8026fad5>] ? acct_collect+0x45/0x1d0
[    7.011541]  [<ffffffff8023f27d>] ? do_exit+0x18d/0x9b0
[    7.011541]  [<ffffffff803c7d19>] ? do_unblank_screen+0x19/0x130
[    7.011541]  [<ffffffff804a1a17>] ? oops_end+0x87/0x90
[    7.011541]  [<ffffffff804a3cd3>] ? do_page_fault+0x663/0x800
[    7.011541]  [<ffffffff804a15ed>] ? error_exit+0x0/0x9a
[    7.011541]  [<ffffffffa008f524>] ? get_idr+0x44/0xa0 [thermal_sys]
[    7.011541]  [<ffffffff8025e282>] ? debug_mutex_add_waiter+0x32/0x80
[    7.011541]  [<ffffffffa008f524>] ? get_idr+0x44/0xa0 [thermal_sys]
[    7.011541]  [<ffffffff8049f556>] ? mutex_lock_nested+0xa6/0x250
[    7.011541]  [<ffffffffa008f524>] ? get_idr+0x44/0xa0 [thermal_sys]
[    7.011541]  [<ffffffff80363584>] ? idr_pre_get+0x44/0x90
[    7.011541]  [<ffffffffa008f524>] ? get_idr+0x44/0xa0 [thermal_sys]
[    7.011541]  [<ffffffffa008fe43>] ? thermal_cooling_device_register+0x83/0x250 [thermal_sys]
[    7.011541]  [<ffffffffa019b2a3>] ? acpi_processor_start+0x64b/0x774 [processor]
[    7.011541]  [<ffffffff8031a90b>] ? __sysfs_add_one+0x6b/0xa0
[    7.011541]  [<ffffffff8031b9fc>] ? sysfs_do_create_link+0xbc/0x150
[    7.011541]  [<ffffffff803a7f1e>] ? acpi_start_single_object+0x2d/0x52
[    7.011541]  [<ffffffff803a9516>] ? acpi_device_probe+0x7e/0x92
[    7.011541]  [<ffffffff803dd3ab>] ? driver_probe_device+0x9b/0x1a0
[    7.011541]  [<ffffffff803dd536>] ? __driver_attach+0x86/0x90
[    7.011541]  [<ffffffff803dd4b0>] ? __driver_attach+0x0/0x90
[    7.011541]  [<ffffffff803dc8fd>] ? bus_for_each_dev+0x5d/0x90
[    7.011541]  [<ffffffff803dd1ec>] ? driver_attach+0x1c/0x20
[    7.011541]  [<ffffffff803dcf39>] ? bus_add_driver+0x1e9/0x260
[    7.011541]  [<ffffffffa0222000>] ? acpi_processor_init+0x0/0x107 [processor]
[    7.011541]  [<ffffffff803dd70f>] ? driver_register+0x5f/0x140
[    7.011541]  [<ffffffffa0222000>] ? acpi_processor_init+0x0/0x107 [processor]
[    7.011541]  [<ffffffff803a9826>] ? acpi_bus_register_driver+0x3e/0x40
[    7.011541]  [<ffffffffa0222094>] ? acpi_processor_init+0x94/0x107 [processor]
[    7.011541]  [<ffffffff80209040>] ? _stext+0x40/0x180
[    7.011541]  [<ffffffff802a88d1>] ? __vunmap+0xa1/0x110
[    7.011541]  [<ffffffff80267642>] ? sys_init_module+0x142/0x1dc0
[    7.011541]  [<ffffffff80367ad6>] ? __up_read+0x46/0xb0
[    7.011541]  [<ffffffff8048e530>] ? cpu_down+0x0/0x70
[    7.011541]  [<ffffffff8020c34b>] ? system_call_fastpath+0x16/0x1b
[    7.011541] 
[    7.011541] 
[    7.011541] Code: 8b 47 08 8b 50 1c 65 8b 04 25 24 00 00 00 39 c2 74 0d 0f ae f0 48 8b 47 08 f6 40 18 04 74 02 c9 c3 89 d7 ff 15 1f 7b 3c 00 c 
[    7.021541] RIP  [<ffffffff8022cc2b>] resched_task+0x6b/0x70
[    7.021541]  RSP <ffff88022f0efe98>
[    7.021541] ---[ end trace 53d26a9a6cd6aa38 ]---
[    7.021541] Kernel panic - not syncing: Aiee, killing interrupt handler!
[    7.021541] ------------[ cut here ]------------
[    7.021541] WARNING: at kernel/smp.c:328 smp_call_function_mask+0x25a/0x260()
[    7.021541] Modules linked in: processor(+) fan thermal_sys fuse
[    7.021541] Pid: 1259, comm: modprobe Tainted: G      D   2.6.27-rc3 #26
[    7.021541] 
[    7.021541] Call Trace:
[    7.021541]  <IRQ>  [<ffffffff8023bacf>] warn_on_slowpath+0x5f/0x80
[    7.021541]  [<ffffffff802650ca>] smp_call_function_mask+0x25a/0x260
[    7.021541]  [<ffffffff8036957d>] ? string+0x3d/0xd0
[    7.021541]  [<ffffffff80369a4b>] ? vsnprintf+0x43b/0x720
[    7.021541]  [<ffffffff8036957d>] ? string+0x3d/0xd0
[    7.021541]  [<ffffffff8036957d>] ? string+0x3d/0xd0
[    7.021541]  [<ffffffff80369a4b>] ? vsnprintf+0x43b/0x720
[    7.021541]  [<ffffffff80368d1e>] ? number+0x2ae/0x2d0
[    7.021541]  [<ffffffff80368d1e>] ? number+0x2ae/0x2d0
[    7.021541]  [<ffffffff80269e4d>] ? kallsyms_lookup+0x5d/0xa0
[    7.021541]  [<ffffffff80368d1e>] ? number+0x2ae/0x2d0
[    7.021541]  [<ffffffff80369a4b>] ? vsnprintf+0x43b/0x720
[    7.021541]  [<ffffffff80369d98>] ? sprintf+0x68/0x70
[    7.021541]  [<ffffffff8036957d>] ? string+0x3d/0xd0
[    7.021541]  [<ffffffff804a3f63>] ? __atomic_notifier_call_chain+0x83/0xa0
[    7.021541]  [<ffffffff804a3ee0>] ? __atomic_notifier_call_chain+0x0/0xa0
[    7.021541]  [<ffffffff804a0eb6>] ? _spin_unlock+0x26/0x30
[    7.021541]  [<ffffffff8021c470>] ? stop_this_cpu+0x0/0x30
[    7.021541]  [<ffffffff80265110>] smp_call_function+0x40/0x50
[    7.021541]  [<ffffffff8021c4f3>] native_smp_send_stop+0x23/0x40
[    7.021541]  [<ffffffff8023be1f>] panic+0xaf/0x190
[    7.021541]  [<ffffffff8023cc77>] ? printk+0x67/0x70
[    7.021541]  [<ffffffff8049f4a9>] ? mutex_unlock+0x9/0x10
[    7.021541]  [<ffffffff80256c91>] ? blocking_notifier_call_chain+0x11/0x20
[    7.021541]  [<ffffffff8023f9f9>] do_exit+0x909/0x9b0
[    7.021541]  [<ffffffff803c7d19>] ? do_unblank_screen+0x19/0x130
[    7.021541]  [<ffffffff804a1a17>] oops_end+0x87/0x90
[    7.021541]  [<ffffffff8020e08e>] die+0x5e/0x90
[    7.021541]  [<ffffffff804a1f20>] do_trap+0x130/0x150
[    7.021541]  [<ffffffff8020e662>] do_invalid_op+0x92/0xb0
[    7.021541]  [<ffffffff8022cc2b>] ? resched_task+0x6b/0x70
[    7.021541]  [<ffffffff8025788e>] ? sched_clock_cpu+0x14e/0x190
[    7.021541]  [<ffffffff804a15ed>] error_exit+0x0/0x9a
[    7.021541]  [<ffffffff8022cc2b>] ? resched_task+0x6b/0x70
[    7.021541]  [<ffffffff8023774f>] task_tick_fair+0xbf/0xd0
[    7.021541]  [<ffffffff80238510>] ? hrtick+0x0/0x90
[    7.021541]  [<ffffffff8023855d>] hrtick+0x4d/0x90
[    7.021541]  [<ffffffff80254f65>] __run_hrtimer+0x95/0xb0
[    7.021541]  [<ffffffff80255c4b>] hrtimer_interrupt+0x11b/0x190
[    7.021541]  [<ffffffff8021d643>] smp_apic_timer_interrupt+0x83/0xc0
[    7.021541]  [<ffffffff8020d0e6>] apic_timer_interrupt+0x66/0x70
[    7.021541]  <EOI>  [<ffffffff804a12eb>] ? _spin_unlock_irq+0x2b/0x30
[    7.021541]  [<ffffffff804a0b75>] ? __down_read+0xa5/0xb7
[    7.021541]  [<ffffffff8026fad5>] ? acct_collect+0x45/0x1d0
[    7.021541]  [<ffffffff8049fb57>] ? down_read+0x37/0x40
[    7.021541]  [<ffffffff8026fad5>] ? acct_collect+0x45/0x1d0
[    7.021541]  [<ffffffff8026fad5>] ? acct_collect+0x45/0x1d0
[    7.021541]  [<ffffffff8023f27d>] ? do_exit+0x18d/0x9b0
[    7.021541]  [<ffffffff803c7d19>] ? do_unblank_screen+0x19/0x130
[    7.021541]  [<ffffffff804a1a17>] ? oops_end+0x87/0x90
[    7.021541]  [<ffffffff804a3cd3>] ? do_page_fault+0x663/0x800
[    7.021541]  [<ffffffff804a15ed>] ? error_exit+0x0/0x9a
[    7.021541]  [<ffffffffa008f524>] ? get_idr+0x44/0xa0 [thermal_sys]
[    7.021541]  [<ffffffff8025e282>] ? debug_mutex_add_waiter+0x32/0x80
[    7.021541]  [<ffffffffa008f524>] ? get_idr+0x44/0xa0 [thermal_sys]
[    7.021541]  [<ffffffff8049f556>] ? mutex_lock_nested+0xa6/0x250
[    7.021541]  [<ffffffffa008f524>] ? get_idr+0x44/0xa0 [thermal_sys]
[    7.021541]  [<ffffffff80363584>] ? idr_pre_get+0x44/0x90
[    7.021541]  [<ffffffffa008f524>] ? get_idr+0x44/0xa0 [thermal_sys]
[    7.021541]  [<ffffffffa008fe43>] ? thermal_cooling_device_register+0x83/0x250 [thermal_sys]
[    7.021541]  [<ffffffffa019b2a3>] ? acpi_processor_start+0x64b/0x774 [processor]
[    7.021541]  [<ffffffff8031a90b>] ? __sysfs_add_one+0x6b/0xa0
[    7.021541]  [<ffffffff8031b9fc>] ? sysfs_do_create_link+0xbc/0x150
[    7.021541]  [<ffffffff803a7f1e>] ? acpi_start_single_object+0x2d/0x52
[    7.021541]  [<ffffffff803a9516>] ? acpi_device_probe+0x7e/0x92
[    7.021541]  [<ffffffff803dd3ab>] ? driver_probe_device+0x9b/0x1a0
[    7.021541]  [<ffffffff803dd536>] ? __driver_attach+0x86/0x90
[    7.021541]  [<ffffffff803dd4b0>] ? __driver_attach+0x0/0x90
[    7.021541]  [<ffffffff803dc8fd>] ? bus_for_each_dev+0x5d/0x90
[    7.021541]  [<ffffffff803dd1ec>] ? driver_attach+0x1c/0x20
[    7.021541]  [<ffffffff803dcf39>] ? bus_add_driver+0x1e9/0x260
[    7.021541]  [<ffffffffa0222000>] ? acpi_processor_init+0x0/0x107 [processor]
[    7.021541]  [<ffffffff803dd70f>] ? driver_register+0x5f/0x140
[    7.021541]  [<ffffffffa0222000>] ? acpi_processor_init+0x0/0x107 [processor]
[    7.021541]  [<ffffffff803a9826>] ? acpi_bus_register_driver+0x3e/0x40
[    7.021541]  [<ffffffffa0222094>] ? acpi_processor_init+0x94/0x107 [processor]
[    7.021541]  [<ffffffff80209040>] ? _stext+0x40/0x180
[    7.021541]  [<ffffffff802a88d1>] ? __vunmap+0xa1/0x110
[    7.021541]  [<ffffffff80267642>] ? sys_init_module+0x142/0x1dc0
[    7.021541]  [<ffffffff80367ad6>] ? __up_read+0x46/0xb0
[    7.021541]  [<ffffffff8048e530>] ? cpu_down+0x0/0x70
[    7.021541]  [<ffffffff8020c34b>] ? system_call_fastpath+0x16/0x1b
[    7.021541] 
[    7.021541] ---[ end trace 53d26a9a6cd6aa38 ]---
[    7.990001] BUG: spinlock lockup on CPU#0, swapper/0, ffff8800280b6e00
[    7.990001] Pid: 0, comm: swapper Tainted: G      D W 2.6.27-rc3 #26
[    7.990001] 
[    7.990001] Call Trace:
[    7.990001]  <IRQ>  [<ffffffff8036ee4e>] _raw_spin_lock+0x18e/0x1a0
[    7.990001]  [<ffffffff804a0fc4>] _spin_lock+0x34/0x40
[    7.990001]  [<ffffffff80230ed6>] ? sched_rt_period_timer+0x126/0x1e0
[    7.990001]  [<ffffffff80230ed6>] sched_rt_period_timer+0x126/0x1e0
[    7.990001]  [<ffffffff80230db0>] ? sched_rt_period_timer+0x0/0x1e0
[    7.990001]  [<ffffffff80254f65>] __run_hrtimer+0x95/0xb0
[    7.990001]  [<ffffffff80255c4b>] hrtimer_interrupt+0x11b/0x190
[    7.990001]  [<ffffffff8021d643>] smp_apic_timer_interrupt+0x83/0xc0
[    7.990001]  [<ffffffff8020d0e6>] apic_timer_interrupt+0x66/0x70
[    7.990001]  <EOI>  [<ffffffff802138a0>] ? mwait_idle+0x40/0x50
[    7.990001]  [<ffffffff8020a8d2>] ? enter_idle+0x22/0x30
[    7.990001]  [<ffffffff8020ae5c>] ? cpu_idle+0x4c/0xc0
[    7.990001]  [<ffffffff8048d7d1>] ? rest_init+0x61/0x70
[    7.990001] 

 CTRL-A Z for help |115200 8N1 | NOR | Minicom 2.3-rc | VT102 | Online 00:03                                                                     



--------------020308070009090704040704--
