Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8979FC433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 20:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240498AbiCGUVW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 15:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbiCGUVU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 15:21:20 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EC250E34
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 12:20:25 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so19266897oos.9
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 12:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PCOtIyZh6lj25FCVI0mtmLmPgGcH7XD30+MqmyikG20=;
        b=OAkk4axRE7nFbZL0pHFVeMCe+tOOgmHvFX+l/mjavaNlAe/oiBphCnMnTPTQjH5eOx
         6nSHXVjAEONfMDWyl9jH6M2/KNXS3aSB10wnOk5UvsG3dysOTAX64YTVC376IvW2YSOm
         jT357LXcvOmUlpHO7S+AAu03PvmwRTAvxYL46VlIiyvyO5KOZn7muGAbQdonWQ1wvS84
         mRWJ5bSPPuTLRb/pUgtcLHH1SrL2M/jixC9KjfnXCCwI/BF6kVFBtZ07H0E7kqeBr+xy
         fTqiQtzcqpQY++iE4z70jDMgfRzXn/XUwOGYho2+yxItxydRDdESiKoSbf9A7kvP8AE+
         nGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PCOtIyZh6lj25FCVI0mtmLmPgGcH7XD30+MqmyikG20=;
        b=P98HENZVVTBWUQ5z+lIW3KC9po5/a3yhwTgF708w82uVOTnplV/VFEw3Em0bgIElOv
         Q/kuNjxIstICFpARsPswuYJg0OWByM9rEz3h44D35fCxpkeA+YCrs8k10IKSWLYeMxXX
         wTHHSneYQy6mqhrCS3tYn/z4hpwTgySwQwUL4vyP1Tn4e3Nk63OzlAvP3XDMJ/2U5dFO
         fhOPofvSDKdSddoLl7qnMAI2NiWliidAZkf3nC8KnPU8kSPgl/6mT6y2oUDUjvXFhkuy
         nWOXrPAVwsg8QvZ+RIC+R7Kd/R8pSOzQ6r0x6YZjVSOzsPEa3QHs1g4KAqWprK3ZR91M
         bdNg==
X-Gm-Message-State: AOAM531SBrEPFDXWQDrlksO/Y587+9Io5BsbiKYVepNi8oKX+atV/Gab
        OB6Cv/R4JUwbg7MJ03EFYQrO
X-Google-Smtp-Source: ABdhPJyRpbjb/L2jRM3LnOZrRPAl5yeSq5+1VdcozCCw04CPWIsyciy+vFlpKkwQqbxxiMRVnsgDUg==
X-Received: by 2002:a05:6870:ec8c:b0:da:249c:1807 with SMTP id eo12-20020a056870ec8c00b000da249c1807mr465455oab.148.1646684424846;
        Mon, 07 Mar 2022 12:20:24 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l6-20020a056870d3c600b000d75713938csm5957708oag.7.2022.03.07.12.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 12:20:24 -0800 (PST)
Message-ID: <24c277cc-5649-2de6-854a-8d87bbfd7b91@github.com>
Date:   Mon, 7 Mar 2022 15:20:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 11/11] bundle: unbundle promisor packs
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <ec51d0a50e6e64ae37795d77f7d33204b9b71ecd.1645638911.git.gitgitgadget@gmail.com>
 <xmqqzgm5wafu.fsf@gitster.g>
 <ee6c7a5b-63e8-af1c-fdb7-75dca9cd798d@github.com>
 <xmqqv8wpu2fq.fsf@gitster.g>
 <85d434f8-0eb1-c6f7-dfd4-99bffbfbba57@github.com>
 <xmqq8rtlsg9h.fsf@gitster.g>
 <51fabaef-4849-2d9f-285a-3f442f803717@github.com>
 <xmqq35jtsfm9.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq35jtsfm9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/7/2022 2:54 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> I've been trying this:
>>
>>  git clone --no-local --filter=$filter "file://$(pwd)" cloned &&
>>
>> which "succeeds" with this in the stderr:
>>
>>  warning: filtering not recognized by server, ignoring
> 
> Hmph, and we won't see it when going over ssh to the same
> repository?  That is puzzling.

Of course, it's not an issue with file://, but an issue with the
defaults. In order to test partial clones, I need to enable these
config options in the server repo:

		test_config uploadpack.allowfilter 1 &&
		test_config uploadpack.allowanysha1inwant 1 &&

Sorry for taking so long to realize this.

Thanks,
-Stolee
