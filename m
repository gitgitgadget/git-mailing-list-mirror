Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABA6C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 19:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB8561976
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 19:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhC2Tqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 15:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhC2Tqf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 15:46:35 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD550C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 12:46:34 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id v70so13642517qkb.8
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t4bSgp3q3+4ZAFFs4gUUhL+E2eMb3laAg/c/DJKGS88=;
        b=YcQ/VouL2+YTm78QOsLnZ01v5rntxrqherdiUAM5HtXzFcMjGw4Hg/n+hkfzuT/m69
         lQq+oDcyTdnnvyLFaIbv7VE6bh1YaD9ANApevXOVKOTaUxx5X0nYv8kE3GBWUr3Ln4bF
         1rwZgNz0c2oy3h6kT7OQp7z79vnBx9aDjAUaxMdCRbyXriIGJQ9lR+tmEIA1IHy+GGHT
         s0xLNfv2tQBFaD16gMT2OviQacEoNs4RPJ8E94NfbZmhlLyuUhhLFQVkD4cHnCjB4OhI
         o1ESK8fwmwa/Ejg74aAcMoLuJ6IIkE/GH66InnvQiqyj3o+d+hXKVvEqn1/e0EnraAYa
         wDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t4bSgp3q3+4ZAFFs4gUUhL+E2eMb3laAg/c/DJKGS88=;
        b=WOMDMLv6xwadpsEZFbA6irjIlaR1iA1H6mOeJbXPWw2iRMQ8kbW5KM8ShcsFrjhwjv
         UsrZL/20q4I6GylrKlf5S3UPU1tCMCj1LXObkXnrbv8jWQOCK66wdwb9j52m8Nc27VFE
         CTBalCJaKx3M/vq0mw6WfkW6jCXIRpEQ/lev3MTa+d9MyC9FvGG+NVKPggUMSH7DOYzP
         rSNbsulKb7Fp9fWMhLJte4EI3lQQ9uQIRG3rXloz8xm71CNOUt4CTY5beoMa8fDWf1vc
         6rEIAZD1XZ72479uNkqd6QcNV2UQ6WSupSXcukCfK9sNTNXGxWW3pKFaRlhSFQBd/WrT
         iQLA==
X-Gm-Message-State: AOAM5310s5WDaTQMdDaZ3u5lunlJbIjToCQz13kMmqKiKhZkmfqWflWs
        xGEvctL1VVUUcNlIq6pBpN0=
X-Google-Smtp-Source: ABdhPJzvhvW6T//hBDBI8FM+vkKJVUxMZkbvaJ8TqZF6ZNNoB48RRWzd9TTwSmgnNt1LKOl4zyfqJQ==
X-Received: by 2002:a37:6348:: with SMTP id x69mr26089022qkb.154.1617047193966;
        Mon, 29 Mar 2021 12:46:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:18fb:da6e:ec24:b27d? ([2600:1700:e72:80a0:18fb:da6e:ec24:b27d])
        by smtp.gmail.com with ESMTPSA id z6sm11572431qtv.69.2021.03.29.12.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 12:46:33 -0700 (PDT)
Subject: Re: [PATCH v4 07/20] test-read-cache: print cache entries with
 --table
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
 <7ebd9570b1ad81720569a770526651c62c152b9f.1616507069.git.gitgitgadget@gmail.com>
 <87r1k5pcmx.fsf@evledraar.gmail.com>
 <ca8a96a4-5897-2484-b195-57e5b3820576@gmail.com>
 <874kgzq4qi.fsf@evledraar.gmail.com>
 <CABPp-BGRwxn73sntpX8Q5aD-O192RZmOOy_jiU3SQp4-erivtg@mail.gmail.com>
 <87eeg0ng78.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b1eee802-f20c-5381-366c-729755bfac8a@gmail.com>
Date:   Mon, 29 Mar 2021 15:46:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <87eeg0ng78.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/28/2021 11:31 AM, Ævar Arnfjörð Bjarmason wrote:> It seems to me that the reason for that state is based on a
> misunderstanding about what we would and wouldn't add to builtin/*.c,
> i.e. that we wouldn't have something like a --debug option, but as
> ls-files shows that's not a problem.

I feel _strongly_ that a change to the user-facing CLI should come
with a good reason and care about how it locks-in behavior for the
future.

Any adjustment to 'git ls-files' deserves its own series and
attention, not in an already-too-large series like this one.

I'm not happy that this series and the next are so long, but that's
the best I can do to make them reviewable and still capture a
complete scenario. Hopefully the remaining series after these first
two are smaller. Things like "what should 'git ls-files' do with a
sparse index?" can fit cleanly on top once the core functionality
of the internals are stable.

I have an _opinion_ that the ls-files output is not well-suited to
testing because the --debug output splits details across multiple
lines. This is a minor point that could probably be corrected by
a complicated script method, but that's why I list this as an
opinion.

> I mean it's fine if it's just a "I don't think this is important and
> don't want to spend time on it, but it seems like a good idea", in which
> case others have the option of re-rolling some of these patches if they
> care (at this point I wouldn't).
> 
> Or "this is just a bad idea for XYZ reason", which is also fine, and
> even more valuable to document for future work in the area.
> 
> But to have another series built on this with refactorings back and
> forth before code's landed on master just seems like needless churn.

I think changing 'ls-files' before the sparse index has stabilized is
premature. I said that a series like the RFC you sent would be
appropriate after this concept is more stable. I do _not_ recommend
trying to juggle it on top of the work while the patches are in flight.

Thanks,
-Stolee
