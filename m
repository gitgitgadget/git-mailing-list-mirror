Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74076C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 17:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FDD7611BF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 17:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhIJRB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 13:01:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59961 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhIJRB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 13:01:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 362EAE673B;
        Fri, 10 Sep 2021 13:00:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nM0CgjEmXhVF
        T3Y3tGKKXsfYPWmGgXKgl0dDCxK4CiM=; b=LysQSQU3c/20MJ90Yv2pQKtAbUKN
        Lun8wyyCCbaAUu+E7waAYmHK08O9vx6ASJyZ25kG9fWE+npriw+72paoUgwSAzwi
        aDipm25ec3YYAwr3oa2D4q9aycdn6ACtCsCEMu4yZJE6adlkCC1bnWMVGXS3ka4M
        diYyeKvanig7WfM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C172E673A;
        Fri, 10 Sep 2021 13:00:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA7DFE6739;
        Fri, 10 Sep 2021 13:00:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 6/8] http: correct curl version check for
 CURLOPT_PINNEDPUBLICKEY
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
        <patch-v2-6.8-397d54a1352-20210910T105523Z-avarab@gmail.com>
Date:   Fri, 10 Sep 2021 10:00:45 -0700
In-Reply-To: <patch-v2-6.8-397d54a1352-20210910T105523Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 10 Sep
 2021 13:04:31
        +0200")
Message-ID: <xmqqfsuctlfm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A3DC65A8-1258-11EC-8562-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In aeff8a61216 (http: implement public key pinning, 2016-02-15) a
> dependency and warning() was added if curl older than 7.44.0 was used,
> but the relevant code depended on CURLOPT_PINNEDPUBLICKEY, introduced
> in 7.39.0.

[PATCH 7/8] should make the difference irrelevant, but OK ;-)

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  http.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/http.c b/http.c
> index b82b5b7a532..543faad9879 100644
> --- a/http.c
> +++ b/http.c
> @@ -59,7 +59,7 @@ static struct {
>  static const char *ssl_key;
>  static const char *ssl_capath;
>  static const char *curl_no_proxy;
> -#if LIBCURL_VERSION_NUM >=3D 0x072c00
> +#if LIBCURL_VERSION_NUM >=3D 0x072700
>  static const char *ssl_pinnedkey;
>  #endif
>  static const char *ssl_cainfo;
> @@ -373,10 +373,10 @@ static int http_options(const char *var, const ch=
ar *value, void *cb)
>  	}
> =20
>  	if (!strcmp("http.pinnedpubkey", var)) {
> -#if LIBCURL_VERSION_NUM >=3D 0x072c00
> +#if LIBCURL_VERSION_NUM >=3D 0x072700
>  		return git_config_pathname(&ssl_pinnedkey, var, value);
>  #else
> -		warning(_("Public key pinning not supported with cURL < 7.44.0"));
> +		warning(_("Public key pinning not supported with cURL < 7.39.0"));
>  		return 0;
>  #endif
>  	}
> @@ -845,7 +845,7 @@ static CURL *get_curl_handle(void)
>  		curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
>  	if (ssl_capath !=3D NULL)
>  		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
> -#if LIBCURL_VERSION_NUM >=3D 0x072c00
> +#if LIBCURL_VERSION_NUM >=3D 0x072700
>  	if (ssl_pinnedkey !=3D NULL)
>  		curl_easy_setopt(result, CURLOPT_PINNEDPUBLICKEY, ssl_pinnedkey);
>  #endif
