Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA15C433F5
	for <git@archiver.kernel.org>; Sun, 19 Dec 2021 20:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhLSUrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Dec 2021 15:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbhLSUrK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Dec 2021 15:47:10 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA52EC061574
        for <git@vger.kernel.org>; Sun, 19 Dec 2021 12:47:10 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id k6-20020a17090a7f0600b001ad9d73b20bso8197657pjl.3
        for <git@vger.kernel.org>; Sun, 19 Dec 2021 12:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=flH3zgtgFgbznYHZR0UHAps2QKAHychqkFEfWBK87kQ=;
        b=V4W/plfrkQ/Sp1kiZLQeJKXD1q4usWzuvJm7h8bB10z0OofNjIWBmeGrpqB/A4VKUQ
         3DRZLbVMuWXVNPTCnskm8MjJNtUFu+KSKdm4reqZ+id9r/ypQTSYmeWNrQ2FZBoJi5qK
         wxSD+f4jtB6LmJxtDXJqH7JkFcnoOKLw9RnmGcKybelaFK8NX0MzU8hSjY1mzCMYi6mM
         F/ZFouuj6+gtvgC9NQRDh/zjwOh8CgY4btTg79ek0w2B/3weeSRIxPE6oVFNHBsFSNIs
         0+05iGxbmaYtyv8CD2aYA+458BpLmCPdPK2bv1p7IprU4BSo2J67VKj2sTKXrYkauKvS
         y2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=flH3zgtgFgbznYHZR0UHAps2QKAHychqkFEfWBK87kQ=;
        b=VAfzdt0kaFLBdYYnnCw7ZBetMYV+FbbsduHOKLbIMY+2HiC2j13+JurCetM5oL3S9M
         +PuqMgBj2vx/I2MtDMyAD5FuWoIGZteN4kwotsJI4c+YG4DSxUsxfecyF8La1bg9bOan
         VQm3r8HHqpiHScruSlhkE4s1LdmAE2mahZ+SpZAxQ9g9GoBR/Qn8m1QNLgWEcTKzzw6g
         bLQVwCs6Y/tUDRqjhvs6WFAO63j4g98gONXMz1IzQjwpSz+v66d22mGsThRWrbigGV1n
         qjiQT+1j8YuLhMRUQO/A6Zz2+BmMIdzbxVyQ9stkplb5h+M+6J44AvuzZ15mhbgtuWgs
         ZTBA==
X-Gm-Message-State: AOAM530NAoAqA0Fb6Bn5GMZ2w9kjqgrnRoDY0aOra0A2Ap1POfx1Uk3r
        /GD6eZ5Nle+G8w6kBtkXXC/GA8lSd4kACIQgaArxZ8Y+rVA=
X-Google-Smtp-Source: ABdhPJx7sfJHuonDyuo7Us/rGqPwOLVYHMuOn4lNsV1CmSxW5XdMDOP7CIdMg/jy3BO3WMken2Z03toHo6IdcyLvMnI=
X-Received: by 2002:a17:90b:1c8d:: with SMTP id oo13mr24601796pjb.139.1639946830022;
 Sun, 19 Dec 2021 12:47:10 -0800 (PST)
MIME-Version: 1.0
References: <CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com>
 <e992d4b4-f9e2-a8f9-22da-e9d342c7bede@sunshineco.com>
In-Reply-To: <e992d4b4-f9e2-a8f9-22da-e9d342c7bede@sunshineco.com>
From:   Sean Allred <allred.sean@gmail.com>
Date:   Sun, 19 Dec 2021 14:46:59 -0600
Message-ID: <CABceR4YVd4remACJkxwSCTSYB2v3Zn1BsjKHbzeve8uHiZv1pA@mail.gmail.com>
Subject: Re: Bug report - Can create worktrees from bare repo / such worktrees
 can fool is_bare_repository()
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> However, you missed the step (discussed in [1]) in which it is your
> responsibility to move the `core.bare=true` setting from
> git.git/config to git.git/worktree.config manually after setting
> `extensions.worktreeconfig=true`.

Ahh, that makes sense!  I did notice the `core.bare` setting being
respected in source and figured this had a part to play (which is why
I included git-config output).

I think then that I was overzealous in trying to MWE-ify the issue: as
I noted, I found this issue when I was trying to perform a
sparse-checkout within the worktree.  To memory (I don't have my work
system at the moment and don't have its `history`), I think it went
something like this:

    git worktree add --no-checkout ../next && cd ../next
    git sparse-checkout init --cone # auto-created a worktree config
    git sparse-checkout set t

I think either the git-sparse-checkout-set command (or the
git-checkout I ran after) would fail complaining that I was not in a
worktree.  Based on the above, it sounds like `init` is creating the
worktree-specific config, but is not overriding `core.bare` in that
config.  Would a patch to take this step this automatically be
well-received?  I see two options for when to set `core.bare=false` in
worktree-specific config:

  1. At git-worktree-add: This is probably the earliest time which
     makes sense, but may be over-reach.  I'm not up-to-speed on how
     worktree-specific configs are generally considered on this list.
     If I were implementing a workaround, though, this is probably
     where I'd make it.

  2. At git-sparse-checkout-init: This is where the problem begins to
     have an effect, so this might also make sense.

I'm glad to learn about bare repositories + worktrees being a
supported use-case :-)
