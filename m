Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03D7C433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 21:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 614B0619CA
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 21:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhC3Vtk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 17:49:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59800 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhC3VtK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 17:49:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDCFEC103F;
        Tue, 30 Mar 2021 17:49:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eCFKT0WE1KpgSVnTkbUNZqXu0go=; b=MFat0n
        Lq+pYSZ8+j/gKa/XbvNP+wnhGStELb16K0p3lCHcv8JrU6zg/fLLIe+BHY3V9kve
        OR91luEQUFQ468j+U47QeX6ZU2oLbdynQM0Jhcvwo4XuaQh5NZzSFrd+qrV3jvgk
        9wdNowVUepHMtV091hoYkwJEx9uWzPrTf8o+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jXahAh7oW0qc6gphsHvjMXm2rZC9YQim
        ORHlev3KYDRoyvYDLiyPFK5ooieI1eoGRbsoV8b+cFVthQKH7MpAxZl4qlFeb+kG
        +xO78kCPnDJVHMyyATDBDJ9waPEKqnazCwV1I23TOrXkkLCyDKYr+vvNCHw9c7j/
        Q3bqGBfFQrE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3891C103E;
        Tue, 30 Mar 2021 17:49:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 321A9C103D;
        Tue, 30 Mar 2021 17:49:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v5 00/21] Sparse Index: Design, Format, Tests
References: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
        <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
        <xmqqsg4ccsgd.fsf@gitster.g>
        <0a2e3028-8ebe-86be-d55d-b96aefb1ee53@gmail.com>
Date:   Tue, 30 Mar 2021 14:49:08 -0700
In-Reply-To: <0a2e3028-8ebe-86be-d55d-b96aefb1ee53@gmail.com> (Derrick
        Stolee's message of "Tue, 30 Mar 2021 17:31:42 -0400")
Message-ID: <xmqqeefwcnxn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1CF3F6E-91A1-11EB-9CC1-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> We have a similar setting in index.version; I believe we always
>> auto-demote 3 down to 2 when extended flags are not used, and
>> I think "always auto-demote" would be sufficient (iow,
>> "use-even-unneeded" may not be necessary, even though that might
>> help debugging).
>
> Yes, the same is happening here: we auto-demote to not use 'sdir'
> if it the other settings are not configured as well.
>
> There is the rare scenario where these things all occur:
> ...
> This seems like a rare occurrence. Is it still worth adding logic
> to avoid 'sdir' when these are all true?

You'd be the primary one who will be debugging the system while and
after this goes through the stabilization effort, so whichever you
find is more convenient is good enough for us, I guess.

Thanks.
