Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD304C2BA2B
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 00:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7191E20757
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 00:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZV0BV+/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgDIAIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 20:08:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53585 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgDIAIs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 20:08:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3D7A8BA2C3;
        Wed,  8 Apr 2020 20:08:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w9605GNRpQKbzOBWrxEdk6K9Sa0=; b=ZV0BV+
        /c5t3layNC71MJS9Mii2o824DxKBNo5VU4xbiRN/GLisVVQcnbXDymkNX7vvjSUn
        OBLMC+4LUzCpaXp5iEldpRHF7/iXtx4rzp3mXnqJ8oTx4XlqDU78kqPi0aTPX9q/
        MwyPrhoDgGcy+2iMYTjZEx9e+APtgqPUi0CVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JLRwVkNyHT//02ijBHB9Yz1JK92RqX5v
        L2cdsALbHTCW+8BVSEjwiXxirrFhx7e3YDHbHMh69Fm+xYHUjaD/2S/OVhko4tPj
        SWi+LQ9tU9IZqzLAe0QX7eKTFB/v12B8DD1SEvCpo1qKsDXOtEj+30MY7UBc4EKh
        GpF68Stp9go=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 36C81BA2C2;
        Wed,  8 Apr 2020 20:08:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7EDC1BA2C1;
        Wed,  8 Apr 2020 20:08:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] revision: --include-diversions adds helpful merges
References: <pull.599.git.1586308923544.gitgitgadget@gmail.com>
        <xmqqv9mapxw9.fsf@gitster.c.googlers.com>
        <5f1c6868-303c-ccc1-553e-e54d0fa8e24f@gmail.com>
        <74562b04-b1ce-cad4-da18-4af030a3dc29@gmail.com>
        <xmqqzhbloj4u.fsf@gitster.c.googlers.com>
        <20200408200526.GA2270445@coredump.intra.peff.net>
        <9eab6c60-3c99-d6ac-9206-02ce37f7a479@gmail.com>
        <xmqqv9m9oe2p.fsf@gitster.c.googlers.com>
        <91fafa17-c58f-dcd0-320d-48c4512561f6@gmail.com>
Date:   Wed, 08 Apr 2020 17:08:42 -0700
In-Reply-To: <91fafa17-c58f-dcd0-320d-48c4512561f6@gmail.com> (Derrick
        Stolee's message of "Wed, 8 Apr 2020 19:59:16 -0400")
Message-ID: <xmqqimi9o705.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46D2E6F8-79F6-11EA-BD0E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>> In my latest attempt at documentation, I called these merges "diverters"
>>> yet still used "--include-diversions". Here are a few other words that we
>>> could use:
>>>
>>>  * diverters or diversions
>>>  * redirects
>>>  * switches (think railroad switch). Synonym: exchange
>>>  * detours
>> 
>> ...none of the above tells me that they are not no-op (in other
>> words, they do something meaningful), so I must be coming from
>> a direction different from you are.  What redirects from what other
>> thing, for example?
>
> The merges do something meaningful: they "merge in" a "real" change.

Yes, but "redirect", "switch", "detour", or "divert" do not quite
mean "merging in a real change", at least to me.

> I'll just submit my v2 as-is, which includes a significant change to
> the documentation that should make things more clear.

Thanks.
