Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718EEC433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 00:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbhK3ASE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 19:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbhK3ASE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 19:18:04 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02425C061574
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 16:14:46 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z5so13940633edd.3
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 16:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=30hyLvMHy6ptkInR3uBMQ2mYT+pNHNaXaiqaLRC9X0w=;
        b=A1tVqk6HBeUe/AJN3C5E2bNVsgbsogCC81XPG77n+Nun+/nmwscEN2MkSEe1ektTNN
         j5FbbcnI7BtLI/Nz+hW9wUfX+TTGZVcwHurRgD6lsFPxsmtC5JFhSbvhcQZG6N5u3azD
         b1ZOD2AeDo27MX/KhJqNUMDsjtMcH5EX3CVtBRZX6l2bdEoxgqF9bAlVqgx4Ba3Jr0L4
         DiFiY9JIztNMyqDIZK4IkYJOo/toVqYeMmviwTHwAHijLxmU7+5NrThF026sq2XSFS2f
         vHHJxMilF435lUQDgLmzuAZ/smwwlLpQgAyrpKfX7Ug5U9GpUFsYiXR5Q6sNuaAWso8I
         8gQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=30hyLvMHy6ptkInR3uBMQ2mYT+pNHNaXaiqaLRC9X0w=;
        b=aOYnemYh2l5TCW9b4hKODMCa0MpxKrrcv/95Ia+QPMRjX7KeDa6K6eRipxmJ1my0em
         8/2Z4bXaH6kK2eeXICd9zLTU+6RDGYrAbI3hV9rzG/Iq1AH8As0NeqMCjfgcjc154fDO
         Q6ayocMJ3aOCB1M8tYDi+MacMK2/8D2ZxzA+1Yml9p5aMAZodngg64bFPHiphWyzyn82
         AuRAaX3xLJJLTXV5eAuJbw8WPHm2TZG4yp+9go+yk1L+4visLuyVo0DJAWwRfiyfF1hv
         ahecQ1hHSaXlmwi2reAy/RF2Yd1pMpZKPapKZVWHtscDHlHmF67zfwWo+Peeg3JfA5yZ
         vbAw==
X-Gm-Message-State: AOAM530JfbM6R+p45RQXOyuVDfds3gdWAw+AlONjPLQ5cFNHM+pKH3xC
        WbCeBKT6fiVYadq4Ez7sVvGp2NCVLLvDHxsFNCyyrVq6FUI=
X-Google-Smtp-Source: ABdhPJw3HqdyN6ai4PjNZYxF+rMgIbBeUMcksalIJg7++xQnXTFDsooow3gbdiILR0YN1BiDKjcpxxQTedIo0C2En6Y=
X-Received: by 2002:aa7:c902:: with SMTP id b2mr77100105edt.320.1638231284574;
 Mon, 29 Nov 2021 16:14:44 -0800 (PST)
MIME-Version: 1.0
References: <CAMJzOtyw78-8gt3oGscN7KUzpzRRWtAQuGfcJ+R_Fjoom9Lexw@mail.gmail.com>
 <211129.868rx7gnd5.gmgdl@evledraar.gmail.com>
In-Reply-To: <211129.868rx7gnd5.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 29 Nov 2021 16:14:33 -0800
Message-ID: <CABPp-BFRE2=Owf15WzkacNfdNKbkd2n4GZh7HqDokKzeviBWRw@mail.gmail.com>
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

On Mon, Nov 29, 2021 at 2:25 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Fri, Nov 26 2021, Nikita Bobko wrote:
>
> > Steps:
> > git rebase HEAD --exec "echo foo"
> >
> > EXPECTED: since 0 commits are going to be rebased then I expect "foo"
> > NOT to be printed
> > ACTUAL:   "foo" is printed
>
> I don't think this is a bug, but explicitly desired behavior.

My reading of the docs are such that I'd expect the same as Nikita here:

        Append "exec <cmd>" after each line creating a commit in the final
        history.
        ...
        If --autosquash is used, "exec" lines will not be appended for the
        intermediate commits, and will only appear at the end of each
        squash/fixup series.

There is no line creating a commit in the final history when you do a
git rebase -i --exec "echo foo" HEAD (there is only a noop line), so
there should be no exec line.

> When you do:
>
>     git rebase -x 'make test' BASE
>
> You expect to run 'make test' for all of BASE..HEAD inclusive of
> "base". E.g. for HEAD~1 we'll run 'make test' twice, and you know both
> your HEAD~ and HEAD passed tests.

This is not true.  Try `git rebase -i --exec HEAD~$N` for various
values of N>0.  base is not included.

> So why wouldn't doing the same for HEAD make sense?

Indeed; HEAD is weirdly inconsistent and should be brought in line
with the others.

> That being said perhaps some users would think an option or
> configuration to skip the injection of "exec" after "noop" would make
> sense in that case.
>
> But does this really have anything per-se to do with --exec? Wouldn't
> such an option/configuration be the same as rebase in general dying if
> there's no work to do?
>
> And wouldn't such a thing be more useful than a narrow change to make
> --exec a NOOP in these cases?
>
> E.g. if I've got a "topic" that has commit "A", that's since been
> integrated into my upstream and I have a script to "make test" on my
> topics, won't simply dying (and thus indicating that the topic is
> dead/integrated) be better than noop-ing?

Why do you suggest "dying" rather than early completion with success?

Anyway, rebase does early exit in non-interactive mode when there is
nothing to do, it's just that interactive mode suggests users might
want to do something special, so they get a TODO list containing only
"noop".  Since --exec was written in terms of interactive rebase by
editing the TODO list and inserting an exec command after each of the
picks, and it accidentally always added one at the end of the todo
list even if the last instruction (group) was not a pick/fixup/squash,
we hit this bug.

Anyway, I've got a patch I'll send in.
