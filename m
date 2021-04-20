Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D172AC433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 19:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98789613D8
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 19:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhDTTON (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 15:14:13 -0400
Received: from siwi.pair.com ([209.68.5.199]:53649 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233691AbhDTTOL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 15:14:11 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id AF8E63F40D9;
        Tue, 20 Apr 2021 15:13:36 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 77F593F40B7;
        Tue, 20 Apr 2021 15:13:36 -0400 (EDT)
Subject: Re: [PATCH 00/23] [RFC] Builtin FSMonitor Feature
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <xmqq8s5hkfxm.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2104201646210.54@tvgsbejvaqbjf.bet>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e5035fa3-4218-209a-28e7-7c1b57d7f388@jeffhostetler.com>
Date:   Tue, 20 Apr 2021 15:13:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2104201646210.54@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/20/21 11:27 AM, Johannes Schindelin wrote:
> Hi Junio,
...
>>> This RFC version includes support for Windows and MacOS file system events.
>>> A Linux version will be submitted in a later patch series.
> 
> I guess this is another reason why this patch series did not see many
> reviews: the lack of a Linux backend. And I fear that the statement "A
> Linux version will be submitted in a later patch series" is a bit strong,
> given that my original implementation of that backend does not really do
> its job well: it uses `inotify` and therefore requires one handle _per
> directory_, which in turn drains the number of file handles rather quickly
> when your worktree has many directories. Meaning: It fails todoes not work in the
> massive worktrees for which it was intended.
> 
> Now, I heard rumors that there is a saner way to monitor directory trees
> in recent Linux kernel versions (Jeff, can you fill in where I am
> blanking?) and it might be a good idea to solicit volunteers to tackle
> this backend, so that the Linux-leaning crowd on this here mailing list
> is interested a bit more?

Yes, I removed the early inotify-based version because the kernel limits
the number of inotify handles to 8k (at least on my Mint box) and that
is a global limit -- shared by any process wanting to use inotify.
The first monorepo that I tried it on had 120K directories in my
sparse checkout...

I'm told there is a newer "fanotify" facility available in newer
Linux kernels that behaves more like Windows and MacOS and handles
subdirectories.  I intend to jump into that shortly (unless someone
is already familiar with fanotify and and wants to try it).

Jeff

