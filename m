Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1358CC6FA8B
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 14:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiIWOcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 10:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiIWOcM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 10:32:12 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DFB13EE9C
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 07:32:11 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id h194so58472iof.4
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 07:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=pgEp08Vd5JB4dAIEv/BL5LVmExly9v+RiHs19qkr5Dc=;
        b=CU7uca/HTctZyd3JBoDnvuSpMfk3ualV7dDqacGUlk2kE+ynDbTOJUvfdmGrT3rVcO
         2n08r69gQpiAP3cNgo8Pah+m9VfGBOi/DKkYHXAUDGKlTryvQ9M6wwuYCfTixQuLoDqm
         80aXBNAf/5hTbWkoI1zUFfaagawS2czRTbs8PKYY8r+OR5qIw1vNK37/5S1DlNvH1RgH
         JG58WuqJjWeOB921YljfHA4z691ppedZvaC0WounhnOXLq1auxRDerjl9Zkr7dipPbtD
         McRlzgup+v07yQgJRMs19WDPggY66DzV1p5bckJGipDO9DENnh9qMbzo7SVcCZfVTSm9
         LdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pgEp08Vd5JB4dAIEv/BL5LVmExly9v+RiHs19qkr5Dc=;
        b=WHMwcUMfo0nAWP0tK09iPBtH2E/vKgCsx+91OFM4S6HXUP+19AMA46HPn2E98ib4rC
         XOj/4gn9aIBdcL1EYcd8QMla/CHK9V1m3fmCZ6pyENQqHU+Y+TThF8ELFee0CbWFYUI1
         6s61sNs1OWarbvg91k0GCxpx3NJvlmIvw4RA3H09KTLQ6IXEenQBNcuoS6Gps0krhtmk
         3ELCHLJQ/Ge5a2LdBs0sb7rs/nsxJ2mQ07gOMIfdccMxd+4J06VinO0uJ7jWhTaCtoFS
         5zAaof5b2lQXa+ZSW6vCmKrehO309d8FiC2XM1uLWxVxa7V/b3tS+QZ5TcHZWDhcNTtN
         oYWA==
X-Gm-Message-State: ACrzQf0zuAwRCkXnkHDAhSxDGh/AaL7RuE7bFrr277a7Q8hlPVE7NIgL
        ZLMpMYGmLoe4fdGqIauDgYqpqdzoc8rQMc79/gQ=
X-Google-Smtp-Source: AMsMyM6rXPtCn+kNFqJX8i19jvPTUYsE2p2mc5Lvm7m+YrWQ5z90Un++UmAbJEHgszXYwYBfGTLXd+tQ9dWYpftOPxU=
X-Received: by 2002:a05:6638:1449:b0:35a:70ce:8a3f with SMTP id
 l9-20020a056638144900b0035a70ce8a3fmr4697978jad.42.1663943531142; Fri, 23 Sep
 2022 07:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8SHo66kGbvWr=+LQ9UVd1NHgqGGEYK2qq6==QgRCgLZqQ@mail.gmail.com>
 <CAJoAoZnm8jE9rT+rrze-zP7KZNW=oCZjcrFWqjDssW3LzxrKPg@mail.gmail.com>
 <CAOLTT8TwdwfHCCv+x51++Aanf3tipMegfZiTKFbQtfh7b_EY0A@mail.gmail.com> <CABPp-BEBB1oqdVcXrWwMAdtb0TwHZvr-6KDa210j5ncw54Di_g@mail.gmail.com>
In-Reply-To: <CABPp-BEBB1oqdVcXrWwMAdtb0TwHZvr-6KDa210j5ncw54Di_g@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 23 Sep 2022 22:31:59 +0800
Message-ID: <CAOLTT8QfwOi9yx_qZZgyGa8iL8kHWutEED7ok_jxwTcYT_hf9Q@mail.gmail.com>
Subject: Re: Question relate to collaboration on git monorepo
To:     Elijah Newren <newren@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=8822=E6=97=
=A5=E5=91=A8=E5=9B=9B 07:36=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Sep 21, 2022 at 8:22 AM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > Emily Shaffer <emilyshaffer@google.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=
=8821=E6=97=A5=E5=91=A8=E4=B8=89 02:53=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Tue, Sep 20, 2022 at 5:42 AM ZheNing Hu <adlternative@gmail.com> w=
rote:
> > > >
> > > > Hey, guys,
> > > >
> > > > If two users of git monorepo are working on different sub project
> > > > /project1 and /project2 by partial-clone and sparse-checkout ,
> > > > if user one push first, then user two want to push too, he must
> > > > pull some blob which pushed by user one. I guess their repo size
> > > > will gradually increase by other's project's objects, so is there a=
ny way
> > > > to delete unnecessary blobs out of working project (sparse-checkout
> > > > filterspec), or just git pull don't really fetch these unnecessary =
blobs?
> > >
> > > This is exactly what the combination of partial clone and sparse
> > > checkout is for!
> > >
> > > Dev A is working on project1/, and excludes project2/ from her sparse
> > > filter; she also cloned with `--filter=3Dblob:none`.
> > > Dev B is working on project2/, and excludes project1/ from his sparse
> > > filter, and similarly  is using blob:none partial clone filter.
> > >
> > > Assuming everybody is contributing by direct push, and not using a
> > > code review tool or something else which handles the push for them...
> > > Dev A finishes first, and pushes.
> > > Dev B needs to pull, like you say - but during that pull he doesn't
> > > need to fetch the objects in project1, because they're excluded by th=
e
> > > combination of his partial clone filter and his sparse checkout
> > > pattern. The pull needs to happen because there is a new commit which
> > > Dev B's commit needs to treat as a parent, and so Dev B's client need=
s
> > > to know the ID of that commit.
> > >
> >
> > I don't agree here, it indeed fetches the blobs during git pull. So I
> > do a little
> > change in the previous test:
> >
> > (
> >   cd m2
> >   git cat-file --batch-check --batch-all-objects | grep blob | wc -l >
> > blob_count1
> > #  git push
> > #  git -c pull.rebase=3Dfalse pull --no-edit #no conflict
> >   git fetch origin main
> >   git cat-file --batch-check --batch-all-objects | grep blob | wc -l >
> > blob_count2
> >   git merge --no-edit origin/main
> >   git cat-file --batch-check --batch-all-objects | grep blob | wc -l >
> > blob_count3
> >   printf "blob_count1=3D%s\n" $(cat blob_count1)
> >   printf "blob_count2=3D%s\n" $(cat blob_count2)
> >   printf "blob_count3=3D%s\n" $(cat blob_count3)
> > )
> >
> > warning: This repository uses promisor remotes. Some objects may not be=
 loaded.
> > remote: Enumerating objects: 32, done.
> > remote: Counting objects: 100% (32/32), done.
> > remote: Compressing objects: 100% (20/20), done.
> > remote: Total 30 (delta 0), reused 0 (delta 0), pack-reused 0
> > Receiving objects: 100% (30/30), 2.61 KiB | 2.61 MiB/s, done.
> > From /Users/adl/./mono-repo
> >  * branch            main       -> FETCH_HEAD
> >    a6a17f2..16a8585  main       -> origin/main
> > warning: This repository uses promisor remotes. Some objects may not be=
 loaded.
> > Merge made by the 'ort' strategy.
>
> Note: The merge completed successfully, and we see no evidence of
> additional blobs being downloaded before this point.
>

Agree. Debug message This is not a problem caused by git merge,
but caused by "finish" period of git merge, which fetch missing objects
to show the diffstat.

(lldb) b fetch_objects
Breakpoint 1: where =3D git`fetch_objects + 29 at
promisor-remote.c:18:23, address =3D 0x0000000100275f4d
(lldb) r
Process 62227 launched: '/Users/adl/repos/git/git' (x86_64)
Merge made by the 'ort' strategy.
Process 62227 stopped
* thread #1, queue =3D 'com.apple.main-thread', stop reason =3D breakpoint =
1.1
    frame #0: 0x0000000100275f4d
git`fetch_objects(repo=3D0x0000000100406a88, remote_name=3D"origin",
oids=3D0x0000000101204360, oid_nr=3D1) at promisor-remote.c:18:23
   15  const struct object_id *oids,
   16  int oid_nr)
   17  {
-> 18  struct child_process child =3D CHILD_PROCESS_INIT;
   19  int i;
   20  FILE *child_in;
   21
Target 0: (git) stopped.
(lldb) bt
* thread #1, queue =3D 'com.apple.main-thread', stop reason =3D breakpoint =
1.1
  * frame #0: 0x0000000100275f4d
git`fetch_objects(repo=3D0x0000000100406a88, remote_name=3D"origin",
oids=3D0x0000000101204360, oid_nr=3D1) at promisor-remote.c:18:23
    frame #1: 0x0000000100275ea3
git`promisor_remote_get_direct(repo=3D0x0000000100406a88,
oids=3D0x0000000101204360, oid_nr=3D1) at promisor-remote.c:249:7
    frame #2: 0x00000001001a2fe3
git`diff_queued_diff_prefetch(repository=3D0x0000000100406a88) at
diff.c:6781:2
    frame #3: 0x00000001001a3075
git`diffcore_std(options=3D0x00007ff7bfefed20) at diff.c:6805:3
    frame #4: 0x000000010009ca11
git`finish(head_commit=3D0x000000010151f000,
remoteheads=3D0x0000600000004390, new_head=3D0x00007ff7bfeff030,
msg=3D"Merge made by the 'ort' strategy.") at merge.c:499:3
    frame #5: 0x000000010009d787
git`finish_automerge(head=3D0x000000010151f000, head_subsumed=3D0,
common=3D0x0000600000004330, remoteheads=3D0x0000600000004390,
result_tree=3D0x00007ff7bfeff280, wt_strategy=3D"ort") at merge.c:960:2
    frame #6: 0x000000010009b07b git`cmd_merge(argc=3D1,
argv=3D0x00007ff7bfeff660, prefix=3D0x0000000000000000) at merge.c:1743:9
    frame #7: 0x0000000100005573 git`run_builtin(p=3D0x00000001003e0e60,
argc=3D3, argv=3D0x00007ff7bfeff660) at git.c:466:11
    frame #8: 0x0000000100004098 git`handle_builtin(argc=3D3,
argv=3D0x00007ff7bfeff660) at git.c:721:3
    frame #9: 0x0000000100004f76
git`run_argv(argcp=3D0x00007ff7bfeff4dc, argv=3D0x00007ff7bfeff4d0) at
git.c:788:4
    frame #10: 0x0000000100003e69 git`cmd_main(argc=3D3,
argv=3D0x00007ff7bfeff660) at git.c:921:19
    frame #11: 0x000000010011e8f6 git`main(argc=3D4,
argv=3D0x00007ff7bfeff658) at common-main.c:56:11
    frame #12: 0x00000001005b94fe dyld`start + 462

> > remote: Enumerating objects: 1, done.
> > remote: Counting objects: 100% (1/1), done.
> > remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
> > Receiving objects: 100% (1/1), 87 bytes | 87.00 KiB/s, done.
>
> Here, we do have an object download, which occurred after the merge
> completed, so there must be something happening after the merge which
> needs the extra blob; if we keep reading...
>
> >  project1/file1 | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
>
> Ah, the 'helpful' diffstat.  It downloads blobs from a promisor remote
> just so we can see what has changed, including in the area of the
> project we don't care about.
>
> (This is yet another reason it'd be nice to have a --restrict mode for
> grep/diff/log/etc. for sparse-checkout uses, and an ability to make it
> the default in some repo, so you could get just the diffstat within
> the region of the project that you care about.  We're discussing such
> an idea, but it isn't implemented yet.)
>
> > warning: This repository uses promisor remotes. Some objects may not be=
 loaded.
> > blob_count1=3D11
> > blob_count2=3D11
> > blob_count3=3D12
> >
> > The result shows that blob count doesn't change in git fetch, but in gi=
t merge.
>
> If you add --no-stat to your merge command (or set merge.stat to
> false), the extra blob will not be downloaded.

After config merge.stat to false, the problem is solved. Thanks a lot!

ZheNing Hu
