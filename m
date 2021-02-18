Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675ECC43381
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D6AA64E89
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhBRTcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:32:45 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57609 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbhBRTMD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 14:12:03 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7CE2A108952;
        Thu, 18 Feb 2021 14:11:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JBwEAOh252o+
        CDRpF6zuS24MaPc=; b=DyFLEgZfKJdhWN9D5ji14J2Y/OedAONTITmdjKAbx34w
        SGpYqC4uVPPclB8n4OKTKaN7UVoEuT+fzrNk6WvyH6Q64yqH2Bc9CLF96cQEO6EG
        IKuN7c/y6OWgC6ougff4GWld/gBFcCT15E7/8j5L17z1o/fr3d+ixWKBh6vsiQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hW2Wum
        C5slkrAAGjCE25AxC946nQVU6SZi+BQao+xHxyBY6pm0LL+uv1gsXEOj0B8iUDoB
        Tq43h0cYX7+FT0nPSHbuiHvg+5IaZff9x8ukADbIHOA7cec6iKIFSPozv0GGDvai
        SszAf1zU8iWxHNZiV7pczN6W01uPC8NYXZUd8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 74D17108951;
        Thu, 18 Feb 2021 14:11:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 944A010894F;
        Thu, 18 Feb 2021 14:11:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 0/2] difftool.c: learn a new way start at specified file
References: <pull.870.v4.git.1613308167239.gitgitgadget@gmail.com>
        <pull.870.v5.git.1613480198.gitgitgadget@gmail.com>
        <xmqqblcjrgvc.fsf@gitster.c.googlers.com>
        <CAOLTT8T=R-M1eK9thSuzHNOJ8wkaTX3yYsLEgpqmHiEYWgM1XA@mail.gmail.com>
        <YCz6oDZCAODPS8sY@generichostname>
        <CAOLTT8Ri+XbSg_=KaLOCmNX4Nrii1ssN9_FFbnmm7ew4vYN5nA@mail.gmail.com>
        <xmqqo8gile02.fsf@gitster.g>
        <CAOLTT8QNbTeSJfo2O7f5vv6Q9ZVMrkGjRCikc4P7eN7M6aeZdw@mail.gmail.com>
Date:   Thu, 18 Feb 2021 11:11:15 -0800
In-Reply-To: <CAOLTT8QNbTeSJfo2O7f5vv6Q9ZVMrkGjRCikc4P7eN7M6aeZdw@mail.gmail.com>
        (ZheNing Hu's message of "Thu, 18 Feb 2021 23:04:10 +0800")
Message-ID: <xmqqy2flfay4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 13C4FF24-721D-11EB-8F60-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> I think my patch is stuck in GGG, and the current version is after I
> cherry-pick your patch and my patch on the master. Because I don=E2=80=99=
t
> know how to based on your patch but not submit your patch. Is there
> any good way?

I am not capable of doing helpdesk for GGG but I think you can send
two of them anyway with the title of the first one munged for
reading humans to tell them not to use or even look at it ;-)

GGG may send both of them out, but the ultimate objective here in
the exercise is to avoid the unwanted first one to waste people's
time, so until such a feature is implemented in GGG (or there may
already be one, but we do not know it), that would serve as a
workaround.

Thanks.
