Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223C8C433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 01:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbiDGBd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 21:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242170AbiDGBcI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 21:32:08 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679EAE43A7
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 18:29:47 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id bo5so4109202pfb.4
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 18:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QCgNJh5WUslxv75r47UpdqIwffxbzP9i34jkfoHDfyE=;
        b=pa128ibOalL0s3Fdva/e12bURgZsEdnETcDq81nY5BuaaWjlBSBYoy6bWed+KRhMnf
         RLVpCxp/i/KU0rjn2DKgF4UaImLD0wLI2eNzUTZ669VvbNT+gJPWG69KFQ1EwnzIRgpZ
         8HXLyxKrirB82iMiRcsJGnNgCuRC6DEVCwUBeZNZyTHYCBvN1Z4x2hbFNF1khnxzdw1D
         DfCL3YDEiBIw8J+xcbIoDu2jtaArKxI93pup82buTFXYyIuoI2Txs52A5bZAzrS2KagO
         AXNtNH/fEJMub6WypG4uvlYS1LC1NS7pN/KPOG2G7iPut1xyhIn1aonrln85Grn63oD5
         zsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QCgNJh5WUslxv75r47UpdqIwffxbzP9i34jkfoHDfyE=;
        b=dUnw3KInDdTqJoNTZYm3EeerqX30OP3thLrhjVW1pEbPQKiAOynGgijljJlNLPkDA2
         IenRj2Kb4ofc5zISE2A/KKMpHX4L2/f1nwAhE7aX2CuIHe6AWgIXptq+wAqbXDPGWYPW
         cLrzhQFxGHX7qNZTWpCaNVQ8tSQun28w3okTaCqimFBaMRl5Pp+M11dHYzfUEGGM5dRS
         n2tOkmBZt//IzARbyz4AyJd+Ec7b2NFGY8hPf637ZNMg4UR1sTNcQSSK1A21pd9s7xSY
         7B+/zY1E6i/Hk0B0epVBZ5/NPjsujrZf6hey1X2cSi8/g9NLEkZrHLNYEZtEpq5WnFjG
         b+HA==
X-Gm-Message-State: AOAM5332SI3FkqyGIJ2TzStWWdlDH5r36gmSzYzhzjKVRcL59qlnsRq5
        0AefIsakwGKVZIMjqVlnQn78+MgZhVfPVocs/KAdeONUZtCC6Q==
X-Google-Smtp-Source: ABdhPJyy9GLeemyrTr94Jc3kcaBQo8bzfgAKQGRDhgv5id1MU7PiH0OraiX5fA5qkoqpODANvRpXyLZuGNk9XbUMaKU=
X-Received: by 2002:a63:2c8e:0:b0:386:4801:ce3b with SMTP id
 s136-20020a632c8e000000b003864801ce3bmr9055160pgs.185.1649294986375; Wed, 06
 Apr 2022 18:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAGyf7-FjqrGYTUwdS=a6nsUnbn0qD9=Pf2Nx=gy6g8KGVRJivw@mail.gmail.com>
In-Reply-To: <CAGyf7-FjqrGYTUwdS=a6nsUnbn0qD9=Pf2Nx=gy6g8KGVRJivw@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 6 Apr 2022 18:29:35 -0700
Message-ID: <CAGyf7-FiAjQGh8vo-oA6j8SH4se2rpU4_09dzUgxmE7Ohy72Kw@mail.gmail.com>
Subject: Re: Git 2.36, ls-tree submodule regression?
To:     Git Users <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        dyroneteng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 6, 2022 at 5:34 PM Bryan Turner <bturner@atlassian.com> wrote:
>
> In the test suite for Bitbucket Server, we have a test repository[1]
> which has a commit that has a .gitmodules file that lists 3
> submodules, each of which has an entry in the tree with "Subproject
> commit <SHA>".
>
> The submodules aren't fetched (at least one of them doesn't actually
> exist anywhere to fetch), but running git ls-tree in Git 2.35.1 and
> prior shows the expected tree data:
>
> $ git ls-tree -r -l ecf42d8adc4d7eb4386e37882d053704067712d4: --
> 100644 blob c0de405f50ea72f9d2b973dd504671ba63ea7189     346 .gitmodules
> 100644 blob 493021b1c9e0ecfebcd5ebce646a44138bc60b39      20
> add_file/add_file.txt
> 100644 blob d8c00a7fe6eb6a00378e103a46e3c472c084a949      25
> basic_branching/file.txt
> 100644 blob 927b01c060cf0dc5036e19abeab8e332d9075ea0     167 binary/B.zip
> 100644 blob 72555d02a139700be930a6734b57c5fab84512b9     167 binary/C.zip
> 100644 blob 72555d02a139700be930a6734b57c5fab84512b9     167 binary/D.zip
> 100644 blob 668076c308990933c2df66efb87b946704252486      46
> branch_mod_merge/file.txt
> 100644 blob b1d99e581f0bb8138b8997f9268294e41faee05b      33
> modification/mod_file.txt
> 100644 blob 46fa903c8af8a92c2714a47ae5a341a99c2ee3b2      18 moved_dir/fi=
le.txt
> 100644 blob f49abb7d6c366e6f83470e36439bc162234d7963      24
> mv_file/moved_file.txt
> 100644 blob 2e6b03cbbe90d3c9afcfc98967a5a71b4c9cff1a      66
> out_of_order/file.txt
> 160000 commit 0ac826865ce7e8bc76022d49424f52e09b16dc87       -
> submodule/atlassian-refapp
> 160000 commit 92b18c97d9d92d2bd02cfd1d268f22fddddafb67       -
> submodule/bamboo-git-plugin
> 160000 commit 996b4f5a7e242a29fe573582d98f5174142bb97c       - submodule/=
stash
> 120000 blob 4cbb553f3f4ac2ee7b01ff6c951d6bf583c39c15      10 symlink/link=
.txt
> 100644 blob 57a3592bb2cf8e76e2faef7660945a2fe0e24360      27 symlink/targ=
et.txt
>
> The same ls-tree command in 2.36.0-rc0 fails:
>
> $ /opt/git/2.36.0-rc0/bin/git ls-tree -r -l
> ecf42d8adc4d7eb4386e37882d053704067712d4: --
> 100644 blob c0de405f50ea72f9d2b973dd504671ba63ea7189     346 .gitmodules
> 100644 blob 493021b1c9e0ecfebcd5ebce646a44138bc60b39      20
> add_file/add_file.txt
> 100644 blob d8c00a7fe6eb6a00378e103a46e3c472c084a949      25
> basic_branching/file.txt
> 100644 blob 927b01c060cf0dc5036e19abeab8e332d9075ea0     167 binary/B.zip
> 100644 blob 72555d02a139700be930a6734b57c5fab84512b9     167 binary/C.zip
> 100644 blob 72555d02a139700be930a6734b57c5fab84512b9     167 binary/D.zip
> 100644 blob 668076c308990933c2df66efb87b946704252486      46
> branch_mod_merge/file.txt
> 100644 blob b1d99e581f0bb8138b8997f9268294e41faee05b      33
> modification/mod_file.txt
> 100644 blob 46fa903c8af8a92c2714a47ae5a341a99c2ee3b2      18 moved_dir/fi=
le.txt
> 100644 blob f49abb7d6c366e6f83470e36439bc162234d7963      24
> mv_file/moved_file.txt
> 100644 blob 2e6b03cbbe90d3c9afcfc98967a5a71b4c9cff1a      66
> out_of_order/file.txt
> 160000 commit 0ac826865ce7e8bc76022d49424f52e09b16dc87       -
> submodule/atlassian-refapp
> error: Could not read 0ac826865ce7e8bc76022d49424f52e09b16dc87
> fatal: Invalid commit 0ac826865ce7e8bc76022d49424f52e09b16dc87 in
> submodule path submodule/atlassian-refapp
>
> Bisecting the error selects:
>
> $ git bisect good
> 9c4d58ff2c385f49585197c8650356955e1fa02e is the first bad commit
> commit 9c4d58ff2c385f49585197c8650356955e1fa02e
> Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Date:   Wed Mar 23 17:13:15 2022 +0800
>
>     ls-tree: split up "fast path" callbacks
>
>     Make the various if/else in the callbacks for the "fast path" a lot
>     easier to read by just using common functions for the parts that are
>     common, and have per-format callbacks for those parts that are
>     different.
>
>     Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
>     Signed-off-by: Teng Long <dyroneteng@gmail.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
>  builtin/ls-tree.c | 199 ++++++++++++++++++++++++++++++++++--------------=
------
>  1 file changed, 125 insertions(+), 74 deletions(-)
>
> (I've CC'd =C3=86var and Teng on this message.)

Actually, it looks like =C3=86var might already have a fix up for it in
[2]. I'll see if I can apply that patch locally and verify it.

Best regards,
Bryan Turner

[2] https://lore.kernel.org/git/patch-v2-1.1-ed83b3b74ab-20220404T234507Z-a=
varab@gmail.com/
