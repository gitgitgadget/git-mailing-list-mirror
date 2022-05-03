Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C984C433EF
	for <git@archiver.kernel.org>; Tue,  3 May 2022 05:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiECFzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 01:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiECFzO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 01:55:14 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FEE237CC
        for <git@vger.kernel.org>; Mon,  2 May 2022 22:51:42 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BBC18189695;
        Tue,  3 May 2022 01:51:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y+66l9tZCBpTdKKBJmxrzS/ohopcsl6RfOKyJX
        pWSnI=; b=scbrVR6dkwyQuQnFppOnpiYEs2Z4guCMEk3UG0n0L59cb1AToAe5qm
        TM9P1ukBgSNC28YGXZiJN0Kemoe+x35fxtNfm5pWAlU3Xub7PoVjHkqWOkD/VhVO
        TPOAWPDJdnFUTAGYdYc8TH7qb7gPl6K8bl0ScOgsTSfytyGK3V+CI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B50ED189694;
        Tue,  3 May 2022 01:51:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 404C0189679;
        Tue,  3 May 2022 01:51:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Incorrect branch information after fetching (local branch !=
 remote branch)
References: <9b3a9023-cd73-2e9d-64f1-7cc7e53d9b54@gmail.com>
Date:   Mon, 02 May 2022 22:51:37 -0700
In-Reply-To: <9b3a9023-cd73-2e9d-64f1-7cc7e53d9b54@gmail.com> (Bagas Sanjaya's
        message of "Tue, 3 May 2022 11:58:10 +0700")
Message-ID: <xmqq7d73rwnq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1932529A-CAA5-11EC-A83E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> I have a copy of linux.git (Linux kernel) repository, with following
> branch mapping:
>
>   * master -> torvalds/master (Linus' mainline tree)
>   * linux-5.*.y -> stable/linux-5.*.y (Stable tree)
>   * net-next -> net-next/master (net-next tree)
>
> When I fetch the mainline tree (torvalds/master), I get the expected
> branch fetching info:
>
> From https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux
>    672c0c5173427e..9050ba3a61a4b5  master     -> torvalds/master
>
> When I fetch net-next, I get possibly incorrect branch name instead:
>
> From https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
>    6e28f56c0d1d97..0530a683fc858a  master     -> net-next/master
>
> I expected that net-next (local branch name) is displayed instead of
> master in this case.
>
> Thanks.

I may be entirely missing what you are raising as a problem, but visiting

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/

shows that their primary branch is called 'master'.

The verbose report left by "git fetch" tells us what branch they
have is used to update what branch we have, so I think this is
pretty much expected.

I am puzzled by your mention of 'net-next' (local).

You may have

    [branch "net-next"]
        remote = net-next
	merge = master

and that is where your expectation on the local may be coming from,
but it wouldn't be all that relevant to "git fetch". The update of
the local branch will happen long after "git fetch" is done.

Besides, you may have more than one local branch that is forked from
the same remotes/net-next/master remote-tracking branch and at that
point "git fetch" wouldn't be able to tell which one of these
multiple local branches to show.
