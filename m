Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A706C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 23:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA0902312F
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 23:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbhALXNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 18:13:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60513 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbhALXNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 18:13:09 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B6B9A101548;
        Tue, 12 Jan 2021 18:12:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CpYBs1GOz/cU
        QoNfXbCViaw40RU=; b=OmzBZGDNzX/dBKGTyv9dXWrIS2JaATOhQx1LZgLIe9RT
        iBNLR6Fi4NKfsGmkqlQDZmZqAR0GsGgJoLjINpuAafbRdNLrkPnxz0LEC2FFtVAy
        o5BSotE6oDhoFBDJnKCD9IDuGUuf6aWFBsOO4Qgif5v81FABwMrJ15dqmmOEjo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=sfmyvg
        pohoYmyxOUq/+hpVm0+bea297I7szBV9qFutVlEDY0N8gRr0i2aoSOS28RO+czGC
        PSvzZhn+zjoL9fzTIIUXsdRuYISG3xHFDIFVsOOTOqiGIz5+g1O4wxBGA7gyggA1
        Bjf0nUGtRGE3nT6MZQp0k1RKlMOxFitOFnhiQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AEAEE101547;
        Tue, 12 Jan 2021 18:12:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 02C00101546;
        Tue, 12 Jan 2021 18:12:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Vojt=C4=9Bch?= Knyttl <vojtech@knyt.tl>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] rebase -i: do leave commit message intact in fixup!
 chains
References: <pull.818.git.1608337339246.gitgitgadget@gmail.com>
        <pull.818.v2.git.1610123298764.gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 15:12:23 -0800
In-Reply-To: <pull.818.v2.git.1610123298764.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Fri, 08 Jan 2021 16:28:18
        +0000")
Message-ID: <xmqqwnwhzr54.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A1BB2BE6-552B-11EB-8825-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> We actually need to actively suppress that clean-up lest a configured
> `commit.cleanup` may interfere with what we want to do: leave the commi=
t
> message unchanged.

Good thinking.

> Reported-by: Vojt=C4=9Bch Knyttl <vojtech@knyt.tl>
> Helped-by: Martin =C3=85gren <martin.agren@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> ...
> diff --git a/sequencer.c b/sequencer.c
> index 8909a467700..092e7b811f0 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -943,6 +943,7 @@ N_("you have staged changes in your working tree\n"
>  #define CLEANUP_MSG (1<<3)
>  #define VERIFY_MSG  (1<<4)
>  #define CREATE_ROOT_COMMIT (1<<5)
> +#define VERBATIM_MSG (1<<6)

It somewhat bothers me that these pretend to be orthogonal options
that can be mixed and matched, but CLEANUP and VERBATIM do not make
sense to be used at the same time.  As long as we have some safety
to ensure that both bits are not used at the same time, i.e.e.g.

	if ((flags & (CLEANUP_MSG|VERBATIM_MSG)) =3D=3D (CLEANUP_MSG|VERBATIM_MS=
G))
		BUG("cleanup and verbatim asked at the same time");

it would be OK, though.

Thanks.
