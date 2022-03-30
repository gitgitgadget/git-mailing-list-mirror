Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D550C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 19:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350555AbiC3TGw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 15:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350536AbiC3TGt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 15:06:49 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A30C237C3
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 12:05:02 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id r22so29010309ljd.4
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 12:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=awwkvm796VW/PqHYlxRXiws1vPhwrbGvOx6JzYmylOg=;
        b=BKqVSG5xSBMpZBJMs5oSiKB57mX96rzo03XzlgX4+LFOtscw80KJdHkkzP9vKxhrE0
         x179Im33x/QtCkxYsxaiIwCqsmIZYeQ2l6minTX2ARSojRXFEy/eunIl5uE+V9UxvHxq
         P9jJoc4QWUGEj5sGgnTBjVHSZrcZzJP19LWoy86LRbZUf6mWypzpwdbQ7JgMtg326ORP
         5ud8bh+xgNZ9LcuS5WXsMWXT/pp6+loN+NLP9BGdiEoFEWl6V+DdRPVgB94Cvym2W3/k
         MuEpZv8dLf1ullyJAzwrTx1UatNnsS4jVmue1YNIlbwUI8YezTIjrJEu54pP1DUSbLPS
         V6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=awwkvm796VW/PqHYlxRXiws1vPhwrbGvOx6JzYmylOg=;
        b=6+4Y2kgf6ZylJ9e4swO7MDaK4ZGTXzYklyIjtjrWUd2wMxrzo65oc+M2dPe4X5sztn
         op1e+lhef2Lw5f7cHn0Stcxu3UABzCisWhYgLIBmwHiYnRyd3t0Ax97wb18tgTjp9gPZ
         10UGNA3QJGsp1XWDCJEd4G9+K8EmdP2va8Mcs8a1sRVzaGis/GLZqaJHPJb3TLklfFub
         CJoNUGj9ZjFEB8T6IPMwGUQ/1dulAMOFGsPn5RupTIOpkpaIEV4KbZ5/EkK7enaFefzT
         SBuhx4/sapbGOotcmwUiu8adfMvAvW8w7AO2GuhTUm88ql/f8b/rdxoG+xoThNXa5Nbv
         zfow==
X-Gm-Message-State: AOAM532H3XugYU4gMCkHpEWXmzIJyYwC8sdN3RxQmnEoqw8HNYZCaJqx
        zxnAE62BFSJbY4LWx9VoEN6FpjMcZTnBCP2zcoc=
X-Google-Smtp-Source: ABdhPJyoVDewaGKYrJMVWvpCSQCzY0ryEx/hAgHouFTR+neoaCBH6g86AvJ99o/ZVU58xsTFmGyV6sjUJhR3nPxLUts=
X-Received: by 2002:a2e:9b96:0:b0:249:8705:8f50 with SMTP id
 z22-20020a2e9b96000000b0024987058f50mr7935830lji.73.1648667097928; Wed, 30
 Mar 2022 12:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
 <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com> <83fa4a5f3a5c79fa814932c0705867ff16a584c7.1648616734.git.gitgitgadget@gmail.com>
 <xmqqy20r8h9o.fsf@gitster.g>
In-Reply-To: <xmqqy20r8h9o.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 30 Mar 2022 12:04:46 -0700
Message-ID: <CANQDOddUQRwq73e9pxxmp8c2JRvLy4YcbDHEQ+h-6uEoauyb2g@mail.gmail.com>
Subject: Re: [PATCH v5 05/14] cache-tree: use ODB transaction around writing a tree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 30, 2022 at 10:47 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Neeraj Singh <neerajsi@microsoft.com>
> >
> > Take advantage of the odb transaction infrastructure around writing the
> > cached tree to the object database.
> >
> > Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> > ---
> >  cache-tree.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/cache-tree.c b/cache-tree.c
> > index 6752f69d515..8c5e8822716 100644
> > --- a/cache-tree.c
> > +++ b/cache-tree.c
> > @@ -3,6 +3,7 @@
> >  #include "tree.h"
> >  #include "tree-walk.h"
> >  #include "cache-tree.h"
> > +#include "bulk-checkin.h"
> >  #include "object-store.h"
> >  #include "replace-object.h"
> >  #include "promisor-remote.h"
> > @@ -474,8 +475,10 @@ int cache_tree_update(struct index_state *istate, int flags)
> >
> >       trace_performance_enter();
> >       trace2_region_enter("cache_tree", "update", the_repository);
>
> There is no I/O in update_one() when the WRITE_TREE_DRY_RUN bit is
> set, so we _could_ optimize the begin/end away with
>
>         if (!(flags & WRITE_TREE_DRY_RUN))
>                 begin_odb_transaction()
>
> > +     begin_odb_transaction();
> >       i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
> >                      "", 0, &skip, flags);
> > +     end_odb_transaction();
> >       trace2_region_leave("cache_tree", "update", the_repository);
> >       trace_performance_leave("cache_tree_update");
> >       if (i < 0)
>
> I do not know if that is worth it.  If we do not do any object
> creation inside begin/end, we don't even create the temporary object
> directory and there is nothing we need to do when we "unplug".  So
> this would be fine as-is, but I may be overlooking something, so I
> thought I'd mention it for completeness.
>

Yes, with the current series, beginning and ending a transaction will
just manipulate a few global variables in bulk-checkin.c unless there
is something real to flush.

Thanks,
Neeraj
