Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB277C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 00:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbiBCASx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 19:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242087AbiBCASw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 19:18:52 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AE8C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 16:18:52 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ka4so2481795ejc.11
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 16:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fn6kOBRivGV4mVYmC3YqmIgcaK/bycJPO4spQVgP7eo=;
        b=k+u3Q9E1Q6imEAlq8/hiVAiwflxzwss+4txahAZOtmC5q4fnq0sIV1avcqZ73JOKJ6
         fE8ocDma0HvTpjNp2s2+WWayo8vMq15OoWISLx0KUQiz1aez6YDADcpXGzOlxQDgTWZQ
         8gFhmhaM7sAglJtkYZVlZERBFlHCT8GwTF2mUsZxhh1BAsF2YxYl+9izrwD0Fvtkh3aM
         bRe8q9J5mvxPhwj93JxWuj3dx74AJMarAp12MLqTUelAmWIprVRyxVsxT4107lrjNLxh
         TH7ZKfzZKIQZn//SWxh5kIZRHgqjWifooV4mQ8TPYrvXzFMRn/EeMIY73xpSAxduGTvx
         NZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fn6kOBRivGV4mVYmC3YqmIgcaK/bycJPO4spQVgP7eo=;
        b=31gA2TJk+Vq55Dm9teNd/awzsEETy+ZXIZrIcA5BdFzffYlx7d/rZEv1ojFpHA3dcC
         Io2LmDSb3gUfad1YgSOFAO+Vr/i1rM6/UoKblaQubMoJXxkNDQ7qFmA3+mSeK4w9YbgK
         gPnhlBhFSkaSjHKuQQ1M/y7OURpMXSSX8VnUOwHF83E2A0NBESBztTnAWSLC8hrGVZP4
         fGQ82BMmLTt0gmGI6sBs0UU1cUSFeNnylXO21+jeMLVRsKfFaxMcVq/BhHw8Ei0eJdjZ
         lL4XBivPmO4DEQVK/dm4cU8CN9BtBawf393QGYmOPuln+qlbJbSMDRwdehohJa/estzG
         JZPg==
X-Gm-Message-State: AOAM530NFP3M5h5dsnaMbvL5jYCe0vGcWE6r9bVtt20jBDadnKIizwt0
        KYS9chAYRxf5sWOR4tnPIUbdqQkMD6v8eCxFZpo=
X-Google-Smtp-Source: ABdhPJw31fOTrQMwhstf2CzbzaM7R2+k3V0zwTpCPwbVFZx/BwrBcOmZ+5Q2rz9PC9npdWNWI7pms7BsoBMrHGNu644=
X-Received: by 2002:a17:907:7388:: with SMTP id er8mr26789008ejc.269.1643847531031;
 Wed, 02 Feb 2022 16:18:51 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com> <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643787281.git.gitgitgadget@gmail.com>
 <xmqqy22tx8t1.fsf@gitster.g> <CABPp-BGpD6g5QH3=4X_dCuSX0Bs0utHn5hyuU4_UiwNhU0h8sg@mail.gmail.com>
 <xmqqh79hvsgn.fsf@gitster.g>
In-Reply-To: <xmqqh79hvsgn.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 Feb 2022 16:18:39 -0800
Message-ID: <CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbHA8+iGjxsYSA@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] merge-tree: implement real merges
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 2, 2022 at 2:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Yes, you are reading right.  I think the cherry-pick/rebase
> > replacement actually deserves a separate command from what merges
> > should use; replaying a sequence of commits just has a number of UI
> > differences and abilities that I think pull it in a different
> > direction.
>
> I completely disagree.  Each individual step in a sequence of
> replaying commits in order (or in reverse order) should be
> scriptable as a single merge-tree that takes "apply the change to go
> from A^ to A on X".  Sequencing and placing UI around it is a job
> for the script that drives merge-tree.

Adding such an ability to merge-tree would be trivial -- it basically
involves just two things: (1) accepting one extra argument, and (2)
calling merge_incore_nonrecursive() instead of
merge_incore_recursive().

However, I think forking a subprocess for every merge of a series of
commits is a completely unreasonable overhead, so even if we provide
such an option to merge-tree, I still want a separate plumbing-ish
tool that does non-worktree/non-index replaying of commits which is
not written as a driver of merge-tree.  That other tool should just
call merge_incore_nonrecursive() directly.  And such a tool, since it
should handle an arbitrary number of commits, should certainly be able
to handle just one commit.  From that angle, it feels like adding
another mode to merge-tree would just be a partial duplication of the
other tool.

However, if the other tool doesn't obviate the need for this
additional mode (perhaps it ends up being forced to be too
porcelain-ish insteading of plumbing-ish?), or folks really just want
another merge-tree mode, I'm happy to add one along with the tool I
submit later.  Does that sound reasonable to you, or is there
something you're still objecting to that I've missed?
