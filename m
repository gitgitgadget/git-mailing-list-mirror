Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211EBC433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B1C2087E
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vxEmXLP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgJLULr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 16:11:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57716 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbgJLULr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 16:11:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DBE64F876B;
        Mon, 12 Oct 2020 16:11:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Uk/zvaGJZS38CreuKcyC9gHJ8KM=; b=vxEmXL
        P0uCtcndIFH3URQXUZN8h56jnPWrHO80aD9k3leET0V3TPt1r1x1uD7FWLaSNdjq
        ZmPSU6Ed9e39JnOJzXBCSlYs49kFoaBi6XE7SwXMHld+5Wp9gLvb29GDLN4vKGGg
        E5pvN7h2/cTkpRD1dsUJci+vWOGu8q5GHW+aA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e5yuhxzyMtrdju0g8T9HiqOuoxy1/K/F
        54PehAWvD7kkB5vI4EGuIVpKh5kIzvZ8kwcG3MQyOnlChAHV8V8grtXkfBkFBSsm
        Jyp7khoFoFZ4jW0m+Mv0TTkh3EcfV/oO32ynNQVb/v7twyNA1SGRGiUopZt22elG
        nNK/u5eMxUE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D41FCF876A;
        Mon, 12 Oct 2020 16:11:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 29F8DF8769;
        Mon, 12 Oct 2020 16:11:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Samuel =?utf-8?Q?=C4=8Cavoj?= <samuel@cavoj.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] sequencer: fix gpg option passed to octopus merge
References: <20201011224804.722607-1-samuel@cavoj.net>
        <20201011225850.GA490427@camp.crustytoothpaste.net>
        <nycvar.QRO.7.76.6.2010121233590.50@tvgsbejvaqbjf.bet>
        <6f650960-6b32-4be5-b909-86685c6ad5ea@gmail.com>
        <xmqq5z7fqt6k.fsf@gitster.c.googlers.com>
        <xmqq362jp6yo.fsf@gitster.c.googlers.com>
Date:   Mon, 12 Oct 2020 13:11:42 -0700
In-Reply-To: <xmqq362jp6yo.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 12 Oct 2020 12:41:51 -0700")
Message-ID: <xmqqft6jnr0h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 261498B2-0CC7-11EB-8F17-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>>> In run_git_commit() we do
>>>
>>> 	if (opts->gpg_sign)
>>> 		strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);
>>> 	else
>>> 		strvec_push(&cmd.args, "--no-gpg-sign");
>>>
>>> I'm not immediately clear why we pass --no-gpg-sign when
>>> opts->gpg_sign isn't set ...
>>
>> Isn't it because there is a configuration that the &cmd may honor
>> that forces gpg signing all the time?
>>
>>> but it makes me wonder if we should be doing
>>> that here as well
>
> I was reacting only based on what I saw in these message, but it
> turns out that cmd above is an internal invocation of "git merge";
> as the command does honor the "commit.gpgsign" option, if "rebase"
> or whatever command that invoked the sequencer turned off the
> signing by setting opts->gpg_sign to false, I agree that the part
> touched by the patch should have the else clause to explicitly
> override the configuration option.

Forgot to say that it is perfectly fine to leave it outside Samuel's
patch.  It "fixes" the "intended" behaviour of the current design
where it somehow was deemed a good idea to disallow overriding
commit.gpgsign variable.  Fixing that design so that we can override
configured default from the command line can be left for a follow-up
patch.

Thanks.
