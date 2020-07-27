Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E24C433E8
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 14:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 219532083B
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 14:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qchJK+rV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733084AbgG0Olt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgG0OHy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 10:07:54 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA920C061794
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 07:07:53 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g26so15332821qka.3
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 07:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GO0ZnJzTXvg3BGZfiOeVkK+3m7s1FVX+Z/T42gSZc6I=;
        b=qchJK+rVHdDduo5Hif5hdMX+JbqNHnpPY9sIbHUrhNrh4sZMP1l04YNQdHrrmTEaoG
         JeKwYioCoGupHSu9yGGq1vJX4ZmcvJALVf8msceVidaCZpJvAvuSdpSZg1N6cX51ltr+
         VtmvbL7Yrt85nM3fvdwsRs4XulbctRvVw9O412TtunUlJTPTZDyPtvDAzU4dso8nnNxR
         VqbXTdK2UegtM/PxvMGkOwklYUUrBzu1ip7iEdXSKvokHkvq/PcmZ/of51n+fvMUxUO4
         CdIuRn9t7vTzLVDPbWiRX/8AQUz5Vedzc6ZLT6V2IqEL1nj9+MDLNqIkXMhkW8LTOHbJ
         j2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GO0ZnJzTXvg3BGZfiOeVkK+3m7s1FVX+Z/T42gSZc6I=;
        b=nXuK1nGxnMhOFX1eU5xAx+ub0e407Y0bfYiBkkr24svLKe7OXup2xq7NbrzF8AIume
         at1z3O++UapOe8hIBKpHzSpbXh8HTOz6MzJ+jB5GRNxcqSBpu6xlLk4iJ888VdEP2MCC
         v1r6PoOY4lzcr06y148T112e/0zgB2Ww5OC2BvqIeJnHIwAmfDhjfOzIekk+BUHI2dFd
         8Mhtu0jv40dJ4EU4HGhzAxiS8FE/S2xi5+ywbNsaAl1/2fHfq1k0gXC/HKIYPzV74fWS
         mmzv5WTN87FuRNcd4U5EFWZj//18MFc1vGDnv7jjIyXlVLAROCVoxDHqnMEXacV1XR7D
         XYvQ==
X-Gm-Message-State: AOAM530RR9ENJVMqj0cxfPNrLrJQKXiOcLBE+vlqy4aTG9D0vEQdOWJj
        g2tEiPP8qnr3v88mMub7/uY=
X-Google-Smtp-Source: ABdhPJyfdgsDSYZqoxL9CQ9LPCf8275YBHcWYBe7b0AqMZ6f2kc3AsFMeo+cqsYnNTPij3A3j+wdRQ==
X-Received: by 2002:a37:a2c2:: with SMTP id l185mr22288332qke.417.1595858873033;
        Mon, 27 Jul 2020 07:07:53 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5d71:9466:74af:ff71? ([2600:1700:e72:80a0:5d71:9466:74af:ff71])
        by smtp.gmail.com with ESMTPSA id 20sm19054057qkh.110.2020.07.27.07.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 07:07:52 -0700 (PDT)
Subject: Re: [PATCH v2 08/18] maintenance: add prefetch task
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <3165b8916d2d80bf72dac6596a42c871ccd4cbe6.1595527000.git.gitgitgadget@gmail.com>
 <20200725013715.GA2436@danh.dev> <xmqqv9icicvd.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <421cb856-24fc-6aa0-6ab0-f513d34ddd1a@gmail.com>
Date:   Mon, 27 Jul 2020 10:07:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <xmqqv9icicvd.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/24/2020 9:48 PM, Junio C Hamano wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
>>> When running 'git fetch <remote> <options>' in the background, use
>>> the following options for careful updating:
>>
>> Does this job interfere with FETCH_HEAD?
>> From my quick test (by applying 01-08 on top of rc1, and messing with t7900),
>> it looks like yes.
>>
>> I (and some other people, probably) rely on FETCH_HEAD for our scripts.
>> Hence, it would be nice to not touch FETCH_HEAD with prefetch job.
> 
> Very good point.  For that, Derrick may want to swallow the single
> patch from 'jc/no-update-fetch-head' topic into this series and
> pass the new command line option.

Thanks for the pointer! I appreciate the attention to detail here.

I'll rebase onto jc/no-update-fetch-head for the next version, since
that branch is based on v2.28.0-rc0, which is recent enough.

Thanks,
-Stolee
