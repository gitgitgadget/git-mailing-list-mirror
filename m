Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF660C4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 00:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1BE12076A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 00:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nimIC9pE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502271AbgJ0AwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 20:52:19 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37706 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408683AbgJ0AwS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 20:52:18 -0400
Received: by mail-ot1-f65.google.com with SMTP id m22so9732965ots.4
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 17:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4vctzntVCQ39b4fEn7Hi7JCz13xbHi1IQsluoAlvL8=;
        b=nimIC9pE54MCqmxFnxEbl2wxdJxrD96OYH5BkH4svzp4ghlPB31MN8tNMiXyE+AFnx
         RD0YtaUmiDWLf2bRScNoE9CbEa1WtwXbH4I1hZyUHslrFKrmYWfdjdMJxx0JMncWzTSe
         bD+WW2y8pRg8myr/Y9Q5viYh32vUmnX6yXsq+2vLwvJYLhq5Q5KFhHEaPTUP0fCkAAge
         5Vlduy3jPJvuHsg1fuFeF5hNs4dLs3AKKkEqYeKuCOdbuZllg0L3EDpdbOeEylJKlK1h
         YEaTxLHqytwdddMMZa1Ta1ZE7D87w3SCKjBTfG9L9g+YsDAUy1MHJCxmUrEqxrPxid8A
         m1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4vctzntVCQ39b4fEn7Hi7JCz13xbHi1IQsluoAlvL8=;
        b=XjTnbrpmY9fdyH2R800ZEJeQtGKdYdGEOZL3P0Dz5vwyoR2gAdk3SmIY4k5CXGIouN
         sKsgO87Ob9RGG/UuIi04O9z1N+TdICaYbKeILaYd4d7uYqVmjBIgQHhAapAURQmCDtMP
         KFoLfqrjXT61/5S8/ltnqGAb6kgiPvto3Yn4+mtedNadA2jJom2b/jNW8nnY1/0tA9t2
         xWVaF2D/uOBsZNR9zpxOFJ7duCmMOS2zEVrwb95VwgPvDuR6eHl9G0rknyfZ7Ls0Ad2o
         q+ttgM5jrLyYaezKydCOeZvQSuWc3M902C5Py/KELp79eW9nyNRXvtDei9lkTfMJh/iS
         dm9Q==
X-Gm-Message-State: AOAM533sgyxD1zbbz8n1dvro1lXVAyxAP/oG4hfIU9peFAyGluz8c5FV
        suFFUusBynZOYZTs8Kfz+RUI8NWHeV442kmxFJw=
X-Google-Smtp-Source: ABdhPJwq3LeXiDm345ZJLK9lkC0S3Ca1tnkWnHLkyXoZ2yk+0kUZ6fkcjYjdJiqd9ey8UpBtc9/ZJYyzsG4xFHX3E3w=
X-Received: by 2002:a05:6830:2389:: with SMTP id l9mr17304426ots.316.1603759937892;
 Mon, 26 Oct 2020 17:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BEGo8qfaoz6vUs+ktvmNUZdiHjwda468Qkh5uaD-wAd4w@mail.gmail.com>
 <20201026215622.2138981-1-jonathantanmy@google.com>
In-Reply-To: <20201026215622.2138981-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 26 Oct 2020 17:52:06 -0700
Message-ID: <CABPp-BFUS39pmB0S79WfOAiOmeM7gLrvog=b6zYrGRCo_RQr7Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] Beginning of new merge strategy: New API, empty implementation
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 26, 2020 at 2:56 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > Hi,
> >
> > On Wed, Oct 21, 2020 at 6:22 AM Elijah Newren via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > >
> > > In this series, I try to show the new merge API I have developed in
> > > merge-ort and show how it differs from that provided by merge-recursive. I
> > > do this in four steps, each corresponding to a patch:
> >
> > I should probably call out that even if folks don't have time to
> > review patches, I'm particularly interested in opinions on the
> > following two questions:
> >   * Are the "pull.twohead" and "GIT_TEST_MERGE_ALGORITHM" names in
> > patch 4 good/bad/ugly?  (especially the mapping from "pull" to revert,
> > cherry-pick, rebase, and merge?)
>
> I think GIT_TEST_MERGE_ALGORITHM is fine. I think extending
> "pull.twohead" is ugly - perhaps we could get away with not doing
> anything about it for now, and once this feature is ready, we could add
> a new config parameter specially for this.

Yeah, it is kinda ugly.  I was thinking of adding "merge.backend" when
I discovered that "pull.twohead" already existed.  I didn't know if
two configuration knobs doing the same thing was uglier, or using that
old ugly misnomer was.  Maybe we can use the merge.backend name or
something like it once merge-ort is further along.

> >   * Is it too weird to have a temporary/hidden builtin, in patch 3?
> > If so, what is a good alternative?
>
> An alternative is to implement it as part of test-tool - see t/helper/
> for more information.

Oh, interesting idea; I hadn't thought of that.  However, It seems
like a bit of a misfit there too -- fast-rebase isn't used in the
testsuite anywhere and I didn't have plans to add it.  My plan was for
fast-rebase to go away soon (perhaps as soon as the merge-ort
implementation lands), probably long before merge-recursive.c goes
away.  fast-rebase exists just to (1) demonstrate the API and (2)
demonstrate some performance benchmarks I used to guide my performance
decisions.  Once merge-ort has fully landed, reason (2) becomes
obsolete.  Reason (1) might still exist in part, but hopefully we can
start updating sequencer.c to use those ideas and then make
fast-rebase fully obsolete.

> I'm not very familiar with the merge code, but overall this looks like a
> good, clear design. Thanks especially for showing how this code can be
> used (in patch 3) and a comparison to the old API (in patch 2).

Thanks for taking a look.  :-)
