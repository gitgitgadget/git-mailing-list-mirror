Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18C0C433F5
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 03:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiDWD5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 23:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiDWD5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 23:57:16 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABD21A8168
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 20:54:20 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 984AE12F669;
        Fri, 22 Apr 2022 23:54:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=N3VXyT5/5I9xfZT+2yC3TZc8s
        S6qJDhQIz94k+TOxHw=; b=vjaFyJN0q/UZXTJ62PCqUU1yRjbduDcnGzCuuM0/p
        Ab24V62C+Y/F0r7FW1xdqvjiUWnw3MBPy5dsfXTLP+vwL7mBUc9bnEsNZQPZtu1K
        nwpYnh7nz6JHE0xh8vc0cs2EhMxJ8Ehg3dgn94T7e7EqfvNv1yoDDcoR9SV2iEoL
        uY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FD4312F668;
        Fri, 22 Apr 2022 23:54:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0132512F667;
        Fri, 22 Apr 2022 23:54:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 4/6] hook tests: fix redirection logic error in 96e7225b310
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
        <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
        <patch-4.6-cf62569b2e0-20220421T122108Z-avarab@gmail.com>
Date:   Fri, 22 Apr 2022 20:54:17 -0700
Message-ID: <xmqqczh84fpy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0D57A93C-C2B9-11EC-817D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The tests added in 96e7225b310 (hook: add 'run' subcommand,
> 2021-12-22) were redirecting to "actual" both in the body of the hook
> itself and in the testing code below.
>
> The net result was that the "2>>actual" redirection later in the test
> wasn't doing anything. Let's have those redirection do what it looks
> like they're doing.

And the error didn't affect the outcome of the tests?
This is fun.

Nicely spotted.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t1800-hook.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> index 26ed5e11bc8..1e4adc3d53e 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -94,7 +94,7 @@ test_expect_success 'git hook run -- out-of-repo runs=
 excluded' '
>  test_expect_success 'git -c core.hooksPath=3D<PATH> hook run' '
>  	mkdir my-hooks &&
>  	write_script my-hooks/test-hook <<-\EOF &&
> -	echo Hook ran $1 >>actual
> +	echo Hook ran $1
>  	EOF
> =20
>  	cat >expect <<-\EOF &&
