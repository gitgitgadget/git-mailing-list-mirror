Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC152C433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 11:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999C320772
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 11:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJaA0/JR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgGILNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 07:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgGILNV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 07:13:21 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6AFC061A0B
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 04:13:20 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k18so1289921qtm.10
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 04:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I77ZWgi6+q1lsh3vsi62iao9Z+rttc4Lfot01840OiY=;
        b=eJaA0/JRrDEmk78PuV+DMCLkTRwCeiu3PXXWc198YUUI+s+7t8I4nOGGy64n1f1Bpb
         cvVoyRnbD/9LAMPoaa5W29qV158mZLqGWazouBm4E1GrLaO+bgUl+IT4YcLukAT3ua0i
         6o18PkIOnEilHHSW8SdFH53sRCDcuKbBpf7lZxdvn9S5vHsDpHZpOI9bWywu5K6uYBw1
         kHwiUy5fYbwrohn935luNOJNHbgI+UiQKBxtGcRgeStLLEC4daH4tR+G/sUGZTnngLc6
         2c1gG8gD6WDFDlxEr1Ku85mM2p6qj9BJlpW7P9+DIBQbF4Ist4mwhNntVlHRZ0qlcURO
         kqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I77ZWgi6+q1lsh3vsi62iao9Z+rttc4Lfot01840OiY=;
        b=Jz7fYod9ESxLg18APZE1CCZxWWKjyAUHE2mSLgO2HfQ1ajrcKXY2fq+tUcMzY1Pu3s
         1pvAl7crhMxkDVQ77vhVzlR0hhjgaw99tBa43MFUIJ+lZXFdfRl22ZIWsnolPxQgpbcy
         U8mR/vEWogLewrsWTApQX/QS8sg35OLrCNUahc/s5xSEfm2deuYypapielPDw8UB0Otb
         B2sHWgb+A+s7b1jUPX06Elt48q+k1aJBW82kHMok0xjfQ7ExmJVM89QaGNcsqF8nrmcs
         kuqw4pIzdRwHEADqfRUBeq4er+y016L8BZs1+OutbDrScQ9wXPhH8O/3VnfZQGa8upoL
         a5nw==
X-Gm-Message-State: AOAM533d+dB2URE4vPjP62fbFXRjKPiwwkA0sjknX7WNTRpsLDTdmeU8
        8/uVt4NxMXeJQ/0QzzOnYMg=
X-Google-Smtp-Source: ABdhPJx2BwZSECceLRvj7Mf8c9kXfg93bdX4u+1shxORkMSMrpuFF7nXKWTxiDskNnXh7bUahsA0yQ==
X-Received: by 2002:ac8:4e4a:: with SMTP id e10mr63092042qtw.203.1594293199585;
        Thu, 09 Jul 2020 04:13:19 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id d53sm3540680qtc.47.2020.07.09.04.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 04:13:18 -0700 (PDT)
Subject: Re: [PATCH 04/21] gc: drop the_repository in log location
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, derrickstolee@github.com,
        dstolee@microsoft.com
References: <e13d351e9ff19695b2ff638af01fdb4527fb7a6d.1594131695.git.gitgitgadget@gmail.com>
 <20200709022257.36743-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4170de4d-c77e-e8a9-1df4-e258e5785360@gmail.com>
Date:   Thu, 9 Jul 2020 07:13:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200709022257.36743-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/8/2020 10:22 PM, Jonathan Tan wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The report_last_gc_error() method use git_pathdup() which implicitly
>> uses the_repository. Replace this with strbuf_repo_path() to get a
>> path buffer we control that uses a given repository pointer.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> 
> Regarding the first 4 patches, it would be great if there was a test
> like the one in test_repository.c (together with a code coverage report,
> perhaps) that verifies that all code paths do not use the_repository.
> 
> But set aside that test for now - I don't think gc.c fully supports
> arbitrary repositories. In particular, when running a subprocess, it
> inherits the environment from the current process. I see that future
> patches try to resolve this by passing "-C", but that does not work if
> environment variables like GIT_DIR are set (because the environment
> variables override the "-C"). Perhaps we need a function that runs a
> subprocess in a specific repository. I ran into the same problem when
> attempting to make fetch-pack (which runs index-pack as a subprocess)
> support arbitrary repositories, but I haven't looked deeply into
> resolving this yet (and I haven't looked at that problem in a while).
> 
> Having said that, I'm fine with these patches being in the set - the
> only negative is that perhaps a reader would be misled into thinking
> that GC supports arbitrary repositories.

I agree. I hope that I do not give the impression that GC is now
safe for arbitrary repositories. I only thought that this was prudent
to do before I start taking new dependencies on the code.

It' probably time for someone to do a round of the_repository cleanups
again, and perhaps the RC window is a good time to think about that
(for submission after the release).

Thanks,
-Stolee


