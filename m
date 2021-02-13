Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8CAC433DB
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9704664E8E
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhBMBxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 20:53:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54042 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbhBMBxy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 20:53:54 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6CB2B672F;
        Fri, 12 Feb 2021 20:53:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WS0rquxLHDpwEYMVjbClLI5fJj4=; b=ZSwm9K
        P+pFkx7M5gc9t4YoNpXjBO2QWCpXitTceb5syOhfftiBNZau0oHwqINHGrSaEDGD
        XUN8ojjq5miM1XfDItPFHU1okrXyhmgb9r9VIkU10M5VMPm5sOMX35fD5JIkORKa
        GyYagJ6XAdOF5SraQDe4OezxdCAKmfTp53JNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qZ2eveKyMIptd3jOrqT1y7ByTodn9fu4
        3GqjZgkO9j38jzR0i+X97YgrHJ4bmZuOeJPiu3MFVQINUFepRz7IvE28Lye+Bszr
        LGxbCefFiecyTFx0aMVzfmAptuEelcfFEc4we5h7MTuAtla+BGT+v4c38yQhuWFQ
        EUhH2e9dD/s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD226B672E;
        Fri, 12 Feb 2021 20:53:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 035EAB672D;
        Fri, 12 Feb 2021 20:53:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 0/6] Optimization batch 7: use file basenames to
 guide rename detection
References: <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
        <pull.843.v4.git.1613031350.gitgitgadget@gmail.com>
Date:   Fri, 12 Feb 2021 17:53:10 -0800
In-Reply-To: <pull.843.v4.git.1613031350.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Thu, 11 Feb 2021 08:15:43
        +0000")
Message-ID: <xmqqk0rcu41l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A00DDDA-6D9E-11EB-A6DC-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series depends on ort-perf-batch-6[1].
>
> This series uses file basenames (portion of the path after final '/',
> including extension) in a basic fashion to guide rename detection.
>
> Changes since v3:
>
>  * update documentation as suggested by Junio
>  * NEW: add another patch at the end, to simplify patch series that will be
>    submitted later (please review!)

Sorry, by mistake I somehow read v4 and sent some comments on v3,
but as the above says, they are on the part that hadn't changed at
all, and should still be relevant.

Thanks.

