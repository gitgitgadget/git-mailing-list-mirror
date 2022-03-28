Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41D8C433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 17:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238748AbiC1R5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 13:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbiC1R5H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 13:57:07 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD6111A3C
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 10:55:10 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-dee0378ce7so5679421fac.4
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 10:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XCxvkI6WrzCThlbrTzXQimCe0dz+DyC3ZDBA/4P/UT4=;
        b=H4XQG3Vns9zsm+l163IqwPW9OBBxdH7RJa1z5FKGdbqk7IL6bxWfiNcd4JK/JzRP4f
         KQON2UqzVeE5xWt9U7z3IDZ/MJkmvf2xG993kxtuSEj+YNZ36I1P4pmQKagqw0YtRqRi
         3Txo/VlprXM/JwnFUgZYbM97Y65uXV3aML7bxiKrw5tvJM6Za9PPchigR0ZwSF8ckyEy
         GtQzGloFfFl/2GTH0n2lvjRBaq8Wm3a0tPHU1mJkDQNlxanxQHs/OshYKLhi9dpvhjz7
         9fetaWTL1IbJ/nxnE89aXEs+5NjwI8XFGpIcanbPoRL7ZJN7QkZkSGmgIs0mbdC8BUhM
         fP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XCxvkI6WrzCThlbrTzXQimCe0dz+DyC3ZDBA/4P/UT4=;
        b=hQ1HddFczMPs96H9OSnMdP8GP+hHBXtGdS+3C0mqPwePWOd4IZvdAnA7/FluOjusYX
         BkH32woVEik63YTaVcskL++rA5z7HmONRX8WeYckAvDoH0IC5SXtN9Dqw7F0AwLSnNjv
         CPLVmFLwH89jSOIGy4kbC0ObIDTYdHOEKAr/HfLhgMIN3X7bx3CIn+6Coq4zaDovRTRh
         +gj1GOUchFVTQp9ZGC2SknK8x27+LmOzigrTBfOctv4fI2gjb/PxzpPpbc11ngrl401b
         vd5+nwu4wznnfpLTSE3T0J74+BYLbW1pxIWG5LZ/cq7hSYdWNicjIpDesDdZZLlbKpq6
         u8WQ==
X-Gm-Message-State: AOAM530EDH1ECrnaxNf1fApcIBBzF2mtpKtviYeoilwTUVTRp8CX3uxW
        DaP5oSw55RYGTHhGox+VbFUm492t6y9I
X-Google-Smtp-Source: ABdhPJzT7BJretghYl/+5aDXAMsFYIpuvs9zZTGkBr/W3PUzc9UOUy9RLb5sYHy8C8/u4x94I8eo1w==
X-Received: by 2002:a05:6870:42d2:b0:dd:a35d:2912 with SMTP id z18-20020a05687042d200b000dda35d2912mr180791oah.242.1648490109994;
        Mon, 28 Mar 2022 10:55:09 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id bm51-20020a0568081ab300b002da5c44e0bdsm7293365oib.28.2022.03.28.10.55.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 10:55:09 -0700 (PDT)
Message-ID: <3bb95e8b-4977-ddca-225c-5afe28d8ac20@github.com>
Date:   Mon, 28 Mar 2022 13:55:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 08/27] revisions API users: add "goto cleanup" for
 "rev_info" early exit
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
 <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
 <patch-v3-08.27-f8a9443fe6f-20220325T171340Z-avarab@gmail.com>
 <xmqqtubl93n3.fsf@gitster.g> <220326.86ee2pleua.gmgdl@evledraar.gmail.com>
 <xmqqee2p70c1.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqee2p70c1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/26/2022 1:24 AM, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
>> Because I don't see how it makes any sense to have a REV_INFO_INIT if it
>> doesn't actually give you an init'd "struct rev_info" that's ready for
>> use. I.e. if you still need to call repo_init_revisions() it's just a
>> misleading interface.
> 
> You can say
> 
> 	struct something *foo = NULL;
> 
> 	if (some condition)
> 		foo = alloc_and_init_foo();
> 
> 	...
> 
> 	free_and_destruct(foo);
> 
> and it is correct that "initialize with NULL" alone would not let
> you use the thing as full fledged 'foo', but you can still safely
> pass it to free_and_destruct() (or if "something" does not hold
> external resources, it could just be free()).  A flow like this:
> 
> 	struct rev_info revs = REV_INFO_INIT;
> 
> 	if (!some condition)
> 		goto leave;
> 	init(&revs);
> 	... use revs ...
> leave:
>         release(&revs);
> 
> would exactly be the same thing.
> 
> In other words, you say "I do not see how it makes any sense" but to
> me it looks more like what does not make sense is your argument
> against what was suggested.

Ævar has stated in multiple threads that he prefers to not
initialize data so that static analysis tools can detect a
use-before-initialization of specific members.

However, now that we are intending to free rev_info structs,
we need them to be initialized with NULL pointers because
otherwise the release_revisions() method won't know which
portions were legitimately initialized and which ones were
not.

Maybe this NULL assignment happens as part of
repo_init_revisions(), but that also assumes that there is no
code path that would jump to a "leave" or "cleanup" tag before
running that initialization method (which is the broken case
that Junio mentions above).

Maybe there are tools that would identify that Junio's example
would be bad, but it is also likely that a compiler doesn't
catch that issue and tests don't cover that error condition.

It's my preference to initialize things to all-zeroes whenever
there is any chance of complexity, which is why this topic has
come to my attention on multiple threads.

Thanks,
-Stolee
 
