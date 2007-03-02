From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.21-rc1: known regressions (part 2)
Date: Fri, 2 Mar 2007 11:20:18 +0100
Message-ID: <20070302102018.GA11549@elte.hu>
References: <20070227103021.GA2250@kernel.dk> <20070227103407.GA17819@elte.hu>
	<20070227105922.GD2250@kernel.dk> <20070227111515.GA4271@kernel.dk>
	<20070301093450.GA8508@elte.hu> <20070301104117.GA22788@elte.hu>
	<20070301145204.GA25304@elte.hu>
	<Pine.LNX.4.64.0703011536450.12485@woody.linux-foundation.org>
	<20070302072100.GB30634@elte.hu> <20070302080441.GA12785@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Daniel Walker <dwalker@mvista.com>,
   Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
   linux-pm@lists.osdl.org,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>,
   Jens Axboe <jens.axboe@oracle.com>,
   "Michael S. Tsirkin" <mst@mellanox.co.il>,
   Thomas Gleixner <tglx@linutronix.de>,
   Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-pm-bounces@lists.osdl.org Fri Mar 02 11:28:32 2007
Return-path: <linux-pm-bounces@lists.osdl.org>
Envelope-to: gll-linux-pm@gmane.org
Received: from smtp.osdl.org ([65.172.181.24])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN502-0007rN-86
	for gll-linux-pm@gmane.org; Fri, 02 Mar 2007 11:28:30 +0100
Received: from fire-2.osdl.org (localhost [127.0.0.1])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l22AS7Ab014284;
	Fri, 2 Mar 2007 02:28:14 -0800
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l22ARvAb014278
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-pm@lists.osdl.org>; Fri, 2 Mar 2007 02:27:59 -0800
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim) id 1HN4zM-0003B2-Pe
	from <mingo@elte.hu>; Fri, 02 Mar 2007 11:27:51 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 46A273E2141; Fri,  2 Mar 2007 11:27:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20070302080441.GA12785@elte.hu>
User-Agent: Mutt/1.4.2.2i
Received-SPF: pass (localhost is always allowed.)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no
	SpamAssassin version=3.0.3
	-2.0 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
X-Spam-Status: No, hits=-2.478 required=5 tests=AWL,OSDL_HEADER_LISTID_KNOWN,OSDL_HEADER_SPF_PASS,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-BeenThere: linux-pm@lists.osdl.org
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: Linux power management <linux-pm.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41184>


* Ingo Molnar <mingo@elte.hu> wrote:

> I'll now try the following: i'll try to manually apply Len's fix to =

> every tree that git-bisect offers me, in the hope of being able to =

> isolate the /other/ bug.
> =

> [ But really, i'm not expecting any miracles because this is way out of
>   league for git-bisect which really depends on only having a binary =

>   space to search for. ]

this method pointed out the real bug that we are interested in:

| 774c47f1d78e373a6bd2964f4e278d1ce26c21cb is first bad commit
| commit 774c47f1d78e373a6bd2964f4e278d1ce26c21cb
| Author: Avi Kivity <avi@qumranet.com>
| Date:   Mon Feb 12 00:54:47 2007 -0800
|     [PATCH] KVM: cpu hotplug support

undoing the 774c47f1 patch from HEAD gave me a working resume. I'll send =

a fix for this KVM breakage in a separate mail.

here's how the bisection went:

 bad:   [01363220f5d23ef68276db8974e46a502e43d01d] [PARISC] clocksource:
 good:  [fa285a3d7924a0e3782926e51f16865c5129a2f7] Linux 2.6.20
 +good: [bcdb81ae29091f6a66369aabfd8324e4a53d05dc] knfsd: SUNRPC: add a
 bad:   [920841d8d1d61bc12b43f95a579a5374f6d98f81] Merge branch 'for-linus'
 +bad:  [86a71dbd3e81e8870d0f0e56b87875f57e58222b] sysctl: hide the sysctl
 +bad:  [719c91ccadd3ed26570dbb29d54166914832eee9] [POWERPC] Use udbg_early
 +bad:  [ebaf0c6032f525ddb0158fb59848d41899dce8cd] Merge branch 'for-linus'
 +good: [8cd133073f9b5cd335c0b2e4740aceb025d50ca9] kvm: Fix mismatch between
 +bad:  [5b8e8ee6c65a34d8aafaeb8e2eaa97e496c2567c] ps3: add shutdown to
 +bad:  [a524d946bdced73c5fbe60170fb33611491c4211] tgafb: sync-on-green
 +bad:  [a268422de8bf1b4c0cb97987b6c329c9f6a3da4b] fbdev driver for S3
 +good: [8d0be2b3bf4a55606967d7d84e56c52521e94333] KVM: VMX: add vcpu_clear=
()
 +bad:  [59ae6c6b87711ceb2d1ea5f9e08bb13aee947a29] KVM: Host suspend/resume
 +bad:  [774c47f1d78e373a6bd2964f4e278d1ce26c21cb] KVM: cpu hotplug support

the commits prefixed with '+' were the ones where i had to hand-merge =

the f3ccb06f commit to. Near the end of the bisection it nicely honed in =

on the group of KVM changes that included the bad commit.

but the conclusion is clear: if multiple bugs are present in the search =

area then it gets quite difficult to sort it out via git-bisect - but =

it's not impossible either. The following git-bisect enhancement could =

have made things easier for me:

   git-bisect mark-must-have <tree>

which would mark <tree> as a must-have fix and would attempt to merge it =

to whatever bisection point it ends up with - if that bisection point =

does not have <tree> included already. (Maybe not even the full tree but =

only one particular commit ID.) In this particular case that merge, when =

it had to be done, was always 'clean'.

	Ingo
