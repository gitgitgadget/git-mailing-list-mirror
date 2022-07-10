Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71EDC433EF
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 05:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiGJFiV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 01:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGJFiU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 01:38:20 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593E714D25
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 22:38:19 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5760014E125;
        Sun, 10 Jul 2022 01:38:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=m2gHp3DkFahgCoH1tRnjvpUtw
        zLPR7LdCymRH3hWo2I=; b=j29FH/PQL/VGYMp8ra5Z3M2DHUnsSyCmjep/EhC4h
        ugJx/j6NuYniVlFD9vvLa7rLSk3yS8KR0T0KyzbJycqcfYPdM91QydWd054lvPda
        ZtZKtBQK1jVTz8uUY6g5XtVLC8IfMdV2INXJwV8fCyBFc6F0uJHKxQU1TtMDGH/e
        EA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4ECC514E124;
        Sun, 10 Jul 2022 01:38:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ADD7914E123;
        Sun, 10 Jul 2022 01:38:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] builtin/mv.c: use correct type to compute size of an
 array element
References: <xmqq8rp54r4l.fsf@gitster.g>
        <220707.86y1x585wy.gmgdl@evledraar.gmail.com>
        <xmqq1quw23r8.fsf@gitster.g>
        <cb866b8c-dcc6-557f-da23-1c1972619a8a@web.de>
        <95432eb4-e66a-5c04-9267-f71391fbe277@web.de>
Date:   Sat, 09 Jul 2022 22:38:16 -0700
Message-ID: <xmqqmtdhsf1z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 801ED97C-0012-11ED-BAAC-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Not a problem, it seems; at least Coccinelle 1.1.1 is still able to
> recreate the conversions from 45ccef87b3 (use COPY_ARRAY, 2016-09-25)
> and 921d49be86 (use COPY_ARRAY for copying arrays, 2019-06-15) with the
> patch below, which removes the normalization rules. =20

The result certainly is cleaner and also looks much less error
prone.

> It increases the
> processing time for array.cocci from 53s to 66s for me, though.  Worth
> the increased precision and clarity?

I would say so.  For manual tests that humans stare at their
progress waiting for their completion, every second may matter, but
a check that makes us wait for more than 30 seconds *and* forces us
to be extra careful when vetting its validity is worse than a check
that takes 10 more seconds with much less risk of broken output.

