Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BA7C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12374206F6
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cva2veWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgHERLF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgHERIz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:08:55 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1346C061756
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 10:08:54 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id h7so42327942qkk.7
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 10:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H5sc08LOHcJcjQdBjl4H6rALfdRPutABQYIp5xm06IA=;
        b=Cva2veWv19pK69cpk7Gl+BpVhSQb/VmPlLbT/bgtUddUILgjRphjsQ1p5gES6qDQaD
         KqakCB1/Onh60OKLsRn21D/ujPFgS8pNVzCQuB/2ER2y50FYZ4HrXFJQNt9PbN1F9aVo
         vLNXNqieW94P+qFYp5gnzkHuazdnwwsoFlsX5MdQx4exhYNymbAmxwXrwRcnI/QUblRv
         p8aDLszjwupEM6JLLOrx904SlKmlSr/D9+FPJW4hjk5M+SjJvjNaYjE1JDXKYFwZP4uy
         vQPQ7XP7gYY0iAG7KCpjw14ktNsPol/7r7pcIrRWwtMrfIbxYospPY9bC0kEIl/xLsoW
         fQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H5sc08LOHcJcjQdBjl4H6rALfdRPutABQYIp5xm06IA=;
        b=HRg5sjE18EfxIRI3nihxHELRAAbuwxhSSRiMQHeKjN4REAjQPp5XuxLM3mcBpLtGfw
         GxLR/hFlWOA81uaoIVHHVI4gh73FCIh8S7o9HuvtHEpUgH/n+9F0FMJV7Z7yuE3XLFU6
         +WjE+gjQd9ZnrixLkebyzTNVBvaS/6ntndQkDZi9VeEeDBpwtzX4BAo/v+OqXGphligD
         fHToJUW9VJL1/H7nCiaBAGEdxvfOzpKiEwOmM67+tk+V9L2MJxdB5uilvzCj86dAsScx
         xdIyXKESAwsiw6lZSo8kMQVrvM4dE1HKAV0I1yzqjsrA5MtkgKw0W6+tEKv67+JPyd9Z
         AFmg==
X-Gm-Message-State: AOAM532sfQ2OYpKBO80F1NxahObkw3bLy8jTIMtrDP07RJRE8oCmb8vF
        vincOYPNyhPODP7Rq+7hKF8=
X-Google-Smtp-Source: ABdhPJwMJd+ji/utB98k8hehSlKMe7R/0YZB9rF1K1yn46CYRIB387uDf+Q3rvRLMtPV8DIHWI++0w==
X-Received: by 2002:a05:620a:792:: with SMTP id 18mr4433918qka.346.1596647334025;
        Wed, 05 Aug 2020 10:08:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:2c68:49ab:a5c1:6501? ([2600:1700:e72:80a0:2c68:49ab:a5c1:6501])
        by smtp.gmail.com with ESMTPSA id 84sm2075277qkl.11.2020.08.05.10.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 10:08:53 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 05/15] diff: halt tree-diff early after max_changes
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
 <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
 <2d4c0b2da38632424c8bd31ccb2037e0676c3c74.1586192395.git.gitgitgadget@gmail.com>
 <20200804144724.GA25052@szeder.dev>
 <a08c26bb-54ec-13af-e503-fccd68727cf3@gmail.com>
 <20200804170040.GB25052@szeder.dev>
 <cfa4e35e-e227-5862-6978-53e699a4a1d2@gmail.com>
Message-ID: <58ae3044-fa07-8e88-414a-fa9b410957f9@gmail.com>
Date:   Wed, 5 Aug 2020 13:08:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <cfa4e35e-e227-5862-6978-53e699a4a1d2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2020 1:31 PM, Derrick Stolee wrote:
> On 8/4/2020 1:00 PM, SZEDER Gábor wrote:

>> Having said that, the best (i.e faster and accurate) solution to this
>> issue is probably:
>>
>>   - Update the callchain between diff_tree_oid() and the diff callback
>>     functions to allow the callbacks to break diffing with a non-zero
>>     error code.
> 
> It looks like this part would not be too difficult. 

Oh, my hubris! I gave this a shot for some time this morning. This
will definitely take some work to do right. Just changing the callbacks
to return 'int' is a wide-sweeping change, but the place where they are
called already has an 'int' return that means something different.

I'm not saying this is impossible. It just takes more attention and care
than I can currently devote, given my other works in progress right now.

>>   - Fill Bloom filters using the approach presented in:
>>
>>       https://public-inbox.org/git/20200529085038.26008-21-szeder.dev@gmail.com/
>>
>>     but modify the callbacks to return non-zero when too many paths
>>     have been processed.
> 
> Thanks for the pointer to that specific patch. You do a good job of
> describing your thought process, including why you used the callback
> approach instead of the diff queue approach. The main reason seemed to
> be memory overhead from populating the entire diff queue before
> checking the limit.
> 
> However, if we are using the diff queue as the short-circuit, then
> perhaps that memory overhead isn't as much of a problem?
> 
> You admit yourself, that
> 
>   This patch implements a more efficient, but more complex, approach:
> 
> The logic around matching prefixes definitely seems complex and
> hard to test, especially around the file/directory changes with the
> sort order problems that have plagued similar prefix checks recently.
> I'm not doubting your implementation, just saying that the complexity
> is worth considering before jumping to that solution too quickly.
> 
> To sum up, I intend to start with a fix that uses the diff queue
> count as a limit, then try the callback approach to see if there are
> measurable improvements in performance.

That fix is now available [1].

[1] https://lore.kernel.org/git/d1c4bbcaa9627068d5d9fbd0e4a2e8c8834a4bd3.1596646576.git.me@ttaylorr.com/

Again, the callback approach seems promising. The complexity is
stopping me from trying to apply it on top of the current
implementation, while I should be focusing on other things. I completely
believe that that approach is faster and more memory-efficient. I would
love to test and review a patch that takes that approach here.

Thanks,
-Stolee
