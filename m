Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A02C54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 17:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbjAIRUv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 12:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbjAIRUr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 12:20:47 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62071CB1F
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 09:20:44 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h16so8912874wrz.12
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 09:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=suJ5N5jYMxUx6PIYHw9NSCu9BDcyqGK4u4BJUwb+Xp8=;
        b=YUIfcYGAvw+XsdUl6xPQVkB+ng1jHGPvf8FkRKUxk412WgQUltZ8H2UfNj+0RjFJ99
         prj1VpSngRDVg3zBuYN/jxMzgXW8Xh+bujqnwSiXUHnN1taL7oIoe+YDlHjwyFJ7e7t7
         nXawL082/e6NIgURvkyvTXGBcwBJMiTyh7EXbgg17WdOTgCkzR4E2lWusF2t+SzSV3NT
         FTi9G3VHH1o/Rj3P4smgUvUW3KsxTxeoPLVi8YKwDqDJFeWpGeoBOJ3qaAGkgUpE156T
         upKTPnoTl9Xy6JuYoLGm63egcR41/47LlPZy4B4r/9C8YLZtI82gzKdi1PkVcQT63ICt
         fzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suJ5N5jYMxUx6PIYHw9NSCu9BDcyqGK4u4BJUwb+Xp8=;
        b=0B5Ay8FP94up7eEcu1mlQNruneilBxcZN9oNsM7MPCfV6BJY87RTEkv86CWCTDt/66
         I2aHSR7V/6Csk1YXVDEVJQlOl7NJkil17ysQmZA2xFWDIHApKPTY76NHs6Ilytmmk6Hk
         5ZsQD9jofcYmPmzsBJx7AIxAom9qhtUh/r1r/PhzxB2VEP+0+TFvj5TZqcvjIllpICdz
         LeHykhdwvv+GeOOMcSdBcnWp6/sB+bSpuhYxL5O5L3DI4eW0xcz3ZGxrdnLgle6k+stS
         sPv2gKzUkKZ229Z/QIt5jGzRS3aat9C3TZHN5tq/e7I2J5zrbYuJ4CMvN9YpiWm+156Y
         YUhg==
X-Gm-Message-State: AFqh2kolzcSF9v3sx+fL/hPmJUAJ20E7zkCkUFeR8KidDzhWzb3WJIY5
        sH2c3teTk7BfIMe1zK2AIrY=
X-Google-Smtp-Source: AMrXdXvFrfEXdcjIO+Hbfv6iQs1KQahhQz405K8fy1yP6DCtCk1Le0sWaTmcl1lsxFeWq74ZZsvVWA==
X-Received: by 2002:a5d:59c7:0:b0:293:1868:3a15 with SMTP id v7-20020a5d59c7000000b0029318683a15mr27574990wry.34.1673284843285;
        Mon, 09 Jan 2023 09:20:43 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id x2-20020adff642000000b002a01e64f7a1sm9201982wrp.88.2023.01.09.09.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:20:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pEvpC-0008mr-14;
        Mon, 09 Jan 2023 18:20:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com, newren@gmail.com,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 0/4] Optionally skip hashing index on write
Date:   Mon, 09 Jan 2023 18:15:12 +0100
References: <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
        <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
        <221216.86sfhf1gbc.gmgdl@evledraar.gmail.com>
        <b2164be2-72e9-cee5-26db-3e4fbfec3051@github.com>
        <xmqqmt6vqo2w.fsf@gitster.g>
        <bb48b1e2-819f-8bf3-ef4a-b9e4d23080b2@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <bb48b1e2-819f-8bf3-ef4a-b9e4d23080b2@github.com>
Message-ID: <230109.86mt6r1v6d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 06 2023, Derrick Stolee wrote:

> On 1/6/2023 5:45 PM, Junio C Hamano wrote:
>> Derrick Stolee <derrickstolee@github.com> writes:
>> 
>>> After investigating some of the failures from creating a BUG() statement
>>> when istate->repo is NULL I see several problems, and they are not related
>>> to submodules for the most part.
>>>
>>> The first issues I've found are due to code paths that operate on the_index
>>> without actually initializing it with a do_read_index(), or otherwise
>>> initialize an index using a memset() instead of a common initializer. This
>>> looks to be a frequent enough problem that solving it would require a
>>> significant effort. It's not a quick fix.
>> 
>> Thanks.  It is not entirely unexpected X-<, considering how the
>> connection from the in-core repository and the in-core index has
>> been developed and evolved.  So in short, istate->repo is not yet
>> ready to be used, until the problems you identified are resolved?
>> 
>> We probably should start paying down such technical debts.  We've
>> punted on them too many times, saying "yes this is klunky but what
>> we have is good enough for adding this feature", I suspect?
>
> Yes, I'll make note to prioritize this soon.

I noted in passing in [1] that I had those patches locally, if I'm
understanding you correctly and you're planning to work on changes
that'll make "istate->repo" always non-NULL.

I've rebased those on top of your "ds/omit-trailing-hash-in-index". I'm
CI-ing those now & hoping to submit them soon (I've had it working for a
while, but there was some interaction with your patches). Preview at
[2].

1. https://lore.kernel.org/git/221215.865yec3b1j.gmgdl@evledraar.gmail.com/
2. https://github.com/avar/git/compare/avar-ds/omit-trailing-hash-in-index...avar/do-not-lazy-populate-istate-repo
