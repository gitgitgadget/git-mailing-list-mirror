Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A159C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 14:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C50661029
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 14:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbhHBO70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 10:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbhHBO7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 10:59:25 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A75C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 07:59:16 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a19so11827756qtx.1
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 07:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yGGMAD2xU/pMM6Y92bM9f+40PBzcOk6ZOp5CvekhaSc=;
        b=s1UzjyiylKou3B5BKRmA/OnUYMhO98Opg1/8yYnTU6Zxmh4+oVkn3B/ntK8BLEXVkB
         ateGxWq9qfj0FSwPGonDPgztMLrZwIpGoFBfw4Q5IvdEvpgdW3A/s9K5NSavG77m/ioh
         5YDyBWjgRm1ud6oB5Uo8QR5OVg4JXsEJTsxii3SGD1v3ueuUGGvI35V37vVSA5zLsnVk
         bE1fOe9kDIG4HLNQ4rAKgyiXWkgswriKDQ2z+u1b5XlMIYJseN1qE+h0rYsrtMJ/XINs
         WzOTqnsa7UBDE7axBdhCCbbp8IX85Bf6qBJ+u/GPBGsrRiFFBlpYf1rT+o+go7M6T0qx
         qxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yGGMAD2xU/pMM6Y92bM9f+40PBzcOk6ZOp5CvekhaSc=;
        b=WvLFU3kKXViB5S74gmAKiHXBv7hkZXarWtbzW2nscOs/4i2eXcM4CL5WrKD5Z/moJo
         toQXc9cBt6BPhiB1Z0EmXPbhUDTEKZoedDj6Vq57u4t6nGkdkbBPaWipQoRBlhUYZi6H
         oWBVz4dQ1WQXKfJj6TInY1v48B6JKHHi013lEQh2vqnEy9dZ+vDd5jJLDX584UpICcko
         Zt9eQ7IpD4pZfaLSd7CwZJnzPT0ym1N2bVorJZDmEMextjiJ1rsRX5fwoRyJHJTZwb2L
         fs/ZsAAoZA6wlttc6k91crehY1TbmP+b/k/vFfMZ15wcSAnKeD73T5SyzlFb8Mr3MRYV
         L+Wg==
X-Gm-Message-State: AOAM532G+x0DCITEXPR1YNILM48+Dl4dAG7Z2RKm8FiQlA2bbVsMU07+
        C2+A9NTOCQZnd+iC8Fl6YVw=
X-Google-Smtp-Source: ABdhPJxQL57hD/Yb3GydbhZZ9tBekcYAePa8haB0HioQUKNS5wESq+DxIKHlATNqbN3Qbr3QjnsBaw==
X-Received: by 2002:a05:622a:134f:: with SMTP id w15mr14675641qtk.24.1627916355147;
        Mon, 02 Aug 2021 07:59:15 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:34d1:2d41:f9b7:ccbc? ([2600:1700:e72:80a0:34d1:2d41:f9b7:ccbc])
        by smtp.gmail.com with ESMTPSA id n5sm5890950qkp.116.2021.08.02.07.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 07:59:14 -0700 (PDT)
Subject: Re: [PATCH 2/2] Update docs for change of default merge backend
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com>
 <35490397590ae4d39ba98c7eb206bfadc22ddf35.1627776462.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4f223333-7cbb-2304-2e81-dc91a3281241@gmail.com>
Date:   Mon, 2 Aug 2021 10:59:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <35490397590ae4d39ba98c7eb206bfadc22ddf35.1627776462.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/31/2021 8:07 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
...
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index afdaeab8503..072bf84fa8a 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -275,7 +275,7 @@ best to always use a regular merge commit.
>  
>  [[merge-two-revert-one]]
>  If I make a change on two branches but revert it on one, why does the merge of those branches include the change?::
> -	By default, when Git does a merge, it uses a strategy called the recursive
> +	By default, when Git does a merge, it uses a strategy called the ort
>  	strategy, which does a fancy three-way merge.  In such a case, when Git

nit: I feel like quotes around "ort" would be beneficial here. It would have
also helped the previous version, too, in my opinion.

>  	performs the merge, it considers exactly three points: the two heads and a
>  	third point, called the _merge base_, which is usually the common ancestor of
> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index eb0aabd396f..72b53188504 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -112,8 +112,8 @@ With --squash, --commit is not allowed, and will fail.
>  	Use the given merge strategy; can be supplied more than
>  	once to specify them in the order they should be tried.
>  	If there is no `-s` option, a built-in list of strategies
> -	is used instead ('git merge-recursive' when merging a single
> -	head, 'git merge-octopus' otherwise).
> +	is used instead (`ort` when merging a single head,
> +	`octopus` otherwise).
>  
>  -X <option>::
>  --strategy-option=<option>::
> diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
> index 2912de706bf..6caf3fd6486 100644
> --- a/Documentation/merge-strategies.txt
> +++ b/Documentation/merge-strategies.txt
> @@ -6,28 +6,23 @@ backend 'merge strategies' to be chosen with `-s` option.  Some strategies
>  can also take their own options, which can be passed by giving `-X<option>`
>  arguments to `git merge` and/or `git pull`.
>  
> -resolve::
> -	This can only resolve two heads (i.e. the current branch
> -	and another branch you pulled from) using a 3-way merge
> -	algorithm.  It tries to carefully detect criss-cross
> -	merge ambiguities and is considered generally safe and
> -	fast.
> -
> -recursive::
> -	This can only resolve two heads using a 3-way merge
> -	algorithm.  When there is more than one common
> -	ancestor that can be used for 3-way merge, it creates a
> -	merged tree of the common ancestors and uses that as
> -	the reference tree for the 3-way merge.  This has been
> -	reported to result in fewer merge conflicts without
> -	causing mismerges by tests done on actual merge commits
> -	taken from Linux 2.6 kernel development history.
> -	Additionally this can detect and handle merges involving
> -	renames, but currently cannot make use of detected
> -	copies.  This is the default merge strategy when pulling
> -	or merging one branch.
> +ort::
> +	This is the default merge strategy when pulling or merging one
> +	branch.  This strategy can only resolve two heads using a
> +	3-way merge algorithm.  When there is more than one common
> +	ancestor that can be used for 3-way merge, it creates a merged
> +	tree of the common ancestors and uses that as the reference
> +	tree for the 3-way merge.  This has been reported to result in
> +	fewer merge conflicts without causing mismerges by tests done
> +	on actual merge commits taken from Linux 2.6 kernel
> +	development history.  Additionally this strategy can detect
> +	and handle merges involving renames.  It does not make use of
> +	detected copies.  The name for this algorithm is an acronym
> +	("Ostensibly Recursive's Twin") and came from the fact that it
> +	was written as a replacement for the previous default
> +	algorithm, recursive.

nit: Quotes around "recursive" might be useful here, too.

>  +
> -The 'recursive' strategy can take the following options:
> +The 'ort' strategy can take the following options:

(Like these quotes.)

Other than my nits, these doc updates are solid.

Thanks,
-Stolee
