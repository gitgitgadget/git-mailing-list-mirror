Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32FEEB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 13:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjFWNGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 09:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjFWNFy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 09:05:54 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A572133
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 06:05:53 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b46e61638eso555580a34.0
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 06:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1687525553; x=1690117553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jtUMZ+zsmYuqhoYRQjI1HCi2X/06Wjg5IgH9zoQ5hjg=;
        b=dVgIi0AkLDQ/hEmH+7ZNmkG/j614nrwSclPa+duQIUMkvm97UxoVDlB/knHIsLFrfG
         wEuiNjN/Xsv8pIJ2UbT+B/GvxqtWe/soefzxVFoTxgMyZ5FTFgkqPMAjwsFBOEE4LgPG
         4jhPK+TWwD16eZWS4S9OKa+kfmNx5B006WM1By3dzz0p+8OMPlpAHGlkJsI+kMWar4j2
         cbE4D/Dddhb0KyNoGV07CygWOOAtq+pHv9SV7f9Gb2I3yXtPRLBC8Vlk+1bPCCqjNi6I
         tNhsMrrwFsPXeGFMdlbX6N3JYDbrJh2TvSOaCVvHgETneRVQGuZ6pJNGRuuNphzLHjJu
         ioZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687525553; x=1690117553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jtUMZ+zsmYuqhoYRQjI1HCi2X/06Wjg5IgH9zoQ5hjg=;
        b=kODBEV+PPHa1hO1BS/AbeTNiAne8USoEKucN508ZeLOSLjmyoJAVwiBn0nvLy38aG7
         fn10+WJR57iyt9PaXOAutRwHg8niSKPtNBakAO//6sWIqsJoYLBGR+OOtxImg553EE77
         FQWasKtoT8SoTBE8lIukxMraCXgbX4UvAXoBUbHg7/sLqmfruKYH9Rkv0kgLyiv++BFV
         k7qhwFTrR4kAaAPegrKOk2Be4m8Rx9Khgdrc5RNLL1A8S7iFg/Dh56K31VwQWNpMJQqz
         TG8hdx4uRLa4abHIX63ILckItNTqKoEYpQQ90qIkyNDLXKRmTcuaF2/uQ9ky2oItNp5D
         6VRg==
X-Gm-Message-State: AC+VfDzsb4IEY/gqOUIvw/RMRqQTUbWjiQWoKn9074mzlqpXaIKa0uP9
        RCw9MgGAx+NXTwZc3wa/wR8ysANj3KHHD3YzNw==
X-Google-Smtp-Source: ACHHUZ6zNfWrSy195SVdaC9nS9HEUoMxsgv2cLoeBM5qS09S48JzeoTUkrbePHQWsX8H0IR+2SmBow==
X-Received: by 2002:a05:6359:5a4:b0:130:e721:f4d6 with SMTP id ee36-20020a05635905a400b00130e721f4d6mr12548345rwb.16.1687525552821;
        Fri, 23 Jun 2023 06:05:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:ed06:4a41:daac:5b11? ([2600:1700:e72:80a0:ed06:4a41:daac:5b11])
        by smtp.gmail.com with ESMTPSA id k124-20020a0dc882000000b0056d4649670fsm2449202ywd.133.2023.06.23.06.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 06:05:52 -0700 (PDT)
Message-ID: <e57b2272-b269-b705-3d42-d32e0b410f03@github.com>
Date:   Fri, 23 Jun 2023 09:05:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/4] gitformat-commit-graph: describe version 2 of BDAT
To:     Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <20230622222637.2045705-1-jonathantanmy@google.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20230622222637.2045705-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/22/2023 6:26 PM, Jonathan Tan wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>>> I wonder if we want to mention what the undesired misbehaviour the
>>> "bug" causes and what we do to avoid getting affected by the bug
>>> here.  If we can say something like "When querying for a pathname
>>> with a byte with high-bit set, the buggy filter may produce false
>>> negative, making the filter unusable, but asking for a pathname
>>> without such a byte produces no false negatives (even though we may
>>> get false positives).  When Git reads version 1 filter data, it
>>> refrains from using it for processing paths with high-bit set to
>>> avoid triggering the bug", then it would be ideal.
>>
>> Your description of the bug matches my understanding of the issue, that
>> a corrupt filter would produce false negatives and thus be unusable.
>>
>> I skimmed through the rest of the series, and couldn't find a spot where
>> we do the latter, i.e. still use v1 filters as long as we don't have any
>> characters in the path with high-order bits set.
>>
>> I think this would be as simple as modifying the Bloom filter query
>> function to return "maybe" before even trying to hash a path with at
>> least one character with its high-bit set.
>>
>> Apologies if this functionality is implemented and I just missed it.
>>
>> Thanks,
>> Taylor
> 
> Thanks for the suggestion - yeah, this might work.

If I understand the situation correctly, the high bits can make the
hashes "not very random" but they are still effective at identifying
the "maybe" case consistently for the inputs it is given (it would not
present a "no" when it should not, but it might say "maybe" more often
than it should). The behavior is only incorrect if the same commit-graph
file is used with two different Git versions that were compiled with
different signed-ness.

If that is the case, then ignoring the Bloom filters when you see a
high bit would change the performance implication from "probably
slower" to "definitely slower" but not affect the correctness in a
system that doesn't have competing Git versions with different
compiler semantics.

That is to say, doing this extra work doesn't seem to be critical to
making this change. The ROI seems too low.

Thanks,
-Stolee
