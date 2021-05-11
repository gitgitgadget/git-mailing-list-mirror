Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B87EC433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 02:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59FD961606
	for <git@archiver.kernel.org>; Tue, 11 May 2021 02:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhEKCPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 22:15:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50358 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhEKCPx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 22:15:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 846EA1182F1;
        Mon, 10 May 2021 22:14:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P3tDtsQeXDF46PAFWLGeG5w2ZvvfsE3nO/LOA1
        mikTA=; b=IZzUqHL3OgTxRZy6+UloOElL6x6vod73hG6mVdQSiEZaOXSzNi7Jqk
        7wgAxCDUSqIzyVBYyBwUrU9uuwc5DtYKYmHI+YEizHFdxagDJ+/chlYR7kXO+x0G
        0wLu+VCXFzFEL1j3ypNCUEIqOy5ytjl5cxJXg6MEb7LSZiH4jxCoQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7D6A01182F0;
        Mon, 10 May 2021 22:14:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B535C1182ED;
        Mon, 10 May 2021 22:14:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Hariom Verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] ref-filter: introduce enum atom_type
References: <pull.951.git.1620487353.gitgitgadget@gmail.com>
        <pull.951.v2.git.1620659000.gitgitgadget@gmail.com>
        <a1f70b39b7efbadff9e2202968dd1ca65ea3c1b4.1620659000.git.gitgitgadget@gmail.com>
Date:   Tue, 11 May 2021 11:14:42 +0900
In-Reply-To: <a1f70b39b7efbadff9e2202968dd1ca65ea3c1b4.1620659000.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Mon, 10 May 2021 15:03:19
        +0000")
Message-ID: <xmqqh7jaow31.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A70F75E0-B1FE-11EB-BE96-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> the enum value of `ATOM_UNKNOWN` is equals to zero, which

s/the/The/;

> could ensure that we can easily distinguish such a struct
> where the atom_type is known from such a struct where it
> is unknown yet.
>
> the enum value of `ATOM_INVALID` is equals to the size of

Ditto.

> +/*
> + * The enum atom_type is used as the coordinates of valid_atom entry.
> + * In the atom parsing stage, it will be passed to used_atom.atom_type
> + * as the identifier of the atom type. We can judge the type of used_atom
> + * entry by `if (used_atom[i].atom_type == ATOM_*)`.
> + *
> + * ATOM_UNKNOWN equals to 0, used as an enumeration value of uninitialized
> + * atom_type.

Shouldn't it be (-1)?

And I'd assume I am right in the following.

> + * ATOM_INVALID equals to the size of valid_atom array, which could help us
> + * iterate over valid_atom array like this:
> + *
> + * 	for (i = ATOM_UNKNOWN + 1; i < ATOM_INVALID; i++) {

I find it far more intuitive to say

	for (i = 0; i < ATOM_INVALID; i++)

than having to say UNKNOWN+1.

In any case, the values should be indented, and a comment should
ensure that the final one stays at the end, perhaps like this.

	enum atom_type {
		ATOM_INVALID = -2,
		ATOM_UNKNOWN = -1,
		ATOM_REFNAME,
		...
		ATOM_ELSE,
		ATOM_MAX /* MUST BE AT THE END */
	}

(note that the trailing comma is deliberately omitted).

It would allow people to say

	for (i = 0; i < ATOM_MAX; i++)

instead, which would be even nicer.
