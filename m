Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62791C6369E
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 22:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0487F22201
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 22:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgLBWPV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 17:15:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60989 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgLBWPU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 17:15:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 796638AC58;
        Wed,  2 Dec 2020 17:14:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5FdutVrow4fd
        km6MVO1vBaA05sQ=; b=GrGbZb7BfhG+IjCgCowryecrBTLZIi8AoBvyXdAP+iJz
        bHvR2ekeOIxpixIcdNRhg7BxnhZ3ZnNPgzw8xzkH5KNwqj0JniPAiEH4dOrtIwIq
        GSySBBOl2IIchxljU9gqXwkXAQ/vqR01WQGYB4UWDkqZfS9+CaDTdsN5lKvUi98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=chaBd4
        qVhzHQn21XbTMOUM2+oPCu+y+2Pyxz7GTr/r8Nm2OOcCOdwdZdArLBtP6ufmlRIU
        JBGcehGN9EtCCR2wT52B4hGqcpn9dN07XEI5qNbk92RCLPmisfRT/ceJyLeaeb2e
        cM3vll1Jb2HSYszOaS8BwShu+RUInYvy4VtnE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66CCD8AC57;
        Wed,  2 Dec 2020 17:14:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E68CC8AC56;
        Wed,  2 Dec 2020 17:14:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>,
        git@vger.kernel.org
Subject: Re: Bug report: orphaned pack-objects after killing upload-pack on [
References: <CAFWsj_UwkQX9y0xPQJE3xguo0z3TMkvKAwei5iryCWXvVP8CjA@mail.gmail.com>
        <badf3777-3970-b714-3ad9-67d2f77f94a5@web.de>
        <20201121002921.GC353076@coredump.intra.peff.net>
        <xmqqd006s7ee.fsf@gitster.c.googlers.com>
        <X7zOKbzR9gwJHMbJ@coredump.intra.peff.net>
        <xmqqy2ipcdvj.fsf@gitster.c.googlers.com>
        <X778eIAr3uzdh0H0@coredump.intra.peff.net>
        <xmqqo8jllyhc.fsf@gitster.c.googlers.com>
        <bd2c4577-4c8c-851c-6045-ba4b306ca612@web.de>
        <X8Yz0bY1LOHpKxKA@coredump.intra.peff.net>
        <ff05986b-5506-3ef1-68bc-e6b46ddf8b98@web.de>
Date:   Wed, 02 Dec 2020 14:14:37 -0800
In-Reply-To: <ff05986b-5506-3ef1-68bc-e6b46ddf8b98@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 2 Dec 2020 12:45:34 +0100")
Message-ID: <xmqq1rg7n9de.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C442BE00-34EB-11EB-9100-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 01.12.20 um 13:15 schrieb Jeff King:
>> On Thu, Nov 26, 2020 at 09:04:35PM +0100, Ren=C3=A9 Scharfe wrote:
>>> The patch is trivial, you don't need my sign-off.  You could record P=
eff
>>> as its author, as he contributed the most to the version in seen.
>>
>> I didn't want this topic to be forgotten, so here it is with me as the
>> author, my signoff, and an overview of the reproduction in the commit
>> message.
>
> Thank you!

Thanks, both.
