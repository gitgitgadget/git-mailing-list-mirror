Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90198C19F2B
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 17:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242968AbiG0RnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 13:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242794AbiG0Rmr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 13:42:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA8D54AC4
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 09:52:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z6-20020a056902054600b00670e3c8b43fso11725654ybs.23
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 09:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=UScWh6AoiYfPXB7YXtS+uO2dyfRXcf3KisI9iCue6HE=;
        b=tOz5SrifHsOn/hEe2OLiNOzkEgnkkTKfYkpwGt0srgigi4CGZYW7k8QsGcJPlgkDHB
         mwUwVupI60ARcc6c3pDlmIEVGTCVOIrAm8zF/dZBAX1usovBkEzKcQjRcN9aHF+TLsgc
         m/UuQzBj2gVL/YnRI54YQz4RDYUK+RxY9zQ2Ul1jdsaD3+S4XF2hVen8q5yEBP2Y/NqU
         Awy6yat1Vo5hqBk3cj6/e+F6BwNfeo0CxoooXN0QppHXFagI7Lm0SgzsJnq3zf10CGLY
         JqWbMnUk33pPqzqVK/wvSIOuAdg5jAzyxUjQK0iLyC4tAZwRyJENhMsrrNMvQG3bg1Yn
         umhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=UScWh6AoiYfPXB7YXtS+uO2dyfRXcf3KisI9iCue6HE=;
        b=B3Pa5leZCNeAoZCuvODDbwwNBuhb8Bkv9/zHjpm+78Cq1q1Fxf5m/q+EIA3h/KrqF7
         01nd4rf2sLX/Wemg+ahfM036c+VBxptZFNGxs+Ol7DFlXjbJnOej8Br+2uSsrwPYaM0d
         nsRuZOjA+pWR3FnBgvkyJ7K1iasSto4uc2x9OXL7pAa+phjq0Pn3qTEwyLMw5NY8FLx6
         67s45EISu886Y3AkRkHgnjckrINOyMkuPDnVXzwgZPuZmrdnMcuIh8YU/ObR49WUTk/d
         MJsOj9nG4gU4M647hsASCCAcV9MTjm2W5jI9JxlhyNeiEuDp+2n0tQPZBaBTTQaSt0on
         1Yqw==
X-Gm-Message-State: AJIora8sroY56R4KN3sBhumxpTsjuzvyZp5lasEsACTzQUoCUnSqwoCD
        Jblha8Ol2x0kM8Vt8ohw08ZPfC5k9zQx2A==
X-Google-Smtp-Source: AGRyM1u1oD9TrmBVfvDRgvKUPJWCSr+i+RG1pImBUqDYTUKvGpBX54Tu5H2HM71QkSnPGzVhHwaaUKoSLfE5tA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a81:59c4:0:b0:31f:4804:76ad with SMTP id
 n187-20020a8159c4000000b0031f480476admr8179387ywb.143.1658940733960; Wed, 27
 Jul 2022 09:52:13 -0700 (PDT)
Date:   Wed, 27 Jul 2022 09:52:12 -0700
In-Reply-To: <xmqq1qu6txb0.fsf@gitster.g>
Message-Id: <kl6lczdqsdkz.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1299.git.git.1658855372189.gitgitgadget@gmail.com>
 <pull.1299.v2.git.git.1658874067077.gitgitgadget@gmail.com> <xmqq1qu6txb0.fsf@gitster.g>
Subject: Re: [PATCH v2] config.c: NULL check when reading protected config
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It however makes me wonder if it is simpler to allow passing NULL to
> git_config_from_file_with_options() and make it silently turn into a
> no-op.  I.e. instead of ...
>
>> @@ -1979,6 +1979,8 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
>>  	int ret = -1;
>>  	FILE *f;
>>  
>> +	if (!filename)
>> +		BUG("filename cannot be NULL");
>
> ... we could do
>
> 	if (!filename)
> 		return 0; /* successful no-op */
>
> Even if there are codepaths that feed arbitrary pathnames given by
> the end user, they wouldn't be passing NULL (they may pass an empty
> string, or a filename that causes fopen() to fail), would they?

Yeah, that's worth considering. I'm not sure how I feel about it yet,
but hopefully I find some time to dig around and form an opinion.

>
> But that is something we should leave to a follow-up series, not
> "oops, we need to fix it now" fix.
>
> Thanks, will queue.

Thanks :)

>
>>  	f = fopen_or_warn(filename, "r");
>>  	if (f) {
>>  		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename,
