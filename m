Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F5EC25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 22:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiHTWYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 18:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHTWYP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 18:24:15 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF220356C9
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 15:24:14 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 19B831A99A1;
        Sat, 20 Aug 2022 18:24:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=NhscS9ucYrZ99E/l0xxMvRLvMiHTdP0iPISIt8jeTA8=; b=MeNI
        RQ+LkDJcpLIZcL32+Z51ovncxRtUQok2Crz348tlJGKvXAT7vgUtCDlakBGQiS/S
        DGJV9gJH5TZHx9GAfFNznCBVsf3dakcvdnCDIVCuSEJ1/yppJLxqjB4iRUXMFsnP
        u70WMApzK+0qhMvbwam/LeX9RUXDhULW1mG4a98=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 12A101A99A0;
        Sat, 20 Aug 2022 18:24:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7D4501A999F;
        Sat, 20 Aug 2022 18:24:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
References: <pull.1326.git.1660855703816.gitgitgadget@gmail.com>
Date:   Sat, 20 Aug 2022 15:24:09 -0700
Message-ID: <xmqqsflqlfjq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0216C70-20D6-11ED-AC96-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> As a first step towards enabling fsmonitor to work against
> network-mounted repos, a configuration option, 'fsmonitor.allowRemote'
> was introduced for Windows. Setting this option to true will override
> the default behavior (erroring-out) when a network-mounted repo is
> detected by fsmonitor. In order for macOS to have parity with Windows,
> the same option is now introduced for macOS.

With this merged in, recent CI runs for 'seen'

e.g. https://github.com/git/git/actions/runs/2892889122

seems to break macOS jobs, letting them hog CPU forever and exceed
6hr or whatever the limit is.

As an experiment I pushed out 'seen' but without this commit (not
the entire topic is excluded, the Windows one is still included).
As there is nothing specific to macOS between 'next' and 'seen',
macOS jobs seem to pass, which is not very surprising.

https://github.com/git/git/actions/runs/2896207171

As the patch collected some review comments, I've already marked it
in the "What's cooking" draft as expecting a reroll of that step;
until that happens, let's keep it out of 'seen'.

Thanks.
