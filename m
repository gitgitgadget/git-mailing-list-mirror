Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666E9C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 04:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbhK3EEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 23:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhK3EEm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 23:04:42 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F029C061574
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 20:01:23 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x15so80880006edv.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 20:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B1qbypoWB5O2yIq3uSVmJMSltiBNsSynUfy3mazbdRU=;
        b=HlxbpDUuPJq6PT9fhdU99zvqUCOQoDW9n/clYhcYwgltAgqQH3+UxSiUce02DdsAmh
         VNDuG3uqe2AeHhyqDJipcdMS3KeoJIsNlh7waSSQ/dsxrgKEJ+wiGyPNQ/RQNVFxHr6R
         F32mcMCZQqdTRhlN7YO0KUjioY9nlZ1pqW5aJgGHpE0j40ZLT+iYa+IiN125yAJVob+F
         Wy4ohGs6vIpLar8qLBqo+aEKUBJV07awhgKsJ7+sFKtaN5z9YrWQSOsvq+ZEKG/9Jsss
         SWsNyIQ8mfehIbVMrVcrjvjMcKVgxQOkWom7Ks1oriUCQ5IuSm1KYogyBgWook6OzFtZ
         02Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B1qbypoWB5O2yIq3uSVmJMSltiBNsSynUfy3mazbdRU=;
        b=ZoiNQZP6bVOHear6kn8EG3x9BXPrkIHth7FbceM4uAuOCZdIbwPtttGojEa2aPaBj8
         rcSnyYpeuWr/1dpUdhMGhZMYnsyFuXWWYoO9COgshZgjWYhs/TjuwtTvO4i1fK/Fmczu
         UDrAe5IwBba+2u8MTuDbQaPZn/GZzyvyEZXfkQV/4UFiIHjaVTxIDnqeCTeyNnZHWcJf
         q+sOev9SjUS1Br2bzx8Yh+qz8nMMSPlG1z9uHW12jMuMdsW1VDf7ZiV8dsUwje/qf8Cw
         XQ9CatOGK82gIWXHnoyJmt7xSt509r/9Y6Ec2M6V6Eaw6Zo7dOx7NCHfBwLxZdo4UQp1
         eH2Q==
X-Gm-Message-State: AOAM532NduqMv1/BpABIbHRys9vM0LTt7o06lDWkMW4ji2JH8cw7x5J8
        l0GoJ6V3iVVWPPtup6BdIYCx27DYOyPQvMjGN7Hw/i0/Ji0=
X-Google-Smtp-Source: ABdhPJzRLQm61rWTUi+6tVq6M+bTjgzicaD3JmyBbUQFYRATce2+Ia5xpUhakyrRfHHCvQ6Ga6ZBYabi2orZrvahr7s=
X-Received: by 2002:a17:906:31c2:: with SMTP id f2mr65838933ejf.341.1638244881966;
 Mon, 29 Nov 2021 20:01:21 -0800 (PST)
MIME-Version: 1.0
References: <CAMJzOtyw78-8gt3oGscN7KUzpzRRWtAQuGfcJ+R_Fjoom9Lexw@mail.gmail.com>
 <211129.868rx7gnd5.gmgdl@evledraar.gmail.com> <CABPp-BFRE2=Owf15WzkacNfdNKbkd2n4GZh7HqDokKzeviBWRw@mail.gmail.com>
In-Reply-To: <CABPp-BFRE2=Owf15WzkacNfdNKbkd2n4GZh7HqDokKzeviBWRw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 29 Nov 2021 20:01:10 -0800
Message-ID: <CABPp-BFdw7wL40WcM7_pfLCRx5CrF30cOgu3mL5EB6DysEqZWQ@mail.gmail.com>
Subject: Re: [BUG REPORT] `git rebase --exec` shouldn't run the exec command
 when there is nothing to rebase
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Nikita Bobko <nikitabobko@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 4:14 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Nov 29, 2021 at 2:25 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> >
> > On Fri, Nov 26 2021, Nikita Bobko wrote:
> >
> > > Steps:
> > > git rebase HEAD --exec "echo foo"
> > >
> > > EXPECTED: since 0 commits are going to be rebased then I expect "foo"
> > > NOT to be printed
> > > ACTUAL:   "foo" is printed
> >
> > I don't think this is a bug, but explicitly desired behavior.
>
> My reading of the docs are such that I'd expect the same as Nikita here:
>
>         Append "exec <cmd>" after each line creating a commit in the fina=
l
>         history.
>         ...
>         If --autosquash is used, "exec" lines will not be appended for th=
e
>         intermediate commits, and will only appear at the end of each
>         squash/fixup series.
>
> There is no line creating a commit in the final history when you do a
> git rebase -i --exec "echo foo" HEAD (there is only a noop line), so
> there should be no exec line.
>
> > When you do:
> >
> >     git rebase -x 'make test' BASE
> >
> > You expect to run 'make test' for all of BASE..HEAD inclusive of
> > "base". E.g. for HEAD~1 we'll run 'make test' twice, and you know both
> > your HEAD~ and HEAD passed tests.
>
> This is not true.  Try `git rebase -i --exec HEAD~$N` for various
> values of N>0.  base is not included.
>
> > So why wouldn't doing the same for HEAD make sense?
>
> Indeed; HEAD is weirdly inconsistent and should be brought in line
> with the others.
>
> > That being said perhaps some users would think an option or
> > configuration to skip the injection of "exec" after "noop" would make
> > sense in that case.
> >
> > But does this really have anything per-se to do with --exec? Wouldn't
> > such an option/configuration be the same as rebase in general dying if
> > there's no work to do?
> >
> > And wouldn't such a thing be more useful than a narrow change to make
> > --exec a NOOP in these cases?
> >
> > E.g. if I've got a "topic" that has commit "A", that's since been
> > integrated into my upstream and I have a script to "make test" on my
> > topics, won't simply dying (and thus indicating that the topic is
> > dead/integrated) be better than noop-ing?
>
> Why do you suggest "dying" rather than early completion with success?
>
> Anyway, rebase does early exit in non-interactive mode when there is
> nothing to do, it's just that interactive mode suggests users might
> want to do something special, so they get a TODO list containing only
> "noop".  Since --exec was written in terms of interactive rebase by
> editing the TODO list and inserting an exec command after each of the
> picks, and it accidentally always added one at the end of the todo
> list even if the last instruction (group) was not a pick/fixup/squash,
> we hit this bug.
>
> Anyway, I've got a patch I'll send in.

Found over here:
https://lore.kernel.org/git/pull.1149.git.git.1638244719381.gitgitgadget@gm=
ail.com/
