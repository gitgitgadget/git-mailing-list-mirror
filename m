Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D86FC433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 17:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20FB360F42
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 17:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbhKLRV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 12:21:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51615 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhKLRVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 12:21:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A2E8EAA2D;
        Fri, 12 Nov 2021 12:18:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OFPZMZUl+sfd
        /2H6m2Ts3K+NeJ/VV/XacPu6DgKelkE=; b=DrXdPxaleNH+c7i2CB7qy9P8M8F9
        s67zVNvdwbVf1PEy6pZbuxJx0JgI1BQT21+zkL+YRtcCkVwzE1mO//vC7/8jSRYp
        gKEi0dRtqgXi8pg3ERCvSRUAraXOdB1mgpTI6hLZPu3hXOWGT7G9lvMBu6U5BO8P
        9ahIRPZHT2g49Vs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00ECDEAA2C;
        Fri, 12 Nov 2021 12:18:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E3CEEAA2B;
        Fri, 12 Nov 2021 12:18:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 5/8] grep.c: don't pass along NULL callback value
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
        <patch-v2-5.8-d0f0ac6c7ae-20211110T013632Z-avarab@gmail.com>
Date:   Fri, 12 Nov 2021 09:18:32 -0800
In-Reply-To: <patch-v2-5.8-d0f0ac6c7ae-20211110T013632Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 10 Nov
 2021 02:43:47
        +0100")
Message-ID: <xmqqk0hds36f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 90468388-43DC-11EC-8723-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change grep_cmd_config() top stop passing around the always-NULL "cb"

"Change X top stop passing"?  I cannot guess so I will not say "I'll
fix it to X, no need to resend".

The change itself does seem sensible.

Thanks.

> value. When this code was added in 7e8f59d577e (grep: color patterns
> in output, 2009-03-07) it was non-NULL, but when that changed in
> 15fabd1bbd4 (builtin/grep.c: make configuration callback more
> reusable, 2012-10-09) this code was left behind.
>
> In a subsequent change I'll start using the "cb" value, this will make
> it clear which functions we call need it, and which don't.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/grep.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index d85cbabea67..5ec4cecae45 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -285,8 +285,8 @@ static int wait_all(void)
> =20
>  static int grep_cmd_config(const char *var, const char *value, void *c=
b)
>  {
> -	int st =3D grep_config(var, value, cb);
> -	if (git_color_default_config(var, value, cb) < 0)
> +	int st =3D grep_config(var, value, NULL);
> +	if (git_color_default_config(var, value, NULL) < 0)
>  		st =3D -1;
> =20
>  	if (!strcmp(var, "grep.threads")) {
