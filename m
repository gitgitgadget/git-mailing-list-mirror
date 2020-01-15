Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982BDC33C9E
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 00:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B5024671
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 00:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uu7JCRsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgAOAzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 19:55:52 -0500
Received: from mail-qv1-f47.google.com ([209.85.219.47]:36822 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728795AbgAOAzv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 19:55:51 -0500
Received: by mail-qv1-f47.google.com with SMTP id m14so6639387qvl.3
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 16:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U/Eh+d0mAP3PnOAcOyoArQ+QNgB2Ofg8woYYFxjP6wA=;
        b=uu7JCRsl4zejM1FuMQcikjjT4uvZe0n5VUTQb9rwPfu6ZM9XrcpVbuEtl32tRU5Rmg
         3HU6xaq/8o7KpbrjwHMfbWK1Y4DQToXa7T6Im1XKMSJ8ODSUuJYYPOLbqixLMj9LIE5L
         5d+u25pyz+tu5wfA6BBDvoHFW6Q+Jg0sDcfUqUy3rjqxS8ziFCNOlESRf5YcBDKob8Oj
         hHyTEU4K8EWdMd1BlCBHZM9N66+/hkmrMM86GwFdAVMMyseZHRrHGsHFU8y32e8wbH/k
         C82nZHf5HHxgEg0YOMtTQ5vcRysPBepzjYerSmaCK+R3l+EwefBUcwkANa60mqMUx0sP
         YhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U/Eh+d0mAP3PnOAcOyoArQ+QNgB2Ofg8woYYFxjP6wA=;
        b=R6/i6GFrFZjxGcR0sqm9I2eytdVDq3s8/jPXBrSS4CFVReOxKRgP9pzxLTuIiECKci
         ZAq+CliAe0bKKq0xYBnUs+AsvoTRgb2BzgcaMQfYGMq8rc1fXXSyMFPSUNVTFN87msnV
         mfODn3j9DtakpfKjwpe4vYTDBJeWgQ/XglaS4w4+KrCxWhOFDFdD3HUkXFfAj0x8pZ9L
         1967HwysycBj3mZ1oLCXA0EN9qAjrspM0XE+C1jbl8DDaKlX8XfIDbZ1SuY8p080+BV1
         kTFW7NVucni2MEz7D8PEh2F2TNMQ5HnT0f6fyXiV0NpQDEnYJE/g/IDvsZTnsXoPqyCQ
         PfDw==
X-Gm-Message-State: APjAAAV0suSCNtkVO64CWyYBp6gUJy/iOjBuaWVscAV/Rd/+C7Hjx+9J
        1iynFVdPfzIYb3QdqCKwY5M=
X-Google-Smtp-Source: APXvYqzOjLePjx9FjKiKfp7z/V2TMfM4Y09X3qS4uc8a8r3XaVZFekxq5PMNh9p1eEi7INojjETA2A==
X-Received: by 2002:a0c:f404:: with SMTP id h4mr19989956qvl.251.1579049750911;
        Tue, 14 Jan 2020 16:55:50 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13f:14fc:be65:9350:cf67? ([2001:4898:a800:1012:c630:be65:9350:cf67])
        by smtp.gmail.com with ESMTPSA id d9sm8288077qth.34.2020.01.14.16.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 16:55:50 -0800 (PST)
Subject: Re: [PATCH 9/9] commit-graph: add GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS
 test flag
To:     Jakub Narebski <jnareb@gmail.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        peff@peff.net, Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <e1c315d0a766af147eb4ead41a172f724e90cc34.1576879520.git.gitgitgadget@gmail.com>
 <86v9phrcml.fsf@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <f8e9c4c7-b448-4014-5647-87c833a21dcc@gmail.com>
Date:   Tue, 14 Jan 2020 19:55:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <86v9phrcml.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 1/11/2020 2:56 PM, Jakub Narebski wrote:
> "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> The test suite passes when GIT_TEST_COMMIT_GRAPH and
>> GIT_COMMIT_GRAPH_BLOOM_FILTERS are enabled.
> 
> Good.  Very good.
> 
> No errors found by Continuous Integration setup either?
> 

Yes, the CI test pipelines all passed.

Cheers! 
Garima Singh
