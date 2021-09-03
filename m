Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE72C433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 05:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89DD460FDC
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 05:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhICFGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 01:06:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55195 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbhICFGE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 01:06:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B6CB155480;
        Fri,  3 Sep 2021 01:05:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qGMZ/kxX394d
        pw/RAqEntSPmMUhnkyDrXrGrsqbHttQ=; b=UyxOCaYCHgLWffdc3GE+cY3cPuEf
        69fBp9wXpilb+2tL2MAD4JbtF01ub/LXv0j2WFoDAoPa1pPIW7YEMqncoFS4tIYh
        K/klylJuVvhNzZRTgmX9gFtBiJPg8PaG6Ycn+mA8OB3IfofPUg/RpEpPSOdrt04d
        EPniZU4evz8u3lE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 143AF15547F;
        Fri,  3 Sep 2021 01:05:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3856B15547D;
        Fri,  3 Sep 2021 01:05:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 2/5] strvec: add a strvec_pushvec()
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
        <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
        <patch-v3-2.5-321b8ba3f0e-20210826T140414Z-avarab@gmail.com>
        <xmqq8s0m9xbl.fsf@gitster.g> <xmqq4kba9x1h.fsf@gitster.g>
        <YSm3ofxlRB1ViBf5@coredump.intra.peff.net>
        <87v93i8svd.fsf@evledraar.gmail.com>
Date:   Thu, 02 Sep 2021 22:05:00 -0700
In-Reply-To: <87v93i8svd.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 03 Sep 2021 01:19:33 +0200")
Message-ID: <xmqq7dfygsg3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7EAA20AC-0C74-11EC-B4E6-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Since the main point of this API is to be a wrapper for what a C main()
> would take, shouldn't its prototype mirror its prototype? I.e. we shoul=
d
> stick to "int" here?

That's a fair-enough argument.

In other words, we do not mind the upper limit of 2 billion strings,
even though we do care that we can have more than 4 billion bytes in
any of these strings ;-)
