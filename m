Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ABEC4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 19:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A64760F01
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 19:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhG3T1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 15:27:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61229 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhG3T1P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 15:27:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D69EC443F;
        Fri, 30 Jul 2021 15:27:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tMaUInps1zRK
        MLBKOgsrSY1vC9SuMBZwk14KL0bxRso=; b=VMfDLg8CCpWOm57rXTVDyH67enKk
        5JQNLEpZ8C782/LHHmdAvvywmmyD9n2JKHsB23wZKkzljhlCAYOubKYy8MXzwxat
        9N1RSruVQUuagznlbxXmrvG4xHZMpPYLKk+RV6QcJQlaybzwZOIikN8ZUYqLBtlT
        BR2G9huLeatHGn8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85149C443E;
        Fri, 30 Jul 2021 15:27:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3B56C443D;
        Fri, 30 Jul 2021 15:27:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Eric Wong <e@80x24.org>
Subject: Re: [PATCH] use fspathhash() everywhere
References: <b85ed04f-ef9c-f460-e21b-bd1f8dfba9e2@web.de>
Date:   Fri, 30 Jul 2021 12:27:09 -0700
In-Reply-To: <b85ed04f-ef9c-f460-e21b-bd1f8dfba9e2@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 30 Jul 2021 21:06:58 +0200")
Message-ID: <xmqq35rv1u2a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2251E876-F16C-11EB-BD1E-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> cf2dc1c238 (speed up alt_odb_usable() with many alternates, 2021-07-07)
> introduced the function fspathhash() for calculating path hashes while
> respecting the configuration option core.ignorecase.  Call it instead o=
f
> open-coding it; the resulting code is shorter and less repetitive.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  builtin/sparse-checkout.c | 10 ++--------
>  dir.c                     | 13 +++----------
>  merge-recursive.c         | 11 +++--------
>  3 files changed, 8 insertions(+), 26 deletions(-)

I love this kind of "now we have this thing available, let's use it
at more places" clean-up patch.

Was coccinelle involved in finding these places?

Thanks.
