Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 619F11F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 17:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbfHORLZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 13:11:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57938 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731299AbfHORLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 13:11:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1FD8E72F1C;
        Thu, 15 Aug 2019 13:11:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JHYUlJ7h8SvB
        NhznqxvEC/B5mDs=; b=B37QkOW1V5szSSTTygzTRiqsbH3bNVthTLADuIFCaFMI
        licAD8Rq4k6805Pxpbzf8geQW0aQuusjf7HY6RHsVCzmAeSJtoYxOn70wM8MfAqi
        SVquGmXMcC/wCTt/Srbem2z25snp/jQpCd8HRuqDDz3Ha8+Rir5dez9dQJpxsl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kpSNgG
        yzDl5TO5ReZ6VxkFF/Ei/WpI2gGcMf6RHRvtiYOuhxQHUraKROAV2g0EDkknw5Io
        Ywkn7oRI1/7QLYN5X4htZotbDur4gJ0Vs8ulUQbwralorh5euxAirbVPiUe8+Pnw
        YLVAdxBwtKqtPYby0m0Z7FSReBmrN6X6QmhyI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 167F872F1A;
        Thu, 15 Aug 2019 13:11:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C3CD772F0E;
        Thu, 15 Aug 2019 13:11:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, daniel@haxx.se,
        peff@peff.net
Subject: Re: [PATCH] http: use xmalloc with cURL
References: <20190815153504.23199-1-carenas@gmail.com>
Date:   Thu, 15 Aug 2019 10:11:17 -0700
In-Reply-To: <20190815153504.23199-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 15 Aug 2019 08:35:04 -0700")
Message-ID: <xmqq5zmy4ami.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B31BDC66-BF7F-11E9-AED2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> f0ed8226c9 (Add custom memory allocator to MinGW and MacOS builds, 2009=
-05-31)
> never told cURL about it.
>
> Correct that by using the cURL initializer available since version 7.12=
 to
> point to xmalloc and friends for consistency which then will pass the
> allocation requests along when USE_NED_ALLOCATOR=3DYesPlease is used (m=
ost
> likely in Windows)
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
> This doesn't conflict with anything and was originally based on maint (=
so it
> applies cleanly also to master and next), but is now rebased on top of
> jk/drop-release-pack-memory so the final product wouldn't have any chan=
ce to
> introduce problems (thanks Peff)
>
> it has been built and tested in Windows through Azure Pipelines (thanks=
 Dscho)
> and shouldn't introduce any build problems even with ancient versions o=
r cURL
> (thanks Daniel) and while not strictly needed is a nice thing to have f=
or
> consistency (thanks Junio)

Thanks, all.  I do not think I did anything that deserves a
"thanks", but anyway.
>  http.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/http.h b/http.h
> index b429f1cf04..e5f075dcbf 100644
> --- a/http.h
> +++ b/http.h
> @@ -22,9 +22,15 @@
>  #define DEFAULT_MAX_REQUESTS 5
>  #endif
> =20
> +#if LIBCURL_VERSION_NUM >=3D 0x070c00
> +#define curl_global_init(a) curl_global_init_mem(a, xmalloc, free, \
> +						xrealloc, xstrdup, xcalloc)
> +#endif
> +
>  #if LIBCURL_VERSION_NUM < 0x070704
>  #define curl_global_cleanup() do { /* nothing */ } while (0)
>  #endif
> +
>  #if LIBCURL_VERSION_NUM < 0x070800
>  #define curl_global_init(a) do { /* nothing */ } while (0)
>  #endif

The earlier version had definitions pertaining to curl_global_init()
at a single place, but the above version allows arbitrary amount of
unrelated stuff to be placed in between two definitions in future
updates.  Is that a good idea?  I sort of expected "we always call
global_init(), but if curl is old enough to lack it, define it as
empty, and if curl is new enough to have curl_global_init_mem(),
then call it instead" #if/#else/#if/#endif/#endif cascade.

>
> base-commit: 9827d4c185e4da728f51cd77c54a38c9de62495f
