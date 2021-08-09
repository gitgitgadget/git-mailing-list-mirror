Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4C5C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 15:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC1B61019
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 15:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbhHIPyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 11:54:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58492 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbhHIPyA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 11:54:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9BEFF143830;
        Mon,  9 Aug 2021 11:53:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=x7Yq4+Zq1f5K
        Z9j6IwGMEdA+bqvZJZ7AuO7+XaLzXw8=; b=x5MkZSgetx3wZVE0BE4jG11KUtX2
        rT9xDVT6hAUzwW26Ro3d5LPj72ERwQwGapTRCVpLRRSNe4wRonCMnWyfb3KEA4Jd
        BYiGIhBHDMVgLcgoBHwLbHzDlzFOjQiRHtfYM6Q6xgSrkqKx1+YDGQ78FF1rQSUZ
        FoX/D5sU2Sffcm0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 94EAD14382D;
        Mon,  9 Aug 2021 11:53:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E0115143826;
        Mon,  9 Aug 2021 11:53:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, e@80x24.org
Subject: Re: [PATCH/RFC 2/3] object-store: avoid extra ';' from KHASH_INIT
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
        <20210809013833.58110-1-carenas@gmail.com>
        <20210809013833.58110-3-carenas@gmail.com>
Date:   Mon, 09 Aug 2021 08:53:35 -0700
In-Reply-To: <20210809013833.58110-3-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 8 Aug 2021 18:38:32 -0700")
Message-ID: <xmqq1r72haww.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F54C5D8C-F929-11EB-AD46-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> cf2dc1c238 (speed up alt_odb_usable() with many alternates, 2021-07-07)
> introduces a KHASH_INIT invocation with a trailing ';', which while
> commonly expected will trigger warnings with pedantic on both
> clang[-Wextra-semi] and gcc[-Wpedantic], because that macro has already
> a semicolon and is meant to be invoked without one.
>
> while fixing the macro would be a worthy solution (specially considerin=
g
> this is a common recurring problem), remove the extra ';' for now to
> minimize churn.

Thanks.  I fully agree with the reasoning.

>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  object-store.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/object-store.h b/object-store.h
> index e679acc4c3..d24915ced1 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -34,7 +34,7 @@ struct object_directory {
>  };
> =20
>  KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
> -	struct object_directory *, 1, fspathhash, fspatheq);
> +	struct object_directory *, 1, fspathhash, fspatheq)
> =20
>  void prepare_alt_odb(struct repository *r);
>  char *compute_alternate_path(const char *path, struct strbuf *err);
