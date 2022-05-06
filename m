Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A24C433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 03:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343785AbiEFDH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 23:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiEFDH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 23:07:26 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5A363BC8
        for <git@vger.kernel.org>; Thu,  5 May 2022 20:03:45 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id o18so5041897qtk.7
        for <git@vger.kernel.org>; Thu, 05 May 2022 20:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TrtAV+W6NsY1tXDIfHOFImtltgelki9ANT9vuo7ALR8=;
        b=LLXyjlmD5zav/6c/4/LDAzn9NBxjz4oi1P/fWOLg+78nDtlpIPvXo3s3OxFTk+ymui
         KFP8rxNi8ol370m4gqmprF/TgIgyOOnK4kiak1MydDdcw+NzBKBb4TV34BL5rj+KvtZf
         4aUaVNT2OHO+wKQYj0lvjUYRRK4btf0UNynzvAESfjsst+qPVdzvGzxv0MZRn+e/CSt0
         RpTHmGK3L5IRPFtz4wZ/UASE5HFIC0957MOX8vl+gjMFd3sa425zAYc5hQ4Gvg+Kt3Lw
         RFO2qycLBWf1SRLBbGvshy6d16O2VOy6pMSbO9BzcecrfI/3RaJvAEGUwHMEufY/t7RQ
         bsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TrtAV+W6NsY1tXDIfHOFImtltgelki9ANT9vuo7ALR8=;
        b=zP7tsxilFjRKlhnv1uTk1jmhIMTHZk8zxEaHLHdOkJq7VXz2fNqUZdg/VUf8vGd8Pz
         CIa2ooJveoUOnCGDp5ChPgVAWPwhYkwl4qhsyJMogtr6Nw7w5fFyI3QtEvf7eFSG0lnw
         d3juKxJda3spm/Um8Su/gC6rtSDldiD4U+GUuTgW3GwjFcDcw/2CR8UCKBDQsJuKwz19
         l3Xz2QNj3sD1/WeVgxSeDLpRU+qQqLii3D8eEqajUiNlmJSr9YWcBCUNaX3gxbTsM1yr
         BEXVezd8W4zUa5imUmWIN2YFHqrIzbrcjHI5p1U8nFOdRtu+UCQgs3fbo2DEatjrEjdX
         mfaQ==
X-Gm-Message-State: AOAM5301pltH4SIfeS2ntw/nGQoFQ3LE4e8LPNa5c+tvCBYstNOT/yir
        4IeNeTFTyw9xebWL8ypo7adytQ==
X-Google-Smtp-Source: ABdhPJxcU1oavbmaSPAQzv50dNydZR7EoXTOf+NdSbnJeJq5TqxE+Uar8XrA9RVijQxVtLjMVEfo2A==
X-Received: by 2002:ac8:7d8a:0:b0:2f3:b85b:39c2 with SMTP id c10-20020ac87d8a000000b002f3b85b39c2mr1032579qtd.500.1651806224581;
        Thu, 05 May 2022 20:03:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 140-20020a370c92000000b0069fe7f77e4bsm1794254qkm.33.2022.05.05.20.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 20:03:44 -0700 (PDT)
Date:   Thu, 5 May 2022 23:03:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] bisect: output bisect setup status in bisect log
Message-ID: <YnSQDzhNjmu5ws4f@nand.local>
References: <cover.1651796862.git.chris@chrisdown.name>
 <acab8859d02c95750fdbc691ac672c17d5be0291.1651796862.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acab8859d02c95750fdbc691ac672c17d5be0291.1651796862.git.chris@chrisdown.name>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 06, 2022 at 01:52:54AM +0100, Chris Down wrote:
> This allows seeing the current intermediate status without adding a new
> good or bad commit:
>
>     $ git bisect log | tail -1
>     # status: waiting for bad commit, 1 good commit known

Hmm. I was worried that this would make it harder to turn the output of
"git bisect log" into something you can inject into "git bisect replay
<log>". But it doesn't, because you prefix the status lines with a '#'
character.

That's good, and I think it's an improvement over what I'd currently
recommend, which would be something like:

    git bisect log | grep '^# bad:'
    git bisect log | grep '^# good:'

to see the state of our good and bad endpoints.

I'm not totally convinced it _needs_ to live in "git bisect log",
though, since it feels like additional information that is just added
for convenience. That's not the worst thing in the world, but I think
it would be fine to just take the first patch (with my suggestions
applied) as well.

> Signed-off-by: Chris Down <chris@chrisdown.name>
> ---
>  builtin/bisect--helper.c    | 25 ++++++++++++++++++++-----
>  t/t6030-bisect-porcelain.sh |  9 +++++++--
>  2 files changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 9d583f651c..ef75f0a0ce 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -404,6 +404,21 @@ static struct bisect_state bisect_status(const struct bisect_terms *terms)
>  	return bs;
>  }
>
> +__attribute__((format (printf, 1, 2)))
> +static void bisect_log_printf(const char *fmt, ...)
> +{
> +	va_list ap;
> +	char buf[1024];
> +
> +	va_start(ap, fmt);
> +	if (vsnprintf(buf, sizeof(buf), fmt, ap) < 0)
> +		*buf = '\0';
> +	va_end(ap);
> +
> +	printf("%s", buf);
> +	append_to_file(git_path_bisect_log(), "# %s", buf);
> +}

This direct use of vsnprintf might be avoided by preparing the output in
bisect_print_status() via a strbuf and then calling:

    append_to_file(git_path_bisect_log(), "# %s", buf.buf).

>  static void bisect_print_status(const struct bisect_terms *terms)
>  {
>  	const struct bisect_state bs = bisect_status(terms);
> @@ -413,13 +428,13 @@ static void bisect_print_status(const struct bisect_terms *terms)
>  		return;
>
>  	if (!bs.nr_good && !bs.nr_bad)
> -		printf(_("status: waiting for both good and bad commits\n"));
> +		bisect_log_printf(_("status: waiting for both good and bad commits\n"));
>  	else if (bs.nr_good)
> -		printf(Q_("status: waiting for bad commit, %d good commit known\n",
> -			  "status: waiting for bad commit, %d good commits known\n",
> -			  bs.nr_good), bs.nr_good);
> +		bisect_log_printf(Q_("status: waiting for bad commit, %d good commit known\n",
> +				     "status: waiting for bad commit, %d good commits known\n",
> +				     bs.nr_good), bs.nr_good);
>  	else
> -		printf(_("status: waiting for good commit(s), bad commit known\n"));
> +		bisect_log_printf(_("status: waiting for good commit(s), bad commit known\n"));
>  }

Interesting; this patch removes the output that we were giving to users
in the last patch. Should it go to both places?

Thanks,
Taylor
