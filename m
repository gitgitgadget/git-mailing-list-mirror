Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5A3C433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 20:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD38207F5
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 20:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZHjy3XR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgG3UVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 16:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgG3UVj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 16:21:39 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC73C061574
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 13:21:39 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l64so20059535qkb.8
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 13:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=udvF3h2+3auA+P/+mkCZHOmJ7ZiCl91fflkFY3YrxdE=;
        b=YZHjy3XRh2+tQnFum8LB9crc/MxmF3lRVuyB2OL8awYk9xZqhJ/bDQCHfSCnFxPqEO
         PeW6Q1Em49qqinBZv4iO1IBLqvNdze7aiqFPnG2OqfWjJGTgluwU9ttP7Z+f7UhlRArb
         BDDDhv3+NEziy/Bn2OGwroUT0LfLJft1+Nq3pMBjzy7KXERYRvyIO609Kd1opIzEvvV/
         IIVZ+rFtsjhtyfWszjBFuROeOV4dNocND4gYMQzCRnwJsBIPGkqd8Xl4pTns3Gnk/KVW
         CArzFI3GOJen/ULeeDr7Im77NKsvlYpZq4KeYduwGzmYodDhCDXi7NLAs53kSRL28i4Z
         Tctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=udvF3h2+3auA+P/+mkCZHOmJ7ZiCl91fflkFY3YrxdE=;
        b=F1jMGD2wDzQs737SyICdaI0AwDLpTiEYXv2H8O4qdKhTPOYTT6+ju7yQko2YzCIWqD
         HH8tquQk3P+JqaZz1u0+LknczCTwCgMLo62+JyCVukLnYOSVbQYYEIWq8fvC17T4tKLF
         PI0soZAdAnPKIfVDoeZEYE8CkM20nCMgpQMAZH8JlY+JNQ3TPLpNcIlCwki/ONCG0FCO
         gv0fJgBXgrzKFKIQSajLMBmmSMqgiev8+gH9saT1Vjlhp/1hIMMUJVcykNuh04i5t8cI
         8G2zNxWml1ROWlnfu2prhRi3zuFRpJsbWc3otzvOdpfuTCwDpCmdvmIimWZx2PANncaK
         +BUw==
X-Gm-Message-State: AOAM530S6PGFN5mJGoVDZaOo9aZQ9OoNY/e018TYbftuEeTrQxdCJbIJ
        M4CvdSQC9zLJOAGq9p/RQ9w=
X-Google-Smtp-Source: ABdhPJzRjtLTCWSgSLwFsl5SY+yAzPTGrKVIYsE1Rakr71pjuhV9R5PilJRvSq3klAGCZXWKWy8aiQ==
X-Received: by 2002:a37:4ed0:: with SMTP id c199mr994219qkb.80.1596140498519;
        Thu, 30 Jul 2020 13:21:38 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5cb3:9664:3acf:ecfa? ([2600:1700:e72:80a0:5cb3:9664:3acf:ecfa])
        by smtp.gmail.com with ESMTPSA id h55sm5845049qtc.28.2020.07.30.13.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 13:21:37 -0700 (PDT)
Subject: Re: [PATCH v2 03/18] maintenance: replace run_auto_gc()
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        Doan Tran Cong Danh <congdanhqx@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <f164d1a0b4363eb6eb174e90e88211829f8a1d55.1595527000.git.gitgitgadget@gmail.com>
 <xmqqblk6q8ws.fsf@gitster.c.googlers.com>
 <9aadb889-007a-c973-c59c-a471436368bb@gmail.com>
 <5757360f-a9e5-0bd2-b933-7efddee29cf6@gmail.com>
 <CAPig+cT50u=she6xm-zam-Qxtt5c7RTUTme+tj4GBGnQ_nus8g@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <10439c4b-6f0b-6d37-d805-18a3ecc313d8@gmail.com>
Date:   Thu, 30 Jul 2020 16:21:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cT50u=she6xm-zam-Qxtt5c7RTUTme+tj4GBGnQ_nus8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/30/2020 3:00 PM, Eric Sunshine wrote:
> On Thu, Jul 30, 2020 at 9:31 AM Derrick Stolee <stolee@gmail.com> wrote:
>> int run_auto_maintenance(int quiet)
>> {
>>         struct child_process maint = CHILD_PROCESS_INIT;
>>         maint.git_cmd = 1;
>>
>>         argv_array_pushl(&maint.args, "maintenance", "run", "--auto", NULL);
>>         if (quiet)
>>                 argv_array_push(&maint.args, "--quiet");
>>         else
>>                 argv_array_push(&maint.args, "--no-quiet");
> 
> It's subjective, but this might be a good fit for the ternary operator:
> 
>     argv_array_pushl(&maint.args, "maintenance", "run", "--auto", NULL);
>     argv_array_push(&maint.args, quiet ? "--quiet" : "--no-quiet");

Good idea! Thanks.

> Or even:
> 
>     argv_array_pushl(&maint.args, "maintenance", "run", "--auto",
>         quiet ? "--quiet" : "--no-quiet", NULL);
> 
> The latter is a bit less readable to me.

I agree.
-Stolee
