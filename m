Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0400C433E6
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 01:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8EE364E2F
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 01:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhBQBUa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 20:20:30 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53251 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhBQBU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 20:20:29 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0037B119C11;
        Tue, 16 Feb 2021 20:19:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Us00b2chxN3i
        V4Fgk8OK7ZcWrxc=; b=B85/6huXOOQcw4Uo5DYHqtm7lV6exmqyxKVOATPUi0ca
        vyFZzctZ0GuPjbIId1HJeASVa2ZHUBD9OllO6rkuecNUeYCo90dIEbQup5PrH6I2
        x2JxWq8U73dYt6hKHZdj/4h8NQrnVEk1Ud909koL5yAD1dx/EI2Gs/x8E+4RdRY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ATWqFr
        nvrmg6ibSdIeWv0U4GNuqPvtQMyp+FP7QNIuoIXDRFctYGRZn+6YAhNSf/r2IgQt
        VnQWUsl8agYaBRoEqY9RUVfvkfAyKMgrtH1Fwvoux28kRzMwqVv6Xp6nzRgmp76T
        ouUM7BCWvZyhgQj6cEbHQ5GMIi/vc6+BUPoHc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ED544119C0E;
        Tue, 16 Feb 2021 20:19:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4442B119C0D;
        Tue, 16 Feb 2021 20:19:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 00/22] pickaxe: test and refactoring for follow-up
 changes
References: <20210203032811.14979-1-avarab@gmail.com>
        <20210216115801.4773-1-avarab@gmail.com>
        <xmqq8s7nps7x.fsf@gitster.c.googlers.com>
Date:   Tue, 16 Feb 2021 17:19:39 -0800
In-Reply-To: <xmqq8s7nps7x.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 16 Feb 2021 14:23:30 -0800")
Message-ID: <xmqqv9armqxg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 35C196C4-70BE-11EB-BC68-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> This is a smaller v2 of the series to remove the kwset backend and
>> make pickaxe use PCRE v2[1].
>>
>> That's not being done here yet. These are mostly small
>> refactoring/test fixes. The most significant work is a new xdiff
>> interface at the end of the series.
>>
>> It's based on next where some preparatory work already landed[2].
>
> Do you really mean <20210204210556.25242-1-avarab@gmail.com>?
> ...
> I do not think we have that many patches whose title begin with
> grep/pcre2 in 'next'.
>
> In any case, I'd rather not to see things done directly on 'next';
> targetting a selected few topics merged on top of 'master' would
> not be bad, though.

It turns out that these patches textually depend on two topics in
'next', and both are to be merged to 'master' hopefully by the end
of the week, so perhaps that is a good time to queue this topic to
'seen' on top of the then-current master.

Thanks.
