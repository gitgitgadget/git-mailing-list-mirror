Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B868EC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 01:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB716113E
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 01:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbhIKBeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 21:34:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63956 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbhIKBeG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 21:34:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 89F8B14B6B0;
        Fri, 10 Sep 2021 21:32:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=VL98IH/94deI/F6n82TP5pZ4l
        yE6Veu16jjey2EE5Y4=; b=Gq6R1D2W0iw36Z9u2kkHOmC3e/xtcNXmxK13nYoLz
        Dviauh2vLpBKOi+kPeJCOpFUx0eNgXWJgwV+c4WuASlExfnBISIjlTzeADqAV7QE
        NV60ucn/ygpf2yrNE2WP2jZ5dIIzybVMB0Rp20b22wj5RTH3HNq2480qqUvLIrrg
        Y0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 82EE114B6AF;
        Fri, 10 Sep 2021 21:32:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CC5CB14B6AC;
        Fri, 10 Sep 2021 21:32:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/5] help tests: add test for --config output
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
        <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
        <patch-v2-3.5-258282095de-20210910T112545Z-avarab@gmail.com>
Date:   Fri, 10 Sep 2021 18:32:50 -0700
Message-ID: <xmqq8s03oq0t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2E107588-12A0-11EC-9B2B-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a missing test for checking what the --config output added in
> ac68a93fd2 (help: add --config to list all available config,
> 2018-05-26) looks like. We should not be emitting anything except
> config variables and the brief usage information at the end here.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t0012-help.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
> index c3aa016fd30..595bf81f133 100755
> --- a/t/t0012-help.sh
> +++ b/t/t0012-help.sh
> @@ -77,6 +77,19 @@ test_expect_success 'git help -g' '
>  	test_i18ngrep "^   tutorial   " help.output
>  '
> =20
> +test_expect_success 'git help -c' '
> +	git help -c >help.output &&
> +	cat >expect <<-\EOF &&
> +
> +	'"'"'git help config'"'"' for more information

	'\''git help config'\'' for more information

is a tad shorter.

> +	EOF
> +	grep -v -E \
> +		-e "^[^.]+\.[^.]+$" \
> +		-e "^[^.]+\.[^.]+\.[^.]+$" \

I have to question if there is much value in this test, especially
the latter pattern.  A configuration variable with three-level name
can have any byte, including a dot, in its second level, so
rejecting a name with more than three dots in it can over-filter,
depending on what new keys we'll document in the future.

> +		help.output >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'generate builtin list' '
>  	git --list-cmds=3Dbuiltins >builtins
>  '
