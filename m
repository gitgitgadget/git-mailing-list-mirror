Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586F6C433EF
	for <git@archiver.kernel.org>; Sun, 17 Apr 2022 05:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiDQFIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Apr 2022 01:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiDQFIe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Apr 2022 01:08:34 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDA52AC54
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 22:05:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 21so14304653edv.1
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 22:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmmO6LCBsGxQtCld/1pmKBFtOqpuWFIymwQHGt/LLlQ=;
        b=SfM5FLw8J9Dr+fHv0Z6DDPwfTz6s709Nd5U3UJxUUD3v9EWf3TzhUma5fa6kbydcFT
         Q0Dx/kMJTL298M5tMtblBHQ7NShBUxCEcoOx3rBw4x5crbsCVN+5p4IfFQp3Ey5nfymD
         HR7qDt6FDUP1+ugDYGudd2hRXAAZVC4a8Py/jH/4oaRgZl/HrGgbxxLs5o3uWu5FgJPJ
         BoEPVouWurxIq5YCBo36NFqEfBjOWN7jLq8NMvq1A0IzZq3dWMd0aL04W5A42gKGlmEN
         ybDCiN3oHBQk3tK+FNZkH2Dr1CLQmNHYNwM1bKvLWhTgKJzvMmE7+IQeGCr2MSJMXMT7
         PkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmmO6LCBsGxQtCld/1pmKBFtOqpuWFIymwQHGt/LLlQ=;
        b=pj2oeg65/9EXcxJhwBahx6Y83q6/CquOrK4GOUKlPpSxHtsKAeCab4UQssc+83vzRr
         JrkTsFUBVcz7EXrbak+0S0Ol6uz71K3euHb4VzDM0yFAyEcIc+583TrPsTDYm8pgwJWw
         WPAIN9tEefpWHRzVrWLFBl4StZo8PjhrgoToSdPu+Z80V0AVj90alHRqXaLdLkmBIAe7
         0jhEe4ptLgpA0HERklMGoCTrPgqCXzdys4qHlSjiicohV2QNU748/+2bVb7SASMwOuwA
         naL/wpA1yjRtkmPoyoGkxrKptdcOEYKWpAOO5JimEm24fVkWn6sIBuZ2bYmRzLMK8iKp
         +WMQ==
X-Gm-Message-State: AOAM530gdFS41lm5M6rwrRaf0ZXhT2jdnCsrUXqNx4LwwbHr440aB6uz
        WgZxkjlkIxs5jIn1JaFG7bVSncpWjnzVsqUIzy6hjw9WkFc=
X-Google-Smtp-Source: ABdhPJyS4pkVe3CZJGHKudwbRe+xwYZEVIp8oWkY/Gf9D76m6/chdhZH9KjuJ35zXDTOl4l7tmO/B/sHKpcdNUkvtX0=
X-Received: by 2002:a05:6402:34cf:b0:419:75b1:99ad with SMTP id
 w15-20020a05640234cf00b0041975b199admr6432009edc.228.1650171957866; Sat, 16
 Apr 2022 22:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220413164336.101390-1-eantoranz@gmail.com> <xmqq4k2wap8g.fsf@gitster.g>
 <CAOc6etYvOhqQn3icWj3Ny1m+J_60h7aiqW-gvm=dQyDLgG=6NA@mail.gmail.com>
 <xmqqbkx2ccj4.fsf@gitster.g> <CAOc6etYwMtfytbw6iRfnJnsexJhe7UydVu0OFUbWP0byS9i=MQ@mail.gmail.com>
In-Reply-To: <CAOc6etYwMtfytbw6iRfnJnsexJhe7UydVu0OFUbWP0byS9i=MQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 16 Apr 2022 22:05:46 -0700
Message-ID: <CABPp-BE=H-OcvGNJKm2zTvV3jEcUV0L=6W76ctpwOewZg56FKg@mail.gmail.com>
Subject: Re: [RFC] introducing git replay
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 15, 2022 at 10:41 PM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
>
> On Fri, Apr 15, 2022 at 10:33 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > It would be wonderful if a single command like replay can be used to
> > say "In the old history master..seen I have bunch of merges.  master
> > used to be M but now it is at N.  Rebuild M..S on top of N _but_
> > with a bit of twist.  Some of the topics in M...S may have been
> > merged to 'master' between M..N and the replayed history on top of N
> > does not want to have a merge from such 'already graduated' topics.
> > Many topics are updated, either by adding a new commit on top or
> > completely rewritten, and we want an updated tip of these topic
> > branches, not the old tip that I merged when I created M..S chain,
> > when replaying the history on top of N."
> >
> > That kind of operation is quite different from what "rebase" does,
> > and deserves to be under a different name.
> >
>
> Let me work a little bit on your workflow to see what I can do.

Replaying merges is something I've put a little thought into, so allow
me to provide some pointers that may help.  Merges need special
handling for replaying, and in my opinion, doing either just a new
merge of the new trees (what rebase --rebase-merges does), or just
reusing existing trees (what you proposed to start this thread) are
both suboptimal, though the former is likely to just be annoying and
require potentially unnecessary user refixing, whereas the latter can
silently discard changes or reintroduce discarded changes and could be
dangerous.  More details on both of these...

An important part about merges is they may have resolved conflicts --
both textual (the standard conflict markers people have to resolve)
and semantic (e.g. one person changes the API of some function, and
the other branch being merged adds a caller of that function, so the
merge has to modify the new caller to use the new API).  We do not
just want to do a new merge and re-use the commit message (as rebase
--rebase-merges does), for two reasons: (1) the user either has to
re-resolve the textual conflict resolutions by hand, or use rerere
which requires a working tree (and we'd like replays to proceed
without a working tree where possible), and (2) it tosses semantic
merge conflict resolutions entirely.  We also do not just want to use
existing trees as-is (as you started with in your patch), for three
reasons: (1) when we move to a new base the new merge needs to include
the changes from the newer base, (2) the topic might have additional
changes added (or removed) during the "rebase" which need to be
reflected in the merge as well, and (3) the merge may have had
additional changes stuffed directly into it to solve semantic
conflicts which we want "ported" to the new merge commit.    So, for
handling merges, we should avoid both of these overly simplistic
mechanisms, and do something that tries to handle forward-porting
these conflict resolutions.  I have outlined steps to do so at
https://lore.kernel.org/git/CABPp-BHp+d62dCyAaJfh1cZ8xVpGyb97mZryd02aCOX=Qn=Ltw@mail.gmail.com/

> Tip: It will probably come out in the shape of a script. We can talk about
> what to do with it later.

Note that we've worked hard to replace scripts with builtins in git,
especially in the case of rebase.  Scripts are great for prototyping,
and I fully support that, but I'd rather that scripts remained a
prototype.  I'd be sad to see us regress and return to scripts for
rebase.

> > Compared to that, "replay exactly the same set of commits in the
> > same shape on top of a different commit whose tree happens to be the
> > same as the original", is a mere special case of "rebase" that is
> > not all that interesting.  It may be a worthwhile thing to do to
> > teach "rebase" capable of doing so reliably and more efficiently,
> > but that still falls into "improving rebase" category, not meriting
> > a separate command.
>
> I agree that it might not require a full separate command. I'll see if
> I am able to get it into rebase.

If you'd like to try out some of the ideas in the link above for
handling replaying of merges, feel free.  I've done a little bit of
playing with this idea, and would be especially interested to learn of
any new testcases or challenges you come up with.  I think a full
implementation requires changes to the merge machinery (at each of the
merge-ort.c, ll-merge.c, and maybe even xdiff/ levels), on top of the
merge machinery changes being driven by the merge-tree changes.

[1] https://lore.kernel.org/git/CABPp-BGW39_5r8Lbt3ymR+F_=hWJcf=2e7O75vFNJ=3CEL5s=g@mail.gmail.com/

I'd also like to mention that I have a git-replay command, as
mentioned previously at various places (see [2,3,4,5,6,7] and probably
elsewhere).  It's far from complete (I was busy with sparse-checkout,
merge-tree, etc., and then disappeared for over a month on top of
that), but I still intend to complete it.  I would like it to cover
several usecases, including better replaying of merges, and I think
usescases like the one Junio points out here should be in scope.  If
you'd like to play around with my git-replay (not even alpha quality
yet, though it can do some things), feel free to take a look:
https://github.com/newren/git/tree/replay

[2] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110211147490.56@tvgsbejvaqbjf.bet/
[3] https://lore.kernel.org/git/CABPp-BH_TiJaDpn2+VVjCb83NEFjL9teSk06+YiZyFGiTu8Lpg@mail.gmail.com/
[4] https://lore.kernel.org/git/CABPp-BHpK8hPsiuHoYsf5D_rjcGLSW-_faL3ODoh56pG_2Luwg@mail.gmail.com/
[5] https://lore.kernel.org/git/CABPp-BFQv+mrWj8iH0Vo5Pr5L922v=ZsVthFjofy5pm1Sx8x5Q@mail.gmail.com/
[6] https://lore.kernel.org/git/CABPp-BE+DaBkis0r7pqs-kaChCvFhCEsyDg=gs3=QjWOPERaXQ@mail.gmail.com/
[7] https://lore.kernel.org/git/pull.1122.v5.git.1645340082.gitgitgadget@gmail.com/
