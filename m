Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C5AC433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 21:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243263AbiAQVVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 16:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiAQVVY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 16:21:24 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE04C061574
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 13:21:24 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id q25so70916082edb.2
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 13:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mEb/lY+bWhCiebzE+4ef1h9bTlw9HI5LZBTMKAtBSYw=;
        b=CMexSYFq+xBV+qdyZGfDClNULg/DRQFKkv9tUW/0Ji22LM8d5n4/OOUGwAjrrTRkhg
         eSzugUdHVNw6S6LuDJ4mvIXmZig2/dyq1vMAQCyaNF04zp92WEnGCoBt5u1T07ZznRgR
         dzJ6Co6eh6vALKEPFsSEGqh86IiEACDjHI6szak33YT9BbjJxwMjSD+ZVGabFW6QXCly
         bhoK7mKonBLATFqGQ4JvXlzkoBy7YiMCCHMtRBQOkukttsZwNJdiYWC66BfhtTDgt1GW
         fYQv5J4kN4INS+p0wTkuEhICg++m19o0WpEfUlPPaA5yFcWkHvjHg53ghHP3aXu5pDp1
         kXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEb/lY+bWhCiebzE+4ef1h9bTlw9HI5LZBTMKAtBSYw=;
        b=XBsdvVbDQgAUhYhnJ+5jwYqwLkoUXaIAC9SRHF8fGFNVkCStTX0dhM0uoWPsTr4Iu7
         8l5JJccPzsreR2MnAQWD0lnD2fkCRRmodK/bRuVn3m35fMgBC6DY1XjXI6lOUUemHDPK
         6r2GOH47kd0HcBrFGI1MT/WFQq9meM2Zyj0gKYhgBSIDyZZBZDRA+VKL5pXaBhC/oEHf
         RsxOFnfa72pVVQgLzymtxBXLMvd2A+2qMLRtUhDQUQgFuYtMW/vodQooc1+uZl2gpJs0
         +ieLz/uJpIGmYeof8wkpNYMZWLK1qqKEzUOQxKQUv/YwgFtZ7BN5S+SlzZHjnyDxst3u
         vjnw==
X-Gm-Message-State: AOAM530vR4v3DDR5+veWkFNEc+zIUKeHI96izMWPUmkXqqSSteM1T1Ae
        bEzDKviowoo4nWh9zKVqO39eksVg+S6SMvNPH3Ka/ZsBWMl+PA==
X-Google-Smtp-Source: ABdhPJwg32mv3zdqyxYnBLBWw9vSyAUaE6ASeyPT83jugFIJ7sR/CpaEJYNwWn5WQ+b+FOCKmixRxy6ZuBKdicjTwSw=
X-Received: by 2002:a05:6402:c19:: with SMTP id co25mr22865784edb.33.1642454482838;
 Mon, 17 Jan 2022 13:21:22 -0800 (PST)
MIME-Version: 1.0
References: <pull.1194.git.git.1642212566346.gitgitgadget@gmail.com>
 <pull.1194.v2.git.git.1642443955836.gitgitgadget@gmail.com> <xmqqh7a2uphk.fsf@gitster.g>
In-Reply-To: <xmqqh7a2uphk.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 Jan 2022 13:21:11 -0800
Message-ID: <CABPp-BF+eUGJ7FgMRG9vOUh8X5ExU+jkR3WHZeFGnKH80SO7gQ@mail.gmail.com>
Subject: Re: [PATCH v2] merge-ort: avoid assuming all renames detected
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 17, 2022 at 11:33 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > In commit 8b09a900a1 ("merge-ort: restart merge with cached renames to
> > reduce process entry cost", 2021-07-16), we noted that in the merge-ort
> > steps of
> >     collect_merge_info()
> >     detect_and_process_renames()
> >     process_entries()
> > that process_entries() was expensive, and we could often make it cheaper
> > by changing this to
> >     collect_merge_info()
> >     detect_and_process_renames()
> >     <cache all the renames, and restart>
> >     collect_merge_info()
> >     detect_and_process_renames()
> >     process_entries()
> > because the second collect_merge_info() would be cheaper (we could avoid
> > traversing into some directories), the second
> > detect_and_process_renames() would be free since we had already detected
> > all renames, and then process_entries() has far fewer entries to handle.
> >
> > However, this was built on the assumption that the first
> > detect_and_process_renames() actually detected all potential renames.
> > If someone has merge.renameLimit set to some small value, that
> > assumption is violated which manifests later with the following message:
> >
> >     $ git -c merge.renameLimit=1 rebase upstream
> >     ...
> >     git: merge-ort.c:546: clear_or_reinit_internal_opts: Assertion
> >     `renames->cached_pairs_valid_side == 0' failed.
> >
> > Turn off this cache-renames-and-restart whenever we cannot detect all
> > renames, and add a testcase that would have caught this problem.
> >
> > Reported-by: Taylor Blau <me@ttaylorr.com>
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
>
> Thanks.  An Ack?

Taylor told me the code change fixed his case, and that he'd review my
full patch with the testcase when I posted it.  Let's wait to hear
from him.
