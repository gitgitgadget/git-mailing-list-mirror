Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE98C433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 19:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 009E76108D
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 19:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbhKFTNz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 15:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbhKFTNw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 15:13:52 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76775C061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 12:11:10 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r12so45218201edt.6
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 12:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5BPs4ggtT2A2M3Rr0sWyeDpFzESNbf+uFsGV4f8naxY=;
        b=IgEWQu8rVaquWRi4AZTutPrVFrauTLqTPVXxI2quTTJfV8HsmNtr0dh5AiTuzG3Iw0
         JYLJX5AHxpCn8s69v12i1DVpwlCVlOMkFJyCD/J3i+WiLDjc3QQcnZyUkQY7MOXC38sI
         O66VYT4VNfYme9eYAhEZO4R1Aee1GHRarS9nmlYXEpTTlZox2t1v4B8DxIGF7faSHKHI
         N2D5c9CdnZv/TU12HYi8wyDNwN5qYdpqZB4bI6ZW8OxXkFpNV8wEjS1tM/DsMBDyzOfX
         4qK2C/ClwpOZns/0BafbCFK6GIn03V5BEHTuK9+HAZnGtAoJtqHe8eyw2EB3AQ1uMy7V
         G3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5BPs4ggtT2A2M3Rr0sWyeDpFzESNbf+uFsGV4f8naxY=;
        b=pzQKx4FxwfTsG8IhGsmOHErBCbCKjM8rZlMBbxloIzoenIab/zaRFOB7IUPk2mEMhX
         xBn7jyqmnjuI1gRkHmVqui+Jt7C0xAblkdqqRnnzK2zl4oP/GB4nqMpwyYDnFC3OZy/A
         wVmMKlUi5mpU4A7BlDWFIupmNfLdmu3dACDCfYd+ff8ri9cCM2e9fvcTRXN3YBLXbhQA
         Kqb+aVrwXMNnApMoEt612v3Qcsqbb/TMZAXMpaDXgSIFatseKYo1b1gdDpNVi6lb/wtz
         Aszb0QQmQ2/X/1ootvShgvzU2ldqJ0ueJ5UJNbrGIr8zZKC8ZbBVBh1b83rte/xypRST
         wcHA==
X-Gm-Message-State: AOAM532uHUA36EExswc2ohi/rx5Tx6dAxX39NJNZq4zmjqJNUKo2JgMu
        bAnS2dAeEu4a7nAdo58EPYg=
X-Google-Smtp-Source: ABdhPJyvIXuABEIu09m9CdJ5hDKBZkPGRqEjrdO8QA0v2eesXiyH+7FTEV0fYdtudhTz+8xoquQXaA==
X-Received: by 2002:a17:906:c015:: with SMTP id e21mr84501008ejz.113.1636225868640;
        Sat, 06 Nov 2021 12:11:08 -0700 (PDT)
Received: from szeder.dev (94-21-58-56.pool.digikabel.hu. [94.21.58.56])
        by smtp.gmail.com with ESMTPSA id g21sm6667824edw.86.2021.11.06.12.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 12:11:08 -0700 (PDT)
Date:   Sat, 6 Nov 2021 20:11:03 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 03/10] parse-options.[ch]: consistently use "enum
 parse_opt_result"
Message-ID: <20211106191103.GA5811@szeder.dev>
References: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
 <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
 <patch-v3-03.10-828e8b96574-20211008T190536Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-03.10-828e8b96574-20211008T190536Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 08, 2021 at 09:07:39PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Use the "enum parse_opt_result" instead of an "int flags" as the
> return value of the applicable functions in parse-options.c.
> 
> This will help catch future bugs, such as the missing "case" arms in
> the two existing users of the API in "blame.c" and "shortlog.c". A
> third caller in 309be813c9b (update-index: migrate to parse-options
> API, 2010-12-01) was already checking for these.
> 
> As can be seen when trying to sort through the deluge of warnings
> produced when compiling this with CC=g++ (mostly unrelated to this
> change) we're not consistently using "enum parse_opt_result" even now,
> i.e. we'll return error() and "return 0;". See f41179f16ba
> (parse-options: avoid magic return codes, 2019-01-27) for a commit
> which started changing some of that.
> 
> I'm not doing any more of that exhaustive migration here, and it's
> probably not worthwhile past the point of being able to check "enum
> parse_opt_result" in switch().
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---

> diff --git a/parse-options.c b/parse-options.c
> index 9c8ba963400..f718242096c 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -699,13 +699,14 @@ static void free_preprocessed_options(struct option *options)
>  	free(options);
>  }
>  
> -static int usage_with_options_internal(struct parse_opt_ctx_t *,
> -				       const char * const *,
> -				       const struct option *, int, int);
> -
> -int parse_options_step(struct parse_opt_ctx_t *ctx,
> -		       const struct option *options,
> -		       const char * const usagestr[])
> +static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t *,
> +							 const char * const *,
> +							 const struct option *,
> +							 int, int);
> +
> +enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
> +					 const struct option *options,
> +					 const char * const usagestr[])
>  {
>  	int internal_help = !(ctx->flags & PARSE_OPT_NO_INTERNAL_HELP);
>  
> @@ -839,10 +840,11 @@ int parse_options_end(struct parse_opt_ctx_t *ctx)
>  	return ctx->cpidx + ctx->argc;
>  }
>  
> -int parse_options(int argc, const char **argv, const char *prefix,
> -		  const struct option *options,
> -		  const char * const usagestr[],
> -		  enum parse_opt_flags flags)
> +enum parse_opt_result parse_options(int argc, const char **argv,

The return type of this function should have been left unchanged,
because it contains only one return statement:

          return parse_options_end(&ctx);

and parse_options_end() does return an int.

