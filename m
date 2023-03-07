Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCD6C6FD1B
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 17:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjCGRaZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 12:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjCGRaB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 12:30:01 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CCF8C95A
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 09:25:15 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so12563226pjp.2
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 09:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678209914;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+X4rY4Po4UWozDjhLGqpN4DVXJcjTDc2Wal/Um9yLaQ=;
        b=QjaSJIEndEbz7ujc8MUsPWYPkto+pOREbyiag/8cy9IRAdJfQXml/K9yOU18GQfQB9
         N7yqt9B9xDS0Wch3LSXCzvwzYgziusVlpd/xU+x+TvRwl2F0TFRhofupmG0avFwrZfH/
         140u0CuwUDKYInTgiOFlPepMMlKefJDrSZdXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678209914;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+X4rY4Po4UWozDjhLGqpN4DVXJcjTDc2Wal/Um9yLaQ=;
        b=KENeji4tFaHk0+DGjMfqcofmi78Pf2yF3MrpCjbidET025+u/nwu0LsxSeNxY90zNJ
         5D4nofn9rCX8ouITu6XCEl0Xo9LnZbguEgepztEk22G0WG3P/vDCScOpKCcvE+Xi3qdV
         MjlPWzD4AitK67oQsWGJbyFvNcMBWoHt0TyOufiT7NSfz4UyaE/+TS3uhY2WlR8SOPlR
         ZUr9rN02aUJrZKR0kL85rRDOP1PuX3Hb9S7DyGaBrSsUi/UH8CbiKC/mEFwGXK6IRnlI
         T96wN3bGka/VYerNoMXprV4TIlEeWGETvjoCoeqgX/HrRO9Tg7xxgZ0LgqrxpHMC2HE4
         H6iQ==
X-Gm-Message-State: AO0yUKWk02LdKlW7Zz58N6kOtPZBr6JtSjG6O36gSTgfqRfFRpJhOfcd
        SMKNPL+XMdLISS21wYt2UamjMU29n9hRs+WX2VA=
X-Google-Smtp-Source: AK7set/CyiKI6N4aSsGUQe2wmJ4IwftEVDFw/Uy8SEvAZwB2NpUPWq26AYC/l1iITkTCVZsi6mcupA==
X-Received: by 2002:a17:903:230e:b0:19c:c961:ac15 with SMTP id d14-20020a170903230e00b0019cc961ac15mr17814310plh.0.1678209914420;
        Tue, 07 Mar 2023 09:25:14 -0800 (PST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com. [209.85.214.177])
        by smtp.gmail.com with ESMTPSA id kf3-20020a17090305c300b0019cb9764340sm8675237plb.225.2023.03.07.09.25.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 09:25:14 -0800 (PST)
Received: by mail-pl1-f177.google.com with SMTP id i10so14878538plr.9
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 09:25:13 -0800 (PST)
X-Received: by 2002:a17:903:25d2:b0:19a:ec61:98d4 with SMTP id
 jc18-20020a17090325d200b0019aec6198d4mr5980519plb.0.1678209913253; Tue, 07
 Mar 2023 09:25:13 -0800 (PST)
MIME-Version: 1.0
References: <Y/UAaC4oBPIby4kV@google.com> <Y/VcbWogtHrpXU8Z@tapette.crustytoothpaste.net>
In-Reply-To: <Y/VcbWogtHrpXU8Z@tapette.crustytoothpaste.net>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Tue, 7 Mar 2023 10:25:01 -0700
X-Gmail-Original-Message-ID: <CAHQZ30BrwiW6ia3v31gto9D8oejkj2UrqK93MjPFNwBJuOBK0Q@mail.gmail.com>
Message-ID: <CAHQZ30BrwiW6ia3v31gto9D8oejkj2UrqK93MjPFNwBJuOBK0Q@mail.gmail.com>
Subject: Re: Parallel worktree checkouts result in index.lock exists
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Raul E Rangel <rrangel@chromium.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2023 at 5:06 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2023-02-21 at 17:33:28, Raul E Rangel wrote:
> > Hello,
> > I'm trying to extract multiple trees in parallel so I can create a
> > tarball of the trees. I can't use `git archive` since it doesn't
> > currently produce hermetic output, and I need to support older git
> > versions.
> >
> > In essence what I'm trying to do is:
> >
> >     git --work-tree ~/tmp/bob1 checkout ff27f5415797ead8bc775518a08f3a4ab24abd53 -- . &
> >     git --work-tree ~/tmp/bob2 checkout e70ebd7c76b9f9ad44b59e3002a5c57be5b9dc12 -- . &
> >
> > When I do this though, I get the following error:
> >     [1] 4027482
> >     [2] 4027483
> >     fatal: Unable to create '/home/rrangel/cros-bazel/.repo/project-objects/chromiumos/platform/vboot_reference.git/./index.lock': File exists.
> >
> >     Another git process seems to be running in this repository, e.g.
> >     an editor opened by 'git commit'. Please make sure all processes
> >     are terminated then try again. If it still fails, a git process
> >     may have crashed in this repository earlier:
> >     remove the file manually to continue.
> >
> > Is this expected? I'm not sure why the index is coming into play here.
> > Is there another method I should be using to extract a tree into a
> > directory?
>
> This is expected because when you do a checkout, the timestamps and
> other metadata of the files are written into the index.  This is what
> makes `git status` work quickly: if the metadata of the files hasn't
> changed, Git doesn't have to re-read them to verify their contents.  You
> definitely don't want to delete that because you'll likely end up with
> corrupt data.
>
> If you want to create multiple worktrees, use `git worktree add`, which
> can create multiple worktrees that each have their own index, but share
> the object store.  When you're done with it, run `git worktree remove`,
> and everything will be cleaned up.

Great thanks for confirming. I ended up doing the following:

    git clone --shared --bare vboot_reference.git ~/tmp/repo-1 && git
-C ~/tmp/repo-1 --work-tree ~/tmp/bob1 checkout
ff27f5415797ead8bc775518a08f3a4ab24abd53 -- . &
    git clone --shared --bare vboot_reference.git ~/tmp/repo-2 && git
-C ~/tmp/repo-2 --work-tree ~/tmp/bob1 checkout
e70ebd7c76b9f9ad44b59e3002a5c57be5b9dc12 -- . &

It's a lot cleaner than my hacky `find` command. I didn't want to use
`git worktree` since that would modify the original repo. I just
wanted to extract the files, so the shared + bare repo works great.

Thanks!

>
> Note that with worktrees, you can have at most one worktree with a given
> branch (or detached head) checked out at a time.
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
