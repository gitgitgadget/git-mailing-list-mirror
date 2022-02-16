Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59B1C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 02:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343661AbiBPCYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 21:24:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239898AbiBPCYK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 21:24:10 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A30DD2051
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 18:23:59 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w3so1407614edu.8
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 18:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qkw08YlX8BZbhg3yl0HSRv7tZPn3RxP3T0ECTDIm7yo=;
        b=oFkf0V+rGbiKTx/RWZLgD0QVwvtgzNzeEv2Il9Ssv3YCZ+nZSqa33X0wItJQ9Q6bN0
         fftiS/H5tMgIrwP1iX1aAviqRKcF+7zffOMfWo/QZzFXl2DprQN0+jyK7PN4v1HkTabM
         u69S1Mt/H7qz0j3idUQkKuuoWJryqXwMtvHQDEjAYe7m5OpvQli6ii5NJ5ZnChYZSkGm
         6Ha0eo6Gbkeho5gLfbtok4EDw/r2eZhFkBP+zvocM0lPJ+zRjKbqx/O0qwDZZ1oPnKkQ
         tvoqVm2zarnSVgdvLaoqrdxaYDMAT9nTOGqwRGRBK/v2pFgAsTtr7H8sJMrEy9YCWAx/
         FTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qkw08YlX8BZbhg3yl0HSRv7tZPn3RxP3T0ECTDIm7yo=;
        b=agyfOIL8MpN4XQMcSFSxavnksaEIwfqumwx85coLSrGhKpmaSlkfrSBrYfc1l0e/7H
         5lU6EeBEIqJQUJND9A+CuLlZhmJGvaCLKC0MAnJgksxdrRlt/AhstOweZVo2OA8utDHM
         Ycg80RzsrOsHohOP6P40DGDaPsDLOkp0xrWoqcCAWTsMJ42oqqtPwps5mhCbmDspyKAP
         XezgUbfE8HgWj5S4C1CQ7UdpCHAizw49ZDCVW0F9cTVTr7Eo2pcKzrDUNnzE64jGB0Of
         rIZdkiiHx5TZduh/pn0EJ10SxiYxZEYRalMMx5R5DehP4807VPZ37LSscAFxyFQCNtlx
         Q2XQ==
X-Gm-Message-State: AOAM532EXJLTVzUi2DFNDS0yp6GyjD5DLGTmvkOEhmt4vKvXoyrGxIM3
        DWxwiCW+RmdaljU/US1c8Kt15FquF+AyaYqPWzk=
X-Google-Smtp-Source: ABdhPJxTQGFetbeqpWdtB+6SHkJHgW5xj3NHCQr6KvcKlEz7ZZtxc5U5BOAru4iJBftuvKx/u3J8cNOvlMlljDqG3DQ=
X-Received: by 2002:a05:6402:354f:b0:406:c518:56f1 with SMTP id
 f15-20020a056402354f00b00406c51856f1mr674983edd.309.1644978237500; Tue, 15
 Feb 2022 18:23:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
 <265cbe36b2df5a9a076877fe3ddc3880a64a9217.1644712798.git.gitgitgadget@gmail.com>
 <xmqqsfsl2utb.fsf@gitster.g> <CABPp-BEhsp4=dzCkSpyu4Bd7Q=hP1Ec6W09-zX2+N+5_-ytk8A@mail.gmail.com>
 <xmqqr183y5yh.fsf@gitster.g>
In-Reply-To: <xmqqr183y5yh.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Feb 2022 18:23:45 -0800
Message-ID: <CABPp-BFymV-bQVfT7u1phO1N8MHu03SfbVa6Q+CDKeJL21Fbwg@mail.gmail.com>
Subject: Re: [PATCH 5/7] sparse-checkout: reject non-cone-mode patterns
 starting with a '#'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 15, 2022 at 5:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > If this were the only special character case, I'd totally agree, but I
> > do worry a bit that escaping this particular case might lead users to
> > expect us to escape and fix other special characters from '*?[]!\'.
>
> Sorry, but I do not quite get why it is a problem.  I understand
> that the idea behind this "rejection" is that "#" is special only
> when it appears in files (as comment introducer) and must be
> prefixed with "\", right?
>
> Do any of the wildcard characters mean different things depending on
> where they appear?  Isn't '*' a wildcard to match 0-or-more-bytes
> whether it appears in files or on the command line, and need to
> prefixed with "\" to make it non-special regardless of where it is
> found?
>
> > If users have files with those characters and specify an argument with
> > one of those, are we to automatically escape them as well?  If we
> > don't escape the other characters but do escape '#', aren't we being
> > inconsistent?
>
> I do not quite get where you are seeing an inconsistency.  Do you
> mean that it is inconsistent that "# comment" is only allowed in
> files but not on the command line?

I don't understand what distinction you are trying to make between the
file or the command line; for non-cone mode, all positional arguments
to sparse-checkout {add,set} are taken as-is and inserted into the
$GIT_DIR/info/sparse-checkout file directly.

I don't like just assuming that users are specifying paths rather than
patterns, when non-cone mode is all about specifying patterns rather
than paths; it just feels broken to me.  However, since comments can
never match anything and part of the point of the sparse-checkout
command is so that users don't have to edit or look at the
$GIT_DIR/info/sparse-checkout file, it seemed worth flagging.

With all the special characters in non-cone mode ('*?[]!#\') and the
years of training we've given to users to edit
$GITDIR/info/sparse-checkout directly, there's really not much we can
check for; this was the only thing I could think of that seemed
reasonable to flag in non-cone mode.  However, it's really not all
that important to me, so I'll just drop this patch.

>  If so, a way to make it
> consistent may be to allow "# comment" even from the command line
> ;-)

Yes, dropping this patch would keep things consistent, and continue
allowing "# comment" from the command line (even if users are unlikely
to ever look at said comment).  I'll do that.
