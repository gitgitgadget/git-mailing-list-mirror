Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5B4C433DB
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C66564D9E
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhAaUYn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbhAaUOU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jan 2021 15:14:20 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2417C0613D6
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 12:13:39 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 36so14275737otp.2
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 12:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=t3xWR82IAYnAEmWoqa6nlhcyCuPLDPEp4RpGij0fTPQ=;
        b=jpGhruSvqPeGf0BWOmitqyoSzmxV+hWgyFFKZufAyCV63FC8+5ofe7uHp9TIhn1HLz
         +WRupcDvSZn1e/RTqAiD+tvdHXYA45Xm8Nk3qttIZmVVJt8ygAXsnKqq9l9quC1/gRF1
         olEaPKPU/xx9KjqxwzBLeJxOwCSljQKlnhdMExsML8f/ANk/mIcd+vgKPvVHR8oqsxMz
         Xd2lnI9vzmrQvEG5Qs3AoSH8u2Ti5RB78WdLt0DSTk7HCuAP+sbcvIbu3wRKojFMVLH2
         3GIRQDT2wC+4bPp3MlRSYJS/m8b1ItR9d5JGPuY4O5N1k+V+1TlvdUVKmdeayvoE9idT
         CP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=t3xWR82IAYnAEmWoqa6nlhcyCuPLDPEp4RpGij0fTPQ=;
        b=sAO5qfY4Ku2fB9ULaSSj1j1f000KZHsb0QhqQ+wYdi4nJazws9Pc/H8VdqHesO1xDt
         H9W/peu1DCsoJ+EUrG6CSUWURpejIp16UhDKHmQ8UCRA4lCzBQvPMC5U8u1f3K5GNBF6
         NMmtiw7t5mDUHio0TmdqSwA3J/4X8BIToEpUzR+Dqu6PvNzeQDFL2/yUyfXAfCqkyiQ4
         ujvniSg+4FCh+UX9M2C9zi63UE4BN4aIl5c852Yx2evzcp/RugBH2xwbpoHJjqX3nS4F
         yQMtUfG5o+e+UF5s8Af5RfqZAKrgCL94DLKgQnQ3DtK+kAZRJPtCYvUc5hshzODKhd9f
         6mKA==
X-Gm-Message-State: AOAM532sEFF0cHQl4K2rURRagUMwzC8lmjCH7U1wEE7To7FJGG/yQ9hM
        0nOsZO/nEdLUMA4n3tRJlxM=
X-Google-Smtp-Source: ABdhPJyNpPJL2lGMpC/I/V8MqjQIVHVtXwBntSiYwZsDXnBRjsbtJIR6IgjYD8aJaz5rbeOWe62isw==
X-Received: by 2002:a9d:5e6:: with SMTP id 93mr9803265otd.35.1612124019346;
        Sun, 31 Jan 2021 12:13:39 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:383e:f17:3be5:db8d? ([2600:1700:e72:80a0:383e:f17:3be5:db8d])
        by smtp.gmail.com with UTF8SMTPSA id w11sm3508313otg.58.2021.01.31.12.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 12:13:38 -0800 (PST)
Message-ID: <1c99bd13-13a8-1c06-6b40-70722d685f5c@gmail.com>
Date:   Sun, 31 Jan 2021 15:13:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 1/3] commit-reach: use one walk in remove_redundant()
Content-Language: en-US
From:   Derrick Stolee <stolee@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        me@ttaylorr.com, peff@peff.net,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
 <3fe74e339fc5b7083398f2df51baae5a4a008060.1611851095.git.gitgitgadget@gmail.com>
 <xmqqtur0vl7i.fsf@gitster.c.googlers.com>
 <e5863616-ff74-88f2-3d6a-c8dbe03477fe@gmail.com>
In-Reply-To: <e5863616-ff74-88f2-3d6a-c8dbe03477fe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/30/2021 10:59 PM, Derrick Stolee wrote:
> On 1/28/2021 3:51 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>> +		parents = c->parents;
>>> +		while (parents) {
>>> +			if (!(parents->item->object.flags & STALE)) {
>>> +				parents->item->object.flags |= STALE;
>>> +				prio_queue_put(&queue, parents->item);
>>> +			}
>>> +			parents = parents->next;
>>> +		}
>>> +	}
>>
>> So, the inner loop makes sure we won't revisit STALE parent, but
>> keep digging parents we haven't seen, and stop when the generation
>> is old enough.  What happens when there is no generation number
>> computed yet, I wonder...  We'll keep getting infinity and dig all
>> the way down to root?
> 
> If we are on commits that have no generation number yet, then we
> will walk until reaching commits in the commit-graph file that have
> a computed generation (or in the heuristic case, when we have reached
> all but one of the commits).
> 
> In the case of the commit-graph, all commits will have generation
> number "infinity". In such a case, perhaps the old algorithm _is_
> the best we can do, at least for now.
> 
> The trade-off is that we might walk more commits in unusual cases
> with few input commits. That quadratic behavior will take over as
> the input size grows, no matter if there is a commit-graph or not.
> 
> I can do a big more digging into these unusual cases, especially
> when we cannot rely on commit-graphs being present.

Indeed, the old algorithm is better for cases where generation
numbers do not help and there are multiple independent commits.

For example, this command in the Linux kernel repo changes from
0.047s in the old algorithm to 6.6s with the new algorithm:

git -c core.commitGraph=false merge-base --independent 2ecedd756908 d2360a398f0b >/dev/null

> One way to ensure we do not regress from the current behavior
> would be to condition the new algorithm with
> 
> 	if (generation_numbers_enabled(the_repository))
> 		new_algorithm();
> 	else
> 		old_algorithm();
> 
> much like in repo_is_descendant_of().

I will include this in a v2.

Thanks,
-Stolee

