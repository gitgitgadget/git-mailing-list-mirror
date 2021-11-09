Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A0AC433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 17:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A4561208
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 17:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbhKIRsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 12:48:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54246 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241247AbhKIRsE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 12:48:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74D26F6E18;
        Tue,  9 Nov 2021 12:45:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JzyNSWK5TZqK
        ppUUYoR5DfItGyKIpnQAcxadlDJV9Q4=; b=oRhGOn6ieUb6TNcWZQpBEhPxVz+C
        YZQsfppMIS7kd7cDVV2sF3qB3WXZFYGWmapvEZ69yhbG5dmtKMRtXeadtKjQHDVr
        KNh6CQEJAqzshm2nEwupYRpeuhT1hB7m8G3d0h/1sHKcgG6qzAzWyPnSGwN7LKJx
        RkKm6jKqYKy1ELs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C1FAF6E17;
        Tue,  9 Nov 2021 12:45:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CACC7F6E16;
        Tue,  9 Nov 2021 12:45:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/2] parse-options.[ch]: revert use of "enum" for
 parse_options()
References: <211106.86lf21ezqx.gmgdl@evledraar.gmail.com>
        <cover-0.2-00000000000-20211109T110113Z-avarab@gmail.com>
        <patch-1.2-057a9f81b47-20211109T110113Z-avarab@gmail.com>
Date:   Tue, 09 Nov 2021 09:45:15 -0800
In-Reply-To: <patch-1.2-057a9f81b47-20211109T110113Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 9 Nov
 2021 12:04:43 +0100")
Message-ID: <xmqqsfw52pg4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CCC30642-4184-11EC-B897-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Revert the parse_options() prototype change in my recent
> 352e761388b (parse-options.[ch]: consistently use "enum
> parse_opt_result", 2021-10-08) was incorrect. The parse_options()
> function returns the number of argc elements that haven't been
> processed, not "enum parse_opt_result".
>
> Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  parse-options.c | 10 +++++-----
>  parse-options.h |  9 ++++-----
>  2 files changed, 9 insertions(+), 10 deletions(-)

Yes, this makes total sense.  We went overboard during the series.

> diff --git a/parse-options.c b/parse-options.c
> index 9a0484c8831..fc5b43ff0b2 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -860,11 +860,11 @@ int parse_options_end(struct parse_opt_ctx_t *ctx=
)
>  	return ctx->cpidx + ctx->argc;
>  }
> =20
> -enum parse_opt_result parse_options(int argc, const char **argv,
> -				    const char *prefix,
> -				    const struct option *options,
> -				    const char * const usagestr[],
> -				    enum parse_opt_flags flags)
> +int parse_options(int argc, const char **argv,
> +		  const char *prefix,
> +		  const struct option *options,
> +		  const char * const usagestr[],
> +		  enum parse_opt_flags flags)
>  {
>  	struct parse_opt_ctx_t ctx;
>  	struct option *real_options;
> diff --git a/parse-options.h b/parse-options.h
> index bdea052c399..275fb440818 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -213,11 +213,10 @@ struct option {
>   * untouched and parse_options() returns the number of options
>   * processed.
>   */
> -enum parse_opt_result parse_options(int argc, const char **argv,
> -				    const char *prefix,
> -				    const struct option *options,
> -				    const char * const usagestr[],
> -				    enum parse_opt_flags flags);
> +int parse_options(int argc, const char **argv, const char *prefix,
> +		  const struct option *options,
> +		  const char * const usagestr[],
> +		  enum parse_opt_flags flags);
> =20
>  NORETURN void usage_with_options(const char * const *usagestr,
>  				 const struct option *options);
