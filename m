Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5084FCA0FFA
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 17:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbjIER4P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 13:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237505AbjIER4F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 13:56:05 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B3C49E0
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 10:48:26 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-401f503b529so27791495e9.0
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 10:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1693935726; x=1694540526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6ChB/HHhC0N2JrW5kQD35fSttRmoo4Qu0o4QhF48bE=;
        b=dZhOvXMrhAXnEqrqQ7vf9oAGKW/4DbNWdGZ26ltgj6c9D7kzDfiPUou20ot0Opy+mx
         CeMVBwaubT5Kfps23vDe2pf/5U8L1gYxiq58Ecta7ME9aj3oMENjWJa+qAelXnN/S3gX
         Uo65gmgWSwA7RUtOvLCRGd0rmCkb6ukGcV764=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693935726; x=1694540526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6ChB/HHhC0N2JrW5kQD35fSttRmoo4Qu0o4QhF48bE=;
        b=Q4oyr3LJsI4Ccq5EcNHs3KU6gfpACSl5h5HREMPABWVBABf0FOmBOTuW9kvwQqyMnd
         IFV3eyf53P0E0MR9/tLyphhcHfvOqLb/pDpDruXgMXp/AP/9khgslUWh2Q7UlNhNiEPb
         xZWRVrhciTwswlFcvz8HsY0Azzsz/QQSpI7Jd0/lH5KsyMLJRf2GuUerDPRqiYtxPTg5
         AwDl2ByXRdaP9U+sDMqMnz4AdNoy1somLRUH7fgwdtxXuNjwKHihWzD+Nv6cezmeeQkG
         /G8drQGESFKYnc6OZwRo7MqrYJD3E1kLZN2B4ITXc+kWOot2AnFgsFD0qU6AQJtMgfys
         +82w==
X-Gm-Message-State: AOJu0YxDPKnooz+DIMnUcpGOfP4TRa70acwamiHt1s/P8RTY6J9KTK/k
        mgEv5zfJbkiqJyx6NNJMn0WpfPE1m9tlNfaICVDXbiL7GjPsYc2Pmd56qw==
X-Google-Smtp-Source: AGHT+IFGGNlD9pYgG2KnvhLI/NEn0msYvazkybnacmmOrSMkCM52zFgUYBoNwIsgYj9X+A+nqNqgh3b8NDckN2jy03g=
X-Received: by 2002:a17:906:4d:b0:9a5:cf81:d556 with SMTP id
 13-20020a170906004d00b009a5cf81d556mr312486ejg.26.1693931124425; Tue, 05 Sep
 2023 09:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
 <CAPig+cTeQDMpWQ-zCf6i9H-yhrdCndX6gs67sypuqmHZZcHm7w@mail.gmail.com>
 <xmqqedjdtoh5.fsf@gitster.g> <CAPig+cRJhrGmnBRm2dporcXiRr4SzRmpM2LTMm0S7wo0XbOU9Q@mail.gmail.com>
 <xmqqmsy0slei.fsf@gitster.g>
In-Reply-To: <xmqqmsy0slei.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 5 Sep 2023 18:25:14 +0200
Message-ID: <CAPMMpogm2tr0dy1nsV9NtF4O8-JS=_L3J0+yKRc7KbyAJ-PNbQ@mail.gmail.com>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird? Bitmap
 error in git gc.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 5, 2023 at 5:13=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> >> All correct.  The per-worktree part of the repository data does live
> >> in a subdirectory of the ".git" directory and that was probably what
> >> Tao had in mind, though.
> >
> > That could be. I read Tao's explanation as meaning that people do this:
> >
> >     git clone foo.git foo
> >     cd foo
> >     git worktree add bar
> >     git worktree add baz
> >
> > rather than (perhaps) this:
> >
> >     git clone foo.git foo
> >     cd foo
> >     git worktree add ../bar
> >     git worktree add ../baz
>
> Ah, that reading does totally make sense.
>

Fwiw, Eric's reading was my intended one. The people I have spoken
with, as well as myself, have started using "git worktree" by doing
the former, and only later felt really transgressive when placing the
worktrees explicitly on a higher level, on equal footing with the
"main worktree". To me it seemed natural that the "nested worktrees"
approach was the expected one, as otherwise it gets even harder to
explain/justify the operational difference between the "main worktree"
and the other worktrees - then leading to the bare+worktrees approach
to eliminate that operational difference.

> But I am not sure it would lead to "we need to carefully protect the
> primary worktree", because it is rather obvious, especially if you
> bypass "git worktree remove" and use "rm -fr", you would lose
> everybody underneath if you remove the "foo" in the "worktrees are
> subdirectories of the primary" variant in the above examples.

Right, sorry, too many poorly-expressed thoughts crammed together.

We need to start carefully protecting main worktree *when we start to
get clever* and actually add the worktrees as siblings to the main
worktree. That protection is indeed "implicit" before you start using
"../"... but then you have other issues of
git-worktree-within-git-worktree confusion.

Is there a manual for "expected typical usage of git worktree" somewhere?

>
> Even though deriving the worktree(s) from a separate and protected
> bare repositories does protect you from total disaster caused by
> removing "rm -fr" and bypassing "git worktree remove", it still
> should be discouraged, as the per-worktree states left behind in the
> repository interfere with the operations in surviving worktrees.

Right, that's fine. Of course you're going to encourage deleting the
worktrees carefully... but equally of-course, some people *will* do
"rm -fr that-worktree-I-dont-know-how-to-clean", and when they do,
telling them "just 'git worktree repair'" is much easier than telling
them to "recover deleted files 'cause your local branches just
evaporated"

> Teaching folks not to do "rm -fr" would be the first step to a more
> pleasant end-user experience, I would think.

The less arcane trivia you *need* to teach users for them to be
effective, the better the experience is for everyone.

The fact that "deleting a standalone git repo only deletes what's in
that standalone git repo the way you've done your whole life, but in
this environment what look like multiple repos are actually
'worktrees', if you ever delete one your life *might*, if you choose
the wrong one, suddenly be very unpleasant" is arcane trivia, in my
opinion. Better to set things up so they *can't* shoot themselves in
the foot with a bullet of that caliber.
