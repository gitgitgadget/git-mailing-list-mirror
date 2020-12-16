Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB7FC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA85D22DCC
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgLPAfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 19:35:52 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61497 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgLPAfv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 19:35:51 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 36F1FF4FCB;
        Tue, 15 Dec 2020 19:35:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IQHmnyKA1DyX
        SbZ99saH3kltc1I=; b=CJosJVTTWta47vxFr1OgIw3at9asDGdgDG9++mqHcwGu
        Dm+vV/n/YxsnFbcJI2819AbOZBFoZ/FbSeU/bcErVx6NPu8Z4McUnPKUkv+le+ly
        Il+PUvsxU8BPJW6IaxJ/YrgBXDurIQ2oedm+age2jWaCkv1vNZsuXUzs40d4K0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dXsddn
        j+3m833RVVEev+u6ikm9UesGVJaoPhhGHpm94RVTG8C8Ep8CiClGfM6DSRxmH6Ct
        KT90HnpyC3zKRPT3A2P4p+KFN/T32EP2nON4gessGCJAsEOejZ7nhGkFm09hIJ6l
        rpxyLoOGCq0OLaIqgAUK6UGclvHqwu2LolXEg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F350F4FCA;
        Tue, 15 Dec 2020 19:35:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 42368F4FC8;
        Tue, 15 Dec 2020 19:35:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] style: do not "break" in switch() after "return"
References: <xmqq7dpkdup6.fsf@gitster.c.googlers.com>
        <20201215235027.10401-3-avarab@gmail.com>
        <xmqqtusm618e.fsf@gitster.c.googlers.com>
Date:   Tue, 15 Dec 2020 16:35:04 -0800
In-Reply-To: <xmqqtusm618e.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 15 Dec 2020 16:30:57 -0800")
Message-ID: <xmqqpn3a611j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8B4E1090-3F36-11EB-98D9-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Remove this unreachable code. It was found by SunCC, it's found by a
>> non-fatal warning emitted by SunCC. It's one of the things it's more
>> vehement about than GCC & Clang.
>
> This is a borderline Meh to me.
>
> I am even tempted to suggest that, unless all other case arms
> return, iow, if there is even a single arm that breaks, it may even
> be more future-proof to end any and all case arms that do not
> fall-thru to consistently end with break.
>
> If there is some way to fix the compiler, that may be preferrable,
> but as I said, this is borderline Meh and I do not care too deeply
> either way.
>
> Thanks.

Heh, this patch cleanly applies even to the tip of 'maint', which
means it is not a new issue at all.  Is this caused by more recent
SunCC than you used in the past?

