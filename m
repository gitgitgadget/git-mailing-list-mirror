Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2040C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 21:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A8D022B3F
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 21:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="PSgPVxXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgGaVal (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 17:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbgGaVal (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 17:30:41 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1741FC061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 14:30:41 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id l13so8436425qvt.10
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 14:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pFR/us4GTWXsRnx75BAx8h/hHXJLtqVl9TRsdMqrnnM=;
        b=PSgPVxXHsXMV635pFEvVKDHy1M79HYFi+ZhOEQiKtGBrvzLqZW8WkEn3in0/4vo4Ak
         Wr7TbqVf8WBmec00Fy5+YuN4UU5NyxeLj2w8aE/324TdFQMG4xSPMcIdP/KfGwzf/njr
         HD58Vuno5exYU2TgA0RXT0JcYW2QQId+wPC6RLI+Cu3VuyaknMMhP4AtzEEBAMkIOsdo
         4pgcO9TBMKl9VCVuW6qtXBWO8n9L68ZYv0tcUN7xbiO6XhN+dTrzDzgong025SVRxI3N
         tpw/x6djQ7/USDbXhEAAj5/3aqh1tNp216r3nhTtXam/9l+cBhhnVA0N9Az8Nx17VgcY
         kzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pFR/us4GTWXsRnx75BAx8h/hHXJLtqVl9TRsdMqrnnM=;
        b=peAU987/dc3mxwWTqwRFnAZo80gRiEbQV6hDQ9HqUsYdTqx4XB7blQgtSJYo8BO/Em
         h/gNebgxVpMAOmAKH+5VV07UBDT8nWmvRpLlQS6Zjn2wao6eeIqM0RJOYwOqxuP5Yn3+
         crREQyEoV5Rh/RfkSsab1Ue4x3V7IE1qR0aS0pE887O6qqSlqqxzsbx5UVM8nGdqCMqG
         EjzA6IJLX/8nPAcxcM2QzF9sztavRthFrYlfQsdGYlJHv1ls6PXKfAMkTRZndmp1f+ni
         RoS4GG7X3V/Ao1RvwdhLgKnKvYdMaBQGBcgsThj39bAVmsmOBOzevpMk+jtBuOIFGdXG
         Fxhw==
X-Gm-Message-State: AOAM531V+TnZWoqNnX71c/Tcqo3jfywTRMFw1v74s3LBZVOgGn2YvbeZ
        5Qfz2nYJSWXCzJigshPQzNUdKyI93rwGYw==
X-Google-Smtp-Source: ABdhPJwn9PZ9fLMk/Y4aIEQBaqtpyIZId+ozS05GlHSsydQhtERRerFRNTHyiyOe1BRdCJLoD9PKOg==
X-Received: by 2002:ad4:54c6:: with SMTP id j6mr6158140qvx.126.1596231040186;
        Fri, 31 Jul 2020 14:30:40 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1861:1305:b592:e057])
        by smtp.gmail.com with ESMTPSA id x7sm9022573qkn.53.2020.07.31.14.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 14:30:39 -0700 (PDT)
Date:   Fri, 31 Jul 2020 17:30:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        chriscool@tuxfamily.org, gitster@pobox.com, szeder.dev@gmail.com
Subject: Re: [PATCH v3 4/4] upload-pack.c: introduce
 'uploadpackfilter.tree.maxDepth'
Message-ID: <20200731213038.GF3409@syl.lan>
References: <cover.1595468657.git.me@ttaylorr.com>
 <cover.1596227003.git.me@ttaylorr.com>
 <c9d71809f49dc1b600b75769e0b6aae17382bf4e.1596227003.git.me@ttaylorr.com>
 <20200731210114.GC1440890@coredump.intra.peff.net>
 <20200731212243.GA1443086@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200731212243.GA1443086@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 05:22:43PM -0400, Jeff King wrote:
> On Fri, Jul 31, 2020 at 05:01:14PM -0400, Jeff King wrote:
>
> > Hmm. So I see now why you wanted to go with the strbuf in the earlier
> > patch. This does still feel awkward, though. You check "is it allowed"
> > in an earlier function, we get "nope, it's not allowed", and now we have
> > to reimplement the check here. That seems like a maintenance burden.
> >
> > I think a more natural flow would be either:
> >
> >   - the "is it allowed" functions calls immediately into the function
> >     that sends the error and dies (this might need a conditional if
> >     there's a caller who doesn't want to die; I didn't check)
> >
> > or
> >
> >   - on failure it populates an error buffer itself, which the caller can
> >     then pass along as it sees fit
>
> The first one is easy to do, because there's no other caller. Worth it?
>
> -- >8 --
> diff --git a/upload-pack.c b/upload-pack.c
> index 131445b212..574a447d5c 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -992,62 +992,63 @@ static int process_deepen_not(const char *line, struct string_list *deepen_not,
>  	return 0;
>  }
>
> -static int allows_filter_choice(struct upload_pack_data *data,
> -				struct list_objects_filter_options *opts)
> +/* probably this helper could be used in lots more places */
> +NORETURN __attribute__((format(printf,2,3)))
> +static void send_err_and_die(struct upload_pack_data *data,
> +			     const char *fmt, ...)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	va_list ap;
> +
> +	/* yuck, buf not necessary if we had va_list versions of our helpers */
> +	va_start(ap, fmt);
> +	strbuf_vaddf(&buf, fmt, ap);
> +	va_end(ap);
> +
> +	packet_writer_error(&data->writer, "%s", buf.buf);
> +	die("%s", buf.buf);
> +}
> +
> +static void check_one_filter(struct upload_pack_data *data,
> +			     struct list_objects_filter_options *opts)
>  {
>  	const char *key = list_object_filter_config_name(opts->choice);
>  	struct string_list_item *item = string_list_lookup(&data->allowed_filters,
>  							   key);
> -	int allowed = -1;
> +	int allowed;
>  	if (item)
>  		allowed = (intptr_t) item->util;
> +	else
> +		allowed = data->allow_filter_fallback;
>
> -	if (allowed != 0 &&
> -	    opts->choice == LOFC_TREE_DEPTH &&
> -	    opts->tree_exclude_depth > data->tree_filter_max_depth)
> -		return 0;
> +	if (!allowed)
> +		send_err_and_die(data, "filter '%s' not supported",
> +				 list_object_filter_config_name(opts->choice));
>
> -	if (allowed > -1)
> -		return allowed;
> -	return data->allow_filter_fallback;
> +	if (opts->choice == LOFC_TREE_DEPTH &&
> +	    opts->tree_exclude_depth > data->tree_filter_max_depth)
> +		send_err_and_die(data,
> +				 "tree filter allows max depth %lu, but got %lu",
> +				 data->tree_filter_max_depth,
> +				 opts->tree_exclude_depth);
>  }
>
> -static struct list_objects_filter_options *banned_filter(
> -	struct upload_pack_data *data,
> -	struct list_objects_filter_options *opts)
> +static void check_filter_recurse(struct upload_pack_data *data,
> +				 struct list_objects_filter_options *opts)
>  {
>  	size_t i;
>
> -	if (!allows_filter_choice(data, opts))
> -		return opts;
> +	check_one_filter(data, opts);
>
>  	if (opts->choice == LOFC_COMBINE)
>  		for (i = 0; i < opts->sub_nr; i++) {
> -			struct list_objects_filter_options *sub = &opts->sub[i];
> -			if (banned_filter(data, sub))
> -				return sub;
> +			check_filter_recurse(data, &opts->sub[i]);
>  		}
> -	return NULL;
>  }
>
>  static void die_if_using_banned_filter(struct upload_pack_data *data)
>  {
> -	struct list_objects_filter_options *banned = banned_filter(data,
> -								   &data->filter_options);
> -	struct strbuf buf = STRBUF_INIT;
> -	if (!banned)
> -		return;
> -
> -	strbuf_addf(&buf, "git upload-pack: filter '%s' not supported",
> -		    list_object_filter_config_name(banned->choice));
> -	if (banned->choice == LOFC_TREE_DEPTH &&
> -	    data->tree_filter_max_depth != ULONG_MAX)
> -		strbuf_addf(&buf, _(" (maximum depth: %lu, but got: %lu)"),
> -			    data->tree_filter_max_depth,
> -			    banned->tree_exclude_depth);
> -
> -	packet_writer_error(&data->writer, "%s\n", buf.buf);
> -	die("%s", buf.buf);
> +	check_filter_recurse(data, &data->filter_options);
>  }
>
>  static void receive_needs(struct upload_pack_data *data,

I think that we crossed emails, but I'm still not convinced that this is
any cleaner than what I wrote. Yes, it's a maintenance problem if we add
more filter-specific logic like what we have in the LOFC_TREE_DEPTH
case, but I feel like we're bending over backwards in the meantime to
accommodate a problem that we don't have.

Thanks,
Taylor
