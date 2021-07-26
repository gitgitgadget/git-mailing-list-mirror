Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4C7C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 17:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CDD060F6C
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 17:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhGZQyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 12:54:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53754 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbhGZQx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 12:53:59 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF8CCCFB8C;
        Mon, 26 Jul 2021 13:34:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o5FT8KPb+J2HpqYoCYYRbpfAr/HCIPdhrss9Th
        jPJFA=; b=PhkabZOqBUyG7/LZ8dRC3mLhOwjoXzSJNWT2QNJl7LYwjVNU0HZwLh
        WgOuhsb43pfbFTO6wOrvFpRNSXVzHXVDR4y0B2LMdGvdE6WEZVNkczOKwZ+IezB5
        pxfozlnNT+ILFac8F7mqNdSbE5j818O1+iu5HA3SpfjX8ssaynmHc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B5A32CFB8B;
        Mon, 26 Jul 2021 13:34:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3CEC4CFB8A;
        Mon, 26 Jul 2021 13:34:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v3 5/5] [GSOC] ref-filter: add %(rest) atom
References: <pull.1000.v2.git.1627031043.gitgitgadget@gmail.com>
        <pull.1000.v3.git.1627136061.gitgitgadget@gmail.com>
        <2300b0463f2fca76970ae7debcffa505909b8c4d.1627136062.git.gitgitgadget@gmail.com>
        <CA+P7+xpfWA_e3rn2vfWBPixFJop-zomj9_N99n9ufe1MxV-1KA@mail.gmail.com>
Date:   Mon, 26 Jul 2021 10:34:26 -0700
In-Reply-To: <CA+P7+xpfWA_e3rn2vfWBPixFJop-zomj9_N99n9ufe1MxV-1KA@mail.gmail.com>
        (Jacob Keller's message of "Sun, 25 Jul 2021 01:29:52 -0700")
Message-ID: <xmqqtukhj7x9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9CBEB12-EE37-11EB-A68F-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Sat, Jul 24, 2021 at 7:14 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: ZheNing Hu <adlternative@gmail.com>
>>
>> %(rest) is a atom used for cat-file batch mode, which can split
>> the input lines at the first whitespace boundary, all characters
>> before that whitespace are considered to be the object name;
>> characters after that first run of whitespace (i.e., the "rest"
>> of the line) are output in place of the %(rest) atom.
>>
>> In order to let "cat-file --batch=%(rest)" use the ref-filter
>> interface, add %(rest) atom for ref-filter.
>>
>> Introduce the reject_atom() to reject the atom %(rest) for
>> "git for-each-ref", "git branch", "git tag" and "git verify-tag".
>>
>> Suggected-by: Jacob Keller <jacob.keller@gmail.com>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Hariom Verma <hariom18599@gmail.com>
>> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
>> ---
>
> Thanks for the improved  commit message here. That helps clarify what
> this atom does and aids in understanding the implementation.
>
> Reviewed-by: Jacob Keller <jacob.keller@gmail.com>

Thanks, both.
