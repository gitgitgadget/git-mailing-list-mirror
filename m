Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47551C2BA83
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 23:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C4320838
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 23:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="RPrntzDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgBIXQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 18:16:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38079 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgBIXQE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 18:16:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so2760326pfc.5
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 15:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JJ4X88wHz/yFPuulBN5/esfgQhDIgf/mCd9ANBlSeVM=;
        b=RPrntzDqO+6apKTd0GMPvihnGYJmK2L6MUctadSA+C95V8S8v3YozJEcFutxNDKStt
         enIVBvoMqERrDQT4INMCDMnl7dfAsf15TO9I+RclfFNDrIUCpK79g/MrGYI8iOEqipvS
         IRyAF8Akqi5yYQ2FXDWB1TgPwkKwZY4QQSBkVf9bM6l051omUqxtvd24OISC+anGMk6p
         ftMTlCZpU3GdKplBE6jp5dTgKKRJ/iaunhVE4rGJH0LNXQyuL/IeU+xrhlFL1O/Nqmx+
         GE/528uPTR31n2beQenTW3S1RVYI5dRH0QnEsTbJM9b0HaXvXzN6pIaGQomcKmI44E/t
         EJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JJ4X88wHz/yFPuulBN5/esfgQhDIgf/mCd9ANBlSeVM=;
        b=FJ8tQY3IaiS4n0IHHKHS3nKxiXWAEgGvtRms74N/B2anQtYCpL5akjNh+PlqSo2eTD
         uL1dPlnZqbpiLcqJDmkDdhPI2BBNwHVzjYPMAVe/OHLsxwM/DTJ2BRsTLXAYXgljvZ0G
         x+QNS96IzhU+yQIMgeNIUrRCHy4xsMBQvuTG7PK00etcFWzk9eZuxFQLutwZsrL4LABu
         dYvUkPEfUolLDb81XgPC6+yXrFxZZGaFDr999SPdG8V0otvFkh4x+aXovJJ+rnnX1bnb
         0q+NW2+5j+b9uSWvP8dDOgyRnfd7XSv6UQKIvi+srunM+aDOLMzf/cd5KDfamA+mc2oo
         G+ZA==
X-Gm-Message-State: APjAAAXaf7ue+LKSoNuhgbuHImAuItIkBF9g+B1v4r7Hf269u/MEHDPq
        ag4GIuqKfRRUKlzl7lNi6tTggw==
X-Google-Smtp-Source: APXvYqykw+etmITGq8YqE97o8lewSOScITbrp81cHAUZoWUnnBjboJZmZl+UYhmMGdmtrqZGQWgtUQ==
X-Received: by 2002:a63:ec49:: with SMTP id r9mr11272292pgj.445.1581290163279;
        Sun, 09 Feb 2020 15:16:03 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:317f:c53e:b83c:7fcb])
        by smtp.gmail.com with ESMTPSA id x132sm9934984pfc.148.2020.02.09.15.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 15:16:02 -0800 (PST)
Date:   Sun, 9 Feb 2020 15:16:02 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v3 04/13] run-command: make `exists_in_PATH()` non-static
Message-ID: <20200209231602.GC4530@syl.local>
References: <20200208090704.26506-1-mirucam@gmail.com>
 <20200208090704.26506-5-mirucam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200208090704.26506-5-mirucam@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 08, 2020 at 10:06:55AM +0100, Miriam Rubio wrote:
> From: Pranit Bauva <pranit.bauva@gmail.com>
>
> Removes the `static` keyword from `exists_in_PATH()` function
> and declares the function in `run-command.h` file.
> The function will be used in bisect_visualize() in a later
> commit.

There may be some odd line-wrapping going on here.

> `exists_in_PATH()` and `locate_in_PATH()` functions don't
> depend on file-local variables.
>
> Mentored by: Christian Couder <chriscool@tuxfamily.org>
> Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  run-command.c |  2 +-
>  run-command.h | 11 +++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/run-command.c b/run-command.c
> index f5e1149f9b..4df975178d 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -210,7 +210,7 @@ static char *locate_in_PATH(const char *file)
>  	return NULL;
>  }
>
> -static int exists_in_PATH(const char *file)
> +int exists_in_PATH(const char *file)
>  {
>  	char *r = locate_in_PATH(file);
>  	int found = r != NULL;
> diff --git a/run-command.h b/run-command.h
> index 592d9dc035..7c8e206d97 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -172,6 +172,17 @@ void child_process_clear(struct child_process *);
>
>  int is_executable(const char *name);
>
> +/**
> + * Returns if a $PATH given by parameter is found or not (it is NULL). This
> + * function uses locate_in_PATH() function that emulates the path search that
> + * execvp would perform. Memory used to store the resultant path is freed by
> + * the function.
> + *
> + * The caller should ensure that $PATH contains no directory
> + * separators.

This line-wrapping caught my eye: it looks like 'separators' would fit
on the line before, or at least that this paragraph and the one above it
are wrapped at two different widths.

I'm not sure that it really matters, since it looks like the wrapping in
this file isn't entirely consistent, but I figured that I'd point it out
nonetheless.

> + */
> +int exists_in_PATH(const char *);

Have you considered naming this argument? It's somewhat clear from the
documentation, but I don't see a reason not to name it (especially since
other declarations in this file *do* name their parameters). What about:

  int exists_in_PATH(const char *file);

To match its definition in 'run-command.c'? (Admittedly, if I had
written this I'd probably call it 'entry', but they should at least be
consistent).

> +
>  /**
>   * Start a sub-process. Takes a pointer to a `struct child_process`
>   * that specifies the details and returns pipe FDs (if requested).
> --
> 2.25.0
>

Thanks,
Taylor
