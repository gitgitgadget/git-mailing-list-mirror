Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F429C433FE
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 21:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbiBAVsL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 16:48:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59730 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbiBAVsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 16:48:09 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E3DE1700D7;
        Tue,  1 Feb 2022 16:48:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qlXCis0Neo+e
        arH9oPU80uc7jwhQ9a9E6aiv6pecQ6s=; b=m2HV6y60hfjTm4BlQGQPWMrQhfVE
        ctplnPQKhRhHIAIfBQ3c6ptV3q+0/hL0jWoYWagcCAUvwdo6H7jsnlVnsiVbUWMr
        ig0mm2fTcjyfNhxwa0ZDHj9cgWEIfw2xoJ8bb9OKlap5rbhUAxeMFZjmK61krSkp
        tHcwgSKanmEhKLI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 75BBB1700D6;
        Tue,  1 Feb 2022 16:48:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E16711700D5;
        Tue,  1 Feb 2022 16:48:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t0051: use "skip_all" under !MINGW in single-test file
References: <patch-1.1-34ff968dcb8-20220201T203428Z-avarab@gmail.com>
Date:   Tue, 01 Feb 2022 13:48:05 -0800
In-Reply-To: <patch-1.1-34ff968dcb8-20220201T203428Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 1 Feb
 2022 21:35:51 +0100")
Message-ID: <xmqq5ypycl7u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A3E9DE4C-83A8-11EC-AAF1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Have this file added in 06ba9d03e34 (t0051: test GIT_TRACE to a
> windows named pipe, 2018-09-11) use the same "skip_all" pattern as an
> existing Windows-only test added in 0e218f91c29 (mingw: unset PERL5LIB
> by default, 2018-10-30) uses.
>
> This way TAP consumers like "prove" will show a nice summary when the
> test is skipped, e.g.:

... as opposed to?  A failure?  A different appearance of the log
message?  Something else?

>
>     $ prove t0051-windows-named-pipe.sh
>     [...]
>     t0051-windows-named-pipe.sh ... skipped: skipping Windows-specific =
tests
>     [...]
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>
> A trivial UX improvement for the "prove" output, so that we'll show a
> notice in the same way as e.g. t0029-core-unsetenvvars.sh and
> t5580-unc-paths.sh do (which are both Windows-specific).
>
>  t/t0051-windows-named-pipe.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/t/t0051-windows-named-pipe.sh b/t/t0051-windows-named-pipe=
.sh
> index 10ac92d2250..412f413360d 100755
> --- a/t/t0051-windows-named-pipe.sh
> +++ b/t/t0051-windows-named-pipe.sh
> @@ -3,8 +3,13 @@
>  test_description=3D'Windows named pipes'
> =20
>  . ./test-lib.sh
> +if ! test_have_prereq MINGW
> +then
> +	skip_all=3D'skipping Windows-specific tests'
> +	test_done
> +fi
> =20
> -test_expect_success MINGW 'o_append write to named pipe' '
> +test_expect_success 'o_append write to named pipe' '
>  	GIT_TRACE=3D"$(pwd)/expect" git status >/dev/null 2>&1 &&
>  	{ test-tool windows-named-pipe t0051 >actual 2>&1 & } &&
>  	pid=3D$! &&
