Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09FFC34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43BF24654
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VsTO+ACk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgBSQiV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:38:21 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53903 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgBSQiV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 11:38:21 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9DE9FC03E8;
        Wed, 19 Feb 2020 11:38:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9ic4UZIMQ6dU5SdWAA2dy5tuc9k=; b=VsTO+A
        Ck1u4qjhnAv8iBH5Ryy7alQ45ta9oft5hEhvl/YSmeqSnuzVqnGcXflv/aICS6OH
        gHJQNUg4uRHxO6H26n5K9hHzMSUixfrxh32k+4QQNYPLde51etV+API1dtSWjhcL
        f8QtKcxNnuny954eBLEYq8t39JCjQlivBUce0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v3upe9YzIfNrlLWb4Kr7N1Lr3smKLIF/
        vzKxc0edlGW7KVqfOABosRFVCIfB6h1FBZmMCGIozqkxK3sFtK37c1ZnpNcDrguW
        oSYgaAXWTs74tWooLfGfZP1h3uK/u1AOiQ2eKdUwjNUWv6oB9alyTsrNTCknyZmS
        lJ3eGZOKxIA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95B68C03E7;
        Wed, 19 Feb 2020 11:38:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8B1A9C03E5;
        Wed, 19 Feb 2020 11:38:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t3424: new rebase testcase documenting a stat-dirty-like failure
References: <pull.712.git.git.1581959751454.gitgitgadget@gmail.com>
        <CABPp-BEtnmzDp0E4=0y9eEMKQ89FcrsK9h-1Mqcd2FDV_EBohw@mail.gmail.com>
        <ed8dc52c-db50-f6fa-9583-8ad4af23d327@gmail.com>
        <CABPp-BHBv+_HkExM1q6WAZZyMhR=UPNQZDhE8jFSQFNoCtgytg@mail.gmail.com>
        <deae766d-f552-2e30-fb49-e7e187ee984b@gmail.com>
        <CABPp-BFij++-6P2ht1EacGXaX4vA_CuBQEfz6M9w9CadXHC8Jw@mail.gmail.com>
Date:   Wed, 19 Feb 2020 08:38:13 -0800
In-Reply-To: <CABPp-BFij++-6P2ht1EacGXaX4vA_CuBQEfz6M9w9CadXHC8Jw@mail.gmail.com>
        (Elijah Newren's message of "Wed, 19 Feb 2020 08:00:45 -0800")
Message-ID: <xmqqblpuh6ru.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A123342-5336-11EA-B5DD-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> I think `--exec true` would be better as it makes it clear that it's not
>> a timing issue. I've changed do_recursive_merge() to print the mtime and
>> mode of "DS" before and after the merge which gives
>>
>> HEAD is now at abd8fe3 side1
>> Rebasing (1/2) # picking commit1
>> DS mtime, mode before merge 1582109854, 120000
>> DS mtime, mode after merge 0, 120000
>> Rebasing (2/2) # picking commit2
>> DS mtime, mode before merge 0, 120000
>> error: Your local changes to the following files would be overwritten by
>> merge:
>>         DS
>>
>> So it looks like the problem is that when we pick commit1 we don't
>> update the index entry for DS properly in merge_trees()
>>
>> Best Wishes
>>
>> Phillip
>
> Oh, indeed, so this was my bug.  Thanks for jumping in and
> investigating; I probably should have found that lead but I just
> didn't.  Anyway, with your extra information I dug around for a bit
> and I think I found the fix.  I'll post it soon.

Nice.  I recall that somebody said that no bug is deep enough to
hide from us when we have sufficient number of eyeballs ;-)

