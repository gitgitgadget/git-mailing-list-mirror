Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E015C433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE0EC65272
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCHUzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 15:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCHUzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 15:55:09 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C97C061760
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 12:55:09 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id j8so10664042otc.0
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 12:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HD6/vRxFSTGEhlezPNyjSj/TXLD7tStLEZg1kuYpgPc=;
        b=RWOpUiI/mI32RzHJlR/e7tFvJyqshayvO8b+D6TqNsW4jmMwFywUL1K0R6rv78rXnx
         J+R93mVOsiSP3xWxTlLqrMk1w02vePrrUow7zZzKZQZpSM67QTnqqMibO5tnm6Y4udaT
         fq5/CzQuVFLtCQAS92sW166M6nu1Pjm41lSrFPm7zYWPIn6xeGyRzy/AHfAI7lXqjIWq
         6XNyVf2e4b87GLtDXnm5OrDwLtd88B5x5GxEl+qV9fKtG5pk9iqcDeu5NZqqK6KzJBTw
         1CxFeKPa3kPKzuJegXHRnnZSi8xeLmCa3nthgWDc1JTHXorIy/vcHf4og95nIp0RDOKQ
         dImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HD6/vRxFSTGEhlezPNyjSj/TXLD7tStLEZg1kuYpgPc=;
        b=feSOCw1zxsiNPigyyZ8gp5SMcXvu/ekU054gOjSGLNFgChO3CP1eri0puzZLx2733M
         RzzjmOa77DTgCBUjhiQRb/wthAYekQbptpa/shkVqKHDGY5OhkIAAGJUEIKuOc/ettcm
         kFIZIjHatn8Ilxg/nA7dw0dQ6OtwMS87bu+6w1mDXdShl5xZSQITO1y1r1idxv9HX9uz
         ZnyzN2CU80XmQ5cG+xM8XzQsi42nqJQzGAqNIeSb65sLHEeiH45FR+wS95lCwL016XZN
         UpJ8GzAat6tZuBYenEZSwp43KaIu2Orjs7qZChFeymQD0XEMCt7Wd2lPjDmPlnBh5nbv
         xzQQ==
X-Gm-Message-State: AOAM532sL3QHpgjCEJ0Vx3ZfWIpOXIt+94MQJANpFDGkHxgbwqY1Rk19
        4gx6W+rD3kpzNP5csrdTsNg95zYMcFRxiImTaTrvSq6jlSk=
X-Google-Smtp-Source: ABdhPJxXOQuwZ4tl5BFt36lkydITxP/wNhBth5nJKQ0AtPz1A2pNecqDphru3xRBOgMDhio4eGCnhQq0DMaQ3IGV9Ns=
X-Received: by 2002:a9d:8ae:: with SMTP id 43mr2645202otf.162.1615236908652;
 Mon, 08 Mar 2021 12:55:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
 <100c0187bdfeef5c560ecd17160ed7c9a3032156.1614905738.git.gitgitgadget@gmail.com>
 <871rcpkd6v.fsf@evledraar.gmail.com>
In-Reply-To: <871rcpkd6v.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 8 Mar 2021 12:54:57 -0800
Message-ID: <CABPp-BE1hyWsTyFDZTtHrsbCSx7TQcLb0WwfYVw2mHVYj7_jLQ@mail.gmail.com>
Subject: Re: [PATCH 08/11] merge-ort: implement CE_SKIP_WORKTREE handling with
 conflicted entries
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 8, 2021 at 5:06 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Fri, Mar 05 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > When merge conflicts occur in paths removed by a sparse-checkout, we
> > need to unsparsify those paths (clear the SKIP_WORKTREE bit), and write
> > out the conflicted file to the working copy.  In the very unlikely case
> > that someone manually put a file into the working copy at the location
> > of the SKIP_WORKTREE file, we need to avoid overwriting whatever edits
> > they have made and move that file to a different location first.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-ort.c                       | 43 +++++++++++++++++++++----------
> >  t/t6428-merge-conflicts-sparse.sh |  4 +--
> >  2 files changed, 32 insertions(+), 15 deletions(-)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index a998f843a1da..37b69cbe0f9a 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -3235,23 +3235,27 @@ static int checkout(struct merge_options *opt,
> >       return ret;
> >  }
> >
> > -static int record_conflicted_index_entries(struct merge_options *opt,
> > -                                        struct index_state *index,
> > -                                        struct strmap *paths,
> > -                                        struct strmap *conflicted)
> > +static int record_conflicted_index_entries(struct merge_options *opt)
> >  {
> >       struct hashmap_iter iter;
> >       struct strmap_entry *e;
> > +     struct index_state *index =3D opt->repo->index;
> > +     struct checkout state =3D CHECKOUT_INIT;
> >       int errs =3D 0;
> >       int original_cache_nr;
> >
> > -     if (strmap_empty(conflicted))
> > +     if (strmap_empty(&opt->priv->conflicted))
> >               return 0;
> >
> > +     /* If any entries have skip_worktree set, we'll have to check 'em=
 out */
> > +     state.force =3D 1;
> > +     state.quiet =3D 1;
> > +     state.refresh_cache =3D 1;
> > +     state.istate =3D index;
> >       original_cache_nr =3D index->cache_nr;
> >
> >       /* Put every entry from paths into plist, then sort */
> > -     strmap_for_each_entry(conflicted, &iter, e) {
> > +     strmap_for_each_entry(&opt->priv->conflicted, &iter, e) {
> >               const char *path =3D e->key;
> >               struct conflict_info *ci =3D e->value;
> >               int pos;
> > @@ -3292,9 +3296,23 @@ static int record_conflicted_index_entries(struc=
t merge_options *opt,
> >                        * the higher order stages.  Thus, we need overri=
de
> >                        * the CE_SKIP_WORKTREE bit and manually write th=
ose
> >                        * files to the working disk here.
> > -                      *
> > -                      * TODO: Implement this CE_SKIP_WORKTREE fixup.
> >                        */
> > +                     if (ce_skip_worktree(ce)) {
> > +                             struct stat st;
> > +
> > +                             if (!lstat(path, &st)) {
> > +                                     char *new_name =3D unique_path(&o=
pt->priv->paths,
> > +                                                                  path=
,
> > +                                                                  "cru=
ft");
> > +
> > +                                     path_msg(opt, path, 1,
> > +                                              _("Note: %s not up to da=
te and in way of checking out conflicted version; old copy renamed to %s"),
> > +                                              path, new_name);
>
> I see this follows existing uses in merge-ort.c, but I wonder if this
> won't be quite unreadable on long paths, i.e.:
>
>     <long x> renamed to <long x.new>
>
> As opposed to:
>
>     We had to rename your thing:
>         from: <long x>
>           to: <long x.new>

Makes sense, but it seems like something we'd want to do to a lot of
messages rather than just this one.  For now, especially given that I
expect this particular message to be *very* rare, I think I'll leave
this one as-is for now but we can address this idea in a subsequent
series or as #leftoverbits.
