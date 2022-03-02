Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4CFC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 06:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239751AbiCBGyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 01:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbiCBGyI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 01:54:08 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6689B16D5
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 22:53:25 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2406C17403F;
        Wed,  2 Mar 2022 01:53:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WC9sKny/AfK8MCOMzjzjFLflgTCDXs+dNjKXih
        4k3AM=; b=h27jzWdnWyzAUJvRCD5qX88wkTYz0RsoYRxhZ4uFEX4OAVsxVFWkfj
        gb0604WyzmEA71Thvi2GGuT1+NAFdRryU3iP6n54JgQ4noAVMnvX1Uka8mezAnhC
        VTIccwNNOvLmKagNV79n5ccypeXUZGtJcITYchuT0UkHcd0Ty+Z34=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1B66717403E;
        Wed,  2 Mar 2022 01:53:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 88DE717403D;
        Wed,  2 Mar 2022 01:53:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] merge-ort: make informational messages from recursive
 merges clearer
References: <pull.1121.git.1645079923090.gitgitgadget@gmail.com>
        <xmqqsfsh5btd.fsf@gitster.g> <xmqqwnheuq79.fsf@gitster.g>
        <CABPp-BFgLfjLBEK96SLaLxoq6Nspse=FBgViKfiQPk4GaQadFQ@mail.gmail.com>
Date:   Tue, 01 Mar 2022 22:53:21 -0800
In-Reply-To: <CABPp-BFgLfjLBEK96SLaLxoq6Nspse=FBgViKfiQPk4GaQadFQ@mail.gmail.com>
        (Elijah Newren's message of "Tue, 1 Mar 2022 18:32:20 -0800")
Message-ID: <xmqqk0dconfi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73847BF0-99F5-11EC-9881-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> > Yup, I found that the messages on inner conflicts, especially when
>> > they "cancel out" at the outer merge, are mostly noise that carries
>> > very little useful information (by being noisy, the user gets a sense
>> > of how complex the histories being merged are).  Reducing the default
>> > messaging level would probably be a good idea.
>>
>> Here is what I just had to scroll through to update 'next' by
>> merging back 'master', only to grab the updates to the release
>> notes.  Needless to say, this would have been somewhat baffling
>> if I didn't know to expect it.
>>
>> It would be good to squelch it before we hear another complaints
>> from old-timer power users ;-)
>
> I'll submit a patch soon.
>
>>
>> $ git merge -m 'Sync with master' --no-log master
>>   From inner merge:  Auto-merging blame.c
>>   From inner merge:  Auto-merging builtin/am.c
>>   From inner merge:  Auto-merging builtin/blame.c
>>   From inner merge:  Auto-merging builtin/clone.c
>>   From inner merge:  Auto-merging builtin/clone.c
>>   From inner merge:  Auto-merging builtin/commit.c
>>   From inner merge:  Auto-merging builtin/fetch.c
>>   From inner merge:  Auto-merging builtin/fetch.c
>>   From inner merge:  Auto-merging builtin/grep.c
>>   From inner merge:  Auto-merging builtin/hash-object.c
>>   From inner merge:  Auto-merging builtin/log.c
>>   From inner merge:  Auto-merging builtin/log.c
>>   From inner merge:  Auto-merging builtin/pack-objects.c
>>   From inner merge:  Auto-merging builtin/pull.c
>>   From inner merge:  Auto-merging builtin/pull.c
>>   From inner merge:  Auto-merging builtin/rebase.c
>>   From inner merge:  Auto-merging builtin/rebase.c
>>   From inner merge:  Auto-merging builtin/reflog.c
>>   From inner merge:  CONFLICT (content): Merge conflict in builtin/reflog.c
>> Auto-merging builtin/reflog.c

Thanks.  I think "From inner merge: " can be removed even when we
emit these messages, as the indentation would make it clear that the
indented ones are different from the outermost ones.

