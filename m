Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B86C2BA19
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 12:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69937221EC
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 12:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRS18smU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgDFMqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:46:23 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:34384 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgDFMqX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 08:46:23 -0400
Received: by mail-qv1-f66.google.com with SMTP id s18so7405009qvn.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 05:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=majKF7ZgECp3I7hNXVrP7gPQR5lUYKOwHANk4HRDMd0=;
        b=FRS18smUPCrBbncghpJ/AyU7o0K35wyHte68qEh5cniUY9TGni+LGu/jFn5MBkXovd
         sVyZu1rzeZvCuDmcYfz64RBq2esnfisx7Fama/8OaoTb5/VL8Mdkb1F8jCJHMCldUZDX
         RyyljzdCU4tFZshWuwxQb77Mzmes7qubqtjsfV8f6DiMcDsSyalp7dyNtsQ00njO70jZ
         zOHf5LWtlBJr/pGKocuE0wc8dbDoucQM34thPR8DUVJ1fI6lyElanpCGiwvhpdfKo7Yz
         IwJmASh32FLeaV99Mq4ARnIXyWE4ykFTNZhl6UBGKLQwnrnCFumkPUP6+xYarzGLbcpj
         Q8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=majKF7ZgECp3I7hNXVrP7gPQR5lUYKOwHANk4HRDMd0=;
        b=XRa2ZCQWs1tnPS7gag/vzTbbyHHcuHaq5CI7jJ9drWEfylkKv6v7+QNZPJpuUccT6U
         CwFPQa1Gc95vwlGJMneCxbX1N6LXvOxD/o16EymZBy5WZ8mwZOkXfk6AzU2zjSjk+f17
         XpGFOnFKJ+XOi4OVd6VGYg1L0zDnMpuChklaJQLfWe94ZyFy8qqTaxN5aoh4xU4AP4xA
         Sb26GMHgacBt/B9Qrqsz3/7EePxWTd1KFFy63OnQaDdmS4aelsFMmB7sRS0C2j1oMDG4
         ZDEDEgzwYo2+IxOmhBe2RLUr6EGuJg72L83idG2T51y7y6k9SM7TM7SIW7ffxkTmOvDN
         p8Fw==
X-Gm-Message-State: AGi0PuYKD6s8TuSbGa7Sgh2aVpm640dSjClJqELuIqBb8VBsOcEcL3tN
        8NPWROmxeH8f54YgSMF7rPU=
X-Google-Smtp-Source: APiQypLie/R3w8K0zp/gKREj9ISLc/8F5k/XVqWOl9zNb7lJqjnCjxn1RgNmTKV1K4v/gGfgiqw2mg==
X-Received: by 2002:a05:6214:1471:: with SMTP id c17mr19850952qvy.97.1586177180964;
        Mon, 06 Apr 2020 05:46:20 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id z6sm7793574qke.56.2020.04.06.05.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 05:46:20 -0700 (PDT)
Subject: Re: [PATCH 03/15] run-job: implement fetch job
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <77b1da5d3063a2404cd750adfe3bb8be9b6c497d.1585946894.git.gitgitgadget@gmail.com>
 <xmqqeet1y8wy.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <704d278d-205a-d11c-3454-73e06aa75dfa@gmail.com>
Date:   Mon, 6 Apr 2020 08:46:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <xmqqeet1y8wy.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/5/2020 4:28 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> 1. One downside of the refs/hidden pattern is that 'git log' will
>>    decorate commits with twice as many refs if they appear at a
>>    remote ref (<remote>/<ref> _and_ refs/hidden/<remote>/<ref>). Is
>>    there an easy way to exclude a refspace from decorations?
> 
> I do not think there is, but it makes sense to teach the decoration
> machinery to either use only certain refs hierarchies or use all
> hierarchies except for certain ones; if we want to make sure we
> won't break existing workflows, we should by defautlt use all the
> refs we currently use and nothing else, but over time we probably
> would want to migrate the default to cover only the local and
> remote-tracking branches and tags (and at that point, refs/hidden
> would be outside the decoration source).

I'll see what I can do about adding config to remove some refs from
decorations. That is immediately useful for Scalar users, too.

> By the way, I have a moderately strong opinion against the use of
> "refs/hidden" for the purpose of "prefetch in advance, without
> disrupting refs/remotes".  There may be more than one reason why
> some refs want to be "hidden", and depending on the purose, the
> exact refs that one workflow (e.g. "decorate") wants to hide may be
> the ones that want to be exposed.
> 
> If we rename it to "refs/prefetch/", would it make the purpose of
> the hierarchy clearer without squatting on a vague (because it does
> not tell why it is hidden) name "hidden" that other people might
> want to use to hide their stuff for different reasons?

I like "refs/prefetch". That's more descriptive.

>> Should
>>    we make refs/hidden/* a "special" refspace that is excluded from
>>    decorations?
> 
> See above.
Thanks,
-Stolee

