Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F94C4167B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58566238E1
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgLGTVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 14:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgLGTVg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 14:21:36 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00A7C061749
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 11:20:56 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id q25so8558577oij.10
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 11:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IflRYolgmSmpXjqCyoEq1gWihhRlhp7NlR4/HZTHQ7c=;
        b=qxlUSV4ihGhJIEXK8YDlWg8fwCtRvBjoB/LBXcIYWQz5Glr4Glsk4PBD666LidYXPj
         UFm+0bR/Pc7cLxlkRXD1iV/NxOAcmnmlz1mHsyl9/HvFfznASD7bQmwLMT8Qu9oZzFbo
         IILv042lrmk9BwTQuM8EsmcZS/LB5nQWWo8UDChiRS3qQQfiQyyOuUxRpqOVQ8gfcATz
         QN8ADNAajyVGHm2VPH/B+HRKNXpGjqZiaUwDjjwcnUa040kBX304DEZbnlfzVfYXa9Uv
         71gobwl6gaIrnxQeuFMtQBlxsAGUAbm5VVpN8aP/36onZpVrGZIQZBJSK+txBBQtQwhC
         BbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IflRYolgmSmpXjqCyoEq1gWihhRlhp7NlR4/HZTHQ7c=;
        b=tZk+Bmc/e7xV1CZ08WBLuXtODk9ewi2XOo40inTd8qDWvVDP8UkD+7lzk6M5luEJK9
         zMK62FSC9eIud1uKtSzuMmJApdxyM/8XXLxXcQFQi9doJ39/2wl5iNFRoqL7oFg8lfw/
         cGyoEMFMRmUHYYMqmYl/BvcLwXm41SCA2wDXas4/DfBm9LnmjVAXvnKH7lyB92EBoqFg
         dzGyLwJFWw/xFXcGXK6kzFfu7Y62gRZsVcsm8v2s9fteY8HfARSvYeIITN/dTc3gFO8y
         eBY+C0qb291kYi/bQwN/2nOXmFYRp8R7OjrsPZMQVw17Nu5Sp9b1Qjsx6YHrBvc35QUw
         6Z/g==
X-Gm-Message-State: AOAM532JoDgBi5NyCbO5PEkit7XqQXHZnaicwBIL7Y/ZbPsh5y4QIqcV
        fAzG4ZgDPZIjNO4sjz+K9ZQ=
X-Google-Smtp-Source: ABdhPJy7cxhxPeWP5UmTL4IHhbjQa5/tXBP6Anf3O/CkqnS1eidsha3TT4MMF4Lv/nuieVhpiM+3Yg==
X-Received: by 2002:aca:45c6:: with SMTP id s189mr262906oia.25.1607368855922;
        Mon, 07 Dec 2020 11:20:55 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:8ddc:62f4:9dcc:ce02? ([2600:1700:e72:80a0:8ddc:62f4:9dcc:ce02])
        by smtp.gmail.com with UTF8SMTPSA id 6sm2841940otc.19.2020.12.07.11.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 11:20:55 -0800 (PST)
Subject: Re: [PATCH v2 24/24] pack-bitmap-write: better reuse bitmaps
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, dstolee@microsoft.com,
        gitster@pobox.com, peff@peff.net, martin.agren@gmail.com,
        szeder.dev@gmail.com
References: <39441f40-f496-af81-87c1-9d7e04fdef20@gmail.com>
 <20201207182418.3034961-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1cd3f001-389f-6e2e-90fd-5e8b4b17119a@gmail.com>
Date:   Mon, 7 Dec 2020 14:20:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201207182418.3034961-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/7/2020 1:24 PM, Jonathan Tan wrote:
>> On 12/2/2020 11:35 AM, Taylor Blau wrote:
>>> On Wed, Dec 02, 2020 at 12:08:08AM -0800, Jonathan Tan wrote:
>>>>> +			c_ent->maximal = 1;
>>>>> +			p = NULL;
>>>>
>>>> Here, we're setting maximal without also setting a bit in this commit's
>>>> commit_mask. This is fine because we're not propagating this commit's
>>>> commit_mask to any parents (we're not continuing the walk from this
>>>> commit), but it seems like a code smell. Suggested fix is below.
>>>>
>>>>> +		}
>>>>> +
>>>>>  		if (c_ent->maximal) {
>>>>>  			num_maximal++;
>>>>>  			ALLOC_GROW(bb->commits, bb->commits_nr + 1, bb->commits_alloc);
>>>>>  			bb->commits[bb->commits_nr++] = commit;
>>>>>  		}
>>>>
>>>> As far as I can tell, this means that this commit occupies a bit
>>>> position in the commit mask that it doesn't need. Could this go into a
>>>> separate list instead, to be appended to bb->commits at the very end?
>>
>> I don't see any value in having a second list here. That only makes
>> things more complicated.
> 
> It does make things more complicated, but it could help shrink commit
> bitmasks (which seem to be a concern, according to patch 23).
> 
> Suppose num_maximal was 3 and we encountered such a commit (not
> selected, but has an old bitmap). So we increment num_maximal. Then, we
> encounter a selected commit. That commit would then have a bitmask of
> ???01. If we had not incremented num_maximal (which would require a
> second list), then the bitmask would be ???1.

OK, I see the value. The value is bounded, since the number of
these "0" gaps is bounded by the number of selected commits _and_
reduces the possible number of maximal commits.

However, that seems like enough justification to create the second
list.

Thanks,
-Stolee
