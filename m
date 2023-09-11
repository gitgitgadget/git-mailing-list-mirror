Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ED9CA0EC5
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348779AbjIKVa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242027AbjIKPUr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 11:20:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550A0CEB
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 08:20:41 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52713d2c606so5985422a12.2
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 08:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694445640; x=1695050440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AODR0q8I1cCVB65GPpdo42J0QL3SkzgQS3wCQOosc3k=;
        b=ecBzjyctolj+AtcXu2UkMa+l/yBDFkrKzOv8Zftck1s0UyFkF55975UpK9OtwCZ/SC
         vqUE1OXu+UHciuwJaW9s1IEM6RvG42CHvb4Eu1nroQ4R0VGuXXCKeB7w/gC49Quxv1X2
         vLuHGdoXNCNePHCcPF1cSLjF7zlcVolC6k+Ka2k97nbpL2Z/enmZeE1x9wa831iuKkg+
         LduIFd6CVHolVtYGJRlt/d0hunj3DJ7++4qo3styaupUpZBOpQ+f3wjHR7Lv2cqBceDu
         iCzeaQ/NXzZ8NZtnaFHekLKmRr6r8osp6yx0DCvo9nGvrp5Wp5JJsz8PTUSaYc527mAl
         MfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694445640; x=1695050440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AODR0q8I1cCVB65GPpdo42J0QL3SkzgQS3wCQOosc3k=;
        b=QJO1w0ZmP1YRzAhSbz4CYl4L7Ow1EudwhwbAooTugzU0fLXELsB44JiFiV3KgxTIaB
         XZIWh6m+QNFx99Hjcx/xQIm6FtoK39gAm/vnOxBTfFFPTnLR/ZKbt3NlnEeC0tFh//uC
         OZ3CoX1eRNFx3ykuOPgdceLMFASYcvHyQRlxqCv+fw3VmvUdk6E7xC6VBLiHPOX5SL5p
         YASPRLdP3ZuQZk7HuHrTRPGJ4FGBdmdDHHY3WioIr6PtvmPhL+dDkn6WHXGekO8PdcCG
         zrA/WQkk3TgmdiHwd3YIlpPdGuaU3IIC6avzHjcbx9riQa7DeD5kpaJYvFcVyiagLTr5
         AhCA==
X-Gm-Message-State: AOJu0Ywzmw+lMANEDjzpRY03lxvVUAK/4KViIEk4TMHatEliU64k5o6u
        xffql4RMu6xn6OdAMGa1L69S7VvYRbmiDelDQNc=
X-Google-Smtp-Source: AGHT+IFR/aRtbqO8DLVPiUNTuJ6NoBLlxxSksgGvIVR0r6FxYUYFBB/EzkVA1zqKb0n1Qerh9ykp0rGG7e7mlgO9/v0=
X-Received: by 2002:aa7:c793:0:b0:523:bfec:4913 with SMTP id
 n19-20020aa7c793000000b00523bfec4913mr7897617eds.0.1694445639490; Mon, 11 Sep
 2023 08:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230808082608.582319-1-christian.couder@gmail.com>
 <20230812000011.1227371-1-christian.couder@gmail.com> <xmqqv8dhjfgm.fsf@gitster.g>
 <ZNvxg7BVJ+C5XFY4@nand.local> <xmqqjztwgcnc.fsf@gitster.g> <ZNwFlcS3SOS9h77N@nand.local>
In-Reply-To: <ZNwFlcS3SOS9h77N@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 11 Sep 2023 17:20:27 +0200
Message-ID: <CAP8UFD2kFjcD29kCp4j1AceCs=mr+_vN+sT5AVnoQNJBaoFt8A@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Repack objects into separate packfiles based on a filter
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 16, 2023 at 1:09=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Tue, Aug 15, 2023 at 03:32:23PM -0700, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:

> > > but I wonder if a more complete fix would be something like:
> > > ...
> > > @@ -966,6 +972,9 @@ int cmd_repack(int argc, const char **argv, const=
 char *prefix)
> > >     if (write_bitmaps && !(pack_everything & ALL_INTO_ONE) && !write_=
midx)
> > >             die(_(incremental_bitmap_conflict_error));
> > >
> > > +   if (write_bitmaps && po_args.filter_options.choice)
> > > +           die(_(filtered_bitmap_conflict_error));
> > > +
> >
> > It sounds like the most direct fix.

I would be Ok with such a fix, if we think that we don't want to fix
the underlying issue, or if we think that fixing the underlying issue
is not enough...

> I agree.
>
> I think that we would be OK to not change the implementation of
> rebuild_bitmap(), or its caller in fill_bitmap_commit(), since this only
> bites us when bitmapping a filtered pack, and we should catch that case
> well before getting this deep into the bitmap code.
>
> But it does seem suspect that we rebuild right into ent->bitmap, so we
> may want to consider doing something like:
>
> --- >8 ---
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index f6757c3cbf..f4ecdf8b0e 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -413,15 +413,19 @@ static int fill_bitmap_commit(struct bb_commit *ent=
,
>
>                 if (old_bitmap && mapping) {
>                         struct ewah_bitmap *old =3D bitmap_for_commit(old=
_bitmap, c);
> +                       struct bitmap *remapped =3D bitmap_new();
>                         /*
>                          * If this commit has an old bitmap, then transla=
te that
>                          * bitmap and add its bits to this one. No need t=
o walk
>                          * parents or the tree for this commit.
>                          */
> -                       if (old && !rebuild_bitmap(mapping, old, ent->bit=
map)) {
> +                       if (old && !rebuild_bitmap(mapping, old, remapped=
)) {
> +                               bitmap_or(ent->bitmap, remapped);
> +                               bitmap_free(remapped);
>                                 reused_bitmaps_nr++;
>                                 continue;
>                         }
> +                       bitmap_free(remapped);
>                 }
>
>                 /*
> --- 8< ---
>
> on top.
>
> Applying that patch and then rerunning the tests with the appropriate
> TEST variables causes the 'git repack' to fail as expected, ensuring
> that the containing test passes.

...however I think that fixing this underlying issue is important, as
it might cause other tricky issues in the future, for example if other
bitmap code is copying or reusing this code.

So I just sent a version 6 of this series with this change in a new
patch. I hope my explanations in the commit message are good enough.

Thanks for finding the cause of the CI test failures and suggesting this fi=
x,
Christian.
