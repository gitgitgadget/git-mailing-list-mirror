Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53A5C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 23:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343834AbhLVX4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 18:56:45 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50570 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbhLVX4o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 18:56:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 529EB1525AF;
        Wed, 22 Dec 2021 18:56:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=krCx4lDNKrBINb8BtX9OX0B0pFmZBKReFKiZRV
        JvRng=; b=Kwhs86C6lZLi5q0Hqz5RIWAqlmm5HBl2Lf6pgUEOdyA3mngObl7X7p
        GehJRE3Reo791Op8aATYng4Vw2syYfcTMQ3QdKZ07k0s9OCwRpdmEZun7v9JSnpc
        FjcTXg/2UNwg0Zk8AnpfoPB9R987t/ZXusAzjoFnAXI8U3UVG3DjM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4AB4F1525AE;
        Wed, 22 Dec 2021 18:56:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A5D001525AD;
        Wed, 22 Dec 2021 18:56:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4 0/5] Sparse index: fetch, pull, ls-files
In-Reply-To: <CABPp-BGuoY_R8Cfoa7OfoqqFt4ZuWn9dNyN94vcJb8XJMXOvRA@mail.gmail.com>
        (Elijah Newren's message of "Wed, 22 Dec 2021 11:17:27 -0800")
References: <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com>
        <pull.1080.v4.git.1640182856.gitgitgadget@gmail.com>
        <CABPp-BGuoY_R8Cfoa7OfoqqFt4ZuWn9dNyN94vcJb8XJMXOvRA@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Wed, 22 Dec 2021 15:56:39 -0800
Message-ID: <xmqqa6gsdwi0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CEBB660E-6382-11EC-8BF9-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Dec 22, 2021 at 6:20 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> This is now based on 'master'.
>>
>> Did you know that 'fetch' and 'pull' read the index? I didn't, or this would
>> have been an integration much earlier in the cycle. They read the index to
>> look for the .gitmodules file in case there are submodules that need to be
>> fetched. Since looking for a file by name is already protected, we only need
>> to disable 'command_requires_full_index' and we are done.
>>
>> The 'ls-files' builtin is useful when debugging the index, and some scripts
>> use it, too. We are not changing the default behavior which expands a sparse
>> index in order to show all of the cached blobs. Instead, we add a '--sparse'
>> option that allows us to see the sparse directory entries upon request.
> ...
>> Updates in v2
>> =============
>>
>>  * Rebased onto latest ld/sparse-index-blame without issue.
>>  * Updated the test to use diff-of-diffs instead of a sequence of greps.
>>  * Added patches that remove the use of 'test-tool read-cache --table' and
>>    its implementation.
>>
>>
>> Updates in v3
>> =============
>>
>>  * Fixed typo in commit message.
>>  * Added comments around doing strange things in an ls-files test.
>>  * Fixed adjacent typo in a test comment.
>>
>>
>> Updates in v4
>> =============
>>
>>  * Rebased on to 'master' now that ld/sparse-index-blame is merged.
>>  * Change testing strategy to check exact output instead of using 'diff -u'.
>>  * Updated documentation to state that directories have a trailing slash.
>
> This version looks good to me:
>
> Reviewed-by: Elijah Newren <newren@gmail.com>

Yup, they looked good to me too.

Thanks.
