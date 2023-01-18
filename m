Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F495C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 08:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjARItd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 03:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjARImJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 03:42:09 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386D0875B8
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 23:58:50 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id p185so6896509oif.2
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 23:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1iT/ZuSaAeoG6wOLtd3OcJJb8eyDWCJ0f5kpZ5hE7U=;
        b=PVIZa2HM2bWHnshjrSTANbyO18s3Zls6dIgRy3ldJM9rWV1uMt+7cyY2WnUoJIwPE1
         Af/OcLD2HwjO+44/jTy4GDaYeE8QEdLILpOfQDmKIP+m8Szjas12G2E8hwM1XvKLnF1t
         wMtFj1rlYTAe7cZ+f3oUt6o/hSagMqDHkXleizaDhx7h7/mCqJyCtCKcZxAcF6tYNcKm
         Kmosr7iqWthauyDOS6g52Y+5SDwTPWUznlPjMTNhnOg0fUJN4A8K7HazTauA+jQmMo1d
         NP2mO4tMtMOc0MgcSg+KlgboLRWF4uAf99QsbbQMfv/bndE3zfbRQFRpPLdwxoQE34l3
         0gTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1iT/ZuSaAeoG6wOLtd3OcJJb8eyDWCJ0f5kpZ5hE7U=;
        b=AHPWuUrhVL2B8F48PxU8BLv89+gddXs9Fwt7wNk7fZqYKV+tCbPy4kfGp2L79GdYC8
         ieUIzYUGx+cZfFlY1oBSpz1WxCOgdgzJbMewvbWHZwCJ9npxJrHe/bd9SU3q10+a37ZH
         +aPtRhd2MAh8SELBmmrYi9SSvrZgdqVhKIDljjdaK5lbyfKmQYX0sz4J20VyRyu2EDl/
         KkSdeoH0dNQ+YX7N2xL2s2fZpa5rhfV+TbKXzBGcFkloyYjthldxryuTfxVOd/7IDCQz
         koP7wv3Lc5yx9mcZ37N7HXqStt8/KJEv0E29qh1tJkkEoRmPQVJa6AuR46Qkhknw9sTZ
         aGZA==
X-Gm-Message-State: AFqh2kpZP79bRCE9LlaBvluPh9ffTPMqgBruV2VQW7QqMy9WyKrFgYws
        aQi5MOrMzOUX4mmzp9HGTKC5wQVtTFUEWDByIWPAJ785fDo=
X-Google-Smtp-Source: AMrXdXu4BZxOzJxM0xcrtZRml5U7Q+xHRKSbuaZeoQD1shxmM1nc1jayv86OMna5PetlNONd2JNbygCpiA4xJNG/33Y=
X-Received: by 2002:a05:6808:241:b0:365:9be:db6f with SMTP id
 m1-20020a056808024100b0036509bedb6fmr302951oie.59.1674028726259; Tue, 17 Jan
 2023 23:58:46 -0800 (PST)
MIME-Version: 1.0
References: <20230116172824.93218-1-carenas@gmail.com> <20230118061527.76218-1-carenas@gmail.com>
 <xmqq5yd48hcb.fsf@gitster.g>
In-Reply-To: <xmqq5yd48hcb.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 17 Jan 2023 23:58:35 -0800
Message-ID: <CAPUEspjmFJUjZmNBH=f_-TY3hYnOtgVjBY-YtWuo15eg3a+5cQ@mail.gmail.com>
Subject: Re: [PATCH v2] checkout/switch: disallow checking out same branch in
 multiple worktrees
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Jinwook Jeong <vustthat@gmail.com>,
        =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2023 at 10:52 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
>
> > As reflected on the tests, this will change the behaviour of those
> > commands when they are invoked in a worktree that has that requested
> > branch checked out, as that matches the logic used by branch, is safer
> > (assuming both commands are user facing) and can be overriden with an
> > existing flag.
>
> ... meaning you can "--force", or something else?  Allowing an
> existing option to be used as the safety valve does make sense,
> especially if the option is something users are already familiar
> with (like "--force") and naturally expected to work.

the following is the way to override:

$ git checkout --ignore-other-worktrees -B foo

> There might need an documentation update.  Back when "checkout -b"
> and "branch" was written, there wasn't "multiple worktrees connected
> to a single repository" hence there was no need to provide safety
> against checking out the same branch in two different places.  "git
> branch" might have learned to give that safety while "git checkout
> -b", which _ought_ to be equivalent to "git branch" followed by "git
> checkout", might have forgot to do so.

Not sure if it was originally forgotten, but it is definitely working now;
this change only fixes the uppercase (-B) version.

> After this change, it may
> still be correct to say that "checkout -b" is equivalent to "branch"
> followed by "checkout", but if the documentation to "branch" talks
> about this safety, it probably deserves to be mentioned in the
> documentation to "checkout -b", as well, if only to give an appropriate
> place to talk about how to override it "with an existing flag".

Interestingly, when the flag was added in 1d0fa898ea (checkout: add
--ignore-other-wortrees, 2015-01-03), it was only added to `checkout`.

`git branch` has no flag and will die even when `-f` is used

Carlo
