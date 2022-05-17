Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B449CC433EF
	for <git@archiver.kernel.org>; Tue, 17 May 2022 06:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbiEQGFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 02:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiEQGFa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 02:05:30 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0B53E5F1
        for <git@vger.kernel.org>; Mon, 16 May 2022 23:05:28 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id a10so18217990ioe.9
        for <git@vger.kernel.org>; Mon, 16 May 2022 23:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LAUHZm47a+2nNp4OJehNnQHQ6ZBCT0orIRCciZMUJC8=;
        b=XaZ6JZHGDLffPIcscMcy3H1AT99PIuBHQxJ8JKRx7OJsu+ezGh3pD9WvA+qicxRlwn
         Kqq6pOA6KsisqlFxxZ8gWXXl+So7Z4vR+uSYApNWuDWC51WvZrIFgaZCi/udXfuBkmp6
         zWcTOlHKvpR7Ej8fljK9vQym2PiBPUx1H/b3BZ4ROotRf8APEF6jJ5eLua4B7CDaFfHh
         JnNjs/CsHcf3P63ugdrJVnK95z5QnkzOEFoj5DHoLtM8QsG5DYo8ufobjLqOosFQ2S/4
         s62EC/HM2w/OioyD8Esn19jAL2WgErzd21hiaLtSK6ccDHwS8Lp79i2KQ33FnmCruOPs
         x6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LAUHZm47a+2nNp4OJehNnQHQ6ZBCT0orIRCciZMUJC8=;
        b=XixPYlmgGlR1xsIoO98adeoHkJO+JuaK/6q7zkO4YbkAaO4IfCq5PDU/W/VcCTlt8N
         LPToxPrhPR9D395pH0yVxOK55NoehCtQWEOjrJyoahObl5F0tkOgAaWfkm1mVU7V18Bn
         X5dlPz9xNWQPhNlQCIx3eTz6uHCbSKBtqk62t6+spHi/fwS/GJBf46X0deXhFKP2XE/U
         FBq/ba9b2oilGXGgKt2lfDKe+EbQ3w+m+ldu+Lb12X8aAYEi48LM11VAK4Gtw/FErLyq
         tjwYbzfGjbw2EV8QuA8jTm+1ZaWWrTQk2RJXbHzHsdcuZ0u3L9MaCfUJ5Q4os8nQv+wm
         rgrw==
X-Gm-Message-State: AOAM533W0MfYjY7A1oHo/wgfHlEDU4UMped3a709I4iBiqgjKvDB3Oa+
        RLVcabGYy5Cw9vhxvMdfO1l2SmDjJLW9zF5+d9eowRekU90=
X-Google-Smtp-Source: ABdhPJy6gRd3aQQr7eQrN2aACCQXCUFCSrSqtko2cY3nzZvJ4Y28UzBOvU5n+tfNn4Hb9lULzx0OV8WjfIXc+ZxSp8I=
X-Received: by 2002:a05:6638:409e:b0:32b:c91a:734f with SMTP id
 m30-20020a056638409e00b0032bc91a734fmr11135805jam.127.1652767528340; Mon, 16
 May 2022 23:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1266.git.git.1652690275625.gitgitgadget@gmail.com>
 <pull.1266.v2.git.git.1652690501963.gitgitgadget@gmail.com> <xmqqv8u54gcm.fsf@gitster.g>
In-Reply-To: <xmqqv8u54gcm.fsf@gitster.g>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Tue, 17 May 2022 09:05:17 +0300
Message-ID: <CAGHpTBJDeOMCfv36Sey1tGadQThS8mGR00YiK4C16BbV==W8XQ@mail.gmail.com>
Subject: Re: [PATCH v2] fetch: limit shared symref check only for local branches
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 16, 2022 at 7:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Orgad Shaneh <orgads@gmail.com>
> >
> > This check was introduced in 8ee5d73137f (Fix fetch/pull when run without
> > --update-head-ok, 2008-10-13) in order to protect against replacing the ref
> > of the active branch by mistake, for example by running git fetch origin
> > master:master.
> >
> > It was later extended in 8bc1f39f411 (fetch: protect branches checked out
> > in all worktrees, 2021-12-01) to scan all worktrees.
> >
> > This operation is very expensive (takes about 30s in my repository) when
> > there are many tags or branches, and it is executed on every fetch, even if
> > no local heads are updated at all.
> >
> > Limit it to protect only refs/heads/* to improve fetch performance.
>
> The point of the check is to prevent the index+working tree in the
> worktrees to go out of sync with HEAD, and HEAD by definition can
> point only into refs/heads/*, this change should be OK.
>
> It is surprising find_shared_symref() is so expensive, though.  If
> you have a dozen worktrees linked to the current repository, there
> are at most a dozen HEAD that point at various refs in refs/heads/
> namespace.  Even if you need to check a thousand ref_map elements,
> it should cost almost nothing if you build a hashmap to find matches
> with these dozen HEADs upfront, no?

I also had this idea, but I'm not familiar enough with the codebase to
implement it. I see you already started that.

> Another thing that is surprising is that you say this loop is
> expensive when there are many tags or branches.  Do you mean it is
> expensive when there are many tags and branches that are updated, or
> it is expensive to merely have thousands of dormant tags and
> branches?  If the latter, I wonder if it is sensible to limit the
> check only to the refs that are going to be updated.

It's expensive even when *nothing* is updated. I have a repo with 44K
tags, 13K of the tags are annotated, 134 remote branches and 4
worktrees (except the main repo) with 33 local branches.

I counted the calls to find_shared_symref - it was called 35755 times,
and refs_read_raw_ref was called 357585 times.

- Orgad
