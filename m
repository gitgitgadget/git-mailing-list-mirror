Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF27DC433DB
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 09:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832C622283
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 09:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgLXJRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 04:17:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56178 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgLXJRm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 04:17:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1A28AE2B6;
        Thu, 24 Dec 2020 04:16:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AXgNKi9DbaM7
        Rcvi9i7lFYdPd5E=; b=uJ/896SyqBEcNZHXN4cvnxR7gDUfevALawvGpx6pHmKK
        hYS5CVhBPVaexqUcj3tsMSRT56Q/U+LrpGovQE1WFc2/KmSzX6vcQDsW9cBzg+BX
        1l5J9XJY/FzQoW/1brBHoOPRaPUuPapBphNroDVzV+3kU1Q4ZqQRbPCqfxQ5UC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YhEfuT
        bBQaNQHB1JJ/uRS3J+v3A/6SM3Gdd6Y86RKQHP/kWoxeyFB9NzU0I8+Y6BfKxoiG
        S5Qodq03dcbRXFlJtfpe5rXG6U5pj5YskNsxEOTVnMjgNsOq9PA1UKnXBdcXf7U9
        qlTrrkVFgQJ1kGz44jX8uSpJ43OQ0dqf5LxyI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA146AE2B5;
        Thu, 24 Dec 2020 04:16:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 413AAAE2B4;
        Thu, 24 Dec 2020 04:16:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 00/20] make "mktag" use fsck_tag() & more
References: <20201209200140.29425-1-avarab@gmail.com>
        <20201223013606.7972-1-avarab@gmail.com>
        <xmqq5z4saar4.fsf@gitster.c.googlers.com>
Date:   Thu, 24 Dec 2020 01:16:58 -0800
In-Reply-To: <xmqq5z4saar4.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 23 Dec 2020 05:54:23 -0800")
Message-ID: <xmqqmty336np.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C69C5B28-45C8-11EB-9FB8-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> So, when re-rolling this with Junio's small fixup this grew in scope a
>> bit, but should paradoxically be easier to deal with even though it's
>> 2x the size now. Read on:
>
> The core part didn't change all that much, which made it a bit
> easier to see.  I left comments here and there, but the series
> mostly looked sensible in general.

This failure is likely from the "mktag" series:

  https://github.com/git/git/runs/1602776090#step:4:1622 (summary)
  https://github.com/git/git/runs/1602776090#step:5:158 (the first one of=
 them)

Thanks.
