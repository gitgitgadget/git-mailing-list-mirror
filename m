Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16450C433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 16:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E52A2207D0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 16:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgD9cgDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgGIQ4Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgGIQ4P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 12:56:15 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD278C08C5CE
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 09:56:15 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g13so2176551qtv.8
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dx4yTI7ar5vDNWGsDftVmTBY8tUhNNjuJr9f2QZVbus=;
        b=qgD9cgDWl3jI3YaLwStMQtwah0uRGBum3jMKpWxBYJvlVhgHwOATIhzgSuBDfMeZbp
         Pe4RZsXpaHfsxMMKYf1VvmVYNFXeregJvEgvcxct4emn4BR+/80NzoEJxGNmLu29Ldgx
         gK5dkeNzSVRPvLwwiszpj9S5YF+Msj97xEHMavVLAsk4ywI14K7i24EEuhMKEGfm0yEg
         vV62n1LLp2imyAQQfmnYUR4Xdsojm4HITbhUrE3W3RBrIBZLFCnDZymRK2/whyIdCozO
         yQ4rNC7BMepK12C6y6yLC/35rUEtuuURrSxZ7ltxtcG7tud0K9SlpFzGtm3WyTbxRavP
         RrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dx4yTI7ar5vDNWGsDftVmTBY8tUhNNjuJr9f2QZVbus=;
        b=b8n34R7Onyfld7VcRoX1qzISvgxFEzcf07vE0RnRV2z3bJk9NODO9d+8qFWEyHDz8q
         s901Y4MmcqMYXvbguvYf+ywreEJHvtOWkCH3T07tUMJZHO9pHdXcPpkug3A35y6d+CC0
         nYuE+iijl6bJIZ/FzA2y7/fn8qCHbACFuTBDVHR1twrF0TmKVRLUrCWnVm7Q0PSqszG0
         XGaDaPDvVuH8iGRz7067KP5Bu6gaHc53/qXEUlHy5R0QuIjqxByHB9W693Yte2TWxyI3
         VtLRzIBlaPorj/prFFRHvmOGbzcyQuyTQsJXRWKOezRjiCoFYCqsd/ZdoBnfuOk8ARDe
         vJKQ==
X-Gm-Message-State: AOAM53109OsZV0jTxlKpeAaoCbpX3nBKf/HssgHL6zYW8hH/PR8tDZkB
        iu/DrRUTBxIRzxBznIa+nlk=
X-Google-Smtp-Source: ABdhPJyZC63EnB0T7bP09dCjREVr+0FQSpy+C6fUwrkW2u68Aj9IOqCzMWKOmLq7g3HoGIddZ5bWCw==
X-Received: by 2002:ac8:2256:: with SMTP id p22mr64974864qtp.75.1594313774538;
        Thu, 09 Jul 2020 09:56:14 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 140sm4276194qko.98.2020.07.09.09.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 09:56:14 -0700 (PDT)
Subject: Re: [PATCH 00/21] Maintenance builtin, allowing 'gc --auto'
 customization
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <20200708235719.GA3189386@google.com>
 <ef6e2704-b122-f620-a952-75f3f9efab78@gmail.com>
 <xmqqv9iwyeac.fsf@gitster.c.googlers.com>
 <52715fe8-a545-5c42-2f3a-e59bcbc43497@gmail.com>
 <xmqqmu48y7rw.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ecadda92-2290-4e96-0e3c-27fbe7e0a6e6@gmail.com>
Date:   Thu, 9 Jul 2020 12:56:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <xmqqmu48y7rw.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/9/2020 12:26 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> On 7/9/2020 10:05 AM, Junio C Hamano wrote:
>>> For existing callers, "git gc --auto" may want to be left alive,
>>> merely as a thin wrapper around "git maintenance --auto", and as
>>> long as the latter is done in the same spirit of the former, i.e.
>>> perform a lightweight check to see if the repository is so out of
>>> shape and then do a minimum cleaning, it would be welcomed by users
>>> if it does a lot more than the current "git gc --auto".
>>
>> It's entirely possible that (after the 'maintenance' builtin
>> stabilizes) that we make 'git gc --auto' become an alias of something
>> like 'git maintenance run --task=gc --auto' (or itemize all of the
>> sub-tasks) so that 'git gc --auto' doesn't change behavior.
> 
> Yes, it is possible, but I doubt it is desirable.
> 
> The current users of "gc --auto" do not (and should not) care the
> details of what tasks are performed.  We surely have added more
> stuff that need maintenance since "gc --auto" was originally
> written, and after people have started using "gc --auto" in their
> workflows.  For example, I think "gc --auto" predates "rerere gc"
> and those who had "gc --auto" in their script had a moment when
> suddenly it started to clean stale entries in the rerere database.
> 
> Were they got upset when it happened?  Will they get upset when it
> starts cleaning up stale commit-graph leftover files?
> 
> As long as "gc --auto" kept the same spirit of doing a lightweight
> check to see if the repository is so out of shape to require
> cleaning and performing a minimum maintenance when it started
> calling "rerere gc", and as long as "maintenance --auto" does the
> same, I would think the users would be delighted without complaints.
> 
> So, I wouldn't worry too much about what exactly happens with the
> future versions of "gc --auto".  The world has changed, and we have
> more items in the repository that needs maintenance/cruft removal.
> The command in the new world should deal with these new stuff, too.

Sounds good to me. The extra context around this helps a lot!

-Stolee
