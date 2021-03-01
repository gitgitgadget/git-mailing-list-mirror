Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4EFC433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 22:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 773E260230
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 22:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238265AbhCAWZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 17:25:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51028 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240577AbhCAWWm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 17:22:42 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4AE22AC61E;
        Mon,  1 Mar 2021 17:21:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qB5PmMZkt7U8
        oOSldH52zi0uc8o=; b=PtLn6/DVqCUYi8VF5BeX4QUTbtKOoLI41xuUlSd1e0nO
        F3IPJaLAkXZD2xRtr8fGFKf3tCGCo+7hC2tLoLRw/xT/TD5t6ldyM2+8KJG0hJe7
        IZa7rcqyGpl9AyQ6XcDlcE9irgCZvLApU5ZeXsMhu6RAm/fKFmcVP+KJL5hhhoE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZdoilW
        gblJcUFdZ41Rzs2oRmL4zx8AhWqSb3Pbgiim1IMxRWPRhsGo41O+nbBjQVh4hOMT
        cgEeaTx2OAx+Io5D5WSRDHMaimcdkk2l3WPV1kuWPrC/vYdHDPfsInZ4yXYbg7pw
        WZbKB8S9i/P8ZeuCVkw+mH1OQI5N4UgOUvT28=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 42A8EAC61D;
        Mon,  1 Mar 2021 17:21:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A8369AC61C;
        Mon,  1 Mar 2021 17:21:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] commit-graph: warn about incompatibilities only when
 trying to write
References: <pull.888.git.1614351036334.gitgitgadget@gmail.com>
        <87r1l27rae.fsf@evledraar.gmail.com> <xmqqy2faqwr0.fsf@gitster.g>
        <8735xgkvuo.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2103012304580.57@tvgsbejvaqbjf.bet>
Date:   Mon, 01 Mar 2021 14:21:45 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2103012304580.57@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 1 Mar 2021 23:10:23 +0100 (CET)")
Message-ID: <xmqqpn0ims5i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 81FAFE68-7ADC-11EB-BDFD-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sun, 28 Feb 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Fri, Feb 26 2021, Junio C Hamano wrote:
>>
>> > I am tempted to say that we should revert c85eec7f (commit-graph:
>> > when incompatible with graphs, indicate why, 2021-02-11) for the
>> > upcoming release.  That would give us enough time to come up with
>> > and cook the solution in 'next' in the meantime.
>>
>> That's probably sensible.
>
> I agree. This close to v2.31.0, I do not want to rush things.
>
>> Also, I noticed that we went through this whole saga in the past, see
>> 25575015ca (repack: silence warnings when auto-enabled bitmaps cannot =
be
>> built, 2019-07-31), including breaking background gc.
>
> Sounds like it.
>
> Thank you for your valuable feedback!
>
> Ciao,
> Dscho

Thanks, reverted and started today's integration cycle on top.

