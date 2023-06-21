Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485B2EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 11:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjFULFO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 07:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjFULFL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 07:05:11 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3869A122
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 04:05:09 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bacf685150cso5597892276.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 04:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687345508; x=1689937508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u2qndgyiV5juD7Gb977P81WKTcADI1Q2HxFrjrS+ZMk=;
        b=SerQKKdQFMIqO9OzrvApq1EYelihQngAZM0AXDpPhJ+l939q0zuLmUtE95X0L/oWHM
         RX0/J+KJGX/0ehTJ094beRGtqgw9hwxuTNTC/u3KSdGEzx0dDwSAOiHU9xZwtvcrXWAD
         XDXhrHc6NskTPWmjSv2nloeFZEfOjqaxOE/rZ2ejijtBOl8nHpg1ggv6onDR4RKIocqk
         7tkEKFKSfGC+c4iIoy6O3kEkF1Ly1G2J1LBDTt5DxWQttl09zN3Wif+uoW/5uDk6SgbI
         fAMSLYxyUMc5Tv8scB5vih/Ph5cSkFs/LhPptmEisnq4B32Ml8Iil3wunI4r1WSozRGB
         napQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687345508; x=1689937508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2qndgyiV5juD7Gb977P81WKTcADI1Q2HxFrjrS+ZMk=;
        b=TNyMxv7YUJACiPmURIGysJKrQGFaEnLGJsK/DLbbfngFP3nVtDg4J2gEy8HnhmWR9z
         bTjLZ9K5OiK/wOCM7AXHFQjwNPGd4eViYKnvGsv+Up8gUWkvdmE0XBC9qLk+67t7up2Y
         dEIAxSEJn1WWm+eYgMK4gTG68YhyGDlMUnyv+t1cIDxvmg1h9w5VrhxaYXlgHaxlEFjL
         q/jyGEK6wP6f6cj94cxxc7LJp9JbOfjiFtxfjWKZtZv+SAYgQpa25VoQvIntWNy6CUYT
         LGeUtQu5u16NAT5vTPTC227hPUrBSbVOd1RHSKnsQ0l2RjDMjjqYXphFBA5YkTL8EJ8h
         9fGA==
X-Gm-Message-State: AC+VfDxPQr+urKhocfNdtUEnJdturvT0xfWNa3+ugok4R/AEazGa8LrL
        vGqgNgsO9U3I1vn3eNztVLQhsIT6s54bM8i1gNHw1e8o
X-Google-Smtp-Source: ACHHUZ7fJKcGs/RJz+S7bVpuTLXRzVwSrS3OXyzrdqxTEMFyvlfsVT1fxXQbXfYxj1L3mEtMCzioYw==
X-Received: by 2002:a0d:d7cf:0:b0:561:3fb7:1333 with SMTP id z198-20020a0dd7cf000000b005613fb71333mr17351856ywd.43.1687345508313;
        Wed, 21 Jun 2023 04:05:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k127-20020a816f85000000b00565a78b7938sm1024032ywc.146.2023.06.21.04.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 04:05:07 -0700 (PDT)
Date:   Wed, 21 Jun 2023 07:05:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 5/9] repack: refactor finishing pack-objects command
Message-ID: <ZJLZYNCQ2ApwePAz@nand.local>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-6-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230614192541.1599256-6-christian.couder@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/builtin/repack.c b/builtin/repack.c
> index e591c295cf..f1adacf1d0 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -703,6 +703,42 @@ static void remove_redundant_bitmaps(struct string_list *include,
>  	strbuf_release(&path);
>  }
>
> +static int finish_pack_objects_cmd(struct child_process *cmd,
> +				   struct string_list *names,
> +				   const char *destination)
> +{
> +	int local = 1;
> +	FILE *out;
> +	struct strbuf line = STRBUF_INIT;
> +
> +	if (destination) {
> +		const char *scratch;

Maybe stick the declaration above (and consider making it static), so
that this can become

    if (destination)
      local = skip_prefix(destination, packdir, &scratch);

without the braces. Although it might be nice to either put this behind
a "has_prefix()" convenience function (which itself owns the scratch
buffer and hides that detail from the caller), or to make skip_prefix
skip trying to assign into the buffer if given NULL.

> +		local = skip_prefix(destination, packdir, &scratch);
> +	}
> +
> +	out = xfdopen(cmd->out, "r");
> +	while (strbuf_getline_lf(&line, out) != EOF) {
> +		struct string_list_item *item;
> +
> +		if (line.len != the_hash_algo->hexsz)
> +			die(_("repack: Expecting full hex object ID lines only "
> +			      "from pack-objects."));
> +		/*
> +		 * Avoid putting packs written outside of the repository in the
> +		 * list of names.
> +		 */
> +		if (local) {

Consider moving the declaration of item into this block, since it's not
used elsewhere throughout the body of the loop.

Alternatively, if you want to leave it up there, it might be easier to
adjust the if condition to be more in line with the comment, like:

    if (!local)
      continue;

> +	ret = finish_pack_objects_cmd(&cmd, &names, NULL);

OK, we don't even bother calling skip_prefix if given a NULL
destination. I wonder if it might make sense to force the caller to
compute "is this local?" ahead of time. This one would always pass "1"
trivially, and the cruft case would depend on whether or not we are
handling the `--expire-to` option.

Thanks,
Taylor
