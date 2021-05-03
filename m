Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F524C433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 09:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E9A610FC
	for <git@archiver.kernel.org>; Tue,  4 May 2021 09:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhEDJva (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 05:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhEDJva (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 05:51:30 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D322C061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 02:50:35 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c22so9693558edn.7
        for <git@vger.kernel.org>; Tue, 04 May 2021 02:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:references:user-agent
         :in-reply-to:mime-version:content-transfer-encoding;
        bh=0dm4P1W8xMiMI2RskXJgP1RjBcPoJJqJ22HdE1HBSho=;
        b=s942IXQ/BwDs6KVWUr/3gPYLlOctroibIxegJwnk7nGk5dpTRzr3U7KdWMxxskY+jq
         +PGCBs2B9zZuOIq9Y5D6fgWg+ktuQgsvu1AZwP4sLM7aq06nR1LBF2oBvIoN4ZtOVrN3
         tGoWOWqospI4YGlLJPTIEgmZ/B12jJe39m9AGJRMbttfEKic7D9mF9SYF3Jqc2T31iUD
         irkNaW7+7DArj6OoIPYikOAFEkCZdMGKoTzp1rLclVVHtCbl1pJ4hQCKryMds6wYxzkG
         3qqeFZkHJ9ks/4NQ4HB/w88kJttu6U94eR/pDmP2Af5009KzzXd9x4HgwqGJRuh4w230
         L9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:references
         :user-agent:in-reply-to:mime-version:content-transfer-encoding;
        bh=0dm4P1W8xMiMI2RskXJgP1RjBcPoJJqJ22HdE1HBSho=;
        b=YT7TKsXmVAHRAybIgg/JbnywFy4EX5NlZz1JzurVIOJCF3aV2PLAldQ2vygchSW4AF
         XZnERwLqhoSVieC4PCokebfYFA5UASnYFQvCSCcC7OwQW/b0kd3LWiLegSlDQL8zXbqR
         mAZE6QIAUwCCG2VaPlpTcGbyzScFa/ASQZUkKMaaOFwULof6zIZhHo4xRdUYD/WBCQN8
         PzN6MolWeXD0lMh/vItsrxh764ZXXaZ04pG1pLHt1Z644sIHq1Me7mwtodZ9SyNdobPU
         UU52NZbcdGq8aWmcu10lHxlqJDqyEJc86UnPUkNQ3Ixf2wC5oCt1HAtLrcTGaRKbPmgw
         v2Dw==
X-Gm-Message-State: AOAM533hAbHb6bRWm9R5vuinWw8qW9mzscDJTaUa4pUQRWBlC2LZcnMF
        mqd+K+St3UphMfKVFWqoh3g=
X-Google-Smtp-Source: ABdhPJxHdKAfDzriEHmGNK0sliUPU8GSeewRc5q6gDLDHXRM+TH9jdR/yjfvARWZYdvbotOikooCMg==
X-Received: by 2002:aa7:d658:: with SMTP id v24mr24525619edr.290.1620121833737;
        Tue, 04 May 2021 02:50:33 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w21sm13669181edq.82.2021.05.04.02.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 02:50:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] fsmonitor: only enable it in non-bare repositories
Date:   Mon, 03 May 2021 19:56:35 +0200
Message-ID: <87k0oex1yi.fsf@evledraar.gmail.com>
References: <pull.942.git.1619682362363.gitgitgadget@gmail.com>
 <87mttbx6ie.fsf@evledraar.gmail.com>
 <810dc60c-3730-b5f3-34f6-5cc2ddc9942a@jeffhostetler.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <810dc60c-3730-b5f3-34f6-5cc2ddc9942a@jeffhostetler.com>
 --text follows this line-
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 03 2021, Jeff Hostetler wrote:

> On 5/3/21 9:58 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Apr 29 2021, Johannes Schindelin via GitGitGadget wrote:
>>=20
>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>>
>>> The entire point of the FSMonitor is to monitor the worktree changes in
>>> a more efficient manner than `lstat()`ing all worktree files every time
>>> we refresh the index.
>>>
>>> But if there is no worktree, FSMonitor has nothing to monitor.
>>>
>>> So let's ignore if an FSMonitor is configured (e.g. in `~/.gitconfig`)
>>> and we're running in a repository without worktree.
>>>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> ---
> ...
>>>
>>> base-commit: 14d50074ff19e68e7a8d718b22d138882087bbc9
>> This is surely a correct fix for now, but wouldn't it in the future
>> also
>> be useful to run it in bare repositories e.g. to be able cache lookups
>> for non-existing loose objects?
>>=20
>
> No, the FSMonitor feature only expects data for paths within the
> working directory.  (And is independent of whether the FS change
> data is provided by my fsmonitor--daemon or provided by a hook-based
> provider, such as Watchman.)  The FSMonitor feature uses that data to
> shortcut scans of the working directory.

Indeed, hence "in the future". I'm not suggesting that it'll do anything
useful by watching anything in the .git directory now, but that it might
be an interesting thing to explore.

> There is no interaction with the contents of the .git/objects
> directory and I'm not sure how that would work.

We'd watch .git/objects and .git/objects/{aa..ff}, then when about to
check for a loose object we'd avoid hitting the FS.

I don't know how useful that is post-61c7711cfea (sha1-file: use loose
object cache for quick existence check, 2018-11-12), but e.g. on NFS
this sort of thing still mattered. I had a "bigger hammer" approach with
[1] that ran (and still does, I believe) on a big corporate
installation.

More generally, if you strace .git access during repo operations you'll
find we're doing all sorts of existence checks etc. all the time. Loose
objects, refs, seeing what packs there are (better with the MIDX, but do
we still fall back?) etc. If we had up-to-date inotify/fsmonitor info we
could ask the daemon about it.

1. https://lore.kernel.org/git/20181028225023.26427-5-avarab@gmail.com/
