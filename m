Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2218C07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 19:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiIZTNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 15:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiIZTNt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 15:13:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6650997516
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 12:13:48 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id cc5so11724809wrb.6
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 12:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date;
        bh=Ls0bmk7ACvPi5iSJKEJ2rZEoy4HUrC6WQLnHZkOjQYg=;
        b=ieEEtc+y6UrMbC1E3cSZHJAaLtCZ/krGJc8Yhe/tRfqoFrAPAe0saMdSl7Ew8rvKHl
         xTsU3TGq04WZIxzJKcqFDh3yKS755e51fspWUvixLbkBLmSvK9iqDnr1hoDaRc6DXdab
         8orREnL49yT3Ow/cBfD3DUbWqB40j98BfRqnxzLw4SBa4vYONXId9Wx1SsYL248c3l65
         I4z2CN4ee43ve0TR80nggxtgAUFncE1aj2E0xJpS+1QhHzIRvwXQPASVuwbraHO02hj9
         qV56AKtdCcs1XL/ry3x2o2PJ0fpOzbLIoWry/er+N/UDg50+ngUfjR8lIV9UhGZ+exUU
         d5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Ls0bmk7ACvPi5iSJKEJ2rZEoy4HUrC6WQLnHZkOjQYg=;
        b=VrQk2yeKkPFl2CvprS7jaK4srF/12qed0BFmSaLC52ob0ssgZHsi+oZHum7k4noeb4
         vCp29dUmJu/cPCSqKTlxacbKV3kKjS2RqjHQisysmNxPgr3o4nxcPbfRxOH9in40mECj
         VYTwnc8mMARYBYapF0/SDkvHyEUGlCFFd8uELcNsIZVdUbDJkuRj+7737+owXqMexAjU
         UYKXLwRWhyzfzao6ySrQFdtQtEeAdW3Atbq/NX4hXSaxn+BBwPDNzjahtweVswLZs8R5
         45Hem4XUgtC1A77TY+KZC0oi9pWfuTUXGEhwRHSpa12y4DHqGJZsIpS8EZaxBm/x3683
         Mzxw==
X-Gm-Message-State: ACrzQf1AW21k5OwP+KRuYCdvLKWeD6nMGhRpbOhhtFqUIQ5QFyTafmyQ
        ix35GrkHz5iZALneyzQf4Vm1MIZ/Mhg=
X-Google-Smtp-Source: AMsMyM7TZNIBqRtW9Cg8zz5IfHfYcEabjm3pDefwZrkqUDlR85ZbnLgMcI2ZAZtNLYT+FhDozodCPQ==
X-Received: by 2002:a5d:6f0d:0:b0:229:a479:989e with SMTP id ay13-20020a5d6f0d000000b00229a479989emr13862293wrb.158.1664219626826;
        Mon, 26 Sep 2022 12:13:46 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id i11-20020a5d584b000000b0022add371ed2sm16438861wrf.55.2022.09.26.12.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 12:13:46 -0700 (PDT)
Subject: Re: [PATCH] ref-filter.c: fix a leak in get_head_description
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
References: <6ff29e96-7f8d-c354-dced-b1b363e54467@gmail.com>
 <220926.86bkr24kjw.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <8288e9e7-dbea-a5de-c05e-5a22a6a853f6@gmail.com>
Date:   Mon, 26 Sep 2022 21:13:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <220926.86bkr24kjw.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/9/22 10:14, Ævar Arnfjörð Bjarmason wrote:
> 
> Thanks, this looks good to me. FWIW I have a local (still unsubmitted)
> series of leak fixes across the tree which fixed this leak, that commit
> is presented below as a "I've already been running with this for a
> while" data point.

That call in die_if_some_operation_in_progress is a good addition to this fix.
I haven't found a happy path that leaks there yet, but it is calling for it
anyway.  And the commit message looks good to me too.  So you can add to that
patch, if you want:

Reviewed-by: Rubén Justo <rjusto@gmail.com>


Thanks Martin for your review!

Un saludo.

> 
> Thanks!
> 
> -- >8 --
> Subject: [PATCH] wt-status API users: use wt_status_state_free_buffers(), fix
>  leaks
> 
> Fix a memory that was accidentally introduced in ref-filter.c in
> 2708ce62d21 (branch: sort detached HEAD based on a flag, 2021-01-07),
> and one that's been present in builtin/checkout.c since
> c45f0f525de (switch: reject if some operation is in progress,
> 2019-03-29).
> 
> In both cases we should be using the wt_status_state_free_buffers()
> API introduced in 962dd7ebc3e (wt-status: introduce
> wt_status_state_free_buffers(), 2020-09-27).
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/checkout.c | 2 ++
>  ref-filter.c       | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 54373424403..549c3d17a1a 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1469,6 +1469,8 @@ static void die_if_some_operation_in_progress(void)
>  		      "or \"git worktree add\"."));
>  	if (state.bisect_in_progress)
>  		warning(_("you are switching branch while bisecting"));
> +
> +	wt_status_state_free_buffers(&state);
>  }
>  
>  static int checkout_branch(struct checkout_opts *opts,
> diff --git a/ref-filter.c b/ref-filter.c
> index 45908d4bdfc..81278ec3cf7 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1722,6 +1722,8 @@ char *get_head_description(void)
>  	} else
>  		strbuf_addstr(&desc, _("(no branch)"));
>  
> +	wt_status_state_free_buffers(&state);
> +
>  	return strbuf_detach(&desc, NULL);
>  }
> 
