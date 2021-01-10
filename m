Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCABC433E0
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 07:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73236238E1
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 07:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbhAJHDy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 02:03:54 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55974 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbhAJHDy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 02:03:54 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4974D11291D;
        Sun, 10 Jan 2021 02:03:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uryGJZH4zrDnOjbHaAbMp2a5MSA=; b=Ucn1wA
        3x6nrAdYkSeFEsTLf2GMaLr0AkxZIlJwPjkWnSeByFGS3xrSnrj6sKoMxu48VvWu
        q1reGaxeNjZPPA0fX3M4LCWtVZdAEa8O4Mc6bSPn1+KaYD7R8gon5LW0SBH1yPqf
        sQKzZdH2woTDWzK4bx6aEhKzDlsY1bswLY9Wg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nFeWmLoNeiql7jsfkA+ovKYLSYebm9ko
        vOFjeVDK28VDFFK/WTM+uHi56LCm0nObUZx0kWuVoXMj1rcIlHsGGDX8UYu3p5ux
        UL5/GzT+t9ZZjdCd8c2JVYVege5zfuApV3NkzB5tiFDke098i43gFrJXKgFJl6h1
        VkTNm81KDlI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F15311291C;
        Sun, 10 Jan 2021 02:03:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E0B9F11291A;
        Sun, 10 Jan 2021 02:03:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 00/14] Remove more index compatibility macros
References: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
        <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
Date:   Sat, 09 Jan 2021 23:03:04 -0800
In-Reply-To: <pull.830.v3.git.1610136177.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Fri, 08 Jan 2021 20:02:43
        +0000")
Message-ID: <xmqq1retclzr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3FB35C6-5311-11EB-A3E6-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> UPDATE: this is now based on ag/merge-strategies-in-c to avoid conflicts in
> 'seen'. The changes in builtin/rm.c still conflict with
> mt/rm-sparse-checkout, but that branch seems to be waiting for a clearer
> plan on some corner cases. I thought about ejecting it, but 'rm' still uses
> ce_match_stat(), so just dropping the patch gives less of a final stake at
> the end of the series. (I'm still open to it, if necessary.)

I haven't read this latest iteration myself yet beyond the cover
letter, but tonight's 'seen' has this queued near its tip.  I expect
it would either stay there or occasionally ejected, until the base
topic solidifies a bit more.

>  * Methods that know about the 'repo' pointer no longer also have an
>    'istate' pointer and instead prefer 'repo->index'
>
>  * This includes the callback_data struct which only has a 'repo' member, no
>    'istate'.

OK.
