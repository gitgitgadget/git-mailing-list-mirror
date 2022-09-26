Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9278C32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 09:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiIZJK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 05:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbiIZJKY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 05:10:24 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817DF3335B
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 02:10:23 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id r134so4661550iod.8
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 02:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=b3dioE5SOFiqrw2rIsrv1hTUCSel9ptmIsk0Fd4wDP4=;
        b=SZDsliyRrrP/j6afw5jDBhSDmZ8OUlVQH8Iw+L+fZ2Xq75ZhaA+gTe/As0rvmSBQj5
         BmqZKsLiWNa7D9+CLl+pA7mbipAzFHI0zqH02msm9mgtBU27vemO8/qvi3BHbL1GdsrY
         RpmwfWnD0TQeDU0DZz5kQibRtP7J/ADI/Ngakh7mC8fTUkfJjgNgVaeMv5KBwG/hSozm
         fS66+dfuUETKZDHeyNUTfRvF0MrYAisDTXd6ljoMot0j8cb+AGLOTXW3zLI3iCnKkPt/
         FDSi1U8eURAS7Nu6JUz5NrfixcCI2Ra+gvRkpI22ZFdEz7HB2HqSkT7Fdb1xDyDyrFHg
         M4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=b3dioE5SOFiqrw2rIsrv1hTUCSel9ptmIsk0Fd4wDP4=;
        b=WoTCo1wgqZ8VsQ1z+HRPEpIrXrY0sfJX34V3qKAWtaOuKVF6RS+50idPnDWRCWn15V
         GA8kNcAtMpmb/RAz3M731LSVM82YLjT5lbjm55MAlbQJQrVc6oz5WB2tiIEy8f0uJqa/
         nW2cqVUzFis3yzv4Vg7AmshvgQIH+AnbGFosQGszymSJHrVwS8zv1QZD9vnw0fZstUd8
         H5b07owZ4loeZi1Yus6C12sIVbajdZLEiySDobYoeWqBkZ8kbFcp7RBEN1y6lX5P8FAT
         Mq9kWStU5chorPcZKZRWCIu6MlIK0zTxhtoLJwWA33B3DyycEVD9HgzfQrvYFEkZh3WQ
         2ULw==
X-Gm-Message-State: ACrzQf2sueWDv4k4iEMnVpb82QdMhZN139MzqOx9ZBXFPUqE11mhDYyX
        n+F0kIYdlsDrcHD8mXwRMqL95I2DNGBd10gFr6On/Ev6nbo=
X-Google-Smtp-Source: AMsMyM75HT+DeQe8qd+9vNhYAsIvJiOIgEfCdRzWyZ2dnXfcfVxb9fhUWejEG8e28yAhf9JEGf4LxrnCAjUlV4w942U=
X-Received: by 2002:a05:6602:3421:b0:6a1:6b14:895b with SMTP id
 n33-20020a056602342100b006a16b14895bmr8820755ioz.24.1664183422721; Mon, 26
 Sep 2022 02:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <d087d467e3fe3000eb19939c2bb5e5c0723fd908.1663959325.git.gitgitgadget@gmail.com>
 <220926.86y1u634yy.gmgdl@evledraar.gmail.com>
In-Reply-To: <220926.86y1u634yy.gmgdl@evledraar.gmail.com>
From:   Chris Poucet <poucet@google.com>
Date:   Mon, 26 Sep 2022 11:10:11 +0200
Message-ID: <CAN9+7XcvS92YU45qaBZjQ4i-g8uJOJQraXhViFQ2uJHDCAcSjg@mail.gmail.com>
Subject: Re: [PATCH 09/10] evolve: add delete command
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2022 at 10:38 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Sep 23 2022, Chris Poucet via GitGitGadget wrote:
>
> > From: Chris Poucet <poucet@google.com>
> >  static const char * const builtin_change_usage[] =3D {
> >       N_("git change list [<pattern>...]"),
> > -     N_("git change update [--force] [--replace <treeish>...] [--origi=
n <treesih>...] [--content <newtreeish>]"),
> > +     N_("git change update [--force] [--replace <treeish>...] [--origi=
n <treeish>...] [--content <newtreeish>]"),
>
> Here you're just correcting a typo in an earlier commit, squash it into t=
hat one instead.

Done, thank you.
>
> >  static const char * const builtin_update_usage[] =3D {
> > -     N_("git change update [--force] [--replace <treeish>...] [--origi=
n <treesih>...] [--content <newtreeish>]"),
> > +     N_("git change update [--force] [--replace <treeish>...] [--origi=
n <treeish>...] [--content <newtreeish>]"),
>
> Ditto.

Done, thank you.
