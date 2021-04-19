Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02577C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 20:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE89461104
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 20:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbhDSUza (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 16:55:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63475 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243943AbhDSUzN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 16:55:13 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F12412F9E5;
        Mon, 19 Apr 2021 16:54:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GHEVybxaUa31943zvRJVMRq2uSA=; b=pdqaHo
        occrGo0eXqHOgbVwV7KvwsOeqGfhl2GbGx7HL5sN66LHJoytQLxsVbDEyGkvwerW
        /kzIH3Do5NP467Idl0s8hSy/d3g4NVldKhqXVhuDLFXwwScjydN5mhLlSZ+5JTnD
        RjIU2w0OLMcDiLoaXz1cZI+zYRKFFRL84NFZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z8yKi9fdM7Z54E1R3xLjoQD57T/XuVOU
        jJFJKWIfLZenSkSKLUx2XMBEOvw42Lkhv9L64B1NhypTX8h/kDT0l78cQPWrTn2j
        kTgoD94G2kVfhGeaB4i27FVgDANWlaYkNQVAbZBzi6Fu1Qw1pcZMkdN4UjxbkfpB
        R420SqxGQYI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 47F2F12F9E4;
        Mon, 19 Apr 2021 16:54:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8DD1A12F9E3;
        Mon, 19 Apr 2021 16:54:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] ref-filter: get rid of show_ref_array_item
References: <pull.935.git.1618831726.gitgitgadget@gmail.com>
        <ec98f2177d905cc9b3c61e15ddb756243536c125.1618831726.git.gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 13:54:38 -0700
In-Reply-To: <ec98f2177d905cc9b3c61e15ddb756243536c125.1618831726.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Mon, 19 Apr 2021 11:28:44
        +0000")
Message-ID: <xmqqczuq9er5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75D0A822-A151-11EB-B22A-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Inlining the exported function `show_ref_array_item()`
> which is not providing the right level of abstraction,
> simplifies the API and can unlock improvements at the
> former call sites.

I'll insert a comma right at the end of the first line while
queuing.

Thanks.
