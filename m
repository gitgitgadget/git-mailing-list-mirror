Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9669CC433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57740619CB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhCWUrg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 16:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhCWUrS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 16:47:18 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03ECC061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 13:47:17 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w70so18485535oie.0
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 13:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xikp4iHImJpbs4pAKj2c91M1VQz0yirK5bbkHyBpVGQ=;
        b=A/nb6+Q70Owcx8MhQy4qi6U7jGaLOyqt1O2/ZT3RsVBHDO398OwaVu9pi9ZW+jdTLx
         8B1vglFt/HN3NfACcS5f6ISKzXku7v4m9E2sDZOLz7yg/0GJY8Yx86pOS+zM7UrB7ExH
         F7l/e6Oli0vJNyxV8iyQkMivG1pa+3wd3AJq5pWfMosyGI7TAZw31gJLqgZZD27dCNmQ
         FgHLnFLNnYoo4iZMleTQcw3Y/60DOB1immi+Uca61cII7SYJHl1H2xv4Ij4E/mcZn76D
         dSV1ZNycASq+wDpnV2JHWpxgdsGIkaPWw5QJQlBeuXTzKwEjoJKOq5NdgCYrdI4vlXlI
         XARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xikp4iHImJpbs4pAKj2c91M1VQz0yirK5bbkHyBpVGQ=;
        b=Iougs0X7qvI+yss1Y/bYNF/Wq2AXFBmFQD45Pr2DfyFQMqqxLwFiVgbBmTu41CHKn2
         hmuvRyRD2n0Kyl1vdsnVhEMwzFjBw6EV5mjAvomXxCFJg/QSvKI550PMlBIMF48slAAe
         9rF6HCwi6MLs+27R14IH4PAvz/0W4EgOhRmQAszpnuEg/k9F5uri04cW+uQMw92EKFvd
         rrZqob8EWdXthgrqOeFS+MjFhrl9a6cfXaxcgkNW9JY75tc7C/o80RfAY+wfmk0orktg
         EhF6VRRAL5i1154dIow5wQP+bGp0UMGb9oWs6hpztTLiH01A0GLc8i9tu/Apex7bsXS7
         VpPA==
X-Gm-Message-State: AOAM533MkYTia+T0LRobDwO4U3S4g0/JCj9p6Pp71BFHPLrDXjfdUp8o
        qFNtIkBfGx4DSM2UF0sukTs=
X-Google-Smtp-Source: ABdhPJz8W/VmoO3oP1bxa6SXvVpldz5RjwJ4zoiKb/B1bTWEsq3bI9O/cfKFJDU4BAygKLMehDebCA==
X-Received: by 2002:aca:4e83:: with SMTP id c125mr2306oib.38.1616532437307;
        Tue, 23 Mar 2021 13:47:17 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:19be:10a5:ec17:ace3? ([2600:1700:e72:80a0:19be:10a5:ec17:ace3])
        by smtp.gmail.com with ESMTPSA id 91sm4341876otc.36.2021.03.23.13.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 13:47:16 -0700 (PDT)
Subject: Re: [PATCH v3 7/7] rm: honor sparse checkout patterns
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com
References: <cover.1615588108.git.matheus.bernardino@usp.br>
 <d25ea10560b501d2ca77b567927a0bb9bc874a1e.1615588109.git.matheus.bernardino@usp.br>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3f5739f2-8d3a-3410-3907-f0cb022397b4@gmail.com>
Date:   Tue, 23 Mar 2021 16:47:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <d25ea10560b501d2ca77b567927a0bb9bc874a1e.1615588109.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/12/2021 5:48 PM, Matheus Tavares wrote:
> `git add` refrains from adding or updating index entries that are
> outside the current sparse checkout, but `git rm` doesn't follow the
> same restriction. This is somewhat counter-intuitive and inconsistent.
> So make `rm` honor the sparsity rules and advise on how to remove
> SKIP_WORKTREE entries just like `add` does. Also add some tests for the
> new behavior.
> 
> Suggested-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  Documentation/config/advice.txt  |  5 +-
>  Documentation/git-rm.txt         |  4 +-
>  builtin/rm.c                     | 35 +++++++++-----
>  t/t3602-rm-sparse-checkout.sh    | 78 ++++++++++++++++++++++++++++++++
>  t/t7011-skip-worktree-reading.sh |  5 --
>  5 files changed, 108 insertions(+), 19 deletions(-)
>  create mode 100755 t/t3602-rm-sparse-checkout.sh
> 
> diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
> index 851b83cf30..8b2849ff7b 100644
> --- a/Documentation/config/advice.txt
> +++ b/Documentation/config/advice.txt
> @@ -120,6 +120,7 @@ advice.*::
>  		Advice shown if a user runs the add command without providing
>  		the pathspec parameter.
>  	updateSparsePath::
> -		Advice shown when linkgit:git-add[1] is asked to update index
> -		entries outside the current sparse checkout.
> +		Advice shown when either linkgit:git-add[1] or linkgit:git-rm[1]
> +		is asked to update index entries outside the current sparse
> +		checkout.

I wonder if this is going to need to be updated forever, or if in
the _next_ iteration we just say "Advice shown when a command is
asked to update..." (using the "three is many" rule).

> diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
> index ab750367fd..26e9b28470 100644
> --- a/Documentation/git-rm.txt
> +++ b/Documentation/git-rm.txt
> @@ -23,7 +23,9 @@ branch, and no updates to their contents can be staged in the index,
>  though that default behavior can be overridden with the `-f` option.
>  When `--cached` is given, the staged content has to
>  match either the tip of the branch or the file on disk,
> -allowing the file to be removed from just the index.
> +allowing the file to be removed from just the index. When
> +sparse-checkouts are in use (see linkgit:git-sparse-checkout[1]),
> +`git rm` will only remove paths within the sparse-checkout patterns.

Good to update in the correct spot.

Implementation and tests look good, too.

I just wanted to chime in and voice my support of this general
direction. Thank you!

-Stolee
