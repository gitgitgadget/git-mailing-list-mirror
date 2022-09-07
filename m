Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DD0C6FA86
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 14:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiIGOgT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 10:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIGOgS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 10:36:18 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8387F6E8AF
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 07:36:16 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1278624b7c4so18238856fac.5
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 07:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=arDd/gQaM/PWTNhFko+wmFUIjdJO084x8MwWxQsVONI=;
        b=Yghcorv4pikVWmRyN42PFSin488hLtkIXG9maIk+Q7VQPQeJF8g/+XDOriZIjf5LKE
         m0TZOcVhrkpHga+UDVu5xNHnjiugeq1qD3TFRFFgZDyQ+Qqx9shGMIN47GHM5s9jQWto
         rzLkHWNuK0WLTZr4C8SNTjWXxKGTOWPCa51/+3q8lX1z45+711fwAbazQffV+o+9OyBx
         MHw/pSg3iITiKqR4UnXqODHHRfd9K8VEcam1LNDYPA2mQ9KQLKr+ki4bbOKZzLupoM18
         2InwsfEQw0tb4dHaiaKEJL1JALjU2Bg61I8RO+O2Igc8GvzEe3qI2upsP1KnIaPJWfUT
         SYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=arDd/gQaM/PWTNhFko+wmFUIjdJO084x8MwWxQsVONI=;
        b=J95or7wYYLUhohNEWwENKecEqaMoM12U5EBkvcSgzfhxmZrT+MCpWQeJ17x3o6sbBV
         dYYlmQXZLXcWjTvzZ/2HDzIdG6X0imPow+0LYo7k3SzEP89P3wWHIOT2nhJUXJIjv/lB
         O05Un0XFylP+2nO2T/+6IcoRJFdp85gNlal/Pyp/gJF/OVSCC0/6Q6GdGFj/hTJcbKHn
         KSaU8ME4qJTTdZMEUBo8Jc/BXdRuo3aK/2Ixu9gBqB8lxF/BfD7T4GHC2Ar9Y4F9vrUB
         s8DGPA8QEUiIowiUKAt78crgIGM8sx3PecfqJF+EEXrEHOX9Ly1jTOSS703A7m0gx997
         fEBw==
X-Gm-Message-State: ACgBeo06VIt4b5wzy53oNa3llLVqhRLlLurlfXYG7RfjDOkn2sNoEdmu
        5VoXCOGgANGOPo4c+xC7ATXR
X-Google-Smtp-Source: AA6agR4F91hAHgY375+LDDGg/wyKEV9WJ01cwc6xybi3TNXdrh0QNKyqFrNDbPohj18gT+PIcHxoOQ==
X-Received: by 2002:a05:6808:1691:b0:345:e814:b778 with SMTP id bb17-20020a056808169100b00345e814b778mr1739236oib.64.1662561375645;
        Wed, 07 Sep 2022 07:36:15 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id w42-20020a056870b3aa00b0011f400edb17sm7992965oap.4.2022.09.07.07.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 07:36:15 -0700 (PDT)
Message-ID: <6018c526-4641-8374-8802-cfda5be330c3@github.com>
Date:   Wed, 7 Sep 2022 10:36:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/3] upload-pack: skip parse-object re-hashing of "want"
 objects
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        =?UTF-8?B?WGluNyBNYSDpqazpkas=?= <maxin7@xiaomi.com>,
        =?UTF-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?UTF-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?UTF-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
References: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
 <YxfSRkEiiP4TyZTM@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YxfSRkEiiP4TyZTM@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/6/2022 7:05 PM, Jeff King wrote:
> This patch teaches both code paths to use the new SKIP_HASH_CHECK flag
> for parse_object(). You can see the speed-up in p5600, which does a
> blob:none clone followed by a checkout. The savings for git.git are
> modest:
> 
>   Test                          HEAD^             HEAD
>   ----------------------------------------------------------------------
>   5600.3: checkout of result    2.23(4.19+0.24)   1.72(3.79+0.18) -22.9%
> 
> But the savings scale with the number of bytes. So on a repository like
> linux.git with more files, we see more improvement (in both absolute and
> relative numbers):
> 
>   Test                          HEAD^                HEAD
>   ----------------------------------------------------------------------------
>   5600.3: checkout of result    51.62(77.26+2.76)    34.86(61.41+2.63) -32.5%
> 
> And here's an even more extreme case. This is the android gradle-plugin
> repository, whose tip checkout has ~3.7GB of files:
> 
>   Test                          HEAD^               HEAD
>   --------------------------------------------------------------------------
>   5600.3: checkout of result    79.51(90.84+5.55)   40.28(51.88+5.67) -49.3%
> 
> Keep in mind that these timings are of the whole checkout operation.

These numbers are _very_ impressive for this user-facing scenario.

>   Benchmark 1: GIT_PROTOCOL=version=2 git.old upload-pack ../gradle-plugin <input
>     Time (mean ± σ):     50.884 s ±  0.239 s    [User: 51.450 s, System: 1.726 s]
>     Range (min … max):   50.608 s … 51.025 s    3 runs
> 
>   Benchmark 2: GIT_PROTOCOL=version=2 git.new upload-pack ../gradle-plugin <input
>     Time (mean ± σ):      9.728 s ±  0.112 s    [User: 10.466 s, System: 1.535 s]
>     Range (min … max):    9.618 s …  9.842 s    3 runs
> 
>   Summary
>     'GIT_PROTOCOL=version=2 git.new upload-pack ../gradle-plugin <input' ran
>       5.23 ± 0.07 times faster than 'GIT_PROTOCOL=version=2 git.old upload-pack ../gradle-plugin <input'
> 
> So a server would see an 80% reduction in CPU serving the initial
> checkout of a partial clone for this repository.

Very nice!

> In both cases skipping the extra hashing on the server should be pretty
> safe. The client doesn't trust the server anyway, so it will re-hash all
> of the objects via index-pack.

Definitely safe for this target scenario.

> There is one thing to note, though: the
> change in get_reference() affects not just pack-objects, but rev-list,
> git-log, etc. We could use a flag to limit to index-pack here, but we
> may already skip hash checks in this instance. For commits, we'd skip
> anything we load via the commit-graph. And while before this commit we
> would check a blob fed directly to rev-list on the command-line, we'd
> skip checking that same blob if we found it by traversing a tree.

It's worth also mentioning that since you isolated the change to
get_reference(), it is only skipping the parse for the requested tips
of the revision walk. As we follow commits and trees to other objects
we do not use parse_object() but instead use the appropriate method
(parse_commit(), parse_tree(), and do not even parse blobs).

This is additionally confirmed that p0001-rev-list.sh has no measurable
change in results with this commit, even when disabling the commit-graph.

> The exception for both is if --verify-objects is used. In that case,
> we'll skip this optimization, and the new test makes sure we do this
> correctly.

The test for this is clever. Thanks for adding it.

Code and test look good.

Thanks,
-Stolee
