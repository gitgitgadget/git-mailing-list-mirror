Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E594C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 23:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A0C6101C
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 23:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbhH3XlG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 19:41:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54909 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239115AbhH3XlF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 19:41:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1E24B139172;
        Mon, 30 Aug 2021 19:40:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W+zuW86GsBrOhzavOIZU1vjk1c4emturrFCyd8
        3sJag=; b=d//lnCXeWZfcvvQyNPoIZf8KFSGv7qPqFmPhhIQA+47p2PLyPsOCzx
        hMth+Oy9BiaqbuawqT/gt3AsQ66hnvIp2/4y/MCzXK/+yPMLaMs1/CNG43Mr29vq
        +ZCaVdIGmYYtJ8i64tglJEExhCUxHUAcEAJ/ZSMnHCkLgs9NI6NJY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 16BDC139171;
        Mon, 30 Aug 2021 19:40:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D87F913916C;
        Mon, 30 Aug 2021 19:40:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, levraiphilippeblain@gmail.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v3] sequencer: advise if skipping cherry-picked commit
References: <4d83766ab3425a5f4b361df2ac505d07fefd7899.1628109852.git.steadmon@google.com>
        <691c660422676c92180feb1c2a88049afe7536b9.1630359271.git.steadmon@google.com>
        <xmqqr1ea1sm7.fsf@gitster.g>
Date:   Mon, 30 Aug 2021 16:40:06 -0700
In-Reply-To: <xmqqr1ea1sm7.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        30 Aug 2021 15:21:20 -0700")
Message-ID: <xmqqy28izell.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BE426BC-09EB-11EC-AF46-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Josh Steadmon <steadmon@google.com> writes:
>
>> Silently skipping commits when rebasing with --no-reapply-cherry-picks
>> (currently the default behavior) can cause user confusion. Issue
>> warnings when this happens, as well as advice on how to preserve the
>> skipped commits.
>>
>> These warnings and advice are displayed only when using the (default)
>> "merge" rebase backend.
>>
>> Update the git-rebase docs to mention the warnings and advice.
>>
>> Signed-off-by: Josh Steadmon <steadmon@google.com>
>> ---
>
> Looks sensible.
>
> Will queue.  Let's merge it down to 'next' in a few days and leave
> the follow-on work to later.

... except for that the advice_skipped_cherry_picks variable should
either be file-scope static or declared in advice.h; otherwise "make
sparse" would fail.

It only matters until ab/retire-advice-config topic graduates, so
I'll see if I can apply a little tweak locally and make things work.

Thanks.
