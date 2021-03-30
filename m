Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A221C433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 23:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE1A619CD
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 23:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhC3XcZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 19:32:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62164 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbhC3XcK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 19:32:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CF13B098D;
        Tue, 30 Mar 2021 19:32:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3sJ/NL6evQDj
        ke1EL5CapHnhYms=; b=Gj22JqAoTo/dNep78CETsSRcaC6eacCCmvHcWii7KqCT
        VcWyFCMsKAvBtaZ065OgRAUEtqSCtQdEzY3Ud5U2mgtYhyPWzN3N+KTZSAZpTM//
        0bunvPBcCWvNrsry33vPIZJJ1TYzqWMl5qEAo0EZdXHyGamV8kg9FJDOxMykIBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VczxN3
        SLW/HK+IA0TsSYhT+5NaoFtjTYUNl2QvFgXUH/Bw4Jcq8k9lhbM+YNhVE5Ft6y8n
        kCXw35ov/RgSO1kVfRYqnxxUoa4MBuem50M4J/UTvH5Z7yrEXvCEpyO8F0estDJu
        cst2RFcH7ljtP8b7drEJGTELg/ooxSOkNyeSQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A977B098C;
        Tue, 30 Mar 2021 19:32:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0555CB098A;
        Tue, 30 Mar 2021 19:32:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 08/22] pickaxe tests: test for -G, -S and
 --find-object incompatibility
References: <20210203032811.14979-1-avarab@gmail.com>
        <20210216115801.4773-9-avarab@gmail.com>
Date:   Tue, 30 Mar 2021 16:32:05 -0700
In-Reply-To: <20210216115801.4773-9-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 Feb 2021 12:57:47 +0100")
Message-ID: <xmqq1rbwb4lm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2412895C-91B0-11EB-94A8-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a test for the options sanity check added in 5e505257f2 (diff:
> properly error out when combining multiple pickaxe options,
> 2018-01-04).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t4209-log-pickaxe.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
> index c6b4751d5b6..5ad4fad964c 100755
> --- a/t/t4209-log-pickaxe.sh
> +++ b/t/t4209-log-pickaxe.sh
> @@ -55,6 +55,17 @@ test_expect_success setup '
>  	git rev-parse --verify HEAD >expect_second
>  '
> =20
> +test_expect_success 'usage' '
> +	test_expect_code 128 git log -Gregex -Sstring 2>err &&
> +	test_i18ngrep "mutually exclusive" err &&
> +
> +	test_expect_code 128 git log -Gregex --find-object=3DHEAD 2>err &&
> +	test_i18ngrep "mutually exclusive" err &&
> +
> +	test_expect_code 128 git log -Gstring --find-object=3DHEAD 2>err &&
> +	test_i18ngrep "mutually exclusive" err

Didn't you mean -Sstring for the third one?  Otherwise we'd be
testing -G/--find-object combination twice.

> +'
> +
>  test_log	expect_initial	--grep initial
>  test_log	expect_nomatch	--grep InItial
>  test_log_icase	expect_initial	--grep InItial
