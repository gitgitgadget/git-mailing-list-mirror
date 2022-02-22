Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CC0C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 18:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiBVSwk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 13:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbiBVSwj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 13:52:39 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866D610DA49
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:52:12 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id e22so1596862qvf.9
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=qqeCNpP6ws+2pnpMM6PtxT4MswiNxzVF7ViZIztsKuk=;
        b=p4R0vWkSXJ802l9dVxRHioBOoV83WGobJjranFGPsFkYBvvL7GFoYt3WwrHzzwD9T9
         Dgx172plr+NlEhtDChbn+sMGh3uIh9ITUj+9f7lyB0V5igBhNtimNwnkPwGo/uFvGKLo
         C052cVgtpd+A4Y3smDzUZIeuYqV8zMeCZAlTpC05+w5dxCOnK/hXTibJhVvSTwA80/Hi
         HiYPAyFcw2/8pcFQo4NEqInQLuXIPk9nJ6y5Xks0NMmcN5YMk3qxIgf/EGHiIZ/ITABY
         IEKfbv7lo62YhN7j1IdvwiVFYPNpTlKCB/zjLVZda7gl5wUbjoN7TIYvEZ6hoFi1PSO1
         pugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=qqeCNpP6ws+2pnpMM6PtxT4MswiNxzVF7ViZIztsKuk=;
        b=0vjG4bdWhD0hk8VMcgrgKKXpUpc0C2Lm/aRwl8djq2zt/Qgid7EQp7tMjun9H9q8lI
         uPxnI24Sjwy/kPN7VLvPVq3IDQvtoYNCKieI7nkTRbGmCt77wYidekHsZlR4SU1Xi0qY
         aT/6fhmXbbkP27q12Bneu0cQs0oY7ZyUiVv1YrPmB9Jc3s/URfdUm4GcYzZirA+RvwQj
         TAlkUJZY3mJdumVq6BSSncKw8TUhKu0UrPvhytU5ZnRN4/mL26UN8adKz6dMQxr2/V9h
         4h2mGBzawwKZShxtn+REIwcBuTb5rfuBRiWcQ7KA1Pxp3fwsXNsnE3udTrntIhmZQeaK
         ra5w==
X-Gm-Message-State: AOAM5328cbp6j7Ufo+hYSVbzSI2QDhOdP60TNMipXNfwr/TDy7H3c1uD
        oTKs4cKgMhg7g6HdG0R02cDT97E9kCA=
X-Google-Smtp-Source: ABdhPJy7ieO2+sLz9vnzZLWtYY8NlyTGWFoN7yaYnV1YZCghb5kGmJ/ZLi500M+R8/zr6aF/x054gg==
X-Received: by 2002:ac8:5790:0:b0:2de:783:5bd7 with SMTP id v16-20020ac85790000000b002de07835bd7mr11301710qta.552.1645555930523;
        Tue, 22 Feb 2022 10:52:10 -0800 (PST)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id o10sm229200qtk.84.2022.02.22.10.52.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Feb 2022 10:52:10 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Robert Coup <robert.coup@koordinates.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/4] [RFC] repack: add --filter=
Date:   Tue, 22 Feb 2022 13:52:09 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <CFECF0B1-A94F-4372-AFC9-C0469A17E9A5@gmail.com>
In-Reply-To: <YhQHYQ9b9bYYv10r@nand.local>
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
 <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
 <CAFLLRpJ1aDyLb4qAoQwYDyGdP1_PH8kzLAQCKJpQwiYiapZ5Aw@mail.gmail.com>
 <CB2ACEF7-76A9-4253-AD43-7BC842F9576D@gmail.com>
 <YhMC+3FdSEZz22qX@nand.local>
 <CAP8UFD2dpicW64eqBK47g43xDWA1qv2BMBEOSqj_My5PUs8TSg@mail.gmail.com>
 <YhQHYQ9b9bYYv10r@nand.local>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On 21 Feb 2022, at 16:42, Taylor Blau wrote:

> On Mon, Feb 21, 2022 at 10:10:15PM +0100, Christian Couder wrote:
>>>> Also, to have more protection we can either
>>>>
>>>> 1. add a config value that needs to be set to true for repack to remove
>>>> objects (repack.allowDestroyFilter).
>>
>> I don't think it's of much value. We don't have such config values for
>> other possibly destructive operations.
>>
>>>> 2. --filter is dry-run by default and prints out objects that would have been removed,
>>>> and it has to be combined with another flag --destroy in order for it to actually remove
>>>> objects from the odb.
>>
>> I am not sure it's of much value either compared to naming it
>> --filter-destroy. It's likely to just make things more difficult for
>> users to understand.
>
> On this and the above, I agree with Christian.
>
>>> I share the same concern as Robert and Stolee do. But I think this issue
>>> goes deeper than just naming.
>>>
>>> Even if we called this `git repack --delete-filter` and only ran it with
>>> `--i-know-what-im-doing` flag, we would still be leaving repository
>>> corruption on the table, just making it marginally more difficult to
>>> achieve.
>>
>> My opinion on this is that the promisor object mechanism assumes by
>> design that some objects are outside a repo, and that this repo
>> shouldn't care much about these objects possibly being corrupted.
>
> For what it's worth, I am fine having a mode of repack which allows us
> to remove objects that we know are stored by a promisor remote. But this
> series doesn't do that, so users could easily run `git repack -d
> --filter=...` and find that they have irrecoverably corrupted their
> repository.
>
> I think that there are some other reasonable directions, though. One
> which Robert and I discussed was making it possible to split a
> repository into two packs, one which holds objects that match some
> `--filter` criteria, and one which holds the objects that don't match
> that filter.
>
> Another option would be to prune the repository according to objects
> that are already made available by a promisor remote.

Thanks for the discussion around the two packfile idea. Definitely interesting.
However, I'm leaning towards the second option here where we ensure that objects that
are about to be deleted can be retrieved via a promisor remote. That way we have an
easy path to recovery.

>
> An appealing quality about the above two directions is that the first
> doesn't actually remove any objects, just makes it easier to push a
> whole pack of unwanted objects off to a promsior remote. The second
> prunes the repository according to objects that are already made
> available by the promisor remote. (Yes, there is a TOCTOU race there,
> too, but it's the same prune-while-pushing race that Git already has
> today).
>
>> I am not against a name and some docs that strongly state that users
>> should be very careful when using such a command, but otherwise I
>> think such a command is perfectly ok. We have other commands that by
>> design could lead to some objects or data being lost.
>
> I can think of a handful of ways to remove objects which are unreachable
> from a repository, but I am not sure we have any ways to remove objects
> which are reachable.
>
>>> But as it stands right now, I worry that this feature is too easily
>>> misused and could result in unintended repository corruption.
>>
>> Are you worrying about the UI or about what it does?
>>
>> I am ok with improving the UI, but I think what it does is reasonable.
>
> I am more worried about the proposal's functionality than its UI,
> hopefully my concerns there are summarized above.
>
> Thanks,
> Taylor
