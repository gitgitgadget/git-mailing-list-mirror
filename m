Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B472FC43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 23:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbiFHXcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 19:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiFHXcL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 19:32:11 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9130227FF8
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 16:32:09 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E567F130475;
        Wed,  8 Jun 2022 19:32:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/uv9aYaG2DQkUAtdbS9NMdGaBkHB2O9pCentqZ
        k02oI=; b=KHVd3H6vJYN63lUp2oBQINEMxgVDJTgvsRA8a8AFWK64xqGnYORCbo
        RZXGVb56jE7cRPaYGd7dhsEQnem4HEhmqTE/kaz1+OKoKeOmz8geMIy0JbHd4J+o
        VJytHZpuvQKnC8owFIMmzbaU06eIgNusvlL4+XqIvj2nfegrxcDVQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB4CD130474;
        Wed,  8 Jun 2022 19:32:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2BDB4130473;
        Wed,  8 Jun 2022 19:32:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH] remote-curl: send Accept-Language header to server
References: <pull.1251.git.1654678407365.gitgitgadget@gmail.com>
Date:   Wed, 08 Jun 2022 16:32:06 -0700
In-Reply-To: <pull.1251.git.1654678407365.gitgitgadget@gmail.com> (Li Linchao
        via GitGitGadget's message of "Wed, 08 Jun 2022 08:53:27 +0000")
Message-ID: <xmqqa6amohop.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3677B12E-E783-11EC-91BE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Li Linchao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Cactusinhand <lilinchao@oschina.cn>

Huh? 

> Git server end's ability to accept Accept-Language header was introduced
> in f18604bbf2(http: add Accept-Language header if possible), but this is
> only used by very early phase of the transfer, that's HTTP GET request to
> discover references. For other phases, like POST request in the smart HTTP
> the server side don't know what language client speak.

"client speak" -> "the client speaks".

> This patch teaches git client to learn end-user's preferred language and

"This patch teaches" -> "Teach"

> throw accept-language header to server side. Once server get this header

"server side" -> "the server side".
"server get" -> "the server gets"
"header" -> "header,"

> it have ability to talk to end-user with language they understand, this

"it have ability" -> "it has the ability"

", this" -> ". This"

> would be very helpful for many non-English speakers.
>
> Signed-off-by: Li Linchao <lilinchao@oschina.cn>

> diff --git a/http.c b/http.c
> index 11c6f69facd..0654e111d1d 100644
> --- a/http.c
> +++ b/http.c
> @@ -1775,7 +1775,7 @@ static void write_accept_language(struct strbuf *buf)
>   *   LANGUAGE= LANG=en_US.UTF-8 -> "Accept-Language: en-US, *; q=0.1"
>   *   LANGUAGE= LANG=C -> ""
>   */
> -static const char *get_accept_language(void)
> +const char *get_accept_language(void)

It was an understandable name for a file-scope static function, but
is this name suitable to be a global without making it more narrow
and specific to "HTTP" and "Header"?

> diff --git a/remote-curl.c b/remote-curl.c
> index 67f178b1120..8acf506705c 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -1400,7 +1412,7 @@ static int stateless_connect(const char *service_name)
>  	struct discovery *discover;
>  	struct rpc_state rpc;
>  	struct strbuf buf = STRBUF_INIT;
> -
> +	const char *accept_language;

Do not lose the blank line after the block with variable
declarations.  IOW, the patch around this line should read like this
instead:

>  	struct discovery *discover;
>  	struct rpc_state rpc;
>  	struct strbuf buf = STRBUF_INIT;
> +	const char *accept_language;
>
>  	/*
>  	 * Run the info/refs request and see if the server supports protocol


> @@ -1418,6 +1430,10 @@ static int stateless_connect(const char *service_name)
>  		printf("\n");
>  		fflush(stdout);
>  	}
> +	accept_language = get_accept_language();
> +	if (accept_language) {
> +		rpc.hdr_accept_language = xstrfmt("%s", accept_language);
> +	}

Drop {} around a single-statement block.

> +	cat >exp <<-\EOF &&
> +	=> Send header: Accept-Language: zh-CN, en;q=0.9, *;q=0.8
> +	=> Send header: Accept-Language: zh-CN, en;q=0.9, *;q=0.8
> +	EOF
> +
> +	cd "$ROOT_PATH"/test_repo_clone &&
> +	: >path_lang &&
> +	git add path_lang &&
> +	test_tick &&
> +	git commit -m path_lang &&
> +	HEAD=$(git rev-parse --verify HEAD) &&
> +	GIT_TRACE_CURL=true LANGUAGE="zh_CN:en" git push -v -v 2>err &&

A few comments.

 * In all gettext/locale tests we seem to set both LANGUAGE and
   LC_ALL environment variables.  Shouldn't we do the same for
   consistency?

 * In existing tests, we seem to use ko_KR, en_US, ja_JP, and random
   assortment of languages (e.g. t5550).  Can we safely add any new
   languages to the mix without any downside to the tester?  We
   should reuse what we already use, especially if this ends up
   forcing users and testers to install yet another "language pack"
   for zh_CN.

Thanks.
