Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5DBC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 22:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD549610FE
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 22:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345817AbhIMWoF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 18:44:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50658 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349375AbhIMWmN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 18:42:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3CEE51409D6;
        Mon, 13 Sep 2021 18:40:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=drOCIvfSYotx
        XuLOf8gtaB5FgD5VQZrAQRT3VFdAryY=; b=R+dYpSh8p+gFxYb3ymoMwy+3r0uc
        pdZs0O5SKhfQHDp5W6eszkOn+SOYzWqks9Afg3WLwz8tfkniJ9Kd3Eg/W+Xnh8Ah
        lMWipjywITSoBVC6LG+zwzPSrg6m3N30so0PP1YIED33v/GzR2Ee4VPy0gxhluGP
        X3TZlkNmVBu+6jw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 355601409D5;
        Mon, 13 Sep 2021 18:40:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 950661409D2;
        Mon, 13 Sep 2021 18:40:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 08/11] rebase: remove redundant strbuf
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
        <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
        <ad3c4efc0272be8eee052a08731656a406f8f90b.1631546362.git.gitgitgadget@gmail.com>
        <3c7c5560-2cae-a4cf-a298-6d77a3fb9226@web.de>
Date:   Mon, 13 Sep 2021 15:40:52 -0700
In-Reply-To: <3c7c5560-2cae-a4cf-a298-6d77a3fb9226@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 13 Sep 2021 20:34:35 +0200")
Message-ID: <xmqqczpccd57.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A7C1CBB2-14E3-11EC-B732-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 13.09.21 um 17:19 schrieb Phillip Wood via GitGitGadget:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> There is already an strbuf that can be reused for creating messages.
>
> Reminds me of a terrible joke from elementary school: In Peter's class
> everybody is called Klaus, except Franz -- his name is Michael.
>
> Why would we want to use the same variable for multiple purposes?  This
> makes the code harder to read.  And the allocation overhead for these
> few cases should be negligible.
>
> The most important question: Is this patch really needed to support
> tags (the purpose of this series)?
>
>> msg is not freed if there is an error and there is a logic error where
>> we call strbuf_release(&msg) followed by strbuf_reset(&msg) and
>> strbuf_addf(&msg).
>
> strbuf_reset() after strbuf_release() is redundant but legal.

All good points.

I do not care too deeply either way, in the sense that it probably
is better for this function to have two variables (with at least one
of them having a meaningful name "msg" that tells readers what it is
about), if the original submission to rewrite "rebase" in C used a
single strbuf for both of these and given it a name (like "tmp")
that makes it clear that the buffer is merely a temporary area
without any longer term significance, I probably wouldn't have told
the submitter to rewrite it to use separate strbuf variables.

But if existing code already uses two variables, with at least one
of them having a meaningful name that tells what it is used for, I
see no reason why we want to rewrite it to use a single one.

Thanks.
