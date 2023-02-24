Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C4BC7EE23
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 17:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjBXRo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 12:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBXRoy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 12:44:54 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4AD13529
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 09:44:49 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d7so124525qtr.12
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 09:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6uxuErITjEh6An/fkXW9FmqMiJDJhKZ0Ehx22AYjWc0=;
        b=jGr+4CvpaJLFzMEndd5NCrXf2CQMo1XELiUQK3ZzEdEi74s3SB07j7rFoB7ZqShwTl
         pm/cuAweMV8KdoW6NAY+ApoAlJB+9Ax41Yv29hCTTFhBm9LrXZ53P1TTw4cP6lqxbTqo
         AA9uA1/qrtBE4UQW8p+tteWM3IM88bJJbt8dnlx+dWzBr6VDby2ToLe3AeyFH1uMskpf
         Q+YCijDUQpC8R8z7OX7M6/siIp59YZQ8rE1x3UvyNEcIGbxgzK3QgQg7FiSVg2ml3Qwh
         zrZMr3SDS46K8eqXwHGZ/rt/SwFZjF2jdbfhxXlpb0VvWCmMMj4xB2uFzNH9SlKC+CXa
         4hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6uxuErITjEh6An/fkXW9FmqMiJDJhKZ0Ehx22AYjWc0=;
        b=R9YYFjuxIdvHZBXEAF8DBhArXw8+OqJt4zGiMeMrmjBnbIPZQouzTazivE2pC1YlG5
         kx3dGmQY11dQf2t9DRS0wf2/TeZpR/ZJiOcD4DmEgXHFybl/v3NP1V2iFndDr0GUpMOr
         JnwkH/2w3HpvcdMO3VCfDZOP9eP9xJFDqdH9ykoT95+FlukchdZKNHmyDUip0t8yGPfV
         jCE4NeA5WPvNd+pEyBEGHQ5rojFL94+xPgIqSA5qcsu4JnKR2YvUQJ02AtXBInOUmHlo
         3U53STJTx1t8zoQ6stMp3DBrPpJRNCGoaUldTeB0queqYbzNHPHQkYH6Kg2FBy4URNxE
         GOBw==
X-Gm-Message-State: AO0yUKVJe9lx/JZqn6J47h8DArhTJBE7X1U/rZKhqOBq/Z98Tg1/mzly
        fjO4T98e+L/vXKGwOtFv9pRLf61+Cx33hQ==
X-Google-Smtp-Source: AK7set8Y9jl9nxu8gboQ8gVwd1MnM6yLfi5fCoVru00F1OEy1Ol1Fd4ImZaqnuORMX6OhzXqRh5xYA==
X-Received: by 2002:a05:622a:1a92:b0:3b6:309e:dfe1 with SMTP id s18-20020a05622a1a9200b003b6309edfe1mr34338918qtc.3.1677260688969;
        Fri, 24 Feb 2023 09:44:48 -0800 (PST)
Received: from [192.168.1.211] ([2600:4041:4542:c100:903c:2f5b:93be:1591])
        by smtp.gmail.com with ESMTPSA id s128-20020a374586000000b007426b8eed51sm2128588qka.118.2023.02.24.09.44.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Feb 2023 09:44:48 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 2/2] diff: teach diff to read algorithm from diff driver
Date:   Fri, 24 Feb 2023 12:44:47 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <95D30379-4B31-4197-8D2F-71369E72514D@gmail.com>
In-Reply-To: <Y/ZxT2ByET4BxGVt@coredump.intra.peff.net>
References: <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
 <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
 <b330222ce83bdf03c20085ff10fcff8a090474d5.1676665285.git.gitgitgadget@gmail.com>
 <CABPp-BFCMpA=nHtb5RuQL7ACbkhSEKtvmRxKwMuktcf24uQJtQ@mail.gmail.com>
 <EE7565DF-BE70-4C45-AF0B-95C85050DFA4@gmail.com>
 <CABPp-BGDi1VQXFdGw_Y8i0ZDBOoHJe9039fh4mO44qJ-nJE1ig@mail.gmail.com>
 <47981D9E-9DC7-4C23-911D-13BA52A27040@gmail.com>
 <CABPp-BHQn0sjAMwJ+r6uenO=nGLG1HvfnhS6tG8mu1BWt4bdOw@mail.gmail.com>
 <Y/ZxT2ByET4BxGVt@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Peff,

On 22 Feb 2023, at 14:47, Jeff King wrote:

> On Mon, Feb 20, 2023 at 09:32:52AM -0800, Elijah Newren wrote:
>
>>> I was thinking we would just use the tree-ish of the first one
>>
>> That would certainly simplify, but it'd be pretty important to
>> document.  (Incidentally, this kind of decision was my reason for
>> asking about all those special cases earlier, i.e. how to handle diff
>> between different commits, how to handle renames, how to handle bare
>> repositories, etc.)
>>
>> This kind of decision probably also means you'd need a variety of
>> testcases where .gitattributes is different in every commit & the
>> index & the working tree, and then you start testing several of the
>> possible pairings to make sure the right .gitattributes file is used
>> (e.g. (commit, commit), (commit, index), (index, commit), (worktree,
>> index), etc.)
>
> There may be some prior art here in how we handle mailmaps in a bare
> repository. In that case, we pull them from HEAD (or really any commit
> of your choosing, but the default is HEAD). That may seem a bit weird,
> but it matches how non-bare repositories work, which read the mailmap
> from the working tree.
>
> So likewise, even looking at an old commit like "git show HEAD~1000", in
> a non-bare repository we will read .gitattributes from the working tree,
> which means it is (roughly) coming from HEAD. In some ways that is good
> (there may be improvements to the attributes) and in some ways it is
> weird and confusing (the meaning of the attributes may have been
> different back then, or the two histories may even be somewhat
> unrelated!). So I think you can make an argument either way on what is
> useful, but harmonizing the non-bare and bare cases seems like the best
> place to start.

Thanks for the historical context and suggestion here
>
> And then that machinery would probably be enough to let people ask for
> specific things on top (like "git show --attributes-from=HEAD~1000
> HEAD~1000" if they really wanted).

Makes sense to me

thanks
John

>
> -Peff
