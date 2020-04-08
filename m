Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34A8C2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 19:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D1F20768
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 19:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FYjATxWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgDHTOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:14:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52835 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbgDHTOW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 15:14:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 01A6BB18BD;
        Wed,  8 Apr 2020 15:14:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Am2KCpZbuf+V
        pptIeAwa+c/u/KY=; b=FYjATxWTcAe8lJ/0IIZwBNGaw3iL6eNTFX6RHdOP1IpL
        Ho5UMbzxsDLDbc+BFxV9wVBx7kELjv8jwJ9OGZ/Mh0LovPqZBH+m4V5nFSgoEpRp
        KGEICaBc6TXCEYjMWhwSUYTju5fNX0A2DBf2zoSKSZWo1wWxsdxgKdFAOxdssE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Od6hls
        tm8nQPk4W+jJfXcjnjmFxbKVx6mdZ+Vauv+1pI6VcIOhHiY20lj2S5MHg27o9dK6
        YMf2Y2MMOutfxnhUpq7qwCSV3Z03D/mvIAZmXU7V27X0OQgBdAvm5vPguchuRBZ1
        alWeR15TBuHCda9QhZehCD448pv/7pughiuW0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ED833B18BC;
        Wed,  8 Apr 2020 15:14:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E7BE6B18BB;
        Wed,  8 Apr 2020 15:14:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Subject: Re: [PATCH] mingw: use modern strftime implementation if possible
References: <pull.753.git.git.1586368729890.gitgitgadget@gmail.com>
Date:   Wed, 08 Apr 2020 12:14:16 -0700
In-Reply-To: <pull.753.git.git.1586368729890.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 08 Apr 2020 17:58:49
        +0000")
Message-ID: <xmqqblo1pz7b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 24B9EBD0-79CD-11EA-BC35-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: =3D?UTF-8?q?Matthias=3D20A=3DC3=3D9Fhauer?=3D <mha1993@live.de>
>
> Microsoft introduced a new "Universal C Runtime Library" (UCRT) with
> Visual Studio 2015. The UCRT comes with a new strftime() implementation
> that supports more date formats. We link git against the older
> "Microsoft Visual C Runtime Library" (MSVCRT), so to use the UCRT
> strftime() we need to load it from ucrtbase.dll using
> DECLARE_PROC_ADDR()/INIT_PROC_ADDR().
>
> Most supported Windows systems should have recieved the UCRT via Window=
s
> update, but in some cases only MSVCRT might be available. In that case
> we fall back to using that implementation.
>
> With this change, it is possible to use e.g. the `%g` and `%V` date
> format specifiers, e.g.
>
> 	git show -s --format=3D%cd --date=3Dformat:=E2=80=98%g.%V=E2=80=99 HEA=
D
>
> Without this change, the user would see this error message on Windows:
>
> 	fatal: invalid strftime format: '=E2=80=98%g.%V=E2=80=99'
>
> This fixes https://github.com/git-for-windows/git/issues/2495
>
> Signed-off-by: Matthias A=C3=9Fhauer <mha1993@live.de>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     Use a modern strftime() on Windows when available
>    =20
>     This is another contribution that came in via Git for Windows.

Sure.  It would be very surprising if contribution to compat/mingw.c
came in via Git on Macintosh ;-)

Will apply, together with the other one.  Thanks.

