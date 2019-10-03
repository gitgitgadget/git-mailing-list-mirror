Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 606541F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 22:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbfJCW2T (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 18:28:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62115 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729219AbfJCW2T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 18:28:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CCEA693FA6;
        Thu,  3 Oct 2019 18:28:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=unreNSd5SyEL1iH/EQz06BqxGok=; b=hiWDZb
        mQBTBI8v87FWbFW/mhs4afQ6jONjJ8DtxXfSgJrHOMKFISZJfMk85y0B2z9IBpZb
        WIEwTz9s5wHAzn97ZSlAwtgpNIBzpYOQTw+OuBPErYNgDUl39mzUyVzrwWpRutyM
        FRwsPr7XLuHXO5EA+5dIcaqCf8eLCk8GwQ0us=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AmgAiVt6ljXEkAzDkewez+Tj/8brV4+I
        AjnrqOnwWHusbjAMoRXU2D9eqAbT5q4+P5E7E24F38mMJceArjeDoD5Ok0YMYj0/
        BQseZIBLHm/n+Yxh8JIUvnLfv3e5NvAJ2Kb+gs9Qx6lPYujKtvPYnSfyuc3SqoeB
        1htlWYC1MzM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C3CC893FA5;
        Thu,  3 Oct 2019 18:28:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E824393FA4;
        Thu,  3 Oct 2019 18:28:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 00/11] New sparse-checkout builtin and "cone" mode
References: <pull.316.git.gitgitgadget@gmail.com>
        <pull.316.v2.git.gitgitgadget@gmail.com>
        <47186f02-164d-fa41-f65c-05a197e4a046@gmail.com>
Date:   Fri, 04 Oct 2019 07:28:13 +0900
In-Reply-To: <47186f02-164d-fa41-f65c-05a197e4a046@gmail.com> (Derrick
        Stolee's message of "Tue, 1 Oct 2019 09:40:08 -0400")
Message-ID: <xmqqftk9bh1e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17DAFEEC-E62D-11E9-A4A5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 9/19/2019 10:43 AM, Derrick Stolee via GitGitGadget wrote:
>> This series makes the sparse-checkout feature more user-friendly. While
>> there, I also present a way to use a limited set of patterns to gain a
>> significant performance boost in very large repositories.
>> 
>> Sparse-checkout is only documented as a subsection of the read-tree docs
>> [1], which makes the feature hard to discover. Users have trouble navigating
>> the feature, especially at clone time [2], and have even resorted to
>> creating their own helper tools [3].
>> 
>> This series attempts to solve these problems using a new builtin.
>
> I haven't heard anything about this series since Elijah's careful
> review of the RFC. There are definitely areas where this can be
> made more robust, but I'd like to save those for a follow-up series.
>
> Junio: I know you didn't track this in the recent "what's cooking"
> list, and I don't expect you to take it until I re-roll v3 to
> include the .gitignore interaction I already pointed out.

I have made a mental note that says "expecting v3, a
reroll. cf. <7d87fe4b-160c-34c2-db6d-4a56fd919755@gmail.com>"; there
is no existing entry to hang it below in the "what's cooking"
report, though X-<.


