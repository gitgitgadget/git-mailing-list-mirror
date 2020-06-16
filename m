Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11563C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 09:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF9F420767
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 09:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjwICFCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgFPJrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 05:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgFPJrO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 05:47:14 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E88C05BD43
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 02:47:13 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dp18so2589632ejc.8
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 02:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=geE5f3kPg2pgfsEvx0Tt4INsw2sPgvmqf0bbX1/P2ug=;
        b=bjwICFCYIVcYT55uJoS+RbgwqsCYPvLP8oypSIc4iv5wTvKFElGv0eVOoJivSi9Jtn
         t/8Lviijc0dl7bYv8ggUKNBxVU0F+YkgrrNrYzjgZGiQWXalpDQzft2tSgizdgNu0DfD
         KJvlqk3b9/ax0o4TMWCjA2kIxM9UNmpst6/M9JcGQAoN+eiW9avjPUHzWgg84z5NhIWD
         OxehAyEUHNWWs58xMROrrwPHS6jIm4HgRL4RbxwKgpm5vUiYeN5dUBFCUspwSf926AJr
         RswheP56yA7gO5RkRYvxLzZgbRY1jKGLocjOVEKYtp5CI01/O3ogIGQnPCDyly4uU3bP
         dERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=geE5f3kPg2pgfsEvx0Tt4INsw2sPgvmqf0bbX1/P2ug=;
        b=HsNOOdMeMxeS79dlXa4qdNVbmk3mmRdU4IXCc887MCyRcRd69+1K7pC1p8GjzNYmNy
         PHSBgJU5D48iXdrS+lYbChN4mUtkxpqYaKKc/W9jCIYh0YhtkX5rjyxYjfArNn1S69jh
         Sz7rZ7K5NiBMV94qNg22hwjtGWdCtDJQSZV3nK5IgTK2tfLSX0LILfTM+xfxDANGr0eM
         MIoCLzDLRdg7WoxQR6KYzdpIWNngO0jfBhryVkQaT1vPAhsquKLWgT5FYBK7b4axaUuf
         ZPLBaV0RI4eWFAbdSuQUBprBp16WLK6kiPExrrlQfWuRB8l7Ftb9XaMP0sYFsqR9/gnV
         2zuw==
X-Gm-Message-State: AOAM533/N31p2k01Up+9oTOs0xEfozhqcUH6x1BmtgNhsJBelKFKh0iK
        TEZfCkNeasGWppDT4+32BVe6VBcJ
X-Google-Smtp-Source: ABdhPJzI554WVQwCtu/lWHawnJD+oczlivYPTM8Js5SI/JCKDvaLUQWM8E7cW0gRaXQYto+r5HmdUg==
X-Received: by 2002:a17:906:1e92:: with SMTP id e18mr2050249ejj.254.1592300831835;
        Tue, 16 Jun 2020 02:47:11 -0700 (PDT)
Received: from evledraar (h65073.upc-h.chello.nl. [62.194.65.73])
        by smtp.gmail.com with ESMTPSA id g22sm10615815ejp.0.2020.06.16.02.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 02:47:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/9] Allow overriding the default name of the default branch
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.1.0
In-reply-to: <pull.656.git.1591823971.gitgitgadget@gmail.com>
Date:   Tue, 16 Jun 2020 11:47:10 +0200
Message-ID: <875zbrcpgh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 10 2020, Johannes Schindelin via GitGitGadget wrote:

> This series DOES NOT change the default automatically, but only provides an
> opt-in mechanism for interested users. It also presents a way forward for
> such a transition, if and when we decide to do so. Specifically, the new
> GIT_TEST_DEFAULT_BRANCH_NAME environment variable could be used to update
> test scripts on an individual basis instead of all-at-once.

I don't have much time for review today, but hopefully these comments
are useful. These comments are on the series as a whole[1] mainly to
save myself time in chasing down individual patches, and I think it's
more useful as one E-Mail, hopefully.

I think this change is going in a good technical direction. I'm just
commenting on the "how it would be done" aspect, I'm not going to add
another voice to the larger "is this a useful endeavor?" discussion
vis-a-vis what the larger goal is.

But I do have purely technical concerns about where this is going.

The part where we just make it easier to do what you could do all along
with sed(1) or whatever to rename the branch after "git init" is
obviously correct (or close enough). That part's easy enough.

The parts I'm concerned about is the behavior of how we make the branch
name persistent, which is new "while we're at it" behavior in git
unrelated to the convenience of allowing a configuration of the main
branch name without "git init --template" or after the fact sed(1)
munging.

Specifically:

 1. The special case in fmt-merge-msg we always had for "master" sucked
    in terms of producing more verbose merge messages for those of us
    who had repos where the main branch wasn't "master", but at least it
    was consistent.

    Now we've created a situation where a user's local config impacts
    what we put in the machine-generated commit messages.

    Now, these messages were never "plumbing", and other users could use
    different git frontends than "core git" etc, but it's a really
    useful property we've tried to maintain that a user's local
    configuration doesn't change what we put in these messages. It's why
    we've left them out of the i18n mechanism.

 2. The whole core.mainBranch thing rubs me the wrong way. So now if we
    rename a branch we munge it, but if you've got an older git version
    or whatever you get different results and the config isn't carried
    forward.

    I'd *really* like to avoid having what's essentially a refstore
    side-value if we can.

 3. Whatever we do with the submodule guess-a-name functionality, I
    think it's the wrong path to make it proceed in lockstep with
    MAIN_BRANCH_FOR_INIT.

    When you decide to change your branch names != when the rest of the
    world does it.

    Also, whatever the suckyness of the current hardcoded "master"
    behavior I think it sucks more than different users on the same
    version can fail or succeed to clone a repository depending on a
    config they set for "what branch names do I want on new repos?".

    This is simlar to #1, in that I'd much rather have behavior that
    consistently sucks than one that interacts with the wider world
    (writing commits, cloning random other repos) that differs because
    of my *local* config preferences.

 4. For fast-export I think we should just drop this entire "master"
    special case instead of making it read the config. That's also in
    line with its documentation. Let's just call it ref0.

    Either that or just hardcode whatever passes for the "main" branch
    name, but anything but making the to-be-shared anonymized output
    continue to leak local config, similar to #1 and #3 above.

In summary, I'd like this series much better if we split off the
convenience change for "init" from the improved heuristics/guesses for
remote "master". Just my 0.02.

1. git diff --stat -p @{u}...pr-656/dscho/default-branch-name-option-v2
