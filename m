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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CE6C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 06:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B20A22CAF
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 06:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbhALGS6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 01:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731090AbhALGS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 01:18:58 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB56C061575
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 22:18:18 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id m6so773350pfm.6
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 22:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c3cTz2BrCZZOWxHsc22D5bCcHThIiDZgNHzpH6NHayw=;
        b=JvKNfag/Zbm1ORARgihitTOwYZRXf9LjMzJQlg1AUJU5RH9Y2IcqvTkQDWdHpJotLy
         f9k+YjHqsvfKtc8dUoD/+kSrsdUPDU3LHY/eEHkn/L0JZIXG597FcBpu+D0m4C2/KXCm
         oJizhX4t5webJhNIDfgkjcel6jDqP60iwxVk/9sKbLszflkui66Y0bKp3D1zD6CSlQop
         aZ5cUMI+5E6r9k+S6U73YmSDZtLcZGFxA+23bMTmNuec6rwmlMWObZTYUiGyfJ0yNure
         Ox5vxZysNNy1TD4dVNcGCIg8igHSJq6jDOJYC0rVauPkcW4kYyo65KFw4GiN26yIIwra
         1rNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c3cTz2BrCZZOWxHsc22D5bCcHThIiDZgNHzpH6NHayw=;
        b=Zfrsco4w/1qSB45mQA7knHyF4MdWSQgAyfXojZCeNsj9CZMZ2YglGZnPUN8zWriU0a
         Mei2sf1GJEQ2JKt5KIrPSz6Oe0a+7Ce8nrxtPIvHNps1gjZFQ+evVNhbG4YKT4poOQIN
         YSfzAtdwPzY7PUl8OR261npR9IvAFqfBYv4akoeMZeI2kmZZKp4gbvb2k72+7aVpOW4M
         m4sT7XqyMFXrDLW/3t8cJ0miLSbqo7FMmTNkHSzkpt953OFp+y2txqx5XtBKpkKsGvdK
         83t70p+JSwF5nAxDYAqon5ecxuKbTWlfEyqJccoWIMSRpyY7Ovgsbklhez/NbAzwQZWe
         rmpQ==
X-Gm-Message-State: AOAM531RqCvMx1i7ECnV0e5IsK10fIcfN6MnuNKebapwUidHdsB7sjNc
        QHuk6BY8ewJ3pOPGcE+VdVJ2/eyMuAY=
X-Google-Smtp-Source: ABdhPJzIpzCoPt15m+J/zBMsLMbDx3QOM1IkauKqAJLPZg+FuJiTstD7nKRQzCdFprBwMenggPTM0A==
X-Received: by 2002:a62:19cc:0:b029:19e:321b:a22e with SMTP id 195-20020a6219cc0000b029019e321ba22emr3122831pfz.73.1610432297605;
        Mon, 11 Jan 2021 22:18:17 -0800 (PST)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id 32sm2021386pgq.80.2021.01.11.22.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 22:18:16 -0800 (PST)
Date:   Mon, 11 Jan 2021 22:18:14 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH v3] fixup! refs: allow @{n} to work with n-sized reflog
Message-ID: <X/0/Jo3NYlKG3hxE@generichostname>
References: <X/tkFuESnia/n35e@ruderich.org>
 <d51c9ccca7c58524d5c735c596c142583029a36c.1610432037.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d51c9ccca7c58524d5c735c596c142583029a36c.1610432037.git.liu.denton@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please disregard, I see that the fixup has already been included.

-Denton

On Mon, Jan 11, 2021 at 10:14:14PM -0800, Denton Liu wrote:
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  refs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/refs.c b/refs.c
> index e70dcd33f7..03968ad787 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -906,7 +906,7 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
>  	cb->date = timestamp;
>  
>  	/*
> -	 * It is not possible for cb->cnt == 0 on the first itertion because
> +	 * It is not possible for cb->cnt == 0 on the first iteration because
>  	 * that special case is handled in read_ref_at().
>  	 */
>  	if (cb->cnt > 0)
> -- 
> 2.30.0.284.gd98b1dd5ea
> 
