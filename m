Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E239DC63682
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 23:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbiAYXVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 18:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbiAYXVw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 18:21:52 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4230FC06161C
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 15:21:51 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id e79so25598189iof.13
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 15:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zBPdeMz0odKsK6uqfGUwABYL/eobpZoBn3ND4y0WLIs=;
        b=ra+iFPxd5nXQvZKkmJt6LkajdYXnGg2ZXAaQA7qSP15Rr3yMLDQRuv2aEUQzJIxV8e
         z4tlCKdwRB+SHGcinoYiK7YfWtzKDi00AibrQaFBLETEQkcV30FsId3MtNc4i2uRA/M4
         rK5+WvQWCdr5aLi9vKFbB6LuCEub+N3Gk3CyRqO2xGSJ0uugJI/Me4zQx0w5fvesGMUd
         dxBecfOAd+wKVZ4io//DrzLSFvN6DIOXqDr4I3Aq82vthK27kNXtjo/NO039ytJLXeDf
         Bh2Lo7dYkb4io6r9WURDa+Zz4DC7cIZbNMZpTMqXHCNJv/tv1VVp1St2RIyr3drL80DU
         XURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zBPdeMz0odKsK6uqfGUwABYL/eobpZoBn3ND4y0WLIs=;
        b=Fq5RgFXZn11vivaMMNVH1tib1MPojd5IIdj4XFxGSZz/6R2BBEkoLBpiBOHFZU5ysr
         UKKvsgr1tG+DgsM6hHbZN0n+cZeV1ZsHTnQY1J6fyM96pm1QuQ8MflgTnDdRLk4/KtMV
         +ZzNVvoHD1qX+xTIJLnwogPUiy6wJB++UpmhISFnG01S/44DlTZ5+rNIBGcxj9livBIJ
         Hvqk9vijFu3IfEvs3Tf5YXScg/Zr2btdOVqgJnvZDDXlQUomsljS7LMN7dR0CnYXWl94
         hzWCK0lVZ2QCo7rieEUBxgywcyYHZzrSfteYuG0fitaLbKqOvoNqHm+VhjqwK+Q1xO2R
         UqkQ==
X-Gm-Message-State: AOAM533JlC4QrfhRAr4vZfwGALIgcx8TrGqauG5aF1gh3Kvh64L6WwQY
        BraRUkl8oE0OKL52OdnjMr73bD60ZVWqNA==
X-Google-Smtp-Source: ABdhPJzX8EZLJtLaGNBMibJwUOR5FVy8I2Z2OPAZA0nznZFE0bj8F0H5gZ0fw2is7FUZ/Tj85HZwag==
X-Received: by 2002:a5e:9316:: with SMTP id k22mr3200273iom.18.1643152910565;
        Tue, 25 Jan 2022 15:21:50 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k14sm10025941ilv.74.2022.01.25.15.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 15:21:50 -0800 (PST)
Date:   Tue, 25 Jan 2022 18:21:49 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] diff-filter: be more careful when looking for
 negative bits
Message-ID: <YfCGDY5qXPCFXpfp@nand.local>
References: <pull.1127.git.1643149759.gitgitgadget@gmail.com>
 <e8006493a9ed4da9b9125865e004ba7ace20e7a4.1643149759.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e8006493a9ed4da9b9125865e004ba7ace20e7a4.1643149759.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 25, 2022 at 10:29:19PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/diff.c b/diff.c
> index c862771a589..fc1151b9c73 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4821,17 +4821,15 @@ static int diff_opt_diff_filter(const struct option *option,
>  	prepare_filter_bits();
>
>  	/*
> -	 * If there is a negation e.g. 'd' in the input, and we haven't
> +	 * If the input starts with a negation e.g. 'd', and we haven't
>  	 * initialized the filter field with another --diff-filter, start
>  	 * from full set of bits, except for AON.
>  	 */
>  	if (!opt->filter) {
> -		for (i = 0; (optch = optarg[i]) != '\0'; i++) {
> -			if (optch < 'a' || 'z' < optch)
> -				continue;
> +		optch = optarg[0];
> +		if (optch >= 'a' && 'z' >= optch) {
>  			opt->filter = (1 << (ARRAY_SIZE(diff_status_letters) - 1)) - 1;
>  			opt->filter &= ~filter_bit[DIFF_STATUS_FILTER_AON];
> -			break;
>  		}
>  	}

Thinking through how this would have worked before with
`--diff-filter=Dr`, I think it goes something like:

  1. We set all bits (except the all-or-none bit) on via the first loop.
  2. Then we OR in the bit for deletions, which does not change the
     overall filter (since it was already set by the previous step).
  3. Then we unset the bit corresponding to renames.

That leaves us with all bits on except two: DIFF_STATUS_RENAMED and
DIFF_STATUS_FILTER_AON.

As far as I can understand, the AON "filter" shows all files as long as
at least one of them matches the filter, otherwise it shows nothing at
all.

But that doesn't save us, since we have many more bits on than we should
have, meaning that `--diff-filter=Dr` doesn't work at all (assuming you
expected it to show just deletions, like `--diff-filter=D` does).

It's possible that I don't understand what the all-or-nothing bit is
supposed to be doing, though.

Thanks,
Taylor
