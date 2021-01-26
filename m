Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EBDC433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 11:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3E2F2311B
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 11:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405258AbhAZLxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 06:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405338AbhAZLja (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 06:39:30 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC07C061756
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 03:38:50 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id t43so5491998uad.7
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 03:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g5R0EZnmei99dtRZ+sS8tyVozpphal74Y/h/0mvxcZs=;
        b=tf1CWo7F+unEQqN7i+p0ewWSlWQ7cN7l6WwU4WlKH14POscsopEQyIPn2wEPEzlDX7
         ws7ys9w1nPCGFzOPD2pIN+30aEXBxhej1tfUk7LbKeMtuM/+IHv10KGT2w+UzA03tC2k
         Ll0g/BFkoTaqaC90JgpzbnivjRAVXFOPcMsqcv4PZKEyLXDr4a+IKuj6SUN5RoZbiiWr
         AeK46hHr10cCg5jy8tDuCzUbOQwixX4bwSN33pENXqHKSNaSuvjowAfHEqZEQy6mu8vE
         Pgu7guPtIrOa8FvGQdMWKA1nRofl7nSYWU7tC1L9Fv/ozHaKSZ4fanba/9HGqFZsHgRt
         uNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g5R0EZnmei99dtRZ+sS8tyVozpphal74Y/h/0mvxcZs=;
        b=f0sKkcCgBoDNOGw/orGMPJZzFT2i8eK0mcZ1Xl6oce8t2UYCg/9pTabgfMSj2lr6ZL
         frLQXYNOlP37/4Skx82mlrfADdWOS/hYUP4mCLK+PCf2K1v3DA5efdlyFmgEeB/sRRpS
         Y36yannSRPoDdG4lq3geH8D0xV2mRxos6snVcxarMHwgCqs6tQbd15kCamcFh3Y0XWG4
         uoLYQJAMepoT6R+hG7NzgJBdhM0wjv7RJJ2ybJXFCxDkkYfQY+tM/o9EVEKQxeovKxaj
         LCOlK0YtVIvblVh+FJpcgybSYsplUaytVdx7rYEGKfENmwvnDvgCBMtRkXsN4PdjpR9s
         /ItQ==
X-Gm-Message-State: AOAM530ohi9yOZd4sN6T79HOeO9jIi/SHAqdx4Cyi3dIGGNkDxfzyFuS
        12PZAPu0aHZ10EyUJ6Ri7k5XkMstYUqdtw2Tb335ng==
X-Google-Smtp-Source: ABdhPJwswZIKoGaHbiuUkQNSE9eKLrsbOjbpgQhMMu3IDIb1cvtgsYlVLK4PgJXVuyM4YCo5sKEw0G4xAOLyvHOefeY=
X-Received: by 2002:ab0:36af:: with SMTP id v15mr3593860uat.85.1611661129241;
 Tue, 26 Jan 2021 03:38:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.951.git.git.1611589125365.gitgitgadget@gmail.com> <xmqq35yo459k.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq35yo459k.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 26 Jan 2021 12:38:38 +0100
Message-ID: <CAFQ2z_PCh2RfWALhAUXm01Xq0o+ibuEGJ2p9sCtvTASQ0FLUag@mail.gmail.com>
Subject: Re: [PATCH] doc/reftable: document how to handle windows
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 26, 2021 at 6:49 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >  $ cat .git/reftable/tables.list
> > -00000001-00000001.log
> > -00000002-00000002.ref
> > -00000003-00000003.ref
> > +00000001-00000001-RANDOM1.log
> > +00000002-00000002-RANDOM2.ref
> > +00000003-00000003-RANDOM3.ref
> >  ....
> > @@ -940,7 +944,7 @@ new reftable and atomically appending it to the sta=
ck:
> >  3.  Select `update_index` to be most recent file's
> >  `max_update_index + 1`.
> >  4.  Prepare temp reftable `tmp_XXXXXX`, including log entries.
> > -5.  Rename `tmp_XXXXXX` to `${update_index}-${update_index}.ref`.
> > +5.  Rename `tmp_XXXXXX` to `${update_index}-${update_index}-${random}.=
ref`.
> >  6.  Copy `tables.list` to `tables.list.lock`, appending file from (5).
> >  7.  Rename `tables.list.lock` to `tables.list`.
>
> Is this because we have been assuming that in step 5. we can
> "overwrite" (i.e. take over the name, implicitly unlinking the
> existing one) the existing 0000001-00000001.ref with the newly
> prepared one, which is not doable on Windows?

No, the protocol for adding a table to the end of the stack is
impervious to problems on Windows, as everything happens under lock,
so there is no possibility of collisions.

> We must prepare for two "randoms" colliding and retrying the
> renaming step anyway, so would it make more sense to instead
> use a non-random suffix (i.e. try "-0.ref" first, and when it
> fails, readdir for 0000001-00000001-*.ref to find the latest
> suffix and increment it)?

This is a lot of complexity, and both transactions and compactions can
always fail because they fail to get the lock, or because the data to
be written is out of date. So callers need to be prepared for a retry
anyway.

> > @@ -993,7 +997,7 @@ prevents other processes from trying to compact the=
se files.
> >  should always be the case, assuming that other processes are adhering =
to
> >  the locking protocol.
> >  7.  Rename `${min_update_index}-${max_update_index}_XXXXXX` to
> > -`${min_update_index}-${max_update_index}.ref`.
> > +`${min_update_index}-${max_update_index}-${random}.ref`.
> >  8.  Write the new stack to `tables.list.lock`, replacing `B` and `C`
> >  with the file from (4).
>
> Likewise.

This case is different. Consider the following situation

1-1.ref:
  main=3Dabc123 @ timestamp 1
  master=3Dabc123 @ timestamp 1
2-2.ref:  bla=3D456def @ timestamp 2
3-3.ref:
  bla delete @ timestamp 3
  master delete @timestamp 3

The result of compacting this together would be a table containing

  main =3D abc123 @ timestamp 1

but in the previous naming convention, we'd name the resulting table
"1-1.ref", which conflicts with the table in our starting situation.


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
