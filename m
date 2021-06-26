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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEF1C49EA5
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 10:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 560256186A
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 10:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFZKJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 06:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZKJd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 06:09:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1D4C061574
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 03:07:10 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l12so12845885wrt.3
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 03:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oLPCY2QTy5X0ElI/n0P9r9hLaWCRQjhJQM1Ty2Wpwf8=;
        b=meTk5n7A+p31GUiyovqGmjoeeQQQmmdUC4fGB5pmF7fKxwQ4AR0TFqEjt8L71++HTG
         qgunPaS/4ZP5fayRmW3G8wxxggseMB7QvFxfDoOUSp5x9lPgFtTkMRu1PO3EB+Fwj5Lp
         YHuNzesNdir0SFPXMEKs5jfB9CUmCXEuwYdMaTkjYqbP2v+JJuV5OpmnezL2x0A3fi/8
         1PMVkFVRmoTHsY+8+N0Oxfj2c9QLx+nF2m6XlNNGKke/utNUYSnI7yMwfFYNOI3x7v6q
         XMkfKfvHO9gH5ShY4H0C3AVVgZBI5NgDLp9xMcsXGPXLK/1/qjfyt+3VhZYciy/w32pF
         rcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oLPCY2QTy5X0ElI/n0P9r9hLaWCRQjhJQM1Ty2Wpwf8=;
        b=khbrS+YCqn2JWTPQ0iwgdEKzo+4LGjBQPQGFTXx9/pszsJHDoRZRcb7/swNY7qj6BW
         E9TYs6RuhmiEubMjBk3B/Vg1ivkKz1lZS9wfSRqIWXW9eTkgm3dgD1AyyGTjpkB+q5/L
         SezmsXXkzHlSTceBZJyav+xtk86hkcyS6gvA0mFJ3DdLzuZYQhYa5Bf7mvzUNYius+DD
         I2mBhFRAb0s5mc40Ei8dFx938by0y4V0f8wN+98uOwLqgGYU1ZuJLM6TRR/OZJzY4KRW
         fwIEU+9lOAspQwE2Ks3Iopm+owoKEN6xFbNWfu6h8j/pcfBxljCso+FfdMRIodDfIQ9q
         ggXw==
X-Gm-Message-State: AOAM530JKJQFO24ACDDE4632u4XoZBA6Cl0NOPrqZ8newi00hq1WsnHp
        H3YZb/xbYIaA4zQOZ08WyVE=
X-Google-Smtp-Source: ABdhPJyf7Up7663sv2sfMjOOk7BedqBl3DHHrWBiAfdA0Kl2z34btrYPQg7dReWYz9O9sJb9qAlLPg==
X-Received: by 2002:a5d:6945:: with SMTP id r5mr16538841wrw.249.1624702029107;
        Sat, 26 Jun 2021 03:07:09 -0700 (PDT)
Received: from [10.23.18.18] ([195.246.120.98])
        by smtp.gmail.com with ESMTPSA id o17sm12294658wmh.19.2021.06.26.03.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jun 2021 03:07:08 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] git-worktree.txt: fix typo in example path
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Barret Rhoden <brho@google.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
References: <20210619112912.76136-1-rybak.a.v@gmail.com>
 <20210625193851.2233114-1-rybak.a.v@gmail.com>
 <20210625193851.2233114-4-rybak.a.v@gmail.com>
 <YNbQGoMP+wYZS0CA@carlos-mbp.lan>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <8da4cb97-eb46-1ce5-ee74-fb1286d230aa@gmail.com>
Date:   Sat, 26 Jun 2021 12:07:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YNbQGoMP+wYZS0CA@carlos-mbp.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/06/2021 08:58, Carlo Marcelo Arenas Belón wrote:
> not sure if this patch really belongs in this specific patchset

Yes, third patch is unrelated to the first two.

>, but it
> might be worth also fixing the same typo in grep as shown by :
> 
> --- >8 ---
> Subject: grep: fix worktree mis spelling

s/mis spelling/misspelling/

> 
> 1d1729caeb (grep: replace grep_read_mutex by internal obj read lock,
>   2020-01-15) adds it as part of a comment
> 
> fix it to the right spelling without the extra trailing 'e'.
> 
> diff --git a/grep.c b/grep.c
> index 8f91af1cb0..f40c734565 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -1510,7 +1510,7 @@ static int fill_textconv_grep(struct repository *r,
>   	 *
>   	 * TODO: allowing text conversion to run in parallel with object
>   	 * reading operations might increase performance in the multithreaded
> -	 * non-worktreee git-grep with --textconv.
> +	 * non-worktree git-grep with --textconv.

I deliberately skipped this typo, because it is in a TODO comment, which
I thought isn't worth fixing. I probably should have mentioned that in
the patch I've sent.

>   	 */
>   	obj_read_lock();
>   	size = fill_textconv(r, driver, df, &buf);
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> 

