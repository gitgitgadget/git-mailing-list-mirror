Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B169C1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 13:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932238AbeDCNOy (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 09:14:54 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:37050 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932230AbeDCNOx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 09:14:53 -0400
Received: by mail-qk0-f196.google.com with SMTP id w6so18511201qkb.4
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 06:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=aKF5tIBxEQAi4jr0ehNQMkTWhwxZ23L7QkL7GIC+IDM=;
        b=UUE9azyxxljt3c8qkd3qSA/CYS4tvHCcYt3tSziaXZXd8vfBRrH8p+zrjGL5yTjaMx
         2EmOmRo4XtzdhThlTJGLtMef6YPI5Vu6umLWvt6QxexY2/H34jYMbg9kuX/xWRF3/ndf
         AQN+YQWKD32YKWtH7ZngrviEunw7Me0f4wLDiO/FU/2v+RdJB5EJmd9CyzhS2FwpdhnF
         pNWMSoWghgG6HNbReEUzp2kozuQ/0L6SHgZKMSFyq0WNONfOEMJymmXd9J3LeGvnnLJ6
         d8Gs8JkODD+sei2CrubK/H/n1sdgrnblH0K1ARAR8Wc0sUUuD2UJzd72pTiNASfQjrRL
         oi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aKF5tIBxEQAi4jr0ehNQMkTWhwxZ23L7QkL7GIC+IDM=;
        b=sCU8R60KJmBjz//UrenDogXlYt8pUlhjfA1inZRbYCEE0G7nnnDZ2af4AKc7MIumjj
         X/9zPEVWaDMzgA7gTJ/PUnveFdZdk3WHwB1ozQajG9wy+7mXyChwLHHhq1Eg23flTsLr
         7+ccOcX03suy9JwxKSihoNtEti8IOp9dktt/QYWrpmz048X+zgbfdJhGca9I+LEgQgBf
         9teSf73MZaT0jZ2NC8SwWLl/TVE1Vd9WH9pfpl7IG58tRpgGm/OOBuZU3D12rWDKB6aK
         QTV9Yg001PxhRcyCFlh0uKbyujxEADxRofGypRhj7RmrDzP4HLGWoUUftGRGB/cHIkmb
         vv2A==
X-Gm-Message-State: ALQs6tB/UjYVcDkh9zXcyxM7a3JHq0ByK8R8nbC5Uabj6JyISo5y6MYB
        5J1N4uFdoCdS21tXAT9HAwQ=
X-Google-Smtp-Source: AIpwx49hUFWqpcF1Y6rEGxmJ8vnQDj5PtjoSzDyVl/XbmJ4NXgNKhxVb0lKCZ53FKFALmhxWkslyXg==
X-Received: by 10.55.160.11 with SMTP id j11mr767018qke.349.1522761292875;
        Tue, 03 Apr 2018 06:14:52 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id r57sm2185180qtb.46.2018.04.03.06.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Apr 2018 06:14:51 -0700 (PDT)
Subject: Re: [PATCH 0/3] Lazy-load trees when reading commit-graph
To:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sbeller@google.com,
        larsxschneider@gmail.com
References: <20180403120057.173849-1-dstolee@microsoft.com>
 <20180403130615.GA18824@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <007c630a-0df8-803c-b637-fb5ccefa7b7c@gmail.com>
Date:   Tue, 3 Apr 2018 09:14:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403130615.GA18824@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/3/2018 9:06 AM, Jeff King wrote:
> On Tue, Apr 03, 2018 at 08:00:54AM -0400, Derrick Stolee wrote:
>
>> There are several commit-graph walks that require loading many commits
>> but never walk the trees reachable from those commits. However, the
>> current logic in parse_commit() requires the root tree to be loaded.
>> This only uses lookup_tree(), but when reading commits from the commit-
>> graph file, the hashcpy() to load the root tree hash and the time spent
>> checking the object cache take more time than parsing the rest of the
>> commit.
>>
>> In this patch series, all direct references to accessing the 'tree'
>> member of struct commit are replaced instead by one of the following
>> methods:
>>
>> 	struct tree *get_commit_tree(struct commit *)
>> 	struct object_id *get_commit_tree_oid(struct commit *)
> This seems like a pretty sane thing to do. There may still be a few
> parts of the code, notably fsck, that are reliant on a "struct object"
> having been instantiated to determine whether an object is "used".  I
> tried to clean that up around the time of c2d17b3b6e (fsck: check
> HAS_OBJ more consistently, 2017-01-16), but I won't be surprised if
> there's still some hidden assumptions.
>
> I peeked at the fsck.c parts of patch 2, and it looks like we may be OK,
> since you use get_commit_tree() during the walk.
>
>> This replacement was assisted by a Coccinelle script, but the 'tree'
>> member is overloaded in other types, so the script gave false-positives
>> that were removed from the diff.
> That catches any existing in-tree callers, but not any topics in flight.
> We could add the Coccinelle script and re-run it to catch any future
> ones. But perhaps simpler still: can we rename the "tree" member to
> "maybe_tree" or something, since nobody should be accessing it directly?
> That will give us a compile error if an older topic is merged.

That's a good idea. I can reorg in v2 to rename 'tree' to 'maybe_tree' 
(and add an explicit comment that 'maybe_tree' could be NULL, so don't 
reference it directly). The check that the rename patch is correct is 
simply "does it compile?" Then Coccinelle could do the transfer of 
"c->maybe_tree" to "get_commit_tree(c)" safely, and can be added to the 
scripts.

I guess one caveat is to not include the mutators (c->maybe_tree = ...), 
but that's probably something Coccinelle can do.

>
>> On the Linux repository, performance tests were run for the following
>> command:
>>
>>      git log --graph --oneline -1000
>>
>> Before: 0.83s
>> After:  0.65s
>> Rel %: -21.6%
> Neat.
>
> Not strictly related, but I happened across another thing today that
> might be worth investigating here. We allocate "struct commit" in these
> nice big allocation blocks. But then for every commit we allocate at
> least one "struct commit_list" to store the parent pointer.
>
> I was looking at this from a memory consumption angle (I found a
> pathological repository full of single-parent commits, and this wastes
> an extra 16 bytes plus malloc overhead for every 64-byte "struct
> commit").
>
> But I wonder if it could also have non-negligible overhead in calling
> malloc() for your case, since you've optimized out so much of the rest
> of the work.

That is a pattern I'm seeing: we strip out one bit and something else 
shows up as a hot spot. This game of whack-a-mole is quite productive.

> I'm not sure what the exact solution would be, but I imagine something
> like variable-sized "struct commit"s with the parent pointers embedded,
> with some kind of flag to indicate the number of parents (and probably
> some fallback to break out to a linked list for extreme cases of more
> than 2 parents).  It may end up pretty invasive, though, as there's a
> lot of open-coded traversals of that parent list.
>
> Anyway, not anything to do with this patch, but food for thought as you
> micro-optimize these traversals.

One other thing that I've been thinking about is that 'struct commit' is 
so much bigger than the other structs in 'union any_object'. This means 
that the object cache, which I think creates blocks of 'union 
any_object' for memory-alignment reasons, is overly bloated. This would 
be especially true when walking many more trees than commits.

Perhaps there are other memory concerns in that case (such as cached 
buffers) that the 'union any_object' is not a concern, but it is worth 
thinking about as we brainstorm how to reduce the parent-list memory.

Thanks,
-Stolee
