Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C27CC433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 20:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C5161358
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 20:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbhDLUYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 16:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237967AbhDLUYN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 16:24:13 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63348C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 13:23:54 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id y2so10991892qtw.13
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 13:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MiBEe91HKAoCATDagn5KAOzow68JnpDzi3TDF+H9HOE=;
        b=opEj+H11GRcjDzChPg7Mo3MotCXaY7gxJrwKhsl9YlWgAXw5OHtsP1cE2yUOR4VDeO
         aPsZM67x+d26/H0LSg1rStXyqAlt/mnbKYrZBSmxTFTy9WMQ1SbzaW/0AGh/fezKYdE2
         1W2nOC1VnUVhkNX1bfLCmm5v4KekXgE8L/La9cSYd/mwdldMHNGiK7+SO9wzpWwhM+UH
         SetgniIhlPnNOUbnwmnRcj3oDM1N5kddPWb3mzb4tfv2TRSiKxR6XmOiZMRKDTll0ZKS
         PExJsWWFAny66gQxmk1OZ0KPYzbL6972el3S7kj5+isHeY0R4YLcYqzKNeJm/p/EGjMx
         vOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MiBEe91HKAoCATDagn5KAOzow68JnpDzi3TDF+H9HOE=;
        b=gTwOp2MeYJ8cDim7Md9VCqAr7iTzOAPDz2ySMesuGaWsz3awZFVFOkWw2oVj1+KsRz
         2UPQew1m8FbGBUJfZSBiCqp6e/Duh+uCw2dfiamLRK3dh/AgZVJsHVjF0kLZxLb770jD
         e+j6Kboe48dcnWjtPQf9r4RoNY51jfKb8WQDpljDSIZN67H6t1Xz4wEfTo00GYs/wwPO
         EgTAF2PNj1WfJekcOrdn+QvIok/UixkRZEJOCT9OjQs9Y465kG1MBHe4FuVBayBkH+TW
         fo48EMbO1p1cYxb+dR/A6hu5bApD3ij05wPhhLAfDZ9QxbOmpqzFbe1QhwIXhO0VddCC
         X/sQ==
X-Gm-Message-State: AOAM530d9ZZ388O4I5YH4ggRTjq9ZGNtxsdT5C48BNNXmG5xfI/V01F/
        A2nlF3W2f6jGB7O0o3/Xqx8=
X-Google-Smtp-Source: ABdhPJwtBhDcF5uKe0UGBiPkxILVdsBWKa3L8+okEtYUo2i5JKBCy2SkC8xWK3FaC1nteHzOblTUog==
X-Received: by 2002:ac8:6f31:: with SMTP id i17mr9973629qtv.184.1618259033403;
        Mon, 12 Apr 2021 13:23:53 -0700 (PDT)
Received: from US0059EMPL003.northamerica.corp.microsoft.com ([2600:1700:e72:80a0:40c3:ffa7:673:48b6])
        by smtp.gmail.com with ESMTPSA id a10sm5606343qtm.16.2021.04.12.13.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 13:23:52 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] fetch: add --prefetch option
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     tom.saeger@oracle.com, gitster@pobox.com, sunshine@sunshineco.com,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
 <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
 <7f488eea6dbdd93ff1a97a2572de7ddb0d65b7e0.1618020225.git.gitgitgadget@gmail.com>
 <9e009c7e-a2bf-1740-ba43-c64a97f1dc28@ramsayjones.plus.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <28857e57-d9c6-ecb9-8a7d-d85a29f20f33@gmail.com>
Date:   Mon, 12 Apr 2021 16:23:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <9e009c7e-a2bf-1740-ba43-c64a97f1dc28@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/11/21 5:09 PM, Ramsay Jones wrote:> On 10/04/2021 03:03, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>> +	for (i = 0; i < rs->nr; i++) {
>> +		struct strbuf new_dst = STRBUF_INIT;
>> +		char *old_dst;
>> +		const char *sub = NULL;
>> +
>> +		if (rs->items[i].negative)
>> +			continue;
>> +		if (!rs->items[i].dst ||
>> +		    (rs->items[i].src &&
>> +		     !strncmp(rs->items[i].src, "refs/tags/", 10))) {
>> +			int j;
>> +
>> +			free(rs->items[i].src);
>> +			free(rs->items[i].dst);
>> +
>> +			for (j = i + 1; j < rs->nr; j++) {
>> +				rs->items[j - 1] = rs->items[j];
>> +				rs->raw[j - 1] = rs->raw[j];
>> +			}
>> +			rs->nr--;
> 
> Hmm, don't you need to do 'i--;' here?
> 
> (Sorry in advance if this is nonsense, I am just skimming the
> patches without reading the whole series carefully).
> 
> Maybe try a test which has an entry, which requires the 'prefetch'
> modification, that immediately follows a 'tag' or 'empty dst' entry.
> (I can't quite tell, just reading the email, whether that is covered
> by the tests below - so please just ignore me if it already works ;)

You are absolutely right! Thanks.

-Stolee
