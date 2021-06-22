Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8579C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 05:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C46660C3E
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 05:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhFVFxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 01:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhFVFxr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 01:53:47 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E6FC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 22:51:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c15so9781033pls.13
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 22:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T6ZIz/fwdAAH/CmTOn3zBJxGcfQXJn0ZH7IOCPpTOQM=;
        b=Wn/kwhI3mASC9d7ogZ08qKv5jTyj1OUm24S34HDYsigu/giqNGZV10rrrGsi5oi/5T
         VcNWe61LQDk1Dcb0qbnmkzGl5lFlUObkM+pNdM+vOoT747GsypMnPbCvyb5EMciQNfQD
         ZSoKiLZD1q+d4cFARpRiNH9MoMj6N3uv5bYXsJ5g/rZE/SbwehBNUwdWENeeKVjANPiq
         lVN43fG3wyWfC/r8t6ATBrQYiyj1gugzxfdUEN6C7g6d2v7uDkFdkE3LRh3G5eOZbFqs
         GqR1jRuSeQjQunalZ+jQEGIR/7h+Ef+vtYqlQkfK6OZmU5AwXpq80SEAC0n86d/wGS5A
         TVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T6ZIz/fwdAAH/CmTOn3zBJxGcfQXJn0ZH7IOCPpTOQM=;
        b=Q6g6BFBgD09RXPoX3xXKmB5XkV6KStQVGg0DykSuvRJt+Xmh0QLTXtde7DRAbwzoGD
         Bk+cGRxeoJycFCRsO9Z5WPyGMzn2DCFXMeF6HYeRaNgINyLIZ7J1dbym+KY+70ZV+y0H
         ZtaIjSr2T6GTVUA9cHpWKM5QIeV/LwHaMWc79Xih90HNcIFFXgUR4ofF2yvgOa9cfx7S
         g/th02mpbLMGAUC/S4zxQZjCYk4gmoW+xEMJXQCSetwlcpceLhb0x6JGf/uXJjPrpORk
         f1eb/Z05U+P/CP2ygIbRGvmzCHs0L2LuPBWc3jaP7w60gD+8jEVIPULTjrcb5JuibZdL
         jvaw==
X-Gm-Message-State: AOAM533BSn1Phst0FxdE3S2Z85wFDbxfm+6Jvkz0B5tdRsLrYO5zHx0/
        iEbkJSKc1pHqyfPykPr/KLM=
X-Google-Smtp-Source: ABdhPJxFgBppbr9uwO1ShgNlFqsiSOZqk3dG9kerHhRbHtbVHkqtSc8n27d299l0q2mnvsPNTBPVQw==
X-Received: by 2002:a17:90a:2ec7:: with SMTP id h7mr2206592pjs.126.1624341091303;
        Mon, 21 Jun 2021 22:51:31 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-57.three.co.id. [116.206.28.57])
        by smtp.gmail.com with ESMTPSA id o9sm18577161pfh.217.2021.06.21.22.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 22:51:30 -0700 (PDT)
Subject: Re: [PATCH 1/2] doc: pull: explain what is a fast-forward
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?Q?V=c3=adt_Ondruch?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-2-felipe.contreras@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <0fd6f76d-a65c-6706-802e-c04d5091e83e@gmail.com>
Date:   Tue, 22 Jun 2021 12:51:24 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210621175234.1079004-2-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/06/21 00.52, Felipe Contreras wrote:
> We want users to know what is a fast-forward in order to understand the
> default warning.
> 
> Let's expand the explanation in order to cover both the simple, and the
> complex cases with as much detail as possible.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>   Documentation/git-pull.txt | 41 ++++++++++++++++++++++++++++++++------
>   1 file changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index 5c3fb67c01..142df1c4a1 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -41,16 +41,41 @@ Assume the following history exists and the current branch is
>   ------------
>   	  A---B---C master on origin
>   	 /
> -    D---E---F---G master
> +    D---E master
>   	^
>   	origin/master in your repository
>   ------------
>   
>   Then "`git pull`" will fetch and replay the changes from the remote
>   `master` branch since it diverged from the local `master` (i.e., `E`)
> -until its current commit (`C`) on top of `master` and record the
> -result in a new commit along with the names of the two parent commits
> -and a log message from the user describing the changes.
> +until its current commit (`C`) on top of `master`.
> +
> +After the remote changes have been synchronized, the local `master` will
> +be fast-forwarded to the same commit as the remote one, therefore
> +creating a linear history.
> +
> +------------
> +    D---E---A---B---C master, origin/master
> +------------
> +

Isn't fast-forward merge simply moving HEAD to point at newly incoming 
commit from origin (in this case commit C) without creating merge commit?

-- 
An old man doll... just what I always wanted! - Clara
