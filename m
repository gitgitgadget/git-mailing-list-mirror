Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85391C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 03:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiGADCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 23:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiGADCV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 23:02:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9783B13FB2
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 20:02:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id o25so1633518ejm.3
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 20:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7pLSTXwcA87cG9/eDTkLfKw5zgiyyVS/CfwVgQtTKmg=;
        b=nT/5zwUO7txHUJZXiL6MH+SNHRWR7FUdmnA6p+fD7opnP+Eqk/DwSqc9NIgCNrZt5r
         zsmghmRuHbMEaN4ogY8oqD3g2DteMvoPtFuXcNMftaJg1aq1RR0SmItKj/h2su/ADrVX
         eSgEpnqvMt8qJ/ZmH/KTiX9rjJeHb5V2jDgP2SQX+LfTc82VsLDM8qaFmppPb8gHXaCE
         pzYK4Q4kphKaeF3+EIc8d/wiG+ANt8FGm7nY3pySIdWinvF2I3n6DGeNyut6EmuBgUGE
         PRmEbhr4QPjIfEN5QkIV8da/oM2FuzZSeF7L27/fPVkfoHWKeQdNHbExoAcRr2K9YbxP
         0WdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7pLSTXwcA87cG9/eDTkLfKw5zgiyyVS/CfwVgQtTKmg=;
        b=1J7fwBXvyAj6RIhP8dXrB7Z6Rx+cCLYm33HIz2NIWAnp6fjXU6iZvkUaQVGtq1W6vb
         H4zAlHsYXDRvlVApFp68HBUOjJJIzk4TLUEyvDAH0Vld3hveYwJSiooEFyezDje79gnc
         CnL+v6nmeL1x3OwcyF0GHPgYBA6dDCGvZMSRpN4z9Oy32I4frC9DA2Nm9WF8/FCLoxnK
         fYvkFP7YeBNQo7wPkPiPOPt3LZieADdDT+J73YW8QTlIzOt0H0s9njp9XYxZhfjOKEEV
         OqasE87OGk+DtarkhO0++8z88PLbEgkQmaKmccB8lOasyMEO8RYUckDorV/PNXKcL+TN
         p4eQ==
X-Gm-Message-State: AJIora9r3IP2CKCgyhueSbF8nd39s6H4ZRDx0fhmXg3opP6iyVmPCekZ
        JNTNi1/LfBlQnPJ3WfpxsmVxEiRXwns6UL21yeA=
X-Google-Smtp-Source: AGRyM1tLbi3v0E0Xetlv44DhLju1VgW4VjtOApMETYE7hXkD4uh4PHcxfAGhKsRhFgzY+O+/YHrcxgjD3abZk7C8OoY=
X-Received: by 2002:a17:907:728a:b0:726:d6c8:d95c with SMTP id
 dt10-20020a170907728a00b00726d6c8d95cmr12039230ejc.269.1656644539100; Thu, 30
 Jun 2022 20:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1268.git.1655871651.gitgitgadget@gmail.com>
 <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com> <cfa38f01481d6a13a676e250e8254182733e0dd1.1656572226.git.gitgitgadget@gmail.com>
 <220630.86pmiqe96x.gmgdl@evledraar.gmail.com>
In-Reply-To: <220630.86pmiqe96x.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Jun 2022 20:02:07 -0700
Message-ID: <CABPp-BFp1JYGmeqj=1HC3X4Eca72spcF2BX=aZ_tkbEdhvHsCw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] merge-ort: shuffle the computation and cleanup of
 potential collisions
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2022 at 3:29 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Jun 30 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Run compute_collisions() for renames on both sides of history before
> > any calls to collect_renames(), and do not free the computed collisions
> > until after both calls to collect_renames().  This is just a code
> > reorganization at this point that doesn't make sense on its own, but
> > will permit us to use the computed collision info from both sides
> > within each call to collect_renames() in a subsequent commit.
>
> I think this would be easier to follow if split in two, since...
>
> > +static void free_collisions(struct strmap *collisions)
> > +{
> > +     struct hashmap_iter iter;
> > +     struct strmap_entry *entry;
> > +
> > +     /* Free each value in the collisions map */
> > +     strmap_for_each_entry(collisions, &iter, entry) {
> > +             struct collision_info *info =3D entry->value;
> > +             string_list_clear(&info->source_files, 0);
> > +     }
> > +     /*
> > +      * In compute_collisions(), we set collisions.strdup_strings to 0
> > +      * so that we wouldn't have to make another copy of the new_path
> > +      * allocated by apply_dir_rename().  But now that we've used them
> > +      * and have no other references to these strings, it is time to
> > +      * deallocate them.
> > +      */
> > +     free_strmap_strings(collisions);
> > +     strmap_clear(collisions, 1);
> > +}
>
> ...a large part of it...
> >
> > -     /* Free each value in the collisions map */
> > -     strmap_for_each_entry(&collisions, &iter, entry) {
> > -             struct collision_info *info =3D entry->value;
> > -             string_list_clear(&info->source_files, 0);
> > -     }
> > -     /*
> > -      * In compute_collisions(), we set collisions.strdup_strings to 0
> > -      * so that we wouldn't have to make another copy of the new_path
> > -      * allocated by apply_dir_rename().  But now that we've used them
> > -      * and have no other references to these strings, it is time to
> > -      * deallocate them.
> > -      */
> > -     free_strmap_strings(&collisions);
> > -     strmap_clear(&collisions, 1);
>
> ..is moving existing code into a utility function...
>
> >       return clean;
> >  }
> >
> > @@ -3100,6 +3105,7 @@ static int detect_and_process_renames(struct merg=
e_options *opt,
> >  {
> >       struct diff_queue_struct combined =3D { 0 };
> >       struct rename_info *renames =3D &opt->priv->renames;
> > +     struct strmap collisions[3];
> >       int need_dir_renames, s, i, clean =3D 1;
> >       unsigned detection_run =3D 0;
> >
> > @@ -3149,12 +3155,22 @@ static int detect_and_process_renames(struct me=
rge_options *opt,
> >       ALLOC_GROW(combined.queue,
> >                  renames->pairs[1].nr + renames->pairs[2].nr,
> >                  combined.alloc);
> > +     for (int i =3D MERGE_SIDE1; i <=3D MERGE_SIDE2; i++) {
> > +             int other_side =3D 3 - i;
> > +             compute_collisions(&collisions[i],
> > +                                &renames->dir_renames[other_side],
> > +                                &renames->pairs[i]);
> > +     }
> >       clean &=3D collect_renames(opt, &combined, MERGE_SIDE1,
> > +                              collisions,
> >                                &renames->dir_renames[2],
> >                                &renames->dir_renames[1]);
> >       clean &=3D collect_renames(opt, &combined, MERGE_SIDE2,
> > +                              collisions,
> >                                &renames->dir_renames[1],
> >                                &renames->dir_renames[2]);
> > +     for (int i =3D MERGE_SIDE1; i <=3D MERGE_SIDE2; i++)
> > +             free_collisions(&collisions[i]);
> >       STABLE_QSORT(combined.queue, combined.nr, compare_pairs);
> >       trace2_region_leave("merge", "directory renames", opt->repo);
>
> ...which when looking at it makes the functional change harder to follow
> than it otherwise would be.

Good point; will split.
