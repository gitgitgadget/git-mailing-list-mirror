Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FB0C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 01:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF4A964F4C
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 01:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhBCBft (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 20:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhBCBfm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 20:35:42 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5A1C061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 17:35:01 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id k142so10615146oib.7
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 17:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Rnxg9MSbSsKiQ21qdrh9CDLdWgZDTdmrO73q7Yj63E8=;
        b=XbxHw9zSDbALoUPvTgOFIGZnD4buxYF08g0MOFAARpMEC0wHGsdTdAaqjQtDCTzzcH
         qVv6tkPWTCxuBMA888ecAk2WN5/SIfod216mQB4zl33uCLmZkkHLm1f7RodlpR8JiF8j
         L4LtzYO+g+ZQy2FBTbdqpY8ArfrJnyHlR2TzPCY2GuJZ/VRJMX1BqzZUmf89hs9JXHSH
         MD8muyV2MmMkec03LKFhT53NaO6DLyetSvO1Zgql2OwHNB5U7gL6e+FqSffQtkTdJakc
         snrbTqwuOWQxnzdI6tkZmdFUnH9hxhYrnU8zBtBfQlhy70rFIc80aA3mdzbahjIORxK5
         6nzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Rnxg9MSbSsKiQ21qdrh9CDLdWgZDTdmrO73q7Yj63E8=;
        b=kZdnClAIVX4jaZe4l6lrPGPxU/W7rCkm0VvEakl/m1w9sYJ1t0N6zHMpSxXdTrT7HZ
         qoFtDlqgX8aX+iQZYPuZJ0/pIcFj0U3zxqXLaD+2z2Rwt9gJpqSe3vACHFLRDzmlIVf3
         +T3Eum6KDeoXXNqzKNknAWK0sSQZPm1UyvVuKKfEcQaiv7p6Ez+KM8tBm9Tx9P6DIBBt
         FwgljldoaJOFxBMQYcpFOOuHXyec3QEZK6xwzhL0ejc5SrQ/bNs4IuXG+ex1W+8IQfyL
         yworeKljlH8iuehPlGBUcIW4Oua+Vzx8FHQSh9O4Hw56nmgY/5gRN3dmUc1jbxtKwNfE
         rdHg==
X-Gm-Message-State: AOAM5320ga/8jnbMYrkxonLiiOJ3nNMuR0x/ZGBIfILaFjHVmipXXO6d
        exYH3SaXiwifV//kGXWyGjo=
X-Google-Smtp-Source: ABdhPJw1Mqico5e0/QtFUKe7fC6NcUj8FoTjApJN98qyBsaoCjIb+WMBoucxMbN/x27JZQprIPmWvg==
X-Received: by 2002:aca:f12:: with SMTP id 18mr484144oip.106.1612316101199;
        Tue, 02 Feb 2021 17:35:01 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:79cd:7444:bf97:c4d4? ([2600:1700:e72:80a0:79cd:7444:bf97:c4d4])
        by smtp.gmail.com with UTF8SMTPSA id o6sm135988otp.77.2021.02.02.17.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 17:35:00 -0800 (PST)
Message-ID: <1dab0bf0-9a7f-370a-c807-25d67ac7a0a0@gmail.com>
Date:   Tue, 2 Feb 2021 20:35:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 2/6] commit-graph: always parse before
 commit_graph_data_at()
Content-Language: en-US
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        gitster@pobox.com, abhishekkumar8222@gmail.com,
        Taylor Blau <ttaylorr@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
 <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
 <454b183b9ba502da7f40dc36aaa95cc3d12b5c2f.1612234883.git.gitgitgadget@gmail.com>
 <YBn3fxFe978Up5Ly@google.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YBn3fxFe978Up5Ly@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/2/2021 8:08 PM, Jonathan Nieder wrote:
> Derrick Stolee wrote:
> 
>> There is a subtle failure happening when computing corrected commit
>> dates with --split enabled. It requires a base layer needing the
>> generation_data_overflow chunk. Then, the next layer on top
>> erroneously thinks it needs an overflow chunk due to a bug leading
>> to recalculating all reachable generation numbers. The output of
>> the failure is
>>
>>   BUG: commit-graph.c:1912: expected to write 8 bytes to
>>   chunk 47444f56, but wrote 0 instead
> 
> At Google, we're running into a commit-graph issue that appears to
> have also arrived as part of this last week's rollout.  This one is a
> bit worse --- it is reproducible for affected users and stops them
> from being able to do day-to-day development:

You're shipping 'next' widely? I appreciate the extra eyes on
early bits, so we can find more issues and get them resolved.

>   $ git pull
>   remote: Finding sources: 100% (33/33)
>   remote: Total 33 (delta 18), reused 33 (delta 18)
>   Unpacking objects: 100% (33/33), 27.44 KiB | 460.00 KiB/s, done.
>   From https://example.com/path/to/repo
>      05ba0d775..279e4e6d0  master     -> origin/master
>   BUG: commit-reach.c:64: bad generation skip     29e3 >      628 at 62abdabd1be00ebadbf73061ecf72b35042338e3
>   error: merge died of signal 6
> 
> "git commit-graph verify" agrees that the generation numbers are wrong:
> 
>   $ git commit-graph verify
>   commit-graph generation for commit 4290b2214cdf50263118322735347d151715a272 is 3 != 1586
>   Verifying commits in commit graph: 100% (1/1), done.
>   commit-graph generation for commit b6c73a8472c7cb503cce0668849150a4b4329230 is 1576 != 10724
>   Verifying commits in commit graph: 100% (10/10), done.
>   Verifying commits in commit graph: 100% (88/88), done.
>   Verifying commits in commit graph: 100% (208/208), done.
>   Verifying commits in commit graph: 100% (592/592), done.
>   Verifying commits in commit graph: 100% (1567/1567), done.
>   Verifying commits in commit graph: 100% (8358/8358), done.
> 
> We have some examples of repositories that were corrupted this way,
> but we didn't catch them in the act of corruption --- it started
> happening to several users with this release so we immediately rolled
> back.

It is definitely related to the split commit-graph during the
upgrade scenario. Your verify output shows that you are using
the --split option heavily (possibly with fetch.writeCommitGraph?
or are you using 'git maintenance run --task=commit-graph'?)

> Questions:
> 
> - is this likely to be due to the same cause, or is it orthogonal?

My guess is that the reason is the same. I think that you might
have some strangeness of a commit-graph layer with corrected commit
dates being below a commit-graph layer without it.

> - what is the recommended way to recover from this state?  "git fsck"
>   shows the repositories to have no problems.  "git help commit-graph"
>   doesn't show a command for users to use; is
>   `rm -fr .git/objects/info/commit-graphs/` the recommended recovery
>   command?

That, followed by `git commit-graph write --reachable [--changed-paths]`
depending on what they want.

> - is there configuration or a patch we can roll out to help affected
>   users recover from this state?

If you are willing, then take v2 of this series and follow through by
clearing the commit-graph files of affected users. Note that you can
be proactive using `git commit-graph verify` to see who needs rewrites.

Thanks,
-Stolee
