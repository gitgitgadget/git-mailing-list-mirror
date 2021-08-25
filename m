Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E651DC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 01:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9CE36108F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 01:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbhHYBKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 21:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbhHYBKF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 21:10:05 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEE8C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 18:09:20 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so42692655otg.11
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 18:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AaAKutk843LXgKxG1VO8tx0c31ivLiz4JHxtqAd1EIQ=;
        b=m8vNIhsRkKpTuQc1e5CPRDIfzpQbk7OReMdttxaThHY019NCvcS6N0nsmtFfwbRwVk
         cbDkj18pSWShNTOtedBHyuKZp1N0QCwk4dluMCqG9wEiByMcBfN2o4b/CbQegPoef5Tr
         eVV9dEmt4J2HP/F6WWoEgbWJOm4eHwpqVAcmA3OEvxxtw7BCJr4C3cw6xC3QuulA/pFY
         wXdy/OZsD7XstYFT3moNai30nrRP1MgyeSAVkzccnC8HHpzCBF0JkHdhSgWqkwiayrfe
         hl1V6rzsVbRo2TjLlHc+TAtKVcyty7H5gFzLguxGoPjflb9PXmo+3cOFFAonV/pNPgqc
         yLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AaAKutk843LXgKxG1VO8tx0c31ivLiz4JHxtqAd1EIQ=;
        b=a/RbeqKGJxWkfvHnoJr/ebQHwqSWseAXBADNhnO8sRKnxLW5+LhPeAtcCEh7/D7/23
         2xDmHkj+oD4uJ6fKkYAJ/3+etMdCVxYAPAkQA3uKIXoAxgtDnZ3bexu3QAEude0k82W/
         APutKFaVC90K8nQ0SVi9WudmXmGENvSTxqCvpFRWTNiQHZgk7h4yx7SQAgAkEtgk+5Qp
         OufRmY2J4roI3y6GWmAc9UkMHUjpHgl70zHOcNDVxsYNE0hG3+lWneLDD+5f7sySUiad
         kchGwYMfzqHc25EPzZ+SCHeRwjVV1YSQPjYLQC68BKZIsERYo3m/cMuIWDI7aLUtIoli
         4iZA==
X-Gm-Message-State: AOAM533XV02nY+GDuopEJgYXNR3On0zv7w2EHLHP6CvT+y9JLpBaWlQ6
        U5pv8RYxLUdWhmfoo0NISKg=
X-Google-Smtp-Source: ABdhPJzte3hgJj6YDnxgoNr9+33hMlkwLb0pbMXU2woQcCP2oyW/b3TGk6HETtrC6mZR+bkKV25ccg==
X-Received: by 2002:a9d:4e96:: with SMTP id v22mr32957480otk.110.1629853759917;
        Tue, 24 Aug 2021 18:09:19 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:1839:e469:b9a3:fa29? ([2600:1700:e72:80a0:1839:e469:b9a3:fa29])
        by smtp.gmail.com with ESMTPSA id b2sm3872909ook.46.2021.08.24.18.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 18:09:19 -0700 (PDT)
Subject: Re: [PATCH v4 05/10] unpack-trees: fix nested sparse-dir search
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
 <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
 <acdded0f762800392515c83aec2b276c62ad691c.1629841904.git.gitgitgadget@gmail.com>
 <51c11512-fb71-277e-790b-88ae3d5a358f@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <249acb56-99bc-4a2a-b3d8-6b697643cf4d@gmail.com>
Date:   Tue, 24 Aug 2021 21:09:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <51c11512-fb71-277e-790b-88ae3d5a358f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/24/2021 6:21 PM, René Scharfe wrote:
> Am 24.08.21 um 23:51 schrieb Derrick Stolee via GitGitGadget:
>> -	struct cache_entry *ce;
>> +	const char *path;
>> +	struct cache_entry *ce = NULL;
>                               ^^^^^^^
> This added initialization doesn't seem to be needed...
> 
>>  	int pos = find_cache_pos(info, p->path, p->pathlen);
>>  	struct unpack_trees_options *o = info->data;
>>
>> @@ -1283,7 +1284,9 @@ static struct cache_entry *find_cache_entry(struct traverse_info *info,
>>  	while (pos >= 0) {
>>  		ce = o->src_index->cache[pos];
> 
> ... because ce is set here before it's used.

Better yet, 'ce' is only used within the while loop, so its
declaration can be moved to this line instead.

Thanks,
-Stolee
