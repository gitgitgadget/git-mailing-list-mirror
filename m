Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2D9C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 13:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42528206F7
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 13:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsulE80C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgIXNxT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 09:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgIXNxT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 09:53:19 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048ECC0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 06:53:19 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id y5so3211931otg.5
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 06:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=txB/ospDs9BQm6xpTAaTcNTcs2ytGqeCdwO5LJdfbE8=;
        b=gsulE80CUZsut/4mSAYe6iq8kCC0EJKL5ketuVLMCiR3InGYujzwYq/dpCVaMX0pJ0
         WsnxzwzOhfYrZV8SaS1Pi9GzhbxI19mhqAqhl9+GK7VeqcEUVrwr6yBfFnWdkiXTNYKf
         SifU2idlpuZO/zFB6qBDrL/O4XGbIBUs/TUC/GK+ca8brO06AH9An6+rXEARcYkZAjJw
         SdC6aFJh5UGqLDp/+ZpTTfOpBK0jSWM6mZJOgMBuK70wqXNqmR3KCTP/2fJ1XUxxNPC0
         yTIcNipDMaHN7oZsMbzXoZiIGwYO+CFowGxUi+aGbm8msQTrg1Hfk3o1kJPzZtq84ZNl
         yrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=txB/ospDs9BQm6xpTAaTcNTcs2ytGqeCdwO5LJdfbE8=;
        b=Mqq1U3Vb3ny7zq0KsFewaaUCZHgcUwVYlnu3EF08/mlmcmXtfK1GIZZsyVqtyAue/3
         n3wqsEmrt4VcjWQushYQ15ymsk0+IfHgkKwW7XLlimyQHY9vJQSE5fg3aUo6513Z7TJV
         lE5UfSw2BzOakbvgybQeFD6y9VTAz1TDzG0yirih0SwL/nJW9+oJsKGWKaESwWdBr9+m
         79my94NuhgaXmV8MFgS37Ix6rkXsW9k8w3dT509S4lI67YIpoeMBBoh4cZNJ71ZLQ9bA
         iF7Pxt1I2o0fTGRZSbHDy62/v8/YE4CAKU+U+x2Iyf7y3M7oicRtmavjTbwbPEmXETvt
         us9Q==
X-Gm-Message-State: AOAM5332LmdyBRAUVlxFfEarUe11yc/JCHbBRb0j7P6/4IA2hT408ACd
        9IBUNZOzseHPp1EPAGcvX6Q=
X-Google-Smtp-Source: ABdhPJz/9Gz6kGAibZbHGaZTEF1HYH1ynGeLBmbRh8AJ2muzVGODapMELZzUq3JmVpvldjRNzXmgiQ==
X-Received: by 2002:a9d:b97:: with SMTP id 23mr3355754oth.54.1600955598387;
        Thu, 24 Sep 2020 06:53:18 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:79a4:d6bb:a424:ecd4? ([2600:1700:e72:80a0:79a4:d6bb:a424:ecd4])
        by smtp.gmail.com with ESMTPSA id 189sm648434oid.40.2020.09.24.06.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 06:53:17 -0700 (PDT)
Subject: Re: [PATCH v3 4/8] midx: enable core.multiPackIndex by default
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        derrickstolee@github.com, dstolee@microsoft.com
References: <d0f2ec70d9dc0b4901704d48bf5cbddbd6e50c01.1598380599.git.gitgitgadget@gmail.com>
 <20200922231652.910686-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d48be601-4e9e-ed9c-93f8-47e6e295adac@gmail.com>
Date:   Thu, 24 Sep 2020 09:53:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <20200922231652.910686-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/22/2020 7:16 PM, Jonathan Tan wrote:
>> diff --git a/repository.h b/repository.h
>> index 3c1f7d54bd..3901ce0b65 100644
>> --- a/repository.h
>> +++ b/repository.h
>> @@ -37,6 +37,8 @@ struct repo_settings {
>>  
>>  	int pack_use_sparse;
>>  	enum fetch_negotiation_setting fetch_negotiation_algorithm;
>> +
>> +	int core_multi_pack_index;
> 
> The only thing I noticed here is why this isn't a bit ("unsigned
> core_multi_pack_index : 1"), but I guess it is consistent with "int
> pack_use_sparse".

The _real_ reason is that we initialize these to -1 in
prepare_repo_settings() so UPDATE_DEFAULT_BOOL() knows that
the setting was not populated by a config value.

Thanks,
-Stolee

