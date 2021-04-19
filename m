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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CC5C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 21:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2691E6101C
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 21:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbhDSVLp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 17:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhDSVLn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 17:11:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231EAC06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 14:11:12 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k128so18963146wmk.4
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 14:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L88u/JFNq/6KJshe3UgIX7bHhGbCSkwnFbdZyyuJXAw=;
        b=EU6xiAkG/qRvqcMFyXCtt7/SevtWXpM9JjF1dNtRYkkLUEit57HosvV3KSp4eS7Xzk
         xyVkY2ojKDdUjCuTddiTnO0Bl6PSj6vu4mL5r/nlwMGc9YY1oMvzdfGDXGL7kH5AsTpw
         vk2H5DHzkOJbpNnkdnX01/mOCnT7KVsnBXZUg74x0cjRTyRROsCjSsh2UuoWFF3A0qiW
         p9VpxbyEtgl/t4UuNmanCXs7KgaYGr3nRUTyF+xT4Mw9HIeQX9CP7+yplvLvRAw6qt7/
         Tshkix8v0jOEps5budFVLkwWhX4JfyXc1BnjVeVYXnqKpFq5ENtzNw3KhgmTh8C0v8Ze
         y75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L88u/JFNq/6KJshe3UgIX7bHhGbCSkwnFbdZyyuJXAw=;
        b=h+scLXuH78/gqgjG+eDeDNpZV2chSNTbcctmixAi260L50Em9W0KBxs6qlx3LA8SUZ
         dUtNkrfUjz6BoBn0ZB7LCkWaFK6dssoBeXoX6Q5m1c+cnkrQSXssBWYmS9VGV4L53BzU
         2a0vLJ89uwy1Xb9ZzK+/YuGHs22DJXexAXw5Pgwz8HLOvHa27g0YWm1e6Vdvu/GjGkHo
         iBB+GeZheSFwI/aV7r1F60EEPAWVBWx3pKEdM90bjJo+bc/5IlDZ3k6xiEQM2MkinS4+
         pN9HrEBrGVUo3XtXvb/Nvc5uFal9RHK4b3h75G+XcoKCpnoHKee3BppiCZi0E5+NNC2Y
         69MQ==
X-Gm-Message-State: AOAM5310/NnJNnpMhpnk71qj0iSyLLu+YLro95ghmTAM+mwiYkD3BHO2
        33sE1OYFn+KX3/MWw4qcczo=
X-Google-Smtp-Source: ABdhPJz17R1ztZPZ0J+nO78wPVP16GGRZpdYR909SEWIfdc8sI2H4Jui1Eq0WI/kzu3ohhRf2xIe2w==
X-Received: by 2002:a1c:e20a:: with SMTP id z10mr935950wmg.158.1618866670908;
        Mon, 19 Apr 2021 14:11:10 -0700 (PDT)
Received: from szeder.dev (78-131-14-48.pool.digikabel.hu. [78.131.14.48])
        by smtp.gmail.com with ESMTPSA id f25sm24315371wrd.43.2021.04.19.14.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 14:11:10 -0700 (PDT)
Date:   Mon, 19 Apr 2021 23:11:08 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 01/18] t4202: split testcase for invalid HEAD symref and
 HEAD hash
Message-ID: <20210419211108.GX2947267@szeder.dev>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <91ef012cbcc9a3106fa51236e20458f108e50ce9.1618829583.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91ef012cbcc9a3106fa51236e20458f108e50ce9.1618829583.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 10:52:46AM +0000, Han-Wen Nienhuys via GitGitGadget wrote:
> From: Han-Wen Nienhuys <hanwen@google.com>
> 
> Reftable will prohibit invalid hashes at the storage level, but
> git-symbolic-ref can still create branches ending in ".lock".
> 
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t4202-log.sh | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 350cfa35936a..c575deaad4fb 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -1834,14 +1834,17 @@ test_expect_success 'log --graph --no-walk is forbidden' '
>  	test_must_fail git log --graph --no-walk
>  '
>  
> -test_expect_success 'log diagnoses bogus HEAD' '
> +test_expect_success 'log diagnoses bogus HEAD hash' '
>  	git init empty &&

This test creates a new repo in 'empty'...

>  	test_must_fail git -C empty log 2>stderr &&
>  	test_i18ngrep does.not.have.any.commits stderr &&
>  	echo 1234abcd >empty/.git/refs/heads/main &&
>  	test_must_fail git -C empty log 2>stderr &&
> -	test_i18ngrep broken stderr &&
> -	echo "ref: refs/heads/invalid.lock" >empty/.git/HEAD &&
> +	test_i18ngrep broken stderr'
> +
> +test_expect_success 'log diagnoses bogus HEAD symref' '
> +	git init empty &&

... and this test create a new repo in 'empty' as well.  Or rather
re-initializes the already existing repository there.

Is this intentional?  It surely cases some confusion.

> +	git --git-dir empty/.git symbolic-ref HEAD refs/heads/invalid.lock &&
>  	test_must_fail git -C empty log 2>stderr &&
>  	test_i18ngrep broken stderr &&
>  	test_must_fail git -C empty log --default totally-bogus 2>stderr &&
> -- 
> gitgitgadget
> 
