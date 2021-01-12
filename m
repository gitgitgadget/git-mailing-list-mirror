Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FA8C433E9
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 22:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F52E2312E
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 22:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405328AbhALWfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 17:35:04 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62612 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730069AbhALWfE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 17:35:04 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 19A11FCB09;
        Tue, 12 Jan 2021 17:34:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=OtWSqzq4XTNNfCfiWZubU0K/D
        OQ=; b=UZXf5mk4MBdBvWEKpOBEaCcjhXVT7azvqU7CyigCZgfYO47AfdA7aYg88
        fAuYvqY6wycwlHjUU6JIQZTHzqTTYzHC6l2ptCo5tv01WJ6VrWlBYeRq8zvc6mxW
        ZUSnlbFn+bujONG4gbuz/Agq4603KmGAui6p/vEb76qVAd6uRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=set8+Bwod3VGuBF7tny
        oHcyQ5oPMrgmLVQ572NYCTpNyNr4PI8SZIpu0K6svwA68izu231k9WrW3jqldMbq
        JDjTylKuffkMEOJmnJlRO09u85Gc/bZNjxQ2yGuGJrVY2x5CBXtZqbUL/U7exue2
        ANMjyf3axqGtJE6sbRiJJxg4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 12E7AFCB08;
        Tue, 12 Jan 2021 17:34:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 57C90FCB07;
        Tue, 12 Jan 2021 17:34:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 09/22] mailmap tests: add a test for "not a blob" error
References: <20210105130359.21139-1-avarab@gmail.com>
        <20210112201806.13284-10-avarab@gmail.com>
Date:   Tue, 12 Jan 2021 14:34:17 -0800
Message-ID: <xmqqft35239y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4F60353A-5526-11EB-9A8A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a test for one of the error conditions added in
> 938a60d64f (mailmap: clean up read_mailmap error handling,
> 2012-12-12).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t4203-mailmap.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)

Nice to see a patch that tries to be careful, like this one.

> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index 03a98d9635..78d56e0566 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -333,6 +333,15 @@ test_expect_success 'mailmap.blob can be missing' =
'
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success 'mailmap.blob might be the wrong type' '
> +	test_when_finished "rm .mailmap" &&
> +	cp default.map .mailmap &&
> +
> +	git -c mailmap.blob=3DHEAD: shortlog HEAD >actual 2>err &&
> +	test_i18ngrep "mailmap is not a blob" err &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'mailmap.blob defaults to off in non-bare repo' '
>  	git init non-bare &&
>  	(
