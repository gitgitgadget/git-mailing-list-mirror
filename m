Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8BCC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 19:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95BB361352
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 19:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhFUTjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 15:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhFUTjE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 15:39:04 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C753BC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 12:36:49 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id es19-20020a0562141933b029023930e98a57so7284435qvb.18
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 12:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wY7nM0OLWRONzvX/rdU+Wnwi6g0V6w3myj8MPmt/+xk=;
        b=BjmzJ+PzmEZmZxRO4SXBlLLft44EUMtN+WHaIcd8KAcFGz5z0dEe/DS5WBLAaZGQUM
         S0pI1Vu1EXLpMEKBf2CPMytvZEIcmmEMdq43XNQoVXeswGANAmy/1oyrZpxfNZADCYlY
         /uALqRd3yj8d3PqYmx3abQCmXlCEc594MZTQWmvMMU/bk1blLVvXenf6NsEzOEyGX351
         Di5h+4O4A/XKUfaz1H1HIDK1KBS8eV3txGzBzc82odSy1SRO3AnVI8nV5oJ46cMVgGXu
         1RwQfng953LaaCJebR4iagYIT2WySbVSDF884Q8ZmG8J3nVUkv7QeZDZAUd67GZoAqEY
         Nujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wY7nM0OLWRONzvX/rdU+Wnwi6g0V6w3myj8MPmt/+xk=;
        b=OcQt0N1tY9EbXgtRHkeWat0/2h/+TgCBiBiC2cBYOax08jGskWz0RbTXV9He24Che1
         zvTMEEnV0bjj5vPr9TNdvhqfOe3fFj1qrM/0hw/OlIyd8wdghOnowe+GDBLPnJCNSAs8
         3FN4Lub5Zfvt3LVIMw82qRxMGFTURd4ccXmeIZbqMYQL6C0Mp1Rit6lzEM+klK+S7YCU
         vOqotyORu0GN9DtpIZthyAoT8KPJ5Kdg3y2+7a9sCP7eNYo28gBW6WzSYwJz9a9hXGXT
         VUsk3pTO9HeCHoZiwwCJxphGMUlBQp2Tn9MYoLhSouML3jxdoiLavQ+YOBGbFVqnxWnX
         Nong==
X-Gm-Message-State: AOAM5323J3xy7NkylJSt6YMLvaAhHxDI4CR7DC09oawF8jN8L7VbrImF
        E/GdvRn1Vc669CZgZLR7Z1KIXxeMjCtK/WFUHMTC
X-Google-Smtp-Source: ABdhPJyZM+vi4jX6gk/Jbt4/Q+SpLB9jAGVWOWEMA3v59EaY/geiE5cF/GFE73ZvGoQu132EINfnz5Bil/yCngyOD1Sf
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:e8cc:: with SMTP id
 m12mr4608478qvo.27.1624304208845; Mon, 21 Jun 2021 12:36:48 -0700 (PDT)
Date:   Mon, 21 Jun 2021 12:36:46 -0700
In-Reply-To: <874kghk906.fsf@evledraar.gmail.com>
Message-Id: <20210621193646.1173220-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <874kghk906.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: Re: [PATCH] hooks: propose repository owner configured hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     albertqcui@gmail.com, gitgitgadget@gmail.com, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Mentioned in [0], the primary motivation for a magic config branch
> > that lived outside of the worktree was "since the configuration is
> > separate from the code base, it allows you to go back in history or to
> > older branches while preserving "improvements" to the hooks
> > configuration e.g. maybe the project has shifted to using a newer
> > version of a linter."
> 
> It also means that your hooks will forever need to be aware of the union
> of all revisions in the project to work properly, or more likely they'll
> simply break on older revisions as e.g. a hook that needs to handle a
> test directory handles just "t", but it used to be called "tests".

Yes, but I think that's better than hooks not working when we're
operating on past commits for whatever reason.

> It's also just un-git-y in *requiring* a remote. A .mailmap,
> .gitattributes etc. all work with a repo you find on-disk, why does
> config & hooks need to be different?

Why is a remote required? The purpose of this proposal is for remotes to
suggest hooks, but that doesn't mean that the existing hooks mechanism
will no longer work.

> How would a user of such a repo suggest changes to a hook? Now it's
> fairly easy for e.g. .gitattributes, you change it, push a branch, ask
> for it to be merged etc.

It depends on the exact implementation, but in my suggestion [1], it is
a patch or a PR on a branch.

[1] https://lore.kernel.org/git/cover.1623881977.git.jonathantanmy@google.com/

> If you want the same hook for all revisions ever having some light logic
> in the hook itself to check/cache that (it's executing arbitrary code
> after all) seems like a saner thing for those who have this "magic
> branch" use-case than to make it the default.

If hooks are per-version, this doesn't work for versions before when the
hook was introduced.

[skipping discussion about general remote-suggested config]

> As noted by brian m. carlson etc. in the side-thread in
> <YGzrfaSC4xd75j2U@camp.crustytoothpaste.net> the danger is that by
> making this a supported feature git becomes the social-engineering
> vector to fool users into trusting a command like that which they
> otherwise might not have.

This danger is being discussed there, and we're trying to balance this
danger against the fact that projects need or want functionality like
this (as evidenced by the available tools described in the original
email).

> > This seems like an OK alternative to allow-listing based on remote,
> > but are you expecting users to add a GPG key to their .gitconfig?
> 
> That instead of saying you trust https://github.com/git/git your primary
> means of interaction with this feature would be saying you, as an
> example, trust Junio's GPG key.

I think this feature can be extended to trusting GPG keys later. Do you
think that we should move to a model of trusting a key *instead of* (not
"in addition to") a URL?

[snip until summary paragraph]

> So if I trust Junio's key and would like this to Just Work it would be
> better if I clone a mirror of git.git that it works, and I don't have to
> maintain a list of all mirrors myself. Trusting based on content and GPG
> keys gives you that, magic URLs don't.

This seems like scope creep to me - perhaps a GPG key is more flexible
than a URL, but I don't think we need this flexibility yet (and we can
always add it later).
