Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F4FC56202
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 05:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD212221F9
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 05:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7TbEyak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbgKLFhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 00:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbgKLBs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 20:48:29 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57276C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 17:48:29 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id l10so937656oom.6
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 17:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shlaAPuHEYC9u8fGgXq5dJ4px4bPZ+luGa5Alej0WEU=;
        b=g7TbEyak0wBJRSgXfQCyWuYRuqr4BRp/6v9WlBa7Yt95TGi7C+xVp0UypZv399HqKM
         7+mfxTNeOjy11S4wxT7PUsb7+3VEa0oehgZyAGb4U9SDPXawJ5NBTmKR9zeBZNHgfGEr
         Pn2ozINRaxA6fjffkVGF5ByXs3FeZhqIaGDwxN8qshwX8C51p9dcJw0rGGz4orLbW3SE
         nrp53tKjVSzdZH25/GdQpoJbCTRk9Yl28rjoOqojfBrSqkiptq4u+/jSQLyf+OurHW2J
         1s2CN5dxOtVMW5moPXmdgg797qvF6FJF0vbTlUxzj0miY5YH2uLkroAE26TY0FN4TtX6
         QW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shlaAPuHEYC9u8fGgXq5dJ4px4bPZ+luGa5Alej0WEU=;
        b=ceWbTpRlgWrx1kYzfuUB/EJrpYre/t9XyrsJaqLkvkkVJ7EmOmQDWFavJybnw/u6Bi
         eqTXd6QTzKHlCwPIXeRRhJ8eMnMPJeOwirb9GF4cDu69sLotOyBq7ggem+2OoysZvzdi
         qygyaiEvXRrRNRGzOnosYLeSkb+ZrZXaSLYr5feJWM/qxJs/2/XZ60OXSLH3CWEqhga5
         LnPVSQxY9TdyVyWA+ZXz2P/2k/K/GFwdAVnHZKghR0SpIOSUVAfKbbqaNTdwDGFFxBlH
         Br4Vmv7NTE7kQePsgpvkTT0zPwPDu7luQi3pZQJJvfNx3R62HKleBBUzU/wb4olOuwR6
         Uk6A==
X-Gm-Message-State: AOAM531oYiX7A5lNkBJLitDtsGPjsgN+IIDIAf8JV2O796Qz1bK/HlJI
        bb3F6O7Qcwy7SkVMHokCJj11rtdFji3/QUsDf6w=
X-Google-Smtp-Source: ABdhPJwJsvD15eWsdW5zmW6wQA3ld1S0RhpFNFqusgkgmtdbtqfAMJLHrN+pBFZS0nbbxTglvOogS77Af53Mvn3W4no=
X-Received: by 2002:a4a:9806:: with SMTP id y6mr19373884ooi.45.1605145708453;
 Wed, 11 Nov 2020 17:48:28 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-12-newren@gmail.com> <20201111195111.3115407-1-jonathantanmy@google.com>
In-Reply-To: <20201111195111.3115407-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Nov 2020 17:48:17 -0800
Message-ID: <CABPp-BFgQX6Ash03x7z+RfE3ytbw3x0DzDSBrGddgMr_soODoA@mail.gmail.com>
Subject: Re: [PATCH v2 11/20] merge-ort: add a preliminary simple
 process_entries() implementation
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 11:51 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Okay...let me review patches 11-15. (Patches 16-20 deal with checkout
> and might be better reviewed by someone who is already familiar with how
> the existing merge performs checkout. If no one reviews it, I might come
> back to it if I have time.)

Thanks for the reviews!  I was hoping to see some comments on patch
15, as it's possibly the gnarliest.  It's a relatively straightforward
algorithm, just lots of bookkeeping.

And I think you took on the harder part of the remaining reviews.  :-)
 The checkout stuff is much easier, IMO -- and knowledge of how the
existing merge performs checkout wouldn't help at all with reviewing
that; it's just too different.

If you do find the time to look at the last five patches, or parts of
them here's some tips on the reviewing:
  * Patches 16, 18, and 20 are very straightforward; patches 17 and 19
are the ones that would benefit more from review.
  * Patch 17 is basically the twoway_merge subset of
merge_working_tree() from builtin/checkout.c.  Find that bit of code
and it's a direct comparison.
  * Patch 19 amounts to "how do I remove stage 0 entries in the index
and replace them with 1-3 higher order stages?".

> > +/* Per entry merge function */
> > +static void process_entry(struct merge_options *opt,
> > +                       const char *path,
> > +                       struct conflict_info *ci)
> > +{
> > +     assert(!ci->merged.clean);
> > +     assert(ci->filemask >= 0 && ci->filemask <= 7);
>
> I see below that this function doesn't handle ci->match_mask == 7 (and
> it doesn't need to because, I believe, there is a function in one of the
> earlier patches that optimizes the case wherein all 3 match with each
> other). Maybe add an assert here for that too.
>
> > +
> > +     if (ci->filemask == 0) {
> > +             /*
> > +              * This is a placeholder for directories that were recursed
> > +              * into; nothing to do in this case.
> > +              */
> > +             return;
> > +     }
> > +
> > +     if (ci->df_conflict) {
> > +             die("Not yet implemented.");
> > +     }
> > +
> > +     /*
> > +      * NOTE: Below there is a long switch-like if-elseif-elseif... block
> > +      *       which the code goes through even for the df_conflict cases
> > +      *       above.  Well, it will once we don't die-not-implemented above.
> > +      */
> > +     if (ci->match_mask) {
> > +             ci->merged.clean = 1;
>
> OK, looks straightforward so far. It's a clean merge if 2 match. (As I
> said earlier, at this point in the code, it is not possible for 3 to
> match.)
>
> > +             if (ci->match_mask == 6) {
> > +                     /* stages[1] == stages[2] */
> > +                     ci->merged.result.mode = ci->stages[1].mode;
> > +                     oidcpy(&ci->merged.result.oid, &ci->stages[1].oid);
>
> If OURS and THEIRS match, use one of them arbitrarily (because they are
> the same anyway). OK.
>
> > +             } else {
> > +                     /* determine the mask of the side that didn't match */
> > +                     unsigned int othermask = 7 & ~ci->match_mask;
> > +                     int side = (othermask == 4) ? 2 : 1;
>
> BASE matches with either OURS or THEIRS, so use the side that doesn't
> match. OK.
>
> > +
> > +                     ci->merged.is_null = (ci->filemask == ci->match_mask);
>
> This works (if the non-matching bit in filemask is set, the file exists;
> the comparison will be false and therefore is_null is false - and
> correctly false because the file exists), but seems unnecessarily
> clever. Couldn't you just check nullness of the OID (or through the
> mode, like the line below it) and set it here?
>
> Admittedly, the way you wrote it also verifies that filemask is what we
> expect. I don't think it is important to verify it, but if you think it
> is important, I think it is this verification that should go in the
> assert statement.

These points and the others earlier in this file and other points I
didn't comment on are all good points; thanks for all the suggestions.

> > +                     ci->merged.result.mode = ci->stages[side].mode;
> > +                     oidcpy(&ci->merged.result.oid, &ci->stages[side].oid);
> > +
> > +                     assert(othermask == 2 || othermask == 4);
> > +                     assert(ci->merged.is_null == !ci->merged.result.mode);
> > +             }
> > +     } else if (ci->filemask >= 6 &&
> > +                (S_IFMT & ci->stages[1].mode) !=
> > +                (S_IFMT & ci->stages[2].mode)) {
> > +             /*
> > +              * Two different items from (file/submodule/symlink)
> > +              */
> > +             die("Not yet implemented.");
>
> There are no matches, and OURS and THEIRS have different types. OK.
>
> > +     } else if (ci->filemask >= 6) {
> > +             /*
> > +              * TODO: Needs a two-way or three-way content merge, but we're
> > +              * just being lazy and copying the version from HEAD and
> > +              * leaving it as conflicted.
> > +              */
> > +             ci->merged.clean = 0;
> > +             ci->merged.result.mode = ci->stages[1].mode;
> > +             oidcpy(&ci->merged.result.oid, &ci->stages[1].oid);
>
> OK.
>
> > +     } else if (ci->filemask == 3 || ci->filemask == 5) {
> > +             /* Modify/delete */
> > +             die("Not yet implemented.");
> > +     } else if (ci->filemask == 2 || ci->filemask == 4) {
> > +             /* Added on one side */
> > +             int side = (ci->filemask == 4) ? 2 : 1;
> > +             ci->merged.result.mode = ci->stages[side].mode;
> > +             oidcpy(&ci->merged.result.oid, &ci->stages[side].oid);
> > +             ci->merged.clean = !ci->df_conflict && !ci->path_conflict;
> > +     } else if (ci->filemask == 1) {
> > +             /* Deleted on both sides */
> > +             ci->merged.is_null = 1;
> > +             ci->merged.result.mode = 0;
> > +             oidcpy(&ci->merged.result.oid, &null_oid);
> > +             ci->merged.clean = !ci->path_conflict;
> > +     }
>
> The rest is OK.
>
> > +
> > +     /*
> > +      * If still unmerged, record it separately.  This allows us to later
> > +      * iterate over just unmerged entries when updating the index instead
> > +      * of iterating over all entries.
> > +      */
> > +     if (!ci->merged.clean)
> > +             strmap_put(&opt->priv->unmerged, path, ci);
> > +}
> > +
> >  static void process_entries(struct merge_options *opt,
> >                           struct object_id *result_oid)
> >  {
> > -     die("Not yet implemented.");
> > +     struct hashmap_iter iter;
> > +     struct strmap_entry *e;
> > +
> > +     if (strmap_empty(&opt->priv->paths)) {
> > +             oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
> > +             return;
> > +     }
> > +
> > +     strmap_for_each_entry(&opt->priv->paths, &iter, e) {
> > +             /*
> > +              * WARNING: If ci->merged.clean is true, then ci does not
> > +              * actually point to a conflict_info but a struct merge_info.
> > +              */
> > +             struct conflict_info *ci = e->value;
> > +
> > +             if (!ci->merged.clean)
> > +                     process_entry(opt, e->key, e->value);
> > +     }
> > +
> > +     die("Tree creation not yet implemented");
>
> The rest looks straightforward.
