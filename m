Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11537C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 00:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhL1AbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 19:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhL1AbF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 19:31:05 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5BDC06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 16:31:04 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id o6so67431585edc.4
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 16:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/zavyX0mPuRiT/5vAyowqWewMUfp1xiZ71aZgL/v+3c=;
        b=XRJmTwdsMP5vtHx5BXuPjSfsdVi4hAbOzG3vnZ2oNLmYa5CJsIqaC6mfoeKKbGb/vR
         u06RylOErotrVq74XU6HPKmOqogB4Jpid8Yzr1iKekWH2gzubVwqWc07cfyqfOqkkYfs
         bWjmt2LGrpczLi8jNvGRn2PnPqRMUSqSUBtZPVPxCr4ojGMTGiKt0pVoIRxwVxorO1Fd
         mCMS44db4YmvMSBf9wafsL1dUAOOLY++U8ODdc98jrtTmzVXmuSdxEot8L9DPcXrWw9g
         W3MZDLQERNXpJ6+QbOvqp4tC/oUbWhCGH33a/QbknX/n4IWvnM2g4BdCmtZ9SniQdtRS
         XeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zavyX0mPuRiT/5vAyowqWewMUfp1xiZ71aZgL/v+3c=;
        b=J1W/vO5pbjgp+lm1QVYNus9hjoxqPtSKJA3+2UOXmnn+JubvjAMK7ljY+FqOD4L4DY
         L3Yrs2AxuQkQYtCEmoOGSrfJnvXkCHVfc5MGtMnH7JfEV8sLx+tQRAzCry+XJF/mJql+
         zM/huniN75CkjW12A0Ko/QqsI5mzCg+W+AcHFxWf9SYBuX9aNV/WNMCXNqRth8h7UQYy
         RduTwcCpe2OjDAGrlgmDV7WWN+ihbqwrlEByO+5snt4iMQPXsCDm/0i2Cx7Gd3hPifV2
         /BKtbK/E268OXU+Ou80z0nd9ZRBdET/uubup9pp9a9kSn+L28SVwZiq5SbckFnPfewzu
         5Umg==
X-Gm-Message-State: AOAM533m4W9EkXbpHtLA4A/pss/OaJVuvBYW8a2u1P4gI9Jn3SWTq4Rc
        pDkw2q218Gx0t0dG8D5pYBuJuBQg+21cewcIpZI=
X-Google-Smtp-Source: ABdhPJzKdi6C+xqZVHqtgmRGWNif4JZpjqNmRX9AkVox490+WhJridRdP34vWqjTZ6pY1T1aihnIpvsFF0JcH2TdyA4=
X-Received: by 2002:a17:907:968a:: with SMTP id hd10mr15105329ejc.269.1640651462922;
 Mon, 27 Dec 2021 16:31:02 -0800 (PST)
MIME-Version: 1.0
References: <CAN0XMOK8iHZnbtYw7CPAQGJcmuVSDxQoFNFEwiaa41V89F1rzA@mail.gmail.com>
 <CABPp-BH=nqeqpW8Grn+6No4HvRaBaC9spwEsDcj1BWdsipJh=Q@mail.gmail.com>
In-Reply-To: <CABPp-BH=nqeqpW8Grn+6No4HvRaBaC9spwEsDcj1BWdsipJh=Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Dec 2021 16:30:51 -0800
Message-ID: <CABPp-BGLMkqQs1ncT_EmPYjEo-GRV_qibx7EYSYL-wME3Exa5g@mail.gmail.com>
Subject: Re: [BUG?] assertion failure when merging branches
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 27, 2021 at 2:15 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Dec 27, 2021 at 10:35 AM Ralf Thielow <ralf.thielow@gmail.com> wrote:
> >
> > Hi,
> >
> > At $WORK I tried to merge two branches and ran into an assertion
> > failure. I exported the two branches down to the merge base as
> > an anonymous repo, so that it can be reproduced.
> >
> > In the branch I tried to merge into, files have been moved
> > and/or reformatted.
> >
> > My Git version is 2.34.1.
> >
> > wget https://gist.github.com/ralfth/5b624abb0a99e3e705a0984c4b2d253e/raw/7f7ef5b10711550b90342c50b53ce25c19075c97/repo.txt
> > mkdir tmp
> > cd tmp
> > git init
> > cat ../repo.txt | git fast-import
> > git checkout ref0/ref1
> > git config merge.renormalize true
> > git merge ref2/ref0/ref3
> >
> > git: merge-ort.c:3846: process_entry: Assertion `!ci->df_conflict &&
> > !ci->path_conflict' failed.
> > Aborted (core dumped)
>
> Yikes, sorry about this renormalization bug in merge-ort.
...
> I'll submit a patch with a smaller testcase soon.

For those wanting to follow along; fix submitted over here:
https://lore.kernel.org/git/pull.1174.git.git.1640650846612.gitgitgadget@gmail.com/
