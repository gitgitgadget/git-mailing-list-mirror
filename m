Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BFBC433EF
	for <git@archiver.kernel.org>; Sun, 17 Apr 2022 01:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbiDQB65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 21:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbiDQB6z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 21:58:55 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB2E13DDF
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 18:56:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b15so14013370edn.4
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 18:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z4kdA/Lv4CJ1pTvqgtWxANOJi8hXVgNTJMj0o3dmhlM=;
        b=D5AsNz5g9ftuW2aAdClCor+v9TlITt7T+JX6DBjq6xZ4hxTJFXwlptvm/rf5PITnad
         cbdVCvnLlADEeLiTS2KBgduHYaqayQ2QWaDwboZIG924ZjmIzKRIrLggH3NhG+XknGP1
         OAzfEeogqybiyTh1dS1RS0qRo+qtz93AtECfJ71PQizZySq+3cqkMQkEs9LnNek9Bq1T
         YPnDCMBXFxkBjvpSsp1G7qucGoF8/CqfRBmIvtxX1waTwEbCRUKRQMsUsPnZfmep5MXf
         XWlWCDsBJqzLPhLEsMeF/i1cbstJu1/hEqVkojS68ObdDtRSoG7Xb2IAPtQ+2bHvMYTZ
         X49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z4kdA/Lv4CJ1pTvqgtWxANOJi8hXVgNTJMj0o3dmhlM=;
        b=8NjCNvWH0O2JWL8YOskZfeCnZyzGtzU8RwX6mshWKCDleeoBOlXQWYXb7TLJbozFOA
         NjAPu+/zZdF3rRbB4DftOvjxZm2+mFst/m3ZoFp/7YVLa/NI+8nwciGH83ICWsMZZE3+
         7P+12Z/4Qa83rIeUbP7NiC13+u5gfZwjaJID/kRtEs3fagrUw5G5Ge0qXzhC5uvAAbTZ
         dN8BnYcqqEJ84lIJuN7K9LkYQtaoF/MQ5yFNWltGEW16dPUJwHRU4QN6Stwi4U2RQLGl
         WbhSU38VAngmCmLvWUloYJNIRKiTcP0SFFo9udFpipFW3QLE5SkhG5qv8L0xbN6MvoEZ
         GkuQ==
X-Gm-Message-State: AOAM530V3ntpYPpSXFY9wJT9wQd6WTjrVYqquRSEfH7cMD74ah9X5ETT
        s9vPSnqEsAFNmGcaoR/I3yPELwtAGMFdpdsb4j7G0wCo
X-Google-Smtp-Source: ABdhPJw64PJiXk/HsFME+td1ySArjD18HSrXIwMNNyWkKAIxFoTzhUKPRwww3jFO43RXPE2QrTHp0BaZlsqbjh90oIs=
X-Received: by 2002:a05:6402:288d:b0:41d:7db9:de95 with SMTP id
 eg13-20020a056402288d00b0041d7db9de95mr6049011edb.206.1650160580511; Sat, 16
 Apr 2022 18:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
 <243e7b0c372c15cc907c838ee74794433aa79858.1645441854.git.gitgitgadget@gmail.com>
 <CAP8UFD25KjNYuMoVb72N2kGmo3yJ0qGgfJn78axc562Z+YhAGQ@mail.gmail.com>
In-Reply-To: <CAP8UFD25KjNYuMoVb72N2kGmo3yJ0qGgfJn78axc562Z+YhAGQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 16 Apr 2022 18:56:09 -0700
Message-ID: <CABPp-BF2p54rcR9xLyZ34-HBPDw6ip08=0rGs3uH=qqSsn0cRA@mail.gmail.com>
Subject: Re: [PATCH 1/7] rebase --apply: remove duplicated code
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 7, 2022 at 1:30 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Tue, Feb 22, 2022 at 6:34 AM Phillip Wood via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > When we are reattaching HEAD after a fast-forward we can use
> > move_to_original_branch() rather than open coding a copy of that
> > code.
>
> Nit: maybe "rebase --apply: reuse move_to_original_branch()" would be
> a better subject for this patch, as it's more specific.
>
> > The old code appears to handle the case where the rebase is
> > started from a detached HEAD but in fact in that case there is nothing
> > to do as we have already updated HEAD.
> >
> > Note that the removal of "strbuf_release(&msg)" is safe as there is an
> > identical call just above this hunk.
>
> It looks like the removed call is using strbuf_reset(), not strbuf_release().
>
> Actually a call to strbuf_release(&msg) is also removed inside the `if
> (oideq(&merge_base, &options.orig_head)) { ... }` clause, but it
> doesn't look like you are talking about this one.

I think he is talking about that one and specifying why it's okay to
drop that one, and omitted why it was okay to drop the strbuf_reset()
because that one seemed more obvious.

> > Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > ---
> >  builtin/rebase.c | 11 +----------
> >  1 file changed, 1 insertion(+), 10 deletions(-)
> >
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index e942c300f8c..4832f16e675 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -1782,19 +1782,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >          * If the onto is a proper descendant of the tip of the branch, then
> >          * we just fast-forwarded.
> >          */
> > -       strbuf_reset(&msg);
>
> Yeah, it looks like `msg` isn't used in the function anymore so this
> call can be removed.
>
> >         if (oideq(&merge_base, &options.orig_head)) {
> >                 printf(_("Fast-forwarded %s to %s.\n"),
> >                         branch_name, options.onto_name);
> > -               strbuf_addf(&msg, "rebase finished: %s onto %s",
> > -                       options.head_name ? options.head_name : "detached HEAD",
> > -                       oid_to_hex(&options.onto->object.oid));
> > -               memset(&ropts, 0, sizeof(ropts));
> > -               ropts.branch = options.head_name;
> > -               ropts.flags = RESET_HEAD_REFS_ONLY;
> > -               ropts.head_msg = msg.buf;
> > -               reset_head(the_repository, &ropts);
> > -               strbuf_release(&msg);
> > +               move_to_original_branch(&options);
> >                 ret = finish_rebase(&options);
> >                 goto cleanup;
> >         }
>
> Nice cleanup!

Agreed.
