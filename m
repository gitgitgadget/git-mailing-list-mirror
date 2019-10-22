Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 351751F4C1
	for <e@80x24.org>; Tue, 22 Oct 2019 08:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388326AbfJVIQc (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 04:16:32 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54211 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388061AbfJVIQb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 04:16:31 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iMpL8-0006mc-Dk; Tue, 22 Oct 2019 10:16:26 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iMpL6-0003pF-L0; Tue, 22 Oct 2019 10:16:24 +0200
Date:   Tue, 22 Oct 2019 10:16:24 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>, git@vger.kernel.org
Subject: Re: [GIT PULL] arm64: Fixes for -rc4
Message-ID: <20191022081624.4tmumskeoayt4bzg@pengutronix.de>
References: <20191017234348.wcbbo2njexn7ixpk@willie-the-truck>
 <CAHk-=wjPZYxiTs3F0Vbrd3kRizJGq-rQ_jqH1+8XR9Ai_kBoXg@mail.gmail.com>
 <20191018174153.slpmkvsz45hb6cts@willie-the-truck>
 <CAHk-=whmtB98b8=YL2b8HzPKRadk2A9pL0aasmvgebhePrDP9w@mail.gmail.com>
 <20191021064658.GB22042@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021064658.GB22042@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I added the git list to Cc:. For the new readers: The context of this
thread can be found at
https://lwn.net/ml/linux-kernel/20191017234348.wcbbo2njexn7ixpk@willie-the-truck/

On Mon, Oct 21, 2019 at 08:46:58AM +0200, Ingo Molnar wrote:
> Anyway, a small Git feature request: it would be super useful if "git 
> request-pull" output was a bit more dependable and at least warned about 
> this and didn't include what is, from the viewpoint of the person doing 
> the merge, a bogus diffstat. (Generating the correct diffstat is probably 
> beyond request-pull's abilities: it would require changing the working 
> tree to actually perform the merge - while request-pull is a read-only 
> operation right now. But detecting the condition and warning about it 
> should be possible?)

I think Will's case is still an easy one compared with what could
actually happen.

The related history looks as follows:

             ,-.     ,-.              ,-.    ,-.    ,-.
  v5.4-rc1 --| |-...-| |-- v5.4-rc2 --| |-..-| |-..-| |-- v5.4-rc3
      \      `-'     `-'       \      `-'    /-'    `-'
       \   ,-.     ,-.          \         ,-/    ,-.     ,-.
        `--| |-...-| |--------------------|*|----| |-...-|H|
           `-'     `-'            \       `-'    `-'     /-'
                                   \   ,-.     ,-.      /
                                    `--| |-...-| |-----'
                                       `-'     `-'

Will asked Linus to merge the Commit marked 'H', the two merge bases are
v5.4-rc2 and '*'.

(FTR:
  * = 3e7c93bd04edfb0cae7dad1215544c9350254b8f
  H = 777d062e5bee0e3c0751cdcbce116a76ee2310ec
, they can be found in
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git)

The formally correct way to create the diffstat is to merge v5.4-rc2 and
'*' (in general: all merge bases) and calculate the diff between this
merge and the to-be-merged-commit. Compared to what Will did (i.e. merge
Linus' HEAD and this branch and then diff @~ with @) doing it the way I
described has the advantage(?) that commits that conflict with this
merge request in Linus' tree since the merge bases are not in the way.

In this case this can be done automatically:

	$ git read-tree --index-output=tralala v5.4-rc2 3e7c93bd04edfb0cae7dad1215544c9350254b8f
	$ GIT_INDEX=tralala git write-tree
	6a2acfd1870d9da3c330ea9b648a7e858b5ee39f
	$ git diff --stat 6a2acfd1870d9da3c330ea9b648a7e858b5ee39f 777d062e5bee0e3c0751cdcbce116a76ee2310ec
	 Documentation/arm64/silicon-errata.rst |  2 ++
	 arch/arm64/Kconfig                     | 17 ++++++++++++++
	 arch/arm64/include/asm/asm-uaccess.h   |  7 +++---
	 arch/arm64/include/asm/cpucaps.h       |  4 +++-
	 arch/arm64/include/asm/memory.h        | 10 ++++++--
	 arch/arm64/include/asm/pgtable.h       |  3 ---
	 arch/arm64/include/asm/sysreg.h        |  2 +-
	 arch/arm64/kernel/cpu_errata.c         | 38 +++++++++++++++++++++++++++++++
	 arch/arm64/kernel/cpufeature.c         | 15 ++++++++----
	 arch/arm64/kernel/entry.S              |  8 ++++---
	 arch/arm64/kernel/hibernate.c          |  9 +++++++-
	 arch/arm64/kernel/process.c            | 18 +++++++++++++++
	 arch/arm64/kvm/hyp/switch.c            | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
	 arch/arm64/mm/fault.c                  |  6 ++++-
	 include/linux/sched.h                  |  1 +
	 15 files changed, 186 insertions(+), 23 deletions(-)

Would be great if git-request-pull learned to do that.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
