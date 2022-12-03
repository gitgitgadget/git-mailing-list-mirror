Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C5BC4321E
	for <git@archiver.kernel.org>; Sat,  3 Dec 2022 01:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiLCBFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 20:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiLCBFT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 20:05:19 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A66DEA6F
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 17:05:19 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id a14so2379261pfa.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 17:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O80aKMXRozNf7ypOruz889x7UDQPVu36PpZ5t/GKwsg=;
        b=dEuwaDnuaVlXl10ESMmN4dcvSzYXer+Adaue1DS7PgWVH8HZXNc0CwCTREymZbgi23
         2Gkexj4dnkH61PFWKqriteN00qczPKFtWnyEYr749u3Q5JLY7k0W1nUG1FA21MJIlbKE
         4KOCxdlFrGGT5s9IeSA5jGvexPOYDPhevGPB7e0qnL2qDqgXHZDuFkayXNYb7j0iApLZ
         Rj7uJ60oMmVOZkiNbAQPjpq91FDQ7JGVjY8xU43j1gNHbvfWnF3eyN51XT1SFHQ517Fp
         LSjCcanutHt25amJYCYUx090Jj612IJQkIq3Jju0y8e2JvpPETeTc6X4qP5untVW8g3Z
         +jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O80aKMXRozNf7ypOruz889x7UDQPVu36PpZ5t/GKwsg=;
        b=0aB4hr4IpjJucxjG5+hNqrIzuQkicQ+e6PVcqQXpZq4HGqRBVhOC/3Z2Sih4k8F0CV
         OeNIDSz9Qx3vd+N0ZbQGwsg7TpUb3EKVmDlTJNEbQgY7ammp/Jt3JmuTqAoa2I1Qu70u
         /Qm/3gdj7doWha8l8otFW9uQKuu4d/OsTpWXopcTkF7bJTHvts8Q5iCKVWN2wLndYxtG
         G5YDWgB289O6w5RGDzRXfoo5CSb+Jrx6j6ZPGwiLZ+pGG+vQnzFPF/wCvePw6LX7WGY+
         CBpoXkgu+RW142nQTEYLMouZPh/WAS5uwfn0tYdRxYFmSNH7KXcnvzOVjX+l1R7lYbV3
         hPzg==
X-Gm-Message-State: ANoB5pm7a9fweNDfhAovpXB/PDHWwVnI/xEL9bMtQCS+BV77KnGJallG
        dhYIQ2iWFKeBMUZxZZRM2ZA=
X-Google-Smtp-Source: AA0mqf6+Y4DfaCpVBG7KlTXQBp6EhVYre9I8nKG6Zuu8pbefN/5HQkreZvBXQYb+Ew0Dd0CjjAWX6A==
X-Received: by 2002:a63:ff63:0:b0:477:8d4f:3dda with SMTP id s35-20020a63ff63000000b004778d4f3ddamr50132245pgk.552.1670029518315;
        Fri, 02 Dec 2022 17:05:18 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z20-20020aa79f94000000b0056be4dbd4besm5663475pfr.111.2022.12.02.17.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 17:05:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Stefan Sundin <git@stefansundin.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH] fsmonitor: eliminate call to deprecated FSEventStream
 function
References: <pull.1436.git.1669991072393.gitgitgadget@gmail.com>
        <221202.86o7slfzot.gmgdl@evledraar.gmail.com>
        <3e2bd865-3ca5-b0f7-095e-f8b97ec8822c@jeffhostetler.com>
        <221202.867cz9fwnf.gmgdl@evledraar.gmail.com>
        <4711d955-02b2-f599-7f89-b442dd0b6215@github.com>
        <221202.86359xfs5c.gmgdl@evledraar.gmail.com>
        <1b090929-f2da-f075-01d4-458804fc0717@github.com>
Date:   Sat, 03 Dec 2022 10:05:17 +0900
In-Reply-To: <1b090929-f2da-f075-01d4-458804fc0717@github.com> (Victoria Dye's
        message of "Fri, 2 Dec 2022 13:17:49 -0800")
Message-ID: <xmqq1qphuwj6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

>> But git gets ported and backported to a long tail of systems way beyond
>> that. Eventually we do need to let got, but we've generally drawn the
>> line at some fuzzy notion of when users don't care anymore, along with
>> whether it's worth the effort to find out.
>
> My point is that such a user for this scenario is so unlikely to exist that
> holding up this patch - which provides a real, tangible benefit to
> developers *right now* - to implement your suggestion or modify the commit
> message is, at best, an unnecessary distraction.
>
> If, somewhere, there is a user that 1) keeps up-to-date with the latest
> version of Git, 2) uses FSMonitor, and 3) is working on the sole version of
> MacOS that was theoretically compatible with FSMonitor before this change
> but now is not, we can accommodate that once such a need is shown to exist.

I'd still prefer that our commit messages keep records of the fact
that we stopped supporting certain older systems and what kind of
due dilligence we did to decide it is a safe thing to do, which all
already happened in this thread, thanks to you three discussing the
issue.  I would be happier even with "Anything older than 2014 does
not matter to Apple, and we follow that stance" than without any ;-)

Thanks.
