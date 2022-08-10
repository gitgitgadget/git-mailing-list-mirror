Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F20FC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 21:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiHJVmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 17:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHJVmE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 17:42:04 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D279E78597
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 14:42:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5A2EC19FA56;
        Wed, 10 Aug 2022 17:42:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bY6wljkiFYEzjzNfPLkN1aXUbcCSzBjEkk1ET6
        dbGNY=; b=MuCYuhHsff8s6s8XaISHXeppTERql0mI9s7g2wsWsVwdmaYrWT3Nmg
        QONIojkbRMsjpW5CsjfWN8x6A0BaG/tSw8sw5vll5LRHDVeGDvw5hV7drPLAJIdB
        eA8q0R/7JhJh9TN49QEVMzedaXJggB2X59JiCAT1q7WQVYBEkvvp4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5288919FA55;
        Wed, 10 Aug 2022 17:42:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E9CA519FA51;
        Wed, 10 Aug 2022 17:41:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric D <eric.decosta@gmail.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
References: <pull.1317.git.1660067049965.gitgitgadget@gmail.com>
        <xmqqmtccniw4.fsf@gitster.g>
        <CAMxJVdH3B2An7La9knM=QJojQ334O+Z2-tqNvqRZz2Eu6CV+-w@mail.gmail.com>
        <xmqqbksrlvyb.fsf@gitster.g>
        <CAMxJVdH-UbCZYp1hcvy4efEYd33jk0bFosJOtag5S4F9-m3-sg@mail.gmail.com>
        <CAMxJVdEvNKzwbHkRHcbd=_8yEuYZiNsNABVieU1tV5kna_nJ_g@mail.gmail.com>
Date:   Wed, 10 Aug 2022 14:41:58 -0700
In-Reply-To: <CAMxJVdEvNKzwbHkRHcbd=_8yEuYZiNsNABVieU1tV5kna_nJ_g@mail.gmail.com>
        (Eric D.'s message of "Wed, 10 Aug 2022 17:30:00 -0400")
Message-ID: <xmqqwnbfixnd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43ABC8D2-18F5-11ED-8CEB-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric D <eric.decosta@gmail.com> writes:

> The only thing that is somewhat gnawing at me is that just because the
> remote worktree is mounted via SMB is no guarantee that fsmonitor will
> work correctly. In many (most?) cases it should, but who knows what
> support the filer server has.
>
> I think we should allow the user to override regardless - as you said
> let the user try it. But, conservatively, just because SMB is there
> may not be enough to let the monitor start without the explicit user
> override. Being able to report on which protocol is being used could
> provide useful diagnostics, but that's about it.

I do not think anybody minds if the initial/first step would be to
add "option to allow" and do nothing else.  No "are we talking SMB?"
check, and just a simple "by default we refuse going remote, but
since the user has an explicit opt-in configuration set, we allow".

That is sufficient to let people gain experience using fsmonitor on
Windows mounting from various filer implementations.  And then the
next step, in one or two major releases down the road, may try to
check what kind of filer we are on and see if it is one of the
"good" ones to flip the default selectively.

