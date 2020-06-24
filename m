Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F32C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 00:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48D620B80
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 00:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXkWgK9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387922AbgFXAQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 20:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387693AbgFXAQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 20:16:57 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CB7C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 17:16:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id jz3so266475pjb.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 17:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WKnah2tW14nVKI0/bbz0qeEvjVFgUNE033nGj/rkH4I=;
        b=LXkWgK9s72CEBT9lLQPq1C6gMh1/Pn7F7vHsNqMwj4oJRn3uYFZtfNrrN6GljbA9Dv
         phpaYoP7/U31crGrzYzIbCI+lJyBIdIZ8RfT55w7ii4KamSlPvKWFL4iPY4AGPqyDchq
         2YI93p/VDyLpEVAhKLINXxdZ9HhSo0143vp2/EyD1xp2N2A1kIIW9pLUerfGCB0lvJw3
         u9GvKJdrmsVO73PbYAR+9QdSAGaMCo7gtijL2A4tLrksKsOsWD672kZQDsgN4C8tU1H1
         K9yWhY75A2Db4AvwS41fRcm1VmcsQiarG27WgORsISGRyDULmSd2mCL4xb28Dz8Rd2bT
         stRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WKnah2tW14nVKI0/bbz0qeEvjVFgUNE033nGj/rkH4I=;
        b=dQ/3JSTM43jY3TF/CK918wl1zNpmRNW0AQSCHL3/exQISaMfdOuZQYWYC86IN3D/rM
         PXDpEb1hQVq/eIkXAlY1isMvnIwkz/tsIaaTR8fdyDVojpY6Avi2uTjtzO2avN5vbG7q
         BoeOvKhu95tnizT++POcDrthjjlCh7GB4qE3jLHGl9Ptjnnzee/OU5tojYna8e0G3kuW
         Qgl4/6VP5Nz7nHkLNwjZeOTf45KbubUIGkLS4jTYpQM+yYzVcS5oV5pdCCuCNk3BgUa8
         8gwwxySqffRYBB/Z8Y7Fvn2fkx2vf97I0lrfgFKOli9adlAdsRAK7LZxOc8PyjOG2bTv
         gZ8Q==
X-Gm-Message-State: AOAM533U/WWFw7JrEgMxJXlWZtu7W5CV+PTakbs93OojTRH69IjjxhQc
        V8ni6neKIy3hu8TwB6IPCvg=
X-Google-Smtp-Source: ABdhPJz7H+DjByAKohkjGVEY5L6F7HTRTHrNeT/8jaB9alftxbZjzvS+5ze1hIP7byD22kU902ehdA==
X-Received: by 2002:a17:902:ac96:: with SMTP id h22mr1240857plr.242.1592957816719;
        Tue, 23 Jun 2020 17:16:56 -0700 (PDT)
Received: from localhost ([2402:800:6375:9968:2644:616c:71ad:c7e6])
        by smtp.gmail.com with ESMTPSA id t2sm765306pja.1.2020.06.23.17.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 17:16:56 -0700 (PDT)
Date:   Wed, 24 Jun 2020 07:16:54 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5.1] lib-submodule-update: pass 'test_must_fail' as an
 argument
Message-ID: <20200624001654.GA18358@danh.dev>
References: <cover.1592907663.git.liu.denton@gmail.com>
 <7b9c19b3606f31b12a79591a41847dcb0a071751.1592942452.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b9c19b3606f31b12a79591a41847dcb0a071751.1592942452.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-06-23 16:21:20-0400, Denton Liu <liu.denton@gmail.com> wrote:
> diff --git a/t/t4137-apply-submodule.sh b/t/t4137-apply-submodule.sh
> index b645e303a0..5477d48ffd 100755
> --- a/t/t4137-apply-submodule.sh
> +++ b/t/t4137-apply-submodule.sh
> @@ -6,13 +6,15 @@ test_description='git apply handling submodules'
>  . "$TEST_DIRECTORY"/lib-submodule-update.sh
>  
>  apply_index () {
> -	git diff --ignore-submodules=dirty "..$1" | git apply --index -
> +	git diff --ignore-submodules=dirty "..$1" >diff &&
> +	$2 git apply --index diff
>  }
>  
>  test_submodule_switch_func "apply_index"
>  
>  apply_3way () {
> -	git diff --ignore-submodules=dirty "..$1" | git apply --3way -
> +	git diff --ignore-submodules=dirty "..$1" >diff
> +	$2 git apply --3way diff

It seems like you forgot to chain commands with '&&' here.

>  }
>  
>  test_submodule_switch_func "apply_3way"

-- 
Danh
