Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EB7C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 19:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C24260E97
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 19:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbhHLTvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 15:51:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62591 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbhHLTvs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 15:51:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C175C14DD7F;
        Thu, 12 Aug 2021 15:51:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NoOK7nrhQNGpIzWL/nOjuIexESCbjZz42aAC7k
        oDCfU=; b=DgCG/c+03+nHQPk6YXOMpb9Z2/RHG5R/lLTCPuhpBXVer0v2Iwdl1G
        hcnmllPCeySKfLgXCw3/syT3bw/urkMmolcJRss0NhOn8Ks5f8ZHK0rT+i7bLp0b
        rfrkPj/DzTwUq/8T8eJySk7FX+SkVseEOXGK2JTTqkjZxTn/5+Do0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BA41014DD7E;
        Thu, 12 Aug 2021 15:51:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1408114DD7D;
        Thu, 12 Aug 2021 15:51:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Joel Klinghed" <the_jk@spawned.biz>
Cc:     "Joel Klinghed via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Jeff King" <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] commit: restore --edit when combined with --fixup
References: <pull.1014.git.1628689758413.gitgitgadget@gmail.com>
        <pull.1014.v2.git.1628725421868.gitgitgadget@gmail.com>
        <xmqq1r6z6xwf.fsf@gitster.g>
        <873ec1ab-c062-4306-b3fb-09d32c70cc7f@www.fastmail.com>
Date:   Thu, 12 Aug 2021 12:51:18 -0700
In-Reply-To: <873ec1ab-c062-4306-b3fb-09d32c70cc7f@www.fastmail.com> (Joel
        Klinghed's message of "Thu, 12 Aug 2021 09:42:06 +0200")
Message-ID: <xmqqbl6230i1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA0BF132-FBA6-11EB-A8E8-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Joel Klinghed" <the_jk@spawned.biz> writes:

>> Writing this as
>> 
>> 			if (edit_flag < 0)
>> 
>> makes it far easier to immediately see that we are talking about a
>> nagetive edit_flag.
>> 
>
> Agree, I'll change it.
> I was unsure of the style and copied from the earlier condition:
> 	if (0 <= edit_flag)
> 		use_editor = edit_flag;

There are two valid schools of thought when it comes to comparison.

Some folks consider that a comparison between a variable and a
constant is a statement about the variable, hence the expression
should be

		if (VARIRABLE comparison-operator CONSTANT)

They will write things like:

		if (edit_flag >= 0)
		if (edit_flag < 0)

Other folks consider that textual order of the comparison should
match the actual order of the things being compared, as if they are
arranged on a number line, hence the expression should be

		if (SMALLER < LARGER)

no matter which one is variable and which one is constant.

They will write:

		if (0 <= edit_flag)
		if (edit_flag < 0)

The case in question, asserting that edit_flag is negative, is what
both camps agree how to write.
