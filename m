Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA9EC433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 14:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28D12207C4
	for <git@archiver.kernel.org>; Wed, 20 May 2020 14:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hguJDHwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgETO6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 10:58:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61709 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETO6W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 10:58:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B62735D721;
        Wed, 20 May 2020 10:58:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JrRufPcHtdPW
        pMbjw+PCJfuULsE=; b=hguJDHwzwWttNdPnmHcFCUs94nLo7Wg2DdP+7OS6PF8x
        bi8u9h+L07MsILn3LvMaGGAFpGZmYFWyRMguQI3BxWHpD6nSOomCZxDgj9rVIio3
        kMAHPhW8Q0cJBrMURL+4hg/a3GhgwqwGnnjfsNQb32zICKsDvwYLozJFLsGuuMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YN23+b
        ZlxLvs61ZcpQZ3WKcA7VPwhLZsxIil84ObjaCioy0bAYiLO70RYBWImQxleyh0xF
        2ewP+degIPn8fvEbDuvYMlBIyxanx8KNGCUuIWv1pZ6hM1OrZumD6zbb/PuHpUAu
        cizf9MHa4WdcCUjOJFfcn8bFmFESk1sp3DNRg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AEBC55D720;
        Wed, 20 May 2020 10:58:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3C96F5D71D;
        Wed, 20 May 2020 10:58:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, liu.denton@gmail.com, chwarr@microsoft.com,
        garima.singh@microsoft.com
Subject: Re: [PATCH 3/3] t5520: avoid alternation in grep's BRE (not POSIX)
References: <20200520034444.47932-1-carenas@gmail.com>
        <20200520034444.47932-4-carenas@gmail.com>
Date:   Wed, 20 May 2020 07:58:19 -0700
In-Reply-To: <20200520034444.47932-4-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 19 May 2020 20:44:44 -0700")
Message-ID: <xmqqv9kqwt4k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 582CE546-9AAA-11EA-B8A7-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> Instead of using a BRE, that broke tests 30-32, 37-39, 42 at least with
> OpenBSD 6.7; use a simpler ERE.

Thanks.  We already do use "test_i18ngrep -E" in another test, so
this should be safe.

> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  t/t5520-pull.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 37535d63a9..9fae07cdfa 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -28,7 +28,7 @@ test_pull_autostash_fail () {
>  	echo dirty >new_file &&
>  	git add new_file &&
>  	test_must_fail git pull "$@" . copy 2>err &&
> -	test_i18ngrep "\(uncommitted changes.\)\|\(overwritten by merge:\)" e=
rr
> +	test_i18ngrep -E "uncommitted changes.|overwritten by merge:" err
>  }
> =20
>  test_expect_success setup '
