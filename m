Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E32C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 10:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5BC361073
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 10:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237996AbhJOKsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 06:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhJOKsO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 06:48:14 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6EBC061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 03:46:08 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id bi9so8055525qkb.11
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 03:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxonly.nl; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=IuKqEoivsN7Bl2Q2civVkwB/t3fenGV7uFAnEAvlAZM=;
        b=5a5yscSJuinApgHQQhb55qaAJ14ILFoT8o8B0SQKlfZs3UoddMnWwFiqWenP4v79ho
         vYBfhR6gc1MSzEbGiRSiJakWxZ4/Q/xWybJvldY6WoYnNCHPOnPqTQpYGfXxKr9xrK6+
         +dX1duUXZDCt6AHrjVFaWy/CbYtkNuQ5bc+gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=IuKqEoivsN7Bl2Q2civVkwB/t3fenGV7uFAnEAvlAZM=;
        b=PpB8Z8wvjg1zjAWp9/VXSISHoFIsh2FJeiMZpWEeexWhYaIuhsacb3K47mT7l7cY/l
         u013I/kre6nlo/mzdpFVzYnCkY6hcJUFMM92T53izXXb+bHylMwDYm1gHRuV8x+3qOvA
         xYIcFAeT+1+cgkCGNkiM+uiKQVnE3hZgRZ6LzM23Noq165VD5wN14XQW89HXuuwo6Wq+
         9n0veebLrPoUzySssQKa/6ZVegU4OocQhtxpKycTZ1RiuAfvVXVy5Ok99rHiXOZhLwP1
         q4bHA5enxe6yFhzpQIZxXfSE2NLiHYiCKjxZKQPGtszHKnUoSAUarkaPFk8JjGubIbEF
         wGyw==
X-Gm-Message-State: AOAM532/FR7a25h2vr4Z2kxNwdXMHV0hIRyK4IHxRlE/OjMtU99zx/DP
        3NUqsS21pmxC3gE6FHe+87XABDGO3tGEaQ==
X-Google-Smtp-Source: ABdhPJwaTYHdrx6/VLZBSpyxU1HwB32m6Pi53izmmh9rX8EAO18Zk2SBGAiWTrmXOmYj5D/AedfHCA==
X-Received: by 2002:a37:6484:: with SMTP id y126mr9492989qkb.384.1634294767643;
        Fri, 15 Oct 2021 03:46:07 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id 6sm2800246qtz.13.2021.10.15.03.46.07
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 03:46:07 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id w2so8421738qtn.0
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 03:46:07 -0700 (PDT)
X-Received: by 2002:a05:622a:1492:: with SMTP id t18mr12855584qtx.229.1634294766733;
 Fri, 15 Oct 2021 03:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAA1vfca+kPSsitsZad-bmrd+o1ay60NXZrH2zGLpwN69Px-rtw@mail.gmail.com>
In-Reply-To: <CAA1vfca+kPSsitsZad-bmrd+o1ay60NXZrH2zGLpwN69Px-rtw@mail.gmail.com>
From:   Sjoerd Langkemper <sjoerd-2021@linuxonly.nl>
Date:   Fri, 15 Oct 2021 12:45:55 +0200
X-Gmail-Original-Message-ID: <CAA1vfcYSZWEXsDBD2_0o48EYbU9e9nKVoFdQ0M=fDAOMki3bng@mail.gmail.com>
Message-ID: <CAA1vfcYSZWEXsDBD2_0o48EYbU9e9nKVoFdQ0M=fDAOMki3bng@mail.gmail.com>
Subject: Re: Git submodule update remote keeps using previous default branch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The submodule is updated according to where `origin/HEAD` points. The
`origin/HEAD` ref of a repository is not automatically updated when
the upstream default branch changes. However, this can be forced with
`git remote set-head origin -a`.

I think it is a little bit surprising that `origin/HEAD` does not
necessarily point to the remote default branch. However, changing the
default branch should be pretty rare, so I understand this is not
checked every time.

Regards,

Sjoerd Langkemper

On Fri, Oct 15, 2021 at 10:34 AM Sjoerd Langkemper
<sjoerd-2021@linuxonly.nl> wrote:
>
> I am having trouble with git 2.33.1 checking out the wrong branch for
> submodules for which the default branch has changed. `git submodule
> update --remote` seems to remember the branch name to retrieve, while
> I expect it to use the remote HEAD every time. This causes unexpected
> behaviour when the remote HEAD starts pointing to another branch.
>
> I create a new git project and add a submodule, with `git submodule
> add git@host:foo/testproject.git`.
>
> This checks out the default branch, `master` in this case. `git remote
> show origin` also shows that `master` is the HEAD branch. Running `git
> submodule update --remote` updates the submodule to the latest master.
>
> Now I change the default branch on the remote (using Gitlab's web
> interface) to `newmaster`.
>
> `git remote show origin` now correctly shows `newmaster` as the
> remote's HEAD branch. However, running `git submodule update --remote`
> still updates the submodule to the latest `master` branch, while I
> expect it to update to the lastest `newmaster` branch.
>
> There's no branch specified in .gitmodules or .git/config. I am not
> sure how git remembers the branch. When switching `testproject` to
> `newmaster` manually and then running `git submodule update --remote`,
> it is reset to `master` again.
>
> Is this a bug? Can I change the branch somehow?
>
> Regards,
>
> Sjoerd Langkemper
