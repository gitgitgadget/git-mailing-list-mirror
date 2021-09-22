Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E60AC433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 22:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2343761211
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 22:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbhIVWbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 18:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238340AbhIVWbc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 18:31:32 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864E7C061756
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 15:30:01 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id w8so4320945pgf.5
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 15:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=9sMhkdsLX4+K8elsAp6LnlTuNuXzwS6ux9r7n1178OY=;
        b=G+zzWb+6pYJKy7d0BanAdDj6OIU6rShpLSqjB77Z3YzzF6eUB6Bt/yac38oiFJtwTE
         0733oVbKqea3vR/fqXjSGNyagb+p3uuPD0yLYEvfAKuD5dlms7iha1zq0Pa2at4amrqp
         jxy9jS46zy9upxj52Xi6owjYi4JrDUC/WMJvtIsDZagmEmIiW0zPL73IzLiAdYHVz7Ec
         LblFwwIxBfs9Hj3KZ/OiCKRj73HEsoF+8nRXQel/7W8FBQFxMiEgFqKw2zBWrX60svjH
         xmvHf+GvVvAl3A0ht/FINeXZ7uoN6jwLAD6HR/1dROD2rRh3Q/gW19jShwFvYsUrruEg
         EoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=9sMhkdsLX4+K8elsAp6LnlTuNuXzwS6ux9r7n1178OY=;
        b=a/q+InEmpHyVNjJKG6m9lT3KlXCAzLZ67MDuuOVQykucwZaSbTUFzoWP91Vn7M654C
         FxmXBuuvdEA9u8SvcVE1L6QGlJWD4STK82XI6Xda+oe1EllYiwevFjYDvQ70ZOmRrs+9
         20x52AaogYTrRtpVMA5lkB9ynJuzLWuRNuy5lDFB6UY78D8ciEoyUyxEZRUs4cGYk1ZQ
         tTzdoKUZL0gHiyyC0YOQSbxDEVaHhmrHEKkQZnwLULVb0Bvh1SEsMlAfJpYrpeNxhe9S
         kMwQXiaZQRgwCn/+yEb66D0p/W7rgkRXpZupOIT8gK7IQ6vTz8j5O3Gqwyf8ebWvxV+v
         cxsw==
X-Gm-Message-State: AOAM530RFVsAzhH2zVhNsMeRTK0CYNU0JGyef/IwWfke8LfWYfRePhuK
        S+rUtrIAIfvuSXHR/+8J9BOdsw==
X-Google-Smtp-Source: ABdhPJwthPln7AbY9O0vtIMXS01q/mcvUmVLZaZTc4Xs+NsL8zHub7di+FtKuAhnU3rCD2aRIY02Zw==
X-Received: by 2002:a65:6487:: with SMTP id e7mr1155480pgv.27.1632349800797;
        Wed, 22 Sep 2021 15:30:00 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3477:59f2:e961:3ce])
        by smtp.gmail.com with ESMTPSA id u12sm4507017pjr.2.2021.09.22.15.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 15:30:00 -0700 (PDT)
Date:   Wed, 22 Sep 2021 15:29:53 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v2 2/8] builtin/multi-pack-index.c: support
 `--stdin-packs` mode
Message-ID: <YUuuYW3RktlDzskH@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        gitster@pobox.com, avarab@gmail.com
References: <cover.1631331139.git.me@ttaylorr.com>
 <cover.1631730270.git.me@ttaylorr.com>
 <59556e554565120929549239f1aee5a76d80ac8d.1631730270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59556e554565120929549239f1aee5a76d80ac8d.1631730270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the series! I have a couple of questions:


On 2021.09.15 14:24, Taylor Blau wrote:
> To power a new `--write-midx` mode, `git repack` will want to write a
> multi-pack index containing a certain set of packs in the repository.
> 
> This new option will be used by `git repack` to write a MIDX which
> contains only the packs which will survive after the repack (that is, it
> will exclude any packs which are about to be deleted).
> 
> This patch effectively exposes the function implemented in the previous
> commit via the `git multi-pack-index` builtin. An alternative approach
> would have been to call that function from the `git repack` builtin
> directly, but this introduces awkward problems around closing and
> reopening the object store, so the MIDX will be written out-of-process.

Could you elaborate a bit on the "awkward problems" here? I'm afraid I'm
missing the context here.


> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index 73c0113b48..047647b5f2 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -47,6 +47,7 @@ static struct opts_multi_pack_index {
>  	const char *preferred_pack;
>  	unsigned long batch_size;
>  	unsigned flags;
> +	int stdin_packs;
>  } opts;
>  
>  static struct option common_opts[] = {
> @@ -61,6 +62,16 @@ static struct option *add_common_options(struct option *prev)
>  	return parse_options_concat(common_opts, prev);
>  }
>  
> +static void read_packs_from_stdin(struct string_list *to)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	while (strbuf_getline(&buf, stdin) != EOF)
> +		string_list_append(to, buf.buf);
> +	string_list_sort(to);
> +
> +	strbuf_release(&buf);
> +}
> +

I'm presuming that the packfile list is going to be generated
automatically, but what happens if that becomes corrupt somehow, and we
skip a packfile that should have been included? Will that cause
incorrect behavior, or will we just miss out on some of the bitmap
performance benefits?
