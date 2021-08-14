Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A482DC4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 18:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CFEE60EE5
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 18:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbhHNSlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 14:41:55 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:41948 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233713AbhHNSly (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 14 Aug 2021 14:41:54 -0400
Received: from MTA-14-3.privateemail.com (mta-14-1.privateemail.com [198.54.122.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id DBE258011F
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 14:41:24 -0400 (EDT)
Received: from mta-14.privateemail.com (localhost [127.0.0.1])
        by mta-14.privateemail.com (Postfix) with ESMTP id 9465D18000BB
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 14:41:23 -0400 (EDT)
Received: from mail-ot1-f45.google.com (unknown [10.20.151.205])
        by mta-14.privateemail.com (Postfix) with ESMTPA id 774AB18000A5
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 14:41:23 -0400 (EDT)
Received: by mail-ot1-f45.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so16094822oth.7
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 11:41:23 -0700 (PDT)
X-Gm-Message-State: AOAM5320bXxPsVGGhcIWirgGpah7RsORtGLleiPsOEOx3mq+aH1Zo9G+
        kNpIp1W4+tdokmFaeHsSmL7zT9SwJSSilIjc0aU=
X-Google-Smtp-Source: ABdhPJweJTP4iQ510pp/1F4ldn3dZWRhsV2hQwUgPYxGA4sctCH3QwLgXIQ7vDA40tmacY0rR5R+wwMwmaxxXI3Q0Ds=
X-Received: by 2002:a05:6830:4108:: with SMTP id w8mr6522407ott.110.1628966482877;
 Sat, 14 Aug 2021 11:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1012.git.1628640954160.gitgitgadget@gmail.com>
 <pull.1012.v2.git.1628917872724.gitgitgadget@gmail.com> <xmqqmtpjubuv.fsf@gitster.g>
In-Reply-To: <xmqqmtpjubuv.fsf@gitster.g>
From:   Azeem Bande-Ali <me@azeemba.com>
Date:   Sat, 14 Aug 2021 14:40:55 -0400
X-Gmail-Original-Message-ID: <CABye917ALhCsfg_7JD72TxO0i2bhTc-0pJKKZwt8BVdiv1Qw4w@mail.gmail.com>
Message-ID: <CABye917ALhCsfg_7JD72TxO0i2bhTc-0pJKKZwt8BVdiv1Qw4w@mail.gmail.com>
Subject: Re: [PATCH v2] help.c: help.autocorrect=prompt waits for user action
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Azeem Bande-Ali via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, David Barr <b@rr-dav.id.au>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 14, 2021 at 2:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Azeem Bande-Ali via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +                     char* answer;
>
> Some people seem to make an asterisk stick to types like this, but
> in our codebase written in C, an asterisk sticks to the identifier
> that it makes into a pointer, i.e.
>
>                         char *answer;
>
Thanks! Will fix. I appreciate you providing the motivation for the
policy as well!

> > +                     struct strbuf msg = STRBUF_INIT;
> > +                     strbuf_addf(&msg, _("Run '%s' instead? (y/N)"),
> > +                                 assumed);
>
> I think these should be kept on a single line for readability, i.e.
>
>                         strbuf_addf(&msg, _("Run '%s' instead? (y/N)"), assumed);
>
> as I see a fairly long line after this block already.
>
>         fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);

The line split was done by clang-format via `make style`. Is it okay
to ignore the clang-format recommendation?
(Incidentally `make style` would have also caught the first issue, I
seem to have not run it after
making a change in that line.)

> Other than these cosmetic bits, this round looks good to me,
> including the documentation update.

Great thanks! This is my first patch so I just wanted to confirm:
should I add a "Reviewed-by:"
line to the commit with your name as well?
