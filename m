Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AAEC433EF
	for <git@archiver.kernel.org>; Tue, 17 May 2022 10:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344417AbiEQKlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 06:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344397AbiEQKl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 06:41:27 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A832EBE2A
        for <git@vger.kernel.org>; Tue, 17 May 2022 03:41:25 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id t2so9230828ilm.13
        for <git@vger.kernel.org>; Tue, 17 May 2022 03:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mu0/ADj0FgMAVw0QQdKEq0ffX/O+tSiro898z/1ZPW4=;
        b=chSBK0Jl43OeKEmAPuUbe58HEaCMOoAKvmMtpywaE3clyLv/4J0RtrfcykAQIvKJ/t
         h4uafbqWU9ePYy3gpOW8plwXjQT4QUPbj0tFV72NMGxEN/Zti8VGfvbjuFna1LmBn5tu
         XJ+UbnEnMiVLegZ6/pYdehNtCfG0fgH7eN141DQw/oryjNvIV57C9Rsl1tWqQO+fnEwg
         26NX6Bh06kVYFRbHuF6+njiAhqsXrneGKB1AUXp322aP3oDWTMmmMdcr6A1DcwF1W1yt
         KyczgLRYd0yKl9OV+fhJ6e+i3wzZ9MMN2ElMUSJULlVzbrfQDligdrx19N8wRMDCi85Z
         drcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mu0/ADj0FgMAVw0QQdKEq0ffX/O+tSiro898z/1ZPW4=;
        b=OT7bjun2UEH2Uoxz/2lmDP9t+JZg7+Q0dBdG3AY0uWPDGr8UO+ZNV6aOYWtc7HGP8x
         9T2klPSV56eqOLCX/UirldjS5ZUGx6ciVmIU0FMnVAfQxHSVPS19oujbAFdpNL6HaH40
         XoLfYpOSTsROFYhw5P7/0bq/AmtY4gSUj8aokBAfK2QXCMBg2LubhwA93jZGxtpu7bgk
         wQdGe6nsVVIl+rVt2NOKUF8AnxcNOayujRQUIDdb7FbniFx/4kLZk3Lw2T6TlbvWu1XC
         deXbZ4on6OzksogsLqQTWrNcnmvCoGa5UuUSS54DCQSocKbZ9IlOk1TZ8bWAMFFgEdvN
         nwYA==
X-Gm-Message-State: AOAM533V4kE9NGyCCv6iQo1AJzR77Bbarwlfc06NSigAoBUpktr2osYC
        LcwVKQulnCwvwvUITFkdnwkY4aUe0yczEweyFx6nzKWbFRU=
X-Google-Smtp-Source: ABdhPJy5O2QyTrfPuJkeGPzHkCT9J3RJayrNS/VNbkHnHcPVeNSysiOBoMI5xRTw5dxgvpvsInCkJtbpDLbDWUnHDdA=
X-Received: by 2002:a05:6e02:194c:b0:2cf:294b:28bf with SMTP id
 x12-20020a056e02194c00b002cf294b28bfmr11718344ilu.51.1652784085015; Tue, 17
 May 2022 03:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1266.git.git.1652690275625.gitgitgadget@gmail.com>
 <pull.1266.v2.git.git.1652690501963.gitgitgadget@gmail.com>
 <xmqqv8u54gcm.fsf@gitster.g> <CAGHpTBJDeOMCfv36Sey1tGadQThS8mGR00YiK4C16BbV==W8XQ@mail.gmail.com>
 <xmqqtu9oxxmv.fsf@gitster.g>
In-Reply-To: <xmqqtu9oxxmv.fsf@gitster.g>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Tue, 17 May 2022 13:41:14 +0300
Message-ID: <CAGHpTBK_K+GK5z3XD-7ob7JPLrUnohfMCRVD2wrwbMhDyy3TEw@mail.gmail.com>
Subject: Re: [PATCH v2] fetch: limit shared symref check only for local branches
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 17, 2022 at 1:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Orgad Shaneh <orgads@gmail.com> writes:
>
> >> Another thing that is surprising is that you say this loop is
> >> expensive when there are many tags or branches.  Do you mean it is
> >> expensive when there are many tags and branches that are updated, or
> >> it is expensive to merely have thousands of dormant tags and
> >> branches?  If the latter, I wonder if it is sensible to limit the
> >> check only to the refs that are going to be updated.
> >
> > It's expensive even when *nothing* is updated. I have a repo with 44K
> > tags, 13K of the tags are annotated, 134 remote branches and 4
> > worktrees (except the main repo) with 33 local branches.
> >
> > I counted the calls to find_shared_symref - it was called 35755 times,
> > and refs_read_raw_ref was called 357585 times.
>
> That is exactly why I asked, as the above number hints that it could
> be a viable optimization to omit calls for refs whose old_ and
> new_oid are the same, just like you omit calls for refs that are not
> inside refs/heads/ in your patch, perhaps?

This would require shuffling the code. check_not_current_branch() is
called by do_fetch before fetch_and_consume_refs (which updates
ref->old_oid and ref->new_oid).

- Orgad
