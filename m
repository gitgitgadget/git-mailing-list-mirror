Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BCCC5ACD8
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 10:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A68920768
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 10:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmD8vQGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgCRK52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:57:28 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40566 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgCRK52 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 06:57:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id j2so24983875qkl.7
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 03:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xQfnEyHhllg6yvzpeuqlQBtX4xgM/cDINB2K7VV35Nk=;
        b=FmD8vQGcOTNzAYFdURP8Zg7stSdmXlIc9VZjlwRIXLetVyI74FKt6lKfKRebNnMyzw
         NnDeyLqlWsJCX7cdTUZ61VFK10WimO6G/RF+x8MMcPnRYn4TVspBnq7gryqFqm/KzHjJ
         wGTPAKk+g4EAnvJOLxI4cBS2sTzAlK3h600A74vNv2m6CdJZOxwVDykqYk+0oDFOLZhm
         MuYTy/d7ZLtPTmMeIKBwoyUiPl+7IC9T4JfHDyx/AyuGp4ektSkAy1DBmwvrs7QbCskb
         H0AQmPj4IVSbf8UAPnjzX5I52aX5XStOuX61w30X6hxjnPhGjQkJT7es5qAI0/CmON47
         HlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xQfnEyHhllg6yvzpeuqlQBtX4xgM/cDINB2K7VV35Nk=;
        b=DcjJVhieUWtvq/n5oKKHozi3MfS4iQMlYbGU9MZZm6GlCbpfEkkY9MEvLoNYSFumjC
         iMjpxsECbvfE4xVJGM8D8zeLb0CeTerTPGuV8bR0FvQWMCUpA1JG16r3TYsdMh5aqsr2
         4RQ7scIuKse3hHcZEiSeADSDEavejSrZt5jH9Be9UYUPHDq/aF5fZXFmFZr+omAgQ0n8
         PMgJdP/6AapNzdkwQZz7eOGptAtCMKiqFF6kxD3DME/63uQf9o8HRl+O7XyH4I4l/stp
         8iFUSSwd6beRgXzcAG/PxXtJbe6aV4l+upxYrX3p3RO9yvYlcfrRXMMdirC4P46Bmr/Y
         G7kw==
X-Gm-Message-State: ANhLgQ0YbIxo+dTZGrC2BN2P+HVZBZnoWjrAkaUyZ9ItUJAV/WPw+3Iw
        O8/glx62qcKerqFDdUvNOuCbjlgkNR0=
X-Google-Smtp-Source: ADFU+vvbv+Xme+v0uvsvvpc8UaT/vO8bsa54ziwZd+9CCxqVrEHqsorBKyKPgoatMX2+vHM9mYDjnw==
X-Received: by 2002:a05:620a:1231:: with SMTP id v17mr3234848qkj.126.1584529046785;
        Wed, 18 Mar 2020 03:57:26 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id u123sm3826325qkf.77.2020.03.18.03.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 03:57:26 -0700 (PDT)
Subject: Re: [PATCH 1/1] submodule--helper.c: Rename 'cb_foreach' to
 'foreach_cb'
To:     Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org
References: <20200318095842.27679-1-shouryashukla.oo@gmail.com>
 <20200318095842.27679-2-shouryashukla.oo@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f6ea8357-a5c3-169c-b3c6-9d1726e65859@gmail.com>
Date:   Wed, 18 Mar 2020 06:57:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <20200318095842.27679-2-shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/18/2020 5:58 AM, Shourya Shukla wrote:
> In 'submodule--helper.c', the structures and macros for callbacks belonging
> to any subcommand are named in the format: 'subcommand_cb' and 'SUBCOMMAND_CB_INIT'
> respectively.
> 
> This was an exception for the subcommand 'foreach' of the command
> 'submodule'. Rename the aforementioned structures and macros:
> 'struct foreach_cb' to 'struct cb_foreach' and 'CB_FOREACH_INIT'
> to 'FOREACH_CB_INIT'.

I believe your "<before> to <after>" statements are reversed.

> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  builtin/submodule--helper.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 86a608eec1..1a4b391c88 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -444,19 +444,19 @@ static void for_each_listed_submodule(const struct module_list *list,
>  		fn(list->entries[i], cb_data);
>  }
>  
> -struct cb_foreach {
> +struct foreach_cb {
>  	int argc;
>  	const char **argv;
>  	const char *prefix;
>  	int quiet;
>  	int recursive;
>  };
> -#define CB_FOREACH_INIT { 0 }
> +#define FOREACH_CB_INIT { 0 }
>  
>  static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
>  				       void *cb_data)
>  {
> -	struct cb_foreach *info = cb_data;
> +	struct foreach_cb *info = cb_data;
>  	const char *path = list_item->name;
>  	const struct object_id *ce_oid = &list_item->oid;
>  
> @@ -557,7 +557,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
>  
>  static int module_foreach(int argc, const char **argv, const char *prefix)
>  {
> -	struct cb_foreach info = CB_FOREACH_INIT;
> +	struct foreach_cb info = FOREACH_CB_INIT;
>  	struct pathspec pathspec;
>  	struct module_list list = MODULE_LIST_INIT;

Based on the description, I was worried this patch would be very large.
The fact that the change is so small makes this reasonable in isolation.

Thanks,
-Stolee

