Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25402C6FA82
	for <git@archiver.kernel.org>; Sun,  4 Sep 2022 06:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiIDF5c (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Sep 2022 01:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIDF5b (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2022 01:57:31 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126F84D24E
        for <git@vger.kernel.org>; Sat,  3 Sep 2022 22:57:30 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b142so4753439iof.10
        for <git@vger.kernel.org>; Sat, 03 Sep 2022 22:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=lemtK+Wi8YWtqgVDajh+mFxNWdXBoU2A6nyFxWSOItA=;
        b=lvTvcdE9AZACmBwWiE3Ze3n4oQqg6idcfbwTs0Ws9Fe0mWoLi+8A3H+x/eJqahy13A
         ERGrmN5UeC15NLg7Vupv+4zGSy+TZjOMdYIvPINs0By4C8Us51dEcG7eZjV36Y7UsF8A
         Nc8XvRaG+ow0+aZD6/cKjNlCMS2Wa7mSWXEkRPyVHGGTcbLC7HtaYqhe//HKj0VTItJM
         Suyy+iTw3OuBhWK+SRbG4HQGkW6bJdAtkOmtbZfVH8F3u9pyVMmCFzaux5YE1I5gfmrr
         jybkQscsmCvK4C7oFRo+db+Z7XpILbFJTfsMNKr+6NaCZ7ZDKczKotPgqgldmD9orx2A
         CtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lemtK+Wi8YWtqgVDajh+mFxNWdXBoU2A6nyFxWSOItA=;
        b=S5e7u8Dt4pqbWbW/iZF688ZpBmTdKsZgNNVqE+3ylt21n88Z5igZYcH2eWqI9ULe5D
         3c7yFQEUDkdczq++ABp5EA8pnLejAwsKV97gbxW0Pd1SnXyLohxvQW4is/4Gn+emsuzS
         C4VAjZWssBqssshBV+54YENvhSyBiI2poZg5RuhWBOoCEY+I1QKNrAyzuVCfGBErhTlm
         gSyetpWmqKt04guYq9NhUWSGg3Obyt8uYWnDXOXlvOSjcge7dliM5HLuSH4Mi2NCqwk7
         gJsLKmz2yttsaLgxqLqr2VhnLekUq0jqWuTj3Aonp2sYNQ6qO/YaEFc5pp62KvPjE0QL
         SHiA==
X-Gm-Message-State: ACgBeo0493/bz9qVDF9RGPiEoCBMyDpW5pZWNHIKiyDgWUUDO/7ZGHr4
        6nBsspHiXGz7XYFsj4rRlBR2c35RA49ZQobQeGI=
X-Google-Smtp-Source: AA6agR5sz5bIkAvzHIHEkFVara8dQjHV7U7GZegZN+0A+/L9e0R/GrmYQR9caG66UeDPke327Lz0cNAGZzX2FLHiqOI=
X-Received: by 2002:a05:6602:4015:b0:688:c39a:dcd9 with SMTP id
 bk21-20020a056602401500b00688c39adcd9mr19921354iob.206.1662271049444; Sat, 03
 Sep 2022 22:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1343.git.1662025272.gitgitgadget@gmail.com>
 <19fd72c34dcd1332df638d76b0b028e9d9da3d41.1662025272.git.gitgitgadget@gmail.com>
 <8b9e8c2d-7a64-2d66-83a8-2a7daff9a81c@github.com>
In-Reply-To: <8b9e8c2d-7a64-2d66-83a8-2a7daff9a81c@github.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 4 Sep 2022 13:57:18 +0800
Message-ID: <CAOLTT8SMQ9nPPs0OnxhH4n_A46WqW8Fv=priFs=NLuBycoBuug@mail.gmail.com>
Subject: Re: [PATCH 1/3] commit-graph: let commit graph respect commit graft
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=882=
=E6=97=A5=E5=91=A8=E4=BA=94 03:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On 9/1/2022 5:41 AM, ZheNing Hu via GitGitGadget wrote:
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > In repo_parse_commit_internal(), if we want to use
> > commit graph, it will call parse_commit_in_graph() to
> > parse commit's content from commit graph, otherwise
> > call repo_read_object_file() to parse commit's content
> > from commit object.
> >
> > repo_read_object_file() will respect commit graft,
> > which can correctly amend commit's parents. But
> > parse_commit_in_graph() not. Inconsistencies here may
> > result in incorrect processing of shallow clone.
> >
> > So let parse_commit_in_graph() respect commit graft as
> > repo_read_object_file() does, which can solve this problem.
>
> If grafts or replace-objects exist, then the commit-graph
> is disabled and this code will never be called. I would
> expect a test case demonstrating the change in behavior
> here, but that is impossible.
>

Thanks for the clarification.
I don't really know what's the wrong here, but just let do a little test:

1. Revert this commit 19fd72c34dcd1332df638d76b0b028e9d9da3d41
$ git revert 19fd72

2. Clone the git repo
$ git clone --bare git@github.com:git/git.git

3. Write commit graph
$ git commit-graph write

4. Use the depth=3D<depth> to clone (depth=3D1)
$  git clone --no-checkout --no-local --=3Ddepth=3D1 git.git git1
Cloning into 'git1'...
remote: Enumerating objects: 4306, done.
remote: Counting objects: 100% (4306/4306), done.
remote: Compressing objects: 100% (3785/3785), done.

4.  Use the depth=3D<depth> to clone (depth=3D2)
$  git clone --no-checkout --no-local --=3Ddepth=3D2 git.git git2
Cloning into 'git2'...
remote: Enumerating objects: 4311, done.
remote: Counting objects: 100% (4311/4311), done.
remote: Compressing objects: 100% (3788/3788), done.

5. Use the depth filter to clone (depth=3D1)
$  git clone --no-checkout --no-local --filter=3Ddepth:1 git.git git3
Cloning into 'git3'...
remote: Enumerating objects: 4306, done.
remote: Counting objects: 100% (4306/4306), done.
remote: Compressing objects: 100% (3785/3785), done.

6. Use the depth filter to clone (depth=3D2)
$  git clone --no-checkout --no-local --filter=3Ddepth:2 git.git git4
Cloning into 'git4'...
remote: Enumerating objects: 322987, done.
remote: Counting objects: 100% (322987/322987), done.
remote: Compressing objects: 100% (77441/77441), done.

As we can see, when we use --filter=3Ddepth:<depth> (depth >=3D 2),
it seems like we clone a lot of objects. The result is significantly
different from git clone --depth=3D<depth> (depth >=3D 2).

So I debug it by reproducing the git pack-objects process:

I find there are different action between --filter=3Ddepth:<depth> and
 --depth=3D<depth> .

--filter=3Ddepth:<depth> will be successfully resolved commit parents in
parse_commit_in_graph(),

Call stack( cmd_pack_objects -> get_object_list -> traverse_commit_list ->
traverse_commit_list_filtered -> do_traverse -> get_revision ->
get_revision_internal -> get_revision_1 -> process_parents ->
repo_parse_commit_gently -> repo_parse_commit_internal ->
parse_commit_in_graph)

--depth=3D<depth> will failed in parse_commit_in_graph(), and call
repo_read_object_file() to resolved commit parents.

Call stack( cmd_pack_objects -> get_object_list -> traverse_commit_list ->
traverse_commit_list_filtered -> do_traverse -> get_revision ->
get_revision_internal -> get_revision_1 -> process_parents ->
repo_parse_commit_gently -> repo_parse_commit_internal ->
repo_read_object_file)

> The commit-graph parsing should not be bogged down with
> this logic.
>

So I try to fix this problem by let commit-graph respect commit-graft.
I don't know if I overlook something before...

> Thanks,
> -Stolee
>

Thanks,
ZheNing Hu
