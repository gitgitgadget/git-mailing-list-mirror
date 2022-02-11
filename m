Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C65DC433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347060AbiBKUHS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:07:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243388AbiBKUHR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:07:17 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD12CFE
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:07:15 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0635A18785D;
        Fri, 11 Feb 2022 15:07:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mAdl1zldbnGFO5OHXDbkZyxkUtUU9LdnCSZxio
        5qwSE=; b=kUfivKSGN3Bwxbsw/0mYlP3hXQoP4WTZA3abWCTgbS5rMHswhbJeJU
        UaoZwoJdscenrx/6h8PrgkWwvoAiD2UIlgNekOdoHwjDpBLOZCELjXRDGt445Ouq
        iDDvl6JGjNSCHWs7xNAoePK6/8nCn/n9HM63N8Ei/kaAQgvk6o6/M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F25E118785C;
        Fri, 11 Feb 2022 15:07:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ACD2618785B;
        Fri, 11 Feb 2022 15:07:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Cai <johncai86@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 3/3] cat-file: add --batch-command mode
References: <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
        <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com>
        <6c51324a6623b62c385ec707a773c21375596584.1644465706.git.gitgitgadget@gmail.com>
        <0b40d1bb-4db1-002f-d665-f51db6c2882c@gmail.com>
        <xmqq5ypmwt1m.fsf@gitster.g>
        <9B08BF05-1C35-4C4F-9C76-CC34A8E7D0F0@gmail.com>
Date:   Fri, 11 Feb 2022 12:07:10 -0800
In-Reply-To: <9B08BF05-1C35-4C4F-9C76-CC34A8E7D0F0@gmail.com> (John Cai's
        message of "Fri, 11 Feb 2022 12:45:51 -0500")
Message-ID: <xmqqpmnt9ngx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32DB5962-8B76-11EC-BA6C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Cai <johncai86@gmail.com> writes:

> Let me see if I understand you. What I'm hearing is that it's hard to test a git
> processes (A) that read/write from/to pipes without knowing exactly how (A) will
> behave. By necessity, the test logic will have embedded some logic in it that
> assumes certain behavior from (A), which might or might not be the case.
>
> This can lead to a hanging test if, say, it is waiting around for (A) to output
> data when due to a bug in the code, it never does. Did I get that right?

Exactly.  And we've seen such tests that are designed to hang, when
they detect bugs, which made us very unhappy and we fixed them not
to hang but reliably fail.  Otherwise, such tests weren't very
useful in unattended CI environment, which we do not want to wait
for 3 hours to timeout and leave later steps in the same script
untested.

Thanks.
