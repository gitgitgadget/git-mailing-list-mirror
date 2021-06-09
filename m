Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFB0C48BE0
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 15:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6112613AC
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 15:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhFIPpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:45:07 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:33489 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbhFIPom (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 11:44:42 -0400
Received: by mail-oo1-f49.google.com with SMTP id v17-20020a4aa5110000b0290249d63900faso2587813ook.0
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 08:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=tE78G+F7K0WkDPjzwnhaxELyDC60UUGKHSTe5VPJj1k=;
        b=L/mwashD1/H7VDG6vQwol438RNgibHA3SaZIfcfTH7ogxFbF7BtvJAmrXnTov+Xrnq
         dfapepiPS75KEvTNPhWDZ2fwDa7Nnpigs8E+lv1gnD6Wl2fyIiQ/j846YTtEmH6NRbW1
         O65sLRmGRec5mRY581hEp55Vvf5B2MTWc4znHej9BsllEFIR015btdVz+lzuskhhwwsz
         SSKBZgxaqKZ7v8z05mGHke7e8VZeXPThEtuf++aijz1jKCbohBsQ25OTYiamKLPBgjBd
         JTIwRgfBe3V1KqsEXfhCH5UQ1r+gmQfRbupJRPy2YsNoXov72scdOisYxB4aor8ecmVD
         oRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=tE78G+F7K0WkDPjzwnhaxELyDC60UUGKHSTe5VPJj1k=;
        b=WY6r4IifecON+yZwBYr36EJyRRKhGeAOhfMgnvgSelEpy0+mcfk08n7YJ746bslVna
         6heM/vNh05nx1XITzp2A5/tNQQSngJTf9evfjHst2OfdNDEt5H920PU2RSv8CSUE7xt+
         dEHfnWM1r7D3iZezeNdcXBlYhzILBPwfZCgCOqUa6sTEJlsYPa7hCc9D0ouqe9k71wea
         TU6hI9CviAdg9H9xXvr/rfc3OqQ/EILBgH49FxunbIzV6kBzMmDaHtUUG5x7Ai5+Kswh
         pHJ3slmk/CR0ZG4Ct0+9KQabocNdEhWQ7Ds8rf7ie2D1M1OuulnWibAEd710rg2EYB1Y
         9oJA==
X-Gm-Message-State: AOAM532FySkd0/R6arXcNbWCK1HC+8IJbXrk36QFkrN1z9H5R1AyhWm1
        bH9XINbo8blF/YVYLOstfU0=
X-Google-Smtp-Source: ABdhPJwCf3+JG+GoPIwzsENMr/3n5Me2RLOCNsbbD3NEbrYdHob4BAb5CVOayPSBYQ0vheYDT1rChA==
X-Received: by 2002:a4a:5886:: with SMTP id f128mr458117oob.48.1623253307302;
        Wed, 09 Jun 2021 08:41:47 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id l12sm32118oig.49.2021.06.09.08.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 08:41:46 -0700 (PDT)
Date:   Wed, 09 Jun 2021 10:41:45 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60c0e1397d5dd_efb208d7@natae.notmuch>
In-Reply-To: <f611603718ab61b56ba430ece7367453161c6406.1623246879.git.gitgitgadget@gmail.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <f611603718ab61b56ba430ece7367453161c6406.1623246879.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH v2 2/4] *: use singular they in comments
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> Replace these uses with "they/them" which universally includes all
> potential readers.

Not me, and others on the mailing list who are being ignored.

I guess only some people are worthy of "inclusion".

> Helped-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit.c    | 2 +-
>  config.h    | 2 +-
>  date.c      | 2 +-
>  pathspec.h  | 2 +-
>  strbuf.h    | 2 +-
>  wt-status.c | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/commit.c b/commit.c
> index 8ea55a447fa9..143f472c0f24 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1178,7 +1178,7 @@ static void handle_signed_tag(struct commit *parent, struct commit_extra_header
>  	/*
>  	 * We could verify this signature and either omit the tag when
>  	 * it does not validate, but the integrator may not have the
> -	 * public key of the signer of the tag he is merging, while a
> +	 * public key of the signer of the tag being merged, while a

This one is OK.

>  	 * later auditor may have it while auditing, so let's not run
>  	 * verify-signed-buffer here for now...
>  	 *
> diff --git a/config.h b/config.h
> index 9038538ffdcb..7107b41a8933 100644
> --- a/config.h
> +++ b/config.h
> @@ -451,7 +451,7 @@ void git_configset_init(struct config_set *cs);
>   * Parses the file and adds the variable-value pairs to the `config_set`,
>   * dies if there is an error in parsing the file. Returns 0 on success, or
>   * -1 if the file does not exist or is inaccessible. The user has to decide
> - * if he wants to free the incomplete configset or continue using it when
> + * if they want to free the incomplete configset or continue using it when

Yet again a semantically singular antecedent.

Doesn't sound grammatically correct to me.

>   * the function returns -1.
>   */
>  int git_configset_add_file(struct config_set *cs, const char *filename);
> diff --git a/date.c b/date.c
> index f9ea807b3a9f..2da0f80b9bfa 100644
> --- a/date.c
> +++ b/date.c
> @@ -908,7 +908,7 @@ int parse_expiry_date(const char *date, timestamp_t *timestamp)
>  		/*
>  		 * We take over "now" here, which usually translates
>  		 * to the current timestamp.  This is because the user
> -		 * really means to expire everything she has done in
> +		 * really means to expire everything they have done in

Semantically singular antecedent.

>  		 * the past, and by definition reflogs are the record
>  		 * of the past, and there is nothing from the future
>  		 * to be kept.
> diff --git a/pathspec.h b/pathspec.h
> index fceebb876f7a..6e84099bea22 100644
> --- a/pathspec.h
> +++ b/pathspec.h
> @@ -108,7 +108,7 @@ struct pathspec {
>   *
>   * A similar process is applied when a new pathspec magic is added. The designer
>   * lifts the GUARD_PATHSPEC restriction in the functions that support the new
> - * magic. At the same time (s)he has to make sure this new feature will be
> + * magic. At the same time they have to make sure this new feature will be

Semantically singular antecedent.

>   * caught at parse_pathspec() in commands that cannot handle the new magic in
>   * some cases. grepping parse_pathspec() should help.
>   */
> diff --git a/strbuf.h b/strbuf.h
> index 223ee2094af8..b543e354f0ed 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -338,7 +338,7 @@ const char *strbuf_join_argv(struct strbuf *buf, int argc,
>   *
>   * In order to facilitate caching and to make it possible to give
>   * parameters to the callback, `strbuf_expand()` passes a context pointer,
> - * which can be used by the programmer of the callback as she sees fit.
> + * which can be used by the programmer of the callback as they see fit.

Another semantically singular antecedent.

But this one has an easy fix:

  can be used by programmers of the callback as they see fit.

It's more weird, but at least grammatically correct.

>   */
>  typedef size_t (*expand_fn_t) (struct strbuf *sb,
>  			       const char *placeholder,
> diff --git a/wt-status.c b/wt-status.c
> index 42b673571696..bd7ef3e4fd02 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -639,7 +639,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
>  		 * mode by passing a command line option we do not ignore any
>  		 * changed submodule SHA-1s when comparing index and HEAD, no
>  		 * matter what is configured. Otherwise the user won't be
> -		 * shown any submodules she manually added (and which are
> +		 * shown any submodules they manually added (and which are

Semantically singular antecedent.


So only 1 out of 6 was correct.

-- 
Felipe Contreras
