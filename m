Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A49C6FD20
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 19:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjCXT70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 15:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjCXT7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 15:59:25 -0400
Received: from bluemchen.kde.org (unknown [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B84920D1C
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 12:58:56 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 4AF36241A2
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 15:58:39 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfnYd-TcN-00
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 20:58:39 +0100
Date:   Fri, 24 Mar 2023 20:58:39 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: Re: limiting git branch --contains
Message-ID: <ZB4A7+LMY+NSaPYE@ugly>
Mail-Followup-To: git@vger.kernel.org
References: <ZBygZbz5E6jVNp3y@ugly>
 <xmqqpm8z8dab.fsf@gitster.g>
 <ZBy6Ku+znv/wuOix@ugly>
 <594a358e-7bd4-e7a1-ad0f-7e41ca1fe767@github.com>
 <ZB3o0seQJVbtPa+j@ugly>
 <85f81579-5876-a573-6d35-88b35ab0f290@github.com>
 <ZB3z3e5G3Lrv9g3Y@ugly>
 <20230324191302.GB536967@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230324191302.GB536967@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2023 at 03:13:02PM -0400, Jeff King wrote:
>On Fri, Mar 24, 2023 at 08:02:53PM +0100, Oswald Buddenhagen wrote:
>> maybe the operation just forgets to load the graph?
>
so i strace'd the thing, and there is indeed no appearance of 
'commit-graph' in the log.

so i tried git log --graph ... and still nothing?!

and yes, core.commitgraph is true (originally absent, so same thing).

>That seems weird.
>
indeed.

so weird in fact, that i tried another repository. and it works!

so apparently something is wrong with my/the linux repository.
things i can imagine contributing to throwing it off somehow:

$ git remote -v
alsa    git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git (fetch)
alsa    git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git (push)
history git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git (fetch)
history git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git (push)
linux-mips      git://git.linux-mips.org/pub/scm/ralf/linux (fetch)
linux-mips      git://git.linux-mips.org/pub/scm/ralf/linux (push)
linux-wireless  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers (fetch)
linux-wireless  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers (push)
origin  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git (fetch)
origin  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git (push)
ossi    git@github.com:ossilator/linux.git (fetch)
ossi    git@github.com:ossilator/linux.git (push)

(the linux-* remotes haven't been pulled for years.)

$ grep replace .git/packed-refs
a3628e41a9946c4fe93d9b2ae5906e1b2184fa8e refs/replace/1da177e4c3f41524e886b7f1b8a0c1fc7321cac2

>What version of Git are you using?
>
rather recent master. dogfeeding my contributions.
