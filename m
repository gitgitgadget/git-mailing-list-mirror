Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2954D1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 06:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfKDGC3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 01:02:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57780 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfKDGC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 01:02:29 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE7F4331C6;
        Mon,  4 Nov 2019 01:02:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=5jty2mInbehN9adrmMp1qCmzIIc=; b=pWQ7X/9QSWOC0JXSzR/1
        9uoqALKorrCAkMiR42r5Nm72mZqrHn0jI65by238HYqODwbGHqUoN/gTxIwfNush
        ySAnHAvVX2/jjvsI5vxjTN3pCI6PJ4FaVjusZ2ZElwfNOO4D5bannRHNqvLXYplg
        ofrGZKlhtUvCXzs4s+juiD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=j/ioG5k2Qf7Vc7z0AX0BpjNlDlwPqrTIrk46Me02kypIeW
        JzjqQfDidd02v9ueCIsUoFiLLNjXv/5QBjcVpyYtqDxaACx2gBAGwmB7mlxT7rru
        ynfu2RBxkbCuRkm86e3eBaomh9B7oVzVJQ94llqNjUOtvXK/cRtGSdJ2wYxSI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4087331C5;
        Mon,  4 Nov 2019 01:02:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CF367331C4;
        Mon,  4 Nov 2019 01:02:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Utsav Shah <utsav@dropbox.com>
Cc:     Kevin Willford <Kevin.Willford@microsoft.com>,
        Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Utsav Shah <ukshah2@illinois.edu>
Subject: Re: [PATCH 1/1] unpack-trees: skip lstat based on fsmonitor
References: <pull.424.git.1572017008.gitgitgadget@gmail.com>
        <609c7c5047719a619ba22425dafc6ecd105e2cda.1572017008.git.gitgitgadget@gmail.com>
        <xmqq8sp5a6cd.fsf@gitster-ct.c.googlers.com>
        <CAPYzU3N9mDfHVogfq=mhJFj6VOjS2z4ui4msnDdK6pOtVBa_QA@mail.gmail.com>
        <BN6PR21MB078676C4FA54391B1954D5F791660@BN6PR21MB0786.namprd21.prod.outlook.com>
        <CAPYzU3NZZ-H_PWcRH_ooXzrYnRNjvF9ayX4_xeMJeMiHB=8fLg@mail.gmail.com>
        <BN6PR21MB078689FFE9ED95A31998F41A91610@BN6PR21MB0786.namprd21.prod.outlook.com>
        <CAPYzU3Mv9fHG_WhCOfsA8KGeegdUCoEzfDCt8-DQ+CEjs=V62Q@mail.gmail.com>
        <xmqqh83r5bi0.fsf@gitster-ct.c.googlers.com>
        <CAPYzU3MuacmCJoC0pioL4ymyRA7tku8BbNmSTrtZtJWMHpvJNg@mail.gmail.com>
Date:   Mon, 04 Nov 2019 15:02:24 +0900
Message-ID: <xmqqsgn4xjpr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACDEAEB8-FEC8-11E9-941E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Utsav Shah <utsav@dropbox.com> writes:

[jc: we avoid top-posting for readability, so swapped paragraphs in
this quote]

>> Perhaps we can take a polished version of this "'reset --hard' can
>> and should notice paths known-to-be-uptodate via fsmonitor" as an
>> independent patch (to reduce the number of things we have to worry
>> by one) for now?  Taking this patch means we would now have one more
>> place that checks both ce_uptodate() and FSMONITOR_VALID bit, but if
>> we would be auditing all such places before we can decide what the
>> best way to reach the goal of allowing them to just say ce_uptodate()
>> without having to spell FSMONITOR_VALID, that probably is a cost
>> worth paying.
>>
>> Thanks for working on this topic.
>
> Thanks, that makes a lot of sense. ce_uptodate doesn't have too many
> callers either, so modifying it and checking CE_FSMONITOR_VALID there
> should not be hard to audit.

OK, so let's see an updated and hopefully final version of [*1*],
perhaps with Kevin's help you mentioned in [*2*] for now?


[References]

*1* <pull.424.git.1572017008.gitgitgadget@gmail.com>
*2* <CAPYzU3Mv9fHG_WhCOfsA8KGeegdUCoEzfDCt8-DQ+CEjs=V62Q@mail.gmail.com>
