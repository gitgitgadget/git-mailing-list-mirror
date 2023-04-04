Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D19FC6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 21:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbjDDVPB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 17:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjDDVPA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 17:15:00 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209E8170E
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 14:14:58 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-545e907790fso524934927b3.3
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 14:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680642897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6gxlXrgptADu/RlV/6WWqUkuRYhZwusmMmm5NDCv5c=;
        b=QhfJJzyxmyGIRK8D1rs73ot3kGgQFI5o6mMgoMVo9YNn7a3EIANwLfQ/ZTUYmxLofw
         h6HMt8tRawYfi492VjBTk2/sw7Lxx5lRsGUZap4OWzuR+wRqzeDJc0c5ChSWUueFkMc5
         ddJ4iXA82KAitKXbSeETBnm9hduFhyYniWQviJgTUDdoNm5AJrVslH6qtJ20yQM3oCkG
         +gzFXvJa7hl5X6MF5jfVeOiXTTLhvr5mhClRc3MgL/jB7FjhVD7woWnQM5aGY6Czg1LI
         l7itMAHxOqtPtuGiu4lpiCn/eEEaWPTmc/NmrR1eNkYAxuR8vXUcgwhWiGij5V3Rp2mL
         QcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680642897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6gxlXrgptADu/RlV/6WWqUkuRYhZwusmMmm5NDCv5c=;
        b=xSV2fRpUwkgRZCCfrrQc1BFxI0gp1GB20ADqE2uingky2EWt6y6Pz2ML5TwDH1pEsv
         0c5kOzDm/m2lwCpkidN8VkIkq3zYgMYMbdIxi4DeB5MqvRrCpYAD0XcdCzq7CzSaTvzE
         FBZ/kT0SLK1eMX/zcEiAmKVeJaEcefHMMyVU+xxufYrQFMSoofKvyzUN4MjsplK/qBz4
         n294envQpf3gPWDrfFXn27WMP/cEA+jgchJMMunxwLPoHNkG6Jfty0A05quZ8ArnFBzb
         me59EW3yRYuyjJ13nXiFCiN2rK4mcORrz819+Gn4MRiSJ5XbNIx8r55noSCQQNVIUaPC
         JTCw==
X-Gm-Message-State: AAQBX9eJ1tGMJGHzHc94Y+EQ+EW2R8VJXoBUkIzMslFw4oW3nHnKTYoV
        6o74K7FgPSuGVqOruuhUiMjbFOJ2Ixd+0t1Lles=
X-Google-Smtp-Source: AKy350bMSJ/Fx2x+E1xKjsFGJJGUJGp3UWGH7CBgXNDA8qIT4g/9tQRacqqZfe+96RddPTcAaRWEpquQVgpQw0MyMSU=
X-Received: by 2002:a81:b283:0:b0:549:2cc8:6e3e with SMTP id
 q125-20020a81b283000000b005492cc86e3emr2292786ywh.9.1680642897303; Tue, 04
 Apr 2023 14:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAGP6POLrtA_9kjCwUbVB8-F+dgQbhz==oy5SsXULfspNj_Umuw@mail.gmail.com>
 <87edp0ak45.fsf@vps.thesusis.net> <CAGP6POLVpjxO91s1dX98TLepXMrybSWq9y8qJ6b7w+e0SRJT1A@mail.gmail.com>
 <CAGP6POJr63o67k+7BeokM-pkPbXYrQy4kcWwMXTfoeuFaPaADQ@mail.gmail.com>
 <CAGP6POLx0+OhMJ9oqmK8R9Lq7tppC258NWHNFhqXMbO9smXd+w@mail.gmail.com>
 <CAPx1Gvcz6f3AQJYfq7Sih0bL6pAi5mHZj8rj=kd7kRDWKLZEzw@mail.gmail.com>
 <87lej7zhpt.fsf@osv.gnss.ru> <xmqq4jpv1pcj.fsf@gitster.g> <877curzb9u.fsf@osv.gnss.ru>
In-Reply-To: <877curzb9u.fsf@osv.gnss.ru>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 4 Apr 2023 16:14:46 -0500
Message-ID: <CAMP44s2od_=3p8+GF7tSBqQ0KsDaa4qVKXS66BS7L7BJadA_Xw@mail.gmail.com>
Subject: Re: git revert with partial commit.
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>,
        Hongyi Zhao <hongyi.zhao@gmail.com>,
        Phillip Susi <phill@thesusis.net>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2023 at 3:08=E2=80=AFPM Sergey Organov <sorganov@gmail.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Sergey Organov <sorganov@gmail.com> writes:
> >
> >>> This kind of operation produces a new commit, so there's no such
> >>> thing as a partial revert or partial cherry-pick, at least in
> >>> terms of "things Git can do by itself".  But we, as humans writing
> >>> programs, wish to *achieve* such things.
> >>
> >> So, why Git can't help us achieving it by supporting paths limiting in
> >> (all) merge operations? There seems to be no absolute obstacles, just =
a
> >> luck of support.
> >
> > I think there is no fundamental reason to forbid an optional
> > pathspec to "cherry-pick" and "revert", given that a commit that
> > results from either "git cherry-pick" or "git revert" is called a
> > "cherry-pick" or a "revert" merely by convention and there is no
> > tool-level support to treat them any specially at merge or rebase
> > time [*1*].  It would make it harder to design tool-level support
> > for full cherry-picks or reverts, but that is a problem for future
> > generation, not ours ;-)  Allowing pathspec to "merge" and recording
> > the result as a merge of two (or more) parents is an absolute no-no
> > but that is not what we are discussing.
>
> If I got this right, you believe that "git merge" should never have
> support for "partial merges", whereas it makes sense for cherry-pick and
> revert? If so, I disagree. There is no reason for Git to strictly
> prevent me from using the feature specifically in "git merge" (once it's
> otherwise implemented), provided I do mean it and didn't do it by
> mistake.
>
> Please notice that I can do it right now already (and I did a few
> times), only with a more pain than necessary, and I don't see why this
> pain is to be preserved (provided we do have the feature implemented in
> the future). Besides, "git merge" is only a helper, and it'd be an
> improvement if it'll be capable to help in more cases.

This sounds awfully familiar to Mercurial's reluctance to support
rewriting history. It wasn't the tool's place to prescribe what the
users should or shouldn't do.

If the user wants to do it, the tool should help him do it, not
pontificate about what is heretic.

The user is still going to do it, like with a rebase plugin on
Mercurial, or with `git filter-branch` and then merge the result. All
the tool is achieving is being annoying by not helping the user.

> > But I do not think Chris meant to say "you should not expect such a
> > feature"; what we heard was a reasonable explanation of how the
> > current world works, and I do not see a reason to react strongly to
> > such a statement as if you were unreasonably forbidden from doing
> > something sensible.
>
> Nice, so I figure I may allow myself to still keep a weak hope for the
> feature, and thus stop being forbidden, even if not unreasonably, from
> doing something sensible. ;-)

I wouldn't. Features agreed by everyone decades ago never got merged,
even features already agreed by the maintainer.

Cheers.

--=20
Felipe Contreras
