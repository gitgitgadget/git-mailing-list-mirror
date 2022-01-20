Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD086C433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 05:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiATFCr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 00:02:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58261 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiATFCq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 00:02:46 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D889C10F85A;
        Thu, 20 Jan 2022 00:02:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=eaMoWuE30tuGuBrYC8QLfbQGXBbHOtS5LdKVtql+f+A=; b=DN+M
        JlbIqE2KUoEjiWxt97L8IpvXlNs+yUO5Anb1WrAhWwZpwf1dgmcjE/6fm+Xu37pU
        k5wWW2LBmG7Fu1ygIuQl2lnOhlg2k7h8iU8m9H59Ym23qRT875Jc4xwRRS0jEV4h
        IgfQeBneZbJRqgsdiz0fh0VUpjagzCSp+8iT1Lg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE29810F859;
        Thu, 20 Jan 2022 00:02:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 408E010F858;
        Thu, 20 Jan 2022 00:02:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/2] builtin add -p: fix hunk splitting
References: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
        <pull.1100.v2.git.1641899530.gitgitgadget@gmail.com>
        <220111.861r1ezcxn.gmgdl@evledraar.gmail.com>
        <348d37a3-f01b-cda6-8ce4-1536e0bd3b06@gmail.com>
        <xmqqv8yovlc2.fsf@gitster.g>
        <47e7b23a-56a3-b533-63ed-a854503b59ed@gmail.com>
Date:   Wed, 19 Jan 2022 21:02:43 -0800
Message-ID: <xmqqr193j8y4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3472674A-79AE-11EC-BA2A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Even if the helper is finalizing the current hunk then I think that
> "nonsense" hunk would still wrong as it would be calling
> finalize_hunk() on _every_ context line in the hunk rather than just
> being called once to finalize the hunk.

True; this triggers every time we finish reading the common context
lines and not at the end of hunk.  In any case, I think what we
queued looks good for 'next'.

>>   -		if ((marker == '-' || marker == '+') && *p == ' ')
>> -			hunk->splittable_into++;
>> +		if (*p == ' ')
>> +			complete_file(marker, &hunk->splittable_into);
