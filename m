Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F26C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 20:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F68613AB
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 20:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhGIUUA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 16:20:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59866 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGIUUA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 16:20:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28C1CE32DF;
        Fri,  9 Jul 2021 16:17:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GUHKWccZ4SaO
        QLSDIbw9vLTdObMqD61AQ1cQgE8efE8=; b=tbhnNIB0kfE7/s9LQ30OH0ypPXqR
        ZRAx6Q8Th4cvJW0u0PAEnKG89CWoVU9d0Ha4WdQMmrZ43EZyHV2KGuTIb7RUxi3r
        jR5JvYDbW5daO8RWt74fAt0WW1WT2OuqCivg6wkHkMXHEYr/OH4lhGHhI9PFDiQ8
        ZDru+M9c6H8hg7U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F42EE32DE;
        Fri,  9 Jul 2021 16:17:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85144E32DC;
        Fri,  9 Jul 2021 16:17:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 2/5] revision.h: refactor "disable_stdin" and
 "read_from_stdin"
References: <cover-0.4-00000000000-20210621T150651Z-avarab@gmail.com>
        <cover-0.5-00000000000-20210709T105850Z-avarab@gmail.com>
        <patch-2.5-630feb06650-20210709T105851Z-avarab@gmail.com>
Date:   Fri, 09 Jul 2021 13:17:14 -0700
In-Reply-To: <patch-2.5-630feb06650-20210709T105851Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 9 Jul
 2021 13:06:13 +0200")
Message-ID: <xmqqv95j5jjp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A7217F56-E0F2-11EB-9CDA-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +	/*
> +	 * Did we read from stdin due to stdin_handling =3D=3D
> +	 * REV_INFO_STDIN_CONSUME_ON_OPTION and seeing the --stdin
> +	 * option?
>  	 */
> -	int read_from_stdin;
> +	int consumed_stdin:1;

Will make this into "unsigned int" while queuing, as 1-bit signed
bitfield would not make much sense.

