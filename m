Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2455C00140
	for <git@archiver.kernel.org>; Sun, 31 Jul 2022 16:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiGaQQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jul 2022 12:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiGaQPz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jul 2022 12:15:55 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E166DFF0
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 09:15:43 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id r4so2195012ilm.2
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B7sxcxq9DOINmEt8sMy1aSvLooNA+mkwb4nsOEugiQ4=;
        b=ZS5727h3lTizGWEDMBC1fFxf2yK1P5l1Fosl3yAg5lNShjwyYjpbA3bgowN52w5xKL
         deyVdjFI5r5UMUMW4865uLfFmPIeKlCSL3SMzyHneW4SZ8vSUKtkJM/LSi8fs70HrtDp
         XZZGxtu01M02evT4WRALUKyK/8XPKFzWFnE78ZqCyr7h2x33MPpyadgdnEUK8MVBDJDO
         Plk4hYUhfMMGvSMAX/l44L3GyvlUd7ROR35hKES7QoS0VKaFwPhup2DE0S0h8BO1pziV
         rsysvLGJEbI4WPFsF1i/QVD3Fiy4/DKqNnGXzAaMhOimhgT/7406sqOIWwYG5OgrFUeH
         KSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B7sxcxq9DOINmEt8sMy1aSvLooNA+mkwb4nsOEugiQ4=;
        b=HZ8ETSv09Rw2VjYnbybF+uf86VU0bqbCVfTFaq5omKuk7+zK7LyPfCvwQsLN5SlRlM
         GQTSUCqfsKrSZ/dXyPm4l4Rx8Njz5gRITuLoCj8vHz9xnY0sOvWz86a6Yib111swqS9t
         euX+mNkJ6P0+uJWrwpQ9+To4797TEvthJrPfH55NNXD2C7fmY1s3vCoDeIqxEw6lEaLz
         G7BDR2O6wJR8isJycuZURsknWs2AH5aXwbp9NPAA12X5vTrdaVWGu9nEr4ksdmLXjhQ3
         dsnSzLhn/llWEAiXW9ugwEgreoLTx8MONZM9tlQ0/9CkD4YSjqMX7Pa+VhXzo0l75pFA
         F9vQ==
X-Gm-Message-State: AJIora++sGq8UrJ6bhRQmKcfWfeFqEghppqqJ/9Gv+xcM6Zn4D/acTpZ
        4Paj7nLJeLlq9JgGlp2ZiZ58MA5SroUW8n1g+UA=
X-Google-Smtp-Source: AGRyM1usXJIw4sC0xFDjUc2SZqWnMQWtXyXAcxFvqLEXyeUOsQywziuF3fRfQfI8qolF9SQr0AAvofDxHjTyTOGyPzM=
X-Received: by 2002:a05:6e02:188c:b0:2dc:a00:3222 with SMTP id
 o12-20020a056e02188c00b002dc0a003222mr4524909ilu.43.1659284142425; Sun, 31
 Jul 2022 09:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8QusNzdO1mHqQFPz84pznYSpFWJunroRGXQ7qk6sJjeYg@mail.gmail.com>
 <CAJoAoZmsuwYCA8XGziEA-qwghg9h22Af98JQE1AuHHBRfQgrDA@mail.gmail.com>
In-Reply-To: <CAJoAoZmsuwYCA8XGziEA-qwghg9h22Af98JQE1AuHHBRfQgrDA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 1 Aug 2022 00:15:31 +0800
Message-ID: <CAOLTT8RNnbmnckidVtCbfuSymjvPeMnU_uj7bqGj-XUuL+W_mg@mail.gmail.com>
Subject: Re: Question: What's the best way to implement directory permission
 control in git?
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=8830=
=E6=97=A5=E5=91=A8=E5=85=AD 07:50=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Jul 27, 2022 at 1:56 AM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > if there is a monorepo such as
> > git@github.com:derrickstolee/sparse-checkout-example.git
> >
> > There are many files and directories:
> >
> > client/
> >     android/
> >     electron/
> >     iOS/
> > service/
> >     common/
> >     identity/
> >     list/
> >     photos/
> > web/
> >     browser/
> >     editor/
> >     friends/
> > boostrap.sh
> > LICENSE.md
> > README.md
> >
> > Now we can use partial-clone + sparse-checkout to reduce
> > the network overhead, and reduce disk storage space size, that's good.
> >
> > But I also need a ACL to control what directory or file people can fetc=
h/push.
> > e.g. I don't want a client fetch the code in "service" or "web".
> >
> > Now if the user client use "git log -p" or "git sparse-checkout add ser=
vice"...
> > or other git command, git which will  download them by
> > "git fetch --filter=3Dblob:none --stdin <oid>" automatically.
> >
> > This means that the git client and server interact with git objects
> > (and don't care about path) we cannot simply ban someone download
> > a "path" on the server side.
> >
> > What should I do? You may recommend me to use submodule,
> > but due to its complexity, I don't really want to use it :-(
>
> As a quick note, there is some effort on making submodules less
> complex, at least from the user perspective. My team and I have been
> actively working on improvements in that area for the past year or so.
> Please feel free to read and examine the design doc[1] to see if the
> future looks brighter in that direction than you thought - or, even
> better, if there's something missing from that design that would be
> compelling in allowing you to use submodules to solve your use case.
>

Thanks, I think submodules=E2=80=99 improvement may shift my perception.
But the problem I'm having is whether I should give permission control
to all "subdirectories" (if and when I find out that this is not necessary,
then submodules might be an option)

> As for differing ACLs within a single repository... Google has had
> some attempts at it and has only found pain, at least where Git is
> involved. As others have mentioned elsewhere downthread, it doesn't
> really match Git's data model.
>

That's so sad :(

> Gerrit has tried to support something sort of similar to this -
> per-branch read permissions. They were really painful! So much so that
> our Gerrit team is actively discouraging their use, and in the process
> of deprecating them. It turns out that on the server side, calculating
> permissions for which commit should be visible is very expensive,
> because you are not just saying "is commit abcdef on
> forbidden-branch?" but rather are saying "is commit abcdef on
> forbidden-branch *and not on any branches $user is allowed to see*?"
> The same calculation woes would be true of per-object or per-tree
> permissions, because Git will treat 'everyone/can/see/.linter.config'
> and 'very/secret/dir/.linter.config' as a single object with a single
> ID if the contents of each '.linter.config' are identical. It is still
> very expensive for the server to decide whether or not it's okay to
> send a certain object. Part of the reason the branch ACL calculation
> is so painful is that we have some repositories with many many
> branches (100,000+); if you're using a very large monorepo you will
> probably find similarly expensive and complex calculations even in a
> single repository.
>

Agree, as Avar said that there are delta data too (so data cannot easily
hidden)

> Generally, this isn't something I'd like to see Git support - I think
> it would by necessity be kludgey and has some very pointy edge cases
> for the user (what if I'm trying to merge from another branch and
> there is a conflict in very/secret/dir/, but I'm not allowed to see
> it?). But of course Git is open source, and my opinion is only one of
> many; I just wanted to share some past pain that we've had in this
> area.
>

To summarize (your and other answers' ideas), I have reasons to believe
that git itself cannot easily solve this directory permissions problem:
1. Files with the same object id can be in different directories
(data cannot be isolated).
2. DELTA data can share data between multiple objects
(data cannot be isolated).
3. Permission management is very cumbersome and time consuming,
especially on large repositories.
4. The directories that are not accessible should be or not see merge
conflict is a big problem.

>  - Emily
>
> 1: https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/

Thanks.

ZheNing Hu
