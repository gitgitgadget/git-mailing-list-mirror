Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832E2C433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 21:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 486A322BEF
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 21:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbhAWVgY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 16:36:24 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65125 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbhAWVgX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 16:36:23 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9383B11A04B;
        Sat, 23 Jan 2021 16:35:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4IFy3NUwx0SL
        ePofimKuDE3QrSE=; b=hyKfcFku5z3EpgDDUkHuay565HqhceIfqrZQczZr9zR1
        IzlFxDYzf+LIaMrYYAC0GlrRI6PyPK/051KPo5UvIJn4A9XfGrURk7df7EqFohTr
        HALH2bcafdqIfEQ8sQ/Yky3HSf4Yy85fg6QtX8vmwEHoZBIx3cOHdxcneLULOkc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=x9RSJo
        fTNzqYK+7+a4QfoecpPJEVbi2FyGKvWUR2TgJQySd0E2ju2FfjnEzjf1sVfpDoE+
        KkzMLOxYElyonnRx0KlFfCKCQj2H2DCftNgNFQg8rfYYKGX0kB4NXEpXPww/slGs
        7PKDtpUj6g4QS7qV84y3Rzh9E+7y5BY3t6+c4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8BD4B11A04A;
        Sat, 23 Jan 2021 16:35:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D61CF11A047;
        Sat, 23 Jan 2021 16:35:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 03/10] cache-tree tests: use a sub-shell with less
 indirection
References: <87sg6s6lrs.fsf@evledraar.gmail.com>
        <20210123130046.21975-4-avarab@gmail.com>
Date:   Sat, 23 Jan 2021 13:35:37 -0800
In-Reply-To: <20210123130046.21975-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 23 Jan 2021 14:00:39 +0100")
Message-ID: <xmqqlfcj2v6e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EF8C54FE-5DC2-11EB-96C5-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change a "cd xyz && work && cd .." pattern introduced in
> 9c4d6c0297 (cache-tree: Write updated cache-tree after commit,
> 2014-07-13) to use a sub-shell instead with less indirection.

Much nicer.  Pleased.
