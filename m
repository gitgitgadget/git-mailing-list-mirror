Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86DBC433E0
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 20:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E4342072E
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 20:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yZ6CX30X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGOUCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 16:02:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54285 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgGOUCT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 16:02:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58B907028A;
        Wed, 15 Jul 2020 16:02:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nPhpxo+8zHjzj+WyiTMO590ykZI=; b=yZ6CX3
        0X82mwHMoCmNitd4nHeQuH+uYUxH5XZLk7ddo4Hj/qgbXH6XryPkFeQ1tiRj0hJG
        E9G2Zeqwd/Jrlm1ddp+W4Lyr4Q7DftmKvDa2pTSGRt6Jt3+oLucddqMUCz2i7dwn
        TmgtORtB2afGMU+uRm4K1M0KuufBJ6II4atQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PiirKZb0lNtyEieS36lS4jbf3b2wrJfr
        z791U+/IpHrQVlnK2dgeU6eDUOVAeYcQiU583NP0oXSN3AtYWoINz70r9VLfdHqa
        g/pxoXW0Vzp+HKgYMmMK+TAGASoeX4YpgyMLHwHHNDEcNwQ4KmX2wPcuaEgZmQAD
        eNBNtrd4CEs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4AACB70289;
        Wed, 15 Jul 2020 16:02:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8399B70288;
        Wed, 15 Jul 2020 16:02:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 31/39] bundle: add new version for use with SHA-256
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
        <20200713024909.3714837-32-sandals@crustytoothpaste.net>
        <20200713155617.GF11341@szeder.dev>
        <nycvar.QRO.7.76.6.2007152141160.52@tvgsbejvaqbjf.bet>
Date:   Wed, 15 Jul 2020 13:02:15 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2007152141160.52@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 15 Jul 2020 21:42:10 +0200 (CEST)")
Message-ID: <xmqq1rlck0mw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14FC610E-C6D6-11EA-AEAE-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> This "unknown capability" error message is translated, so it should be
>> checked with 'test_i18ngrep'.
>
> In other words, this patch (which makes things work over here):

Thanks.

>
> -- snipsnap --
> Subject: [PATCH] fixup! bundle: add new version for use with SHA-256
>
> ---
>  t/t5607-clone-bundle.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
> index 4a2a3968cc1..ca4efd88d4a 100755
> --- a/t/t5607-clone-bundle.sh
> +++ b/t/t5607-clone-bundle.sh
> @@ -118,7 +118,7 @@ test_expect_success 'git bundle v3 rejects unknown extensions' '
>  	echo "@unknown=silly" >>new &&
>  	sed "1,2d" >>new &&
>  	test_must_fail git bundle verify new 2>output &&
> -	grep "unknown capability .unknown=silly." output
> +	test_i18ngrep "unknown capability .unknown=silly." output
>  '
>
>  test_done
> --
> 2.26.0.windows.1
