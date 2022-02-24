Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E860C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 17:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiBXRxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 12:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiBXRxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 12:53:09 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905E51179A2
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 09:52:39 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cm8so3979192edb.3
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 09:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kmlMGaYDK3okHHyck2tFDjOlf97wOnOGJBtx6RYueV8=;
        b=11ik8ay5g0rN3ZoE0gktE0p554jSWmy4538BmRFdIVSRpQ1N+Z+zwwr5R5fI1SS6/A
         zm1xk2BGbrF9wIsa8J4lKdDS1JxhJqXPmlBeY/GRL1C13L7eci88zeYkpQjM5KSguLTP
         reNJz1ThSCgshdsrFP/b9573BdN4SPevTxg42gC/nZ20JslNoxDRdJ5EWtKvWIfiazFZ
         yCjshfBjNfSUrRtTIlmcGDhZl8hIDyD81oGkmXtJK884P3j39RfYU7njmVsRdk+Ez7R1
         xSKNPFD1xZhJ6mKyWKKNnSEEPLeD+HjxChrsqafBfYvrh9Vt5R9SZ/dCgwDHX4n8Rx4J
         lUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kmlMGaYDK3okHHyck2tFDjOlf97wOnOGJBtx6RYueV8=;
        b=zmd+yadMWEhCvPEnOu77pJjIciMIdtc47dRBm5uFMeWe1PZ7Ko8/cV0dj+k9XoYTlO
         lhLszyg+GrqT8FU7cMXZWmZ5lCcMxgkiLgHZ8WIQZm5e1AXttc4gfI0VQDEvoeuHxddy
         NXRLDIJLBrUuACw6riLtcsBf61LFlXR65yjSEtOdFfDlJkLhF0WBtO3SLmKDoR8S3idL
         PIkmCWXgHvH9pVP3+Ris6zl0Kjqm9/mXRpRhLFP38WcRbobU2ZRbb3MNRK4GacaGrcOq
         uXmLB0pw9ioaiZidQpTBWn1BwbVMl5MxXXrRk7+Cs110zcf2dcROhM6YrKvGVi5WGFmR
         Yfpw==
X-Gm-Message-State: AOAM531xlb7jQocvPTyfHGEsWNqj4HAE60khWgbERJdv8o5SkPTXKRci
        TXoMX0J2YZ6NRK0osRiFaQcbjvyIAaUx56u7cWOaog==
X-Google-Smtp-Source: ABdhPJzXKsRsyvLdZtnajU3RXFPtcwkXAtw2T47Mx9piQwH6B/re0YzXppnZN6VNGH0esbyLND1PEtS7m7zXnaQtO0c=
X-Received: by 2002:a05:6402:908:b0:410:ef84:f6f1 with SMTP id
 g8-20020a056402090800b00410ef84f6f1mr3391641edz.34.1645725157987; Thu, 24 Feb
 2022 09:52:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.986.git.1624559401.gitgitgadget@gmail.com>
 <627f1952fd8d4864b6b87f5539a9d9b802c5796b.1624559402.git.gitgitgadget@gmail.com>
 <xmqq35t11dtu.fsf@gitster.g>
In-Reply-To: <xmqq35t11dtu.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 24 Feb 2022 18:52:27 +0100
Message-ID: <CAPMMpogerttWdjGBNxJaqHT4bd3_igDx4_Fxev2eNHqexZ=aLQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] Write index when populating empty untracked cache
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Thanks so much for reviewing this, and my apologies for not reacting
earlier, after you took the time.

> our commit title are <area> prefix, a colon and then a
> summary.  Try to make your commits blend in.

Noted, will fix, thx. I believe I did this better in an unrelated
patch series today, but I guess I will see what people say :)

> What requests the untracked cache to
> be created, and what options (or perhaps the lack of what options)
> prevent the untracked cache to be "non-applicable"?

Will try to clarify / be more specific.

> I suspect that "the cache" here is the same "untracked
> cache"

Will fix.

> "we detect ... and queues" sounds like a grammo.

Yep, dreaded perspective shift, will fix.

> perhaps [proposed text] or something along the line.

Will incorporate, thx.

> The logic sounds fairly straight-forward.

I didn't understand here whether you were confirming that the change
seems to make sense (yay!), or commenting that the extra comment block
is redundant, stating something obvious, and should better be removed.
Could you confirm please?

In the meantime, I'll "re-roll" (?) with the proposed changes.

Thanks again,
Tao

On Tue, Jun 29, 2021 at 6:42 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Subject: Re: [PATCH 3/3] Write index when populating empty untracked cache
>
> Common to all three patches.
>
> Look at "git shortlog --no-merges -200 master" and observe the
> pattern, i.e. our commit title are <area> prefix, a colon and then a
> summary.  Try to make your commits blend in.
>
> > From: Tao Klerks <tao@klerks.biz>
> >
> > It is expected that an empty/unpopulated untracked
> > cache structure can be written to the index - by update-
> > index, or by a "git status" call that sees the untracked cache
> > should be enabled, but is running with options that make
> > it non-applicable in that run.
>
> Would an example be helpful?  What requests the untracked cache to
> be created, and what options (or perhaps the lack of what options)
> prevent the untracked cache to be "non-applicable"?
>
> > Currently, if that happens, then subsequent "git status"
> > calls end up populating the untracked cache, but not
> > writing the index (not saving their work) - so the
> > performance outcome is almost identical to the cache
> > being altogether disabled.
> >
> > This continues until the index gets written with the cache
> > populated, for some *other* reason.
>
> Here (and only here), the word "cache" is used instead of "untracked
> cache"---but I suspect that "the cache" here is the same "untracked
> cache".  If that is the case, being consistent and spelling it out
> would reduce the risk of confusing readers.
>
> > In this change, we detect the "existing cache is empty
> > and it looks like we are using it" condition, and queues
> > an index write when this happens.
>
> "we detect ... and queues" sounds like a grammo.
>
> In this project, we describe the change being proposed as if we are
> giving an order to the codebase to "become like so".  So, perhaps
>
>     Detect the condition where an empty untracked cache exists in
>     the index and we collect the list of untracked paths, and queue
>     an index write under that condition, so that the collected
>     untracked paths can be written out to the untracked cache
>     extension in the index.
>
> or something along the line.
>
> > This change depends on previous fixes to t7519 for the
> > "ignore .git changes when invalidating UNTR" test case to
> > pass - before this fix, the test never actually did anything
> > as it was not set up correctly.
> >
> > Signed-off-by: Tao Klerks <tao@klerks.biz>
> > ---
> >  dir.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/dir.c b/dir.c
> > index ebe5ec046e0..a326e40e1c1 100644
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -2703,7 +2703,8 @@ void remove_untracked_cache(struct index_state *istate)
> >
> >  static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
> >                                                     int base_len,
> > -                                                   const struct pathspec *pathspec)
> > +                                                   const struct pathspec *pathspec,
> > +                                                   struct index_state *istate)
> >  {
> >       struct untracked_cache_dir *root;
> >       static int untracked_cache_disabled = -1;
> > @@ -2767,8 +2768,15 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
> >               return NULL;
> >       }
> >
> > -     if (!dir->untracked->root)
> > +     if (!dir->untracked->root) {
> >               FLEX_ALLOC_STR(dir->untracked->root, name, "");
> > +             /*
> > +              * If we've had to initialize the root, then what we had was an
> > +              * empty uninitialized untracked cache structure. We will be
> > +              * populating it now, so we should trigger an index write.
> > +              */
> > +             istate->cache_changed |= UNTRACKED_CHANGED;
> > +     }
>
> The logic sounds fairly straight-forward.  The fact that we came
> this far in the helper function means that we know we want to use
> (i.e. untracked cache is not disabled, and various other "we
> shouldn't be contaminating the cache with the one-shot information"
> cases did not return from the helper) untracked cache, and root
> being NULL originally means the untracked cache wasn't populated.
>
> >       /* Validate $GIT_DIR/info/exclude and core.excludesfile */
> >       root = dir->untracked->root;
> > @@ -2838,7 +2846,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
> >               return dir->nr;
> >       }
> >
> > -     untracked = validate_untracked_cache(dir, len, pathspec);
> > +     untracked = validate_untracked_cache(dir, len, pathspec, istate);
> >       if (!untracked)
> >               /*
> >                * make sure untracked cache code path is disabled,
