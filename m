Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154EAC43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 20:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbiFNUeb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 16:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241415AbiFNUeV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 16:34:21 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BEE2FE46
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 13:34:20 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id p128so10674378iof.1
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 13:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=4T2Ywsj90bxUmbWpJJGi0xUWN1sQS5iPSHSCutpvKUs=;
        b=KVgkTpPeZ5mQg4UhHhSPXmCmM419eEZ9fzVrF6trpp/a5ExqTaRplft36MeA3qzZv9
         LKnysZLE6H7qEPnmwTlVReim4OL/52cvtF7TGAXWdLQtK7WjvvLnTqb1qtVTlAPKa8o+
         s6j63NqjteG8nuXb5w5njAKdUqWEmQv5U5rZjfTQpkN2I0oTtlkQo5HSLnTltEQr7giC
         vrnvvaVxMboBFaR8WdHOMccGOQbp0I1qKlGXilqs9sR1AWl/nuZMei79QUpDJYQui+aR
         Wo8hzikIVjO2Cfbxj/IeQPHSaQG6+H3aQ2dpK3FQ2HBeyRiGvsVCmphFmuUq40pbfRHt
         Q50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=4T2Ywsj90bxUmbWpJJGi0xUWN1sQS5iPSHSCutpvKUs=;
        b=NDr9L3jD1ZDIFMb6Eu3DdxfC+fZkMCsCZyItxu9gDRP1tdkU+7PXPkc4sEmdKjmDIV
         SRHSVdiFF7qJmRGr7m4v/gLIYZ/QKLgkwsY/HcpWrWD+C8BCIMq8aAk8BL+AGTS+7fDp
         5y9cOAYBovxOjRqhDdTyGwwIfzD4jdStiit1RjSdnh56pcv17jjHYCzFcuBhUy5JMCIs
         L7vG+OR0N7UU5tsGnIFRYY6y9jZkmJ6OSnEI7veaGBYVX4hcM0BIKsMIgJtI8Q+InsXJ
         kobAr6QHmobde84dI4dIP1fo4b93sV7IIF77M+NsWUZgVDcymb6MdDKEuV0WtyC3cU8E
         GNUQ==
X-Gm-Message-State: AOAM531GGRpCVmBKZZuWnntEA+8PamLrjnqQ8OK9DEjGeNRg6Ct8MiXW
        pxOrCNzfP3v9AT3uyaQT3wNnLIpHcVnWHE8T5Qn9ZPmtbAmlfaXSaLNow1R6BXzxfhkgNmGum3C
        PKo5NT/fJA2nv7GnAD8DA9j6k5D1ZPNq3Ruyt8Aa5KX0p/mooPJEX1smDv++e768C65JbIA==
X-Google-Smtp-Source: ABdhPJyFRq1Ojj32iHbJMxyWOUgrQiMtDyfQL7DNrTkT3xoLdGNHmGoiqWzkCeAaVWsFyvsAE7jBaA==
X-Received: by 2002:a02:a98a:0:b0:332:b171:df78 with SMTP id q10-20020a02a98a000000b00332b171df78mr3869110jam.54.1655238859642;
        Tue, 14 Jun 2022 13:34:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:508:3b97:7c0b:efc0? ([2600:1700:e72:80a0:508:3b97:7c0b:efc0])
        by smtp.gmail.com with ESMTPSA id 62-20020a020a41000000b0032e0a9d63e6sm5259465jaw.118.2022.06.14.13.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 13:34:19 -0700 (PDT)
Message-ID: <cdc0cba8-bd9d-9299-a769-aa7b522520ae@github.com>
Date:   Tue, 14 Jun 2022 16:34:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Git Test Coverage Report for v2.37.0-rc0
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Neeraj Singh <nksingh85@gmail.com>
References: <00a57a1d-0566-8f54-26b2-0f3558bde88d@github.com>
 <3d1c6dfd-1df6-3393-df5e-692719375772@github.com>
In-Reply-To: <3d1c6dfd-1df6-3393-df5e-692719375772@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/14/2022 4:20 PM, Derrick Stolee wrote:
> On 6/14/2022 4:18 PM, Derrick Stolee wrote:
>> Derrick Stolee	b56166ca multi-pack-index: use --object-dir real path
>> builtin/multi-pack-index.c
>> b56166ca 61) opts.object_dir = xstrdup(get_object_directory());
> 
> This is demonstrating that opts.object_dir is never populated before
> we parse the options. We must be handling a NULL object_dir properly
> somewhere else. I'll work on a patch to fix this.

I was looking at the wrong line. This line is testing the --no-object-dir
option, which is fine to leave untested, probably.

Thanks,
-Stolee
