Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4153C4707F
	for <git@archiver.kernel.org>; Tue, 25 May 2021 20:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B8E66140B
	for <git@archiver.kernel.org>; Tue, 25 May 2021 20:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhEYUrt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 16:47:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61967 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhEYUrs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 16:47:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F31BD21E4;
        Tue, 25 May 2021 16:46:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0WGzxVPah1ksnaRkka+ZrtuihvBbLVLnJrEYyb
        /5hf4=; b=V0Xv/l/uzQVWc0JgpMNPdcaGsAQ2c/gye2VVuTMA/t4McbN5NDUNM2
        D4lYZ1d2e7SOCMg4nDnqd3QVP2c4FWbJi/ziJl7QxWx6nZ/4zOEvAbvEsgzLFFhd
        7TkmA2RfgZ8WpJ/V6KbSRW5DKjesac+Lk27kXoSEhdFIv5xW5kadU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 46978D21E3;
        Tue, 25 May 2021 16:46:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C76BCD21E2;
        Tue, 25 May 2021 16:46:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] t1092: use GIT_PROGRESS_DELAY for consistent results
References: <pull.960.git.1621886108515.gitgitgadget@gmail.com>
        <YKwMU13DOtTIgaeP@google.com>
        <e35b5217-362f-fc4f-7396-08218a9abf63@gmail.com>
        <YKwd2e5VxVmU6zqj@nand.local> <87fsybohy5.fsf@evledraar.gmail.com>
        <YKxBIP4lkoPeCYvb@nand.local>
        <68a2bf8f-07e8-b117-a3f4-862654c781b4@gmail.com>
        <xmqqy2c3fhmy.fsf@gitster.g>
        <9d6568ee-c9bf-b349-d1a6-0bb2fcf06dab@gmail.com>
Date:   Wed, 26 May 2021 05:46:16 +0900
In-Reply-To: <9d6568ee-c9bf-b349-d1a6-0bb2fcf06dab@gmail.com> (Derrick
        Stolee's message of "Tue, 25 May 2021 06:54:02 -0400")
Message-ID: <xmqq1r9uee3r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4104127C-BD9A-11EB-A06D-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 5/25/2021 2:32 AM, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>> 
>>>> So we silently convert -1 to 2^64-1, and call it a day.
>>>
>>> That works for me. I'll send a v2 with that tomorrow unless someone
>>> presents a better option.
>> 
>> I'll queue with this tweak for tonight's integration run.
>> 
>> ...
> Thank you for proactively modifying the patch. This works
> for me. I didn't realize that this was affecting other
> contributors [1] until I woke up this morning.
>
> [1] https://lore.kernel.org/git/036b01d750ed$642b75c0$2c826140$@nexbridge.com/

Well, not so well X-<.  It seems that some builds are not happy with
this change.  See https://github.com/git/git/actions/runs/876229761
specifically these two:

    https://github.com/git/git/runs/2669177395?check_suite_focus=true#step:7:3549
    https://github.com/git/git/runs/2669080101?check_suite_focus=true#step:6:988

I suspect that it has something to do with 32-bit platforms?

Thanks.
