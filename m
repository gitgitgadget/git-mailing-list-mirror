Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F04C4338F
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 19:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD8960E97
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 19:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhHHTYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Aug 2021 15:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbhHHTYB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Aug 2021 15:24:01 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6F9C061760
        for <git@vger.kernel.org>; Sun,  8 Aug 2021 12:23:41 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id lw7-20020a17090b1807b029017881cc80b7so4997641pjb.3
        for <git@vger.kernel.org>; Sun, 08 Aug 2021 12:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5gER0u3F4FcWQnTscFDdKnD/4Rdx29YtmFeY/no2n+E=;
        b=Wy5PL+Vq/879H4Dfg9PhJDBhAmQb1S72DhzkShKlM4A1GWcDLoEWxl+/10jKCQv1hw
         5R5TY3C8q5cv/Sbv+3XFppCx8giXXqMq3n9fYjs93IYaDAPNToet2+k1ybQ4OWcVW379
         n4WWh0tHPUEgl12ihR3YmkOHstSqqbjT8pVQkn5YMOfje9lcLljbF8PrKIQExYXw+nlR
         7e6jDoWsx5XJGK8CSKhO8fLwi2L2XsecBu6IMRUOmBLOaibN2RE2EQHRUjhrrM/M1wh+
         XuvZ8bF0hyP8BeoJuQ3sBr2VBVAIHy8FqPbUO6od0ctppR2YNZE2bfVd+UPzgMMJwNVY
         x8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5gER0u3F4FcWQnTscFDdKnD/4Rdx29YtmFeY/no2n+E=;
        b=oNTDt3mz3hGc1XD2QlAgWuIPgdEfq01lk7pRYDAyw1qAlvyvW3hrM1puYpK3ENW06t
         SgzICyYiI5s3lClZW039kmlzPID+EKw6pbPQ2WMoASQFerH3WhV6qQv1G1/yhKKSwmi0
         YWeJ1hRV4TQyPcIqcJ8OlHuA/+ZJhB7QElHQY2TDE9Ko49UPL8xIMz8LuWZSFf3quqOm
         +qrSWWfMtRdp97gb+FnS2Xfenkm3sGEsIB2zuqlz8fpfqDbNq0+eLKY2CsvLq2Yq5wkH
         YMgXg1WTJ1TzjnRRkew1sbdcMn91h1sUtcn25vXiw/ruhUQkuN0H3qOQkX7gmCSbYPOx
         scog==
X-Gm-Message-State: AOAM532vZm814lbYJLEd7AZIlyfaTBRYN2J0OYntlQhewB5TavnRj2OM
        LuXDJg/HJpa7uCAwBqxeKeI=
X-Google-Smtp-Source: ABdhPJxSkiZKX+IPUNWPAz9CJQi7/T/7JG0SOdBqXPlFIKOD1PUPjMgOMbgdFmDIcVgkkuorSnSK+A==
X-Received: by 2002:a63:3c5d:: with SMTP id i29mr48436pgn.147.1628450621375;
        Sun, 08 Aug 2021 12:23:41 -0700 (PDT)
Received: from [192.168.208.38] ([49.205.84.169])
        by smtp.gmail.com with ESMTPSA id n20sm17116306pfv.212.2021.08.08.12.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 12:23:41 -0700 (PDT)
Subject: Re: [GSoC] [PATCH v4 4/8] dir: libify and export helper functions
 from clone.c
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, pc44800@gmail.com, periperidip@gmail.com,
        rafaeloliveira.cs@gmail.com, sunshine@sunshineco.com
References: <20210806120147.73349-1-raykar.ath@gmail.com>
 <20210807071613.99610-1-raykar.ath@gmail.com>
 <20210807071613.99610-5-raykar.ath@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <1b731c17-7284-746d-331b-d0edd5823318@gmail.com>
Date:   Mon, 9 Aug 2021 00:53:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210807071613.99610-5-raykar.ath@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/08/21 12:46 pm, Atharva Raykar wrote:
>> [ ... ]
>
> diff --git a/dir.h b/dir.h
> index b3e1a54a97..a4a6fd7371 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -453,6 +453,16 @@ static inline int is_dot_or_dotdot(const char *name)
>   
>   int is_empty_dir(const char *dir);
>   
> +/*
> + * Retrieve the "humanish" basename of the given Git URL.
> + *
> + * For example:
> + * 	/path/to/repo.git => "repo"
> + * 	host.xz.foo/.git => "foo"
> + */

Are you sure about the examples here? I just tried and ...

   - '/path/to/repo.git' gave me 'repo' like you said

.. but ..

   - 'host.xz.foo/.git' gives me 'host.xz.foo' instead of 'foo'.
     I think you meant to have 'host.xz/foo.git' in the example.

Also, here's another example that might be useful to mention in the docstring:

   - 'http://example.com/user/bar.baz' => 'bar.baz'

> +char *git_url_basename(const char *repo, int is_bundle, int is_bare);
> +void strip_dir_trailing_slashes(char *dir);
> +
>   void setup_standard_excludes(struct dir_struct *dir);
>   
>   char *get_sparse_checkout_filename(void);
> 

-- 
Sivaraam
