Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AD6C433E3
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 16:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAFF42073E
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 16:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wdRgvrOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgG0QNk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:13:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53741 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgG0QNj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 12:13:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77CE26C907;
        Mon, 27 Jul 2020 12:13:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6B5tBBddO38831PqgeRIQyDmsaY=; b=wdRgvr
        Oqz0AAVmgZJ8MvKDZi67q2U0z3EM5+OU3w32ycZ0/SexuwsG54kLyBGPuuvnq9Hm
        o5FTr6zcg0kF2tvtlVp1SVvD5hrP6+c8k/MlI27zlZgCGZVNEg+TTTPEJR1kya4P
        Sn9e/e3duIxSyNJ70Wc10+8vsEerk2OEIMdnU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wEEVAzyUctaR6nT0MxQqS3UWvuZHuL78
        h30Lni/7xEHQsK0RUpiLbJcowVESUm2qqC8G+AMWGNK7tP2zvEmLI3GQKQfrb/kW
        OYuIaVvS1vqDh94tuJCxmWaCNt4pXMZJAMwshZMnnbSWvNknd5MWSU+KenvvqEqi
        pPshLYW66yQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A8486C906;
        Mon, 27 Jul 2020 12:13:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E176C6C904;
        Mon, 27 Jul 2020 12:13:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 08/18] maintenance: add prefetch task
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <3165b8916d2d80bf72dac6596a42c871ccd4cbe6.1595527000.git.gitgitgadget@gmail.com>
        <20200725013715.GA2436@danh.dev>
        <xmqqv9icicvd.fsf@gitster.c.googlers.com>
        <421cb856-24fc-6aa0-6ab0-f513d34ddd1a@gmail.com>
Date:   Mon, 27 Jul 2020 09:13:35 -0700
In-Reply-To: <421cb856-24fc-6aa0-6ab0-f513d34ddd1a@gmail.com> (Derrick
        Stolee's message of "Mon, 27 Jul 2020 10:07:50 -0400")
Message-ID: <xmqqy2n5gcls.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 206A78A8-D024-11EA-B059-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I'll rebase onto jc/no-update-fetch-head for the next version, since
> that branch is based on v2.28.0-rc0, which is recent enough.

I do not think it is wise to base a work on top of unfinished "you
could do it this way, perhaps?" demonstration patch the original
author does not have much inclination to finish, though.

When I am really bored, I may go back to the topic to finish it, but
I wouldn't mind if you took ownership of it at all.

Thanks.



