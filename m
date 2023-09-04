Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A68AC71153
	for <git@archiver.kernel.org>; Mon,  4 Sep 2023 14:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241957AbjIDO7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Sep 2023 10:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjIDO7h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2023 10:59:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CA01A5
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 07:59:31 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-991c786369cso240350766b.1
        for <git@vger.kernel.org>; Mon, 04 Sep 2023 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1693839570; x=1694444370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3O0bIAEc3UJ5AKsT4+zd6sU6vTM8PZFt0DlKu3xEwM=;
        b=W+eNVO25m3Uj7sUUgNvXR2M1/oWgG3zDmyCp2eHPN6Dx0j6WTwnMtrTKUPLOyRI9As
         8SbKs0rGKiUYT/CnN+x+8Egp5Xhi51IybZp1XlW0HWBNC4R6w2YTeNvF3J9mF88MX8+L
         4Ly6kgy4llkI6pAXed+gDM1UwRPjjuNnwAlYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693839570; x=1694444370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3O0bIAEc3UJ5AKsT4+zd6sU6vTM8PZFt0DlKu3xEwM=;
        b=J24kabItEaN3pFYzjOsRcuQ3GR8jN8cLzC9FyYqBrnz8DNl5mNfdzW5AKSm1pLb9C2
         c/qfYuqENUq/EZC/DFza9XkOopJQ00cKQC/kJ+rSHnsMNTlUfd27ieGHv2Ekz1E1YQBY
         ba2srkrEKAOAYin/wODZ3PN2td0ep0WawTTOO1j3Js0EGo3jRPuCbh7GqbQXzCoNdcvh
         YYDU6WddOrdufjqqjCwMJ8bIwVFFVOtUgbLFWObxsatfp+3Mtq+kRf6LDhYak8C2++oI
         YDDBs/bD6Erg/H4SJsqK5c9X2JHp3vZJLgbecWXgyAWmOA1sWn2Z00GPwm8H68J5jFm1
         Ea4Q==
X-Gm-Message-State: AOJu0YymjidJ3upUCC0+YxEAhEjWcNxMsLbxfm6DmELWcfnQux8G6VgU
        opxezjvnnkNY4LqNjPwBvA4oOAee59fJ/8QQ+IoOf4xmwUXpSAPjP4Em2w==
X-Google-Smtp-Source: AGHT+IHff38NvlvQRUva7bctJBzajsrO2ggvKlVGBVwLcMFjJByNM+dE75aZ7Biz+zDgGbheOrIIw0GC5UhGeAP6eOc=
X-Received: by 2002:a17:907:762e:b0:9a5:cc73:a2a6 with SMTP id
 jy14-20020a170907762e00b009a5cc73a2a6mr6740390ejc.14.1693839569956; Mon, 04
 Sep 2023 07:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
In-Reply-To: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 4 Sep 2023 16:59:20 +0200
Message-ID: <CAPMMpoj7s=ewXJfJyxvrcHjpmOOWEWBvZ94OOuVmYs2UQ482HA@mail.gmail.com>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird? Bitmap
 error in git gc.
To:     git <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 4, 2023 at 4:41=E2=80=AFPM Tao Klerks <tao@klerks.biz> wrote:
>
> we introduced a special clone topology: the
> initial clone is a bare repo, and that folder gets a specific clear
> name (ending in .git). Then we create worktrees attached to that bare
> repo.
>
> Generally speaking, this has worked *very* well: I would recommend it
> generally as a recognized/supported local-repo-setup. The most
> important thing that makes this *possible* is the fact that "git
> rev-parse --is-bare-repository" returns True in the bare repo folder,
> where the lack of index and HEAD shouldn't bother git, and it returns
> False in any one of the worktrees. It feels like things were designed
> to work this way, even though I can find no explicit mention of this
> topology in the docs.

I should add that I only recently discovered "git clone
--separate-git-dir", which I at first though was a formal expression
of this setup... until I understood that the relationship between the
"GITDIR" and the worktree that you end up with is not "Bare repo vs
worktree", but rather... "orphaned repo / repo that doesn't know about
its worktree, vs worktree".

It seems, to me, that "my setup" makes a lot more sense than what you
end up with when you use "--separate-git-dir", and that the behavior
there predates the current "mutual reference" model of
worktrees-to-their-repo. If "my" use of "core.bare" in the example
above is sound - then should the implementation of
"--separate-git-dir" be changed to produce a bare repo with a
"worktrees" folder, like you get if you clone bare and add a worktree
in two separate steps?

(I say "change the implementation", but I guess I really mean
introducing a new option for the new behavior, and deprecate the old
option)

Dscho, I assume you would have the strongest opinion about this?
