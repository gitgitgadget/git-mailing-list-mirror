Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB41C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 21:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518BC2247F
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 21:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503580AbgLNVSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 16:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbgLNVSd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 16:18:33 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE51C0613D3
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 13:17:52 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id k7so3776265ooa.0
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 13:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=rvmrXt0R9B5GipaozxaCvXef8h5jGwB3NbXsKCf9AdU=;
        b=rSoDc0FDqNmize1+2haXv1Rw7il/GSRKcOk+JeZ/d89VfwDOkCVVUzuwMH56meH3WR
         GzqQ/vGKlc6gJeS6QQeQl7OwVXuKg+wSaXyNB6jOfPeJ7LfWChRwcfFIR/RJs6a/XJs8
         yknRG85f8rK/2CR1C/wYwWeQbI8v6k9v/xfzFD2Fio1L4FKro+EUlzBUaO0m57agJgMX
         upGy+MCICv0sMe0Oddgf4XcPLe5hUFwqU/OGpPAIQMnxm9SXN0Xqh2KgRFtU1uojEeGY
         naugXjV7lUFOfv4AkpaRsxhUcWRu4/fKWqz6GH7oSHuY4O+FO6zeNe4FfIS9gg3KGvuP
         V0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=rvmrXt0R9B5GipaozxaCvXef8h5jGwB3NbXsKCf9AdU=;
        b=iKkbYJQdFHdFIbmle2ytv1cqFwonsjHWLGMr1cBZoPMjCjjFCkdbV6uzdO5c84DEBW
         ETD9eE5DoH9vMVFLZTvnCL0cqK6/TUk/6L0Fm6idp9mh9e8tcq+hdVP9uS2/qH7midt2
         I7fFkKrRNatQ9WtQIzDSVulMjeeoT+y8gGM3vZspYHaXBkFymwsCN3VY2VzvUpHYhG+F
         AQ+NhryugRqRCxMCCbWfFVecK9drYui8lzpzYfPFsF1QS11gpNB7mw9aRaPwk5hNJMB8
         ROhLaVOdcmsU6JpP7NRU9tiFZbDC/grThv0L75IWFH/mZT6UtZR1yLKMKwQprMaMOg3P
         qoVw==
X-Gm-Message-State: AOAM532Wbn9iKP5fa6GsrQrzfzXyvaMArm2SVBcHGZIv8wz497e4nVgI
        KVH4jiCPAk7Fha0gCtjOWIA=
X-Google-Smtp-Source: ABdhPJypS/gj/6QFryxJ32sYLkt2Y8OxAh4nMpx8T7QZaGavPIcJsatQ1KFKpsxaovn/Rlo+o0ETPw==
X-Received: by 2002:a4a:d148:: with SMTP id o8mr20410728oor.16.1607980670617;
        Mon, 14 Dec 2020 13:17:50 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s26sm4615208otd.8.2020.12.14.13.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 13:17:49 -0800 (PST)
Date:   Mon, 14 Dec 2020 15:17:48 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <5fd7d67c898e4_d44af20879@natae.notmuch>
In-Reply-To: <20201214202647.3340193-5-gitster@pobox.com>
References: <20201214202647.3340193-1-gitster@pobox.com>
 <20201214202647.3340193-5-gitster@pobox.com>
Subject: RE: [PATCH v7 4/5] pull: correct condition to trigger non-ff advice
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Refactor the advise() call that teaches users how they can choose
> between merge and rebase into a helper function.  This revealed that
> the caller's logic needs to be further clarified to allow future
> actions (like "erroring out" instead of the current "go ahead and
> merge anyway") that should happen whether the advice message is
> squelched out.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/pull.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 2976b8e5cb..1b87ea95eb 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -925,6 +925,22 @@ static int get_can_ff(struct object_id *orig_head, struct object_id *orig_merge_
>  	return ret;
>  }
>  
> +static void show_advice_pull_non_ff(void)
> +{
> +	advise(_("Pulling without specifying how to reconcile divergent branches is\n"
> +		 "discouraged. You can squelch this message by running one of the following\n"
> +		 "commands sometime before your next pull:\n"
> +		 "\n"
> +		 "  git config pull.rebase false  # merge (the default strategy)\n"
> +		 "  git config pull.rebase true   # rebase\n"
> +		 "  git config pull.ff only       # fast-forward only\n"
> +		 "\n"
> +		 "You can replace \"git config\" with \"git config --global\" to set a default\n"
> +		 "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
> +		 "or --ff-only on the command line to override the configured default per\n"
> +		 "invocation.\n"));
> +}


While this change is good, I see a lot of advice code setting up a
separate constant message, like:

  static const char message_advice_pull_non_ff[] =
          N_("...");

>  int cmd_pull(int argc, const char **argv, const char *prefix)
>  {
>  	const char *repo, **refspecs;
> @@ -1028,19 +1044,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  	if (opt_rebase && merge_heads.nr > 1)
>  		die(_("Cannot rebase onto multiple branches."));
>  
> -	if (rebase_unspecified && opt_verbosity >= 0 && !opt_ff) {
> -		advise(_("Pulling without specifying how to reconcile divergent branches is\n"
> -			 "discouraged. You can squelch this message by running one of the following\n"
> -			 "commands sometime before your next pull:\n"
> -			 "\n"
> -			 "  git config pull.rebase false  # merge (the default strategy)\n"
> -			 "  git config pull.rebase true   # rebase\n"
> -			 "  git config pull.ff only       # fast-forward only\n"
> -			 "\n"
> -			 "You can replace \"git config\" with \"git config --global\" to set a default\n"
> -			 "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
> -			 "or --ff-only on the command line to override the configured default per\n"
> -			 "invocation.\n"));
> +	if (rebase_unspecified && !opt_ff) {
> +		if (opt_verbosity >= 0)
> +			show_advice_pull_non_ff();

Then, we could just do:

  if (opt_verbosity >= 0)
          advise(_(message_advice_pull_non_ff)).

Or even better:

  if (opt_verbosity >= 0)
          advise_if_enabled(ADVICE_PULL_NON_FF, _(message_advice_pull_non_ff));

I'm not familiar with the advise code, I don't know if there's any good
reason to setup these separate messages, so feel free to disregard this
suggestion.

Cheers.

-- 
Felipe Contreras
