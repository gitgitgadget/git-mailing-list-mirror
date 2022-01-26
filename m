Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E43C433EF
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 22:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiAZWnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 17:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiAZWnt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 17:43:49 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6353DC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 14:43:49 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id d3so957592ilr.10
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 14:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OkGpcN/nZXnMuxk9PfMB0Hwf8azenJeAnvfaLMrJtvE=;
        b=ry1R5yU1U6NmXO78uj+b1u5r+iZAPKeEc6ZUThkVn18A62ozZZSKzElIKXdTHvCyg5
         j8CuUoqnreGeGAfOQfEF7z37FYVXxn7DmFsr2FI6JC+pRyuITwf8JUiNxdMjyO4S92aJ
         GHdkyRBXWyaJj9R5ro4lSrmDZ2BMC8GYlOOZjVGL7yPKBjaaE3UXpftW9EYBUWG5bO7B
         mgpxCrZWVN2/KpNAn2jMwhKdjwv3JRlUE8nGfnDpcLt2q/P6hoiSRgp4mZUrOXsn/aP9
         UNLU9fPHDmIMXo/xcaf6aGA/wA3EcI3wDFZQUekVIOfG9J4gyOyVjrA7DWf+ngVnUUzE
         67hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OkGpcN/nZXnMuxk9PfMB0Hwf8azenJeAnvfaLMrJtvE=;
        b=5PoJXxcPbu2fEkcMiRkXJDjGUl/nubqz6NFWXMwsD6wx7GhyYSNLPqvPwiGPMDktDh
         atcLHPoa3oes3nzx56Sf6L34L4vL/DrwcBGCI9bY1+KMRvPdnaDd0GbCCXc3qlBB4xpe
         vTArbaHI4Uk74nhlR5nwihfseLBPdMJVSwbSIs8bIR3GvD3tN9VopGRitFJ3CSAbhnEj
         dcmHxU7ZRbHoGVU0aqKc81f7uOsuJfY8HThmnhs2joPfZe8j9JT8cp+mnTlfrf7aNf6i
         Tymq69dtafMafXYsjWrpqIBtIGyEyc9+UQyDrGoKdN8iAiJGRv3myetxlhLPetbZBSOg
         iJBg==
X-Gm-Message-State: AOAM532rmwNaFJkEObjUv1e7/+3ic7c8jhXG3Dtp0FCXvqSbVy/Lk4+C
        Mo2vJRXT1BGHZGPmKwVQOgSCYQ==
X-Google-Smtp-Source: ABdhPJxHEYlbe6+1MSgpFozRW/d1zQZs6gcowX2Zun6csRESb5lJIg/VKNqwggbRVdP+P7s5y0F6fA==
X-Received: by 2002:a92:d78b:: with SMTP id d11mr949511iln.226.1643237028781;
        Wed, 26 Jan 2022 14:43:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j2sm11071389ilu.2.2022.01.26.14.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 14:43:48 -0800 (PST)
Date:   Wed, 26 Jan 2022 17:43:47 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH 3/5] scalar: teach `diagnose` to gather packfile info
Message-ID: <YfHOo8Mf3RP4j0Y6@nand.local>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
 <330b36de799f82425c22bec50e6e42f0e495cab8.1643186507.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <330b36de799f82425c22bec50e6e42f0e495cab8.1643186507.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 08:41:45AM +0000, Matthew John Cheetham via GitGitGadget wrote:
> From: Matthew John Cheetham <mjcheetham@outlook.com>
>
> Teach the `scalar diagnose` command to gather file size information
> about pack files.
>
> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
> ---
>  contrib/scalar/scalar.c          | 39 ++++++++++++++++++++++++++++++++
>  contrib/scalar/t/t9099-scalar.sh |  2 ++
>  2 files changed, 41 insertions(+)
>
> diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
> index e26fb2fc018..690933ffdf3 100644
> --- a/contrib/scalar/scalar.c
> +++ b/contrib/scalar/scalar.c
> @@ -653,6 +653,39 @@ cleanup:
>  	return res;
>  }
>
> +static void dir_file_stats(struct strbuf *buf, const char *path)
> +{
> +	DIR *dir = opendir(path);
> +	struct dirent *e;
> +	struct stat e_stat;
> +	struct strbuf file_path = STRBUF_INIT;
> +	size_t base_path_len;
> +
> +	if (!dir)
> +		return;
> +
> +	strbuf_addstr(buf, "Contents of ");
> +	strbuf_add_absolute_path(buf, path);
> +	strbuf_addstr(buf, ":\n");
> +
> +	strbuf_add_absolute_path(&file_path, path);
> +	strbuf_addch(&file_path, '/');
> +	base_path_len = file_path.len;
> +
> +	while ((e = readdir(dir)) != NULL)

Hmm. Is there a reason that this couldn't use
for_each_file_in_pack_dir() with a callback that just does the stat()
and buffer manipulation?

I don't think it's critical either way, but it would eliminate some of
the boilerplate that is shared between this implementation and the one
that already exists in for_each_file_in_pack_dir().

> +		if (!is_dot_or_dotdot(e->d_name) && e->d_type == DT_REG) {
> +			strbuf_setlen(&file_path, base_path_len);
> +			strbuf_addstr(&file_path, e->d_name);

For what it's worth, I think the callback would start here:

> +			if (!stat(file_path.buf, &e_stat))
> +				strbuf_addf(buf, "%-70s %16"PRIuMAX"\n",
> +					    e->d_name,
> +					    (uintmax_t)e_stat.st_size);

...and end here.

Thanks,
Taylor
