Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E147C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 22:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbiCAWOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 17:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiCAWOc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 17:14:32 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041053F33B
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 14:13:51 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x5so23845401edd.11
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 14:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+RmzTZGyW8r4gSJGiI+DXFgk4H7UHv3frGxVSpkYhU=;
        b=qhdSqnf+LFU18SyMmpNcz092uoClQ8DjjpslvpCJQLAuQmElQ7j3AqGRp46h139oz/
         52m5+N7srdLvzJoX9T34A4L1QdE65CWZ/jY/RO6OLg0dqyuz1DhJSNUaEdoqiNsQyKb0
         IdyfdT7XpB72WEJj1aOwzt4lzCTJVU7IWzEyh4cw4xLRYEGKdqR95gId45AEihWCW2LO
         +/Hd9UL9zrgKYo/JmPNJbU6doGRqDl7VoGpdGLJY0bzxaTVy52Jq7ueowO1ghV7NziCK
         yB7NnB4KFLWY/fgDHEau33hVhBgXDc/tKk0UO11yF4p5VwaKBeqxIag5BS8sbtPPgNoH
         /ubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+RmzTZGyW8r4gSJGiI+DXFgk4H7UHv3frGxVSpkYhU=;
        b=OlK/pB3LDdk++uEA8xNzLT2H/0SRmAbT0EAOlTIUyp0hQx4iLZpGJfYGEtEfZeH0fe
         3G8UGunLwF3PykH4Dv1gC+FSkoPnM4l+COVaiApNbu3lkuJhQc15oC0su4EZeUWT/zb1
         wDsfDfKy9npPS8DR3uWb6yKwaPeG16ZVlm/XzGJ9gQiu4McO7OxSV2Domp4rikEKUrjE
         UbhruoaxIXxwjwsRQxwOoD0/hVj49gn2pH2n+pg/k4ermZvb8QdfF7wNjC0E29EybTOA
         gRprESFwnNe7GCpMf82mcS71ynJv/0jDtPoHxB08xAXVdbTBfJy1rzJAHxXhZYcGQD7R
         VKGQ==
X-Gm-Message-State: AOAM530cg7BcNUGmTNqdRkd9egQySRBJ5U+GjCowTfzA81/WAeg2D1Z0
        kyRryUnTuqpY6RJlklIaOryNDuOJmplYf14mmqg6YA==
X-Google-Smtp-Source: ABdhPJzaSHbkOEQIx+s9UJS9CcekEdxJ0ZHm3kYdIsQlfV7f7PL/izn81ZR0sfandq06WmNoq7ZBdRKEts0zSbLk6Fs=
X-Received: by 2002:a05:6402:528e:b0:407:80ff:6eed with SMTP id
 en14-20020a056402528e00b0040780ff6eedmr26543808edb.165.1646172829565; Tue, 01
 Mar 2022 14:13:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
 <pull.1166.v2.git.1646127910.gitgitgadget@gmail.com> <3e3c9c7faace505958aa01ff82bef5fad3204c67.1646127910.git.gitgitgadget@gmail.com>
 <xmqqk0ddr1n1.fsf@gitster.g>
In-Reply-To: <xmqqk0ddr1n1.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 1 Mar 2022 23:13:38 +0100
Message-ID: <CAPMMpojJhw40DK7mEpZ-4ht6FHohAms=G9LsPQQx6+LCMmWtwA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] t7063: mtime-mangling instead of delays in
 untracked cache testing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 1, 2022 at 7:03 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +chmtime_worktree_root () {
> > +     # chmtime doesnt handle relative paths on windows, so need
> > +     # to "hardcode" a reference to the worktree folder name.
> > +     test-tool -C .. chmtime $1 worktree
> > +}
> > +
>
> Enclose $1 in a pair of double-quotes to help readers.  They do not
> have to wonder if the caller is interested in (or has to worry
> about) triggering word splitting at $IFS if you did so.

Absolutely, thx.

>
> >  avoid_racy() {
> >       sleep 1
> >  }
> > @@ -90,6 +96,9 @@ test_expect_success 'setup' '
> >       cd worktree &&
> >       mkdir done dtwo dthree &&
> >       touch one two three done/one dtwo/two dthree/three &&
> > +     test-tool chmtime =-300 one two three done/one dtwo/two dthree/three &&
> > +     test-tool chmtime =-300 done dtwo dthree &&
> > +     chmtime_worktree_root =-300 &&
>
> I am wondering if it is better to spelling it out like this:
>
>         test-tool -C.. chmtime =-300 worktree &&
>
> instead of hiding the fact that "../worktree" is being touched
> behind a one-line helper.  Being able to explicitly write "worktree"
> in the context that this particular code path uses the "worktree"
> directory is a big plus, but at the same time, bypassing the helper
> makes it unclear why we just don't chmtime "../worktree", and will
> strongly tempt future developers into breaking it, so, I dunno.
>
> What's the reason why utime() works only on a path in the current
> directory and cannot take "../worktree" again? If we cannot solve
> that, I guess an extra helper with a big comment, like we see in
> this patch, would be the least bad solution.
>

Heh. It didn't work, in my initial tests. Now it does. It turns out I was
initially getting the directory handle with
"FILE_WRITE_DATA | FILE_WRITE_ATTRIBUTES", and
everything worked except modifying the current folder via a relative
path expression, which yielded a "Permission denied" error. I
worked around it by explicitly changing the current directory...

Then I realized FILE_WRITE_DATA wasn't necessary (but didn't
connect the dots). Then you noted the "-C .." arg to test-tool
(and I still didn't connect the dots).

The problem was never relative paths, but rather trying to get a
writable handle to the current directory. The only reason "-C .."
worked was that I already stopped trying to get a writable handle.

I have no idea what it means to get a writable handle to a
directory, but apparently you can't do it for your current
directory. Now I know.

Thanks for the nudge, this is all clean now.
