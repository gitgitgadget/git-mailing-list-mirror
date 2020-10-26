Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD130C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F8B22265
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NvSXSoIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788174AbgJZRnW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 13:43:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53005 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1788120AbgJZRnV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 13:43:21 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C278BA4654;
        Mon, 26 Oct 2020 13:43:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4VKnuSUO+RpZa6w/V1nkyIjDXaI=; b=NvSXSo
        IiFhs9FbOXHp6kru0bJ5m6hiAyA/KfeZHa4MGJ4rtFBSlGZgd/HVSSDEA6w6dn7v
        fiCMyUBeZNFtxwSemM/1iQONuWrqfGSjLPy4vjMD/H0SbcVbEwa5TSS2zbR8S9fF
        92RFFjl9NoMsrVnENpsrnIUSi03leZNmpfz/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PU1GgvoU546QLhX/BRckPeTlcCL8KmeX
        Y+gx4vgTSkhcn5UBosgsO8cSaRQx5wOmXB6dPep0LUpiRq6ACUTwANYhHyPdzTff
        OK579KrPaTBp3NBLr57enTLtk+EIJL32Wiev6v86/r9iVUn+OeCjykbKS4xvPVwT
        nLDI0kts5MM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BAD4AA4653;
        Mon, 26 Oct 2020 13:43:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 48168A4652;
        Mon, 26 Oct 2020 13:43:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/9] t/: new helper for tests that pass with ort but
 fail with recursive
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
        <a8d4825a323d5c1e7b2dc1edc8621c51c030ae1e.1603468885.git.gitgitgadget@gmail.com>
        <20201024104910.GA15823@danh.dev>
        <CABPp-BHgJrQMNEm7-y7nStVjcAedsNKH+bHNM9V34netTN+NTQ@mail.gmail.com>
        <20201025134905.GB15823@danh.dev>
        <CABPp-BEmJA92tDymypgJqGmi=eMsvU+eP=KeTKvKcJEvFVztEA@mail.gmail.com>
Date:   Mon, 26 Oct 2020 10:43:18 -0700
In-Reply-To: <CABPp-BEmJA92tDymypgJqGmi=eMsvU+eP=KeTKvKcJEvFVztEA@mail.gmail.com>
        (Elijah Newren's message of "Mon, 26 Oct 2020 07:56:59 -0700")
Message-ID: <xmqq3620g9xl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC252D08-17B2-11EB-A9BD-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> When I wrote the patch, I was expecting something like
>>
>>         test_expect_merge_success recursive=failure,other=failure ...
>>
>> in order to merge all algorithm into single parameters.
>>
>> How about something like:
>>
>>         test_expect_merge_success exception=recursive,other ...
>>
>> Not that we have "other" algorithm to begin with.
>
> Sure, sounds great.  I wouldn't spend any time trying to make it work
> with a 3rd backend, though.

Yup.  I'd appreciate if the lines become a bit shorter while at it,
though.

    test_merge_both [<exception>] '<title>' '
	<body>
    '

that expects success unless otherwise told, and <exception> like
"failure=recursive" can be used to tell us to expect differently,
would work well?
