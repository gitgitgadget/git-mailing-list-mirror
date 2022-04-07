Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E3AC433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 01:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbiDGBpQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 21:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbiDGBoh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 21:44:37 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE8611984A
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 18:41:35 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 7so4084106pfu.13
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 18:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m3DyLcU+LWKCCkn5PNKaTjSN//jMyiu09/C3K0w5sPI=;
        b=IP2wuQca82pa+Myj0WDZpnP1lxX3ZNh1LkSSGiVlXLzLSwKz6q8iisgkq7AMv34J0D
         b8i12TPyIzE9htoSy+hZnMGs9zLVNnEBczS+1uZZ5sUXLHgvSt2y2ed/0oBSq4aj8aip
         ZpIR+7+Dhl1Z5HdQnGP3b0z0lIZfv+9iutr8Cp8XeUGvLs+yxvh59JC0h50p3av+P/C+
         Xa8visXK4HbW1yXCiTFSzXYZCuMBFfSeQiQkw/fWKC7A1/gBwFaJwD4YY9Fgkkp2amSK
         71BcLLUKTYPEPTCLFGB8zUrlx0KtyBstw7Tc0qQysJsDrJPA2PPm0ANtYlZ0eg0CCTfF
         fR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m3DyLcU+LWKCCkn5PNKaTjSN//jMyiu09/C3K0w5sPI=;
        b=voyViW4exC8HdLuAGEL/PQJzBKh56jLYoAdn18LBViAuNMvdMfHYtawmeSSaNEvnmp
         QJ6cXHeYyVvfL0b7rDa26WOXBX35fvsiIpVRfW1QNdbbpGEKoB6Ye3icYrg069oRmwna
         kUG9RI2w5v3YCD3MCCi+9z7D/1ryG1jACzUBYzOEKtscmVwy/Be30i/jhTcfanowMQqg
         tz+Y2Up011nDLYqjS8bYu4ki9SV/eZxcH6Cv3HJg0zHSz4yZUV5Sze6xQenCxbP/jbme
         NkseC+j+47nZenwUK6PwrlkXIB1VEl9gO+VZKPk0YujPoF1LQfivKU1d02IRCdmvXSdd
         9ZMA==
X-Gm-Message-State: AOAM5325ufd8oP917+Fs1SXIDE8sBlvOEOTXQj7PRY3GnSFg/QxycfF5
        WGL6AXuy2jieAginzpH78BfrQbEjhMwOGwU9E7judtrD6G8=
X-Google-Smtp-Source: ABdhPJwXjkJHupjAD9YfFyQcyWnOuEk5KmloF2zIAh7Bz6uWt1mXympn2WwStE2TtjYTrIZegXFs0YhVHSrH27Zquxw=
X-Received: by 2002:aa7:92c8:0:b0:4fd:c1aa:3e11 with SMTP id
 k8-20020aa792c8000000b004fdc1aa3e11mr11961828pfa.29.1649295694553; Wed, 06
 Apr 2022 18:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAGyf7-FjqrGYTUwdS=a6nsUnbn0qD9=Pf2Nx=gy6g8KGVRJivw@mail.gmail.com>
 <CAGyf7-FiAjQGh8vo-oA6j8SH4se2rpU4_09dzUgxmE7Ohy72Kw@mail.gmail.com>
In-Reply-To: <CAGyf7-FiAjQGh8vo-oA6j8SH4se2rpU4_09dzUgxmE7Ohy72Kw@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 6 Apr 2022 18:41:23 -0700
Message-ID: <CAGyf7-EoJzN0ECuhXFDbmKGvN2dKUEJRq7vR=AnOfOcp5kFXow@mail.gmail.com>
Subject: Re: Git 2.36, ls-tree submodule regression?
To:     Git Users <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        dyroneteng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 6, 2022 at 6:29 PM Bryan Turner <bturner@atlassian.com> wrote:
>
> On Wed, Apr 6, 2022 at 5:34 PM Bryan Turner <bturner@atlassian.com> wrote=
:
> >
> > In the test suite for Bitbucket Server, we have a test repository[1]
> > which has a commit that has a .gitmodules file that lists 3
> > submodules, each of which has an entry in the tree with "Subproject
> > commit <SHA>".
> >
> > The submodules aren't fetched (at least one of them doesn't actually
> > exist anywhere to fetch), but running git ls-tree in Git 2.35.1 and
> > prior shows the expected tree data:
> >
> > $ git ls-tree -r -l ecf42d8adc4d7eb4386e37882d053704067712d4: --
> > 100644 blob c0de405f50ea72f9d2b973dd504671ba63ea7189     346 .gitmodule=
s
> > 100644 blob 493021b1c9e0ecfebcd5ebce646a44138bc60b39      20
> > add_file/add_file.txt
> > 100644 blob d8c00a7fe6eb6a00378e103a46e3c472c084a949      25
> > basic_branching/file.txt
> > 100644 blob 927b01c060cf0dc5036e19abeab8e332d9075ea0     167 binary/B.z=
ip
> > 100644 blob 72555d02a139700be930a6734b57c5fab84512b9     167 binary/C.z=
ip
> > 100644 blob 72555d02a139700be930a6734b57c5fab84512b9     167 binary/D.z=
ip
> > 100644 blob 668076c308990933c2df66efb87b946704252486      46
> > branch_mod_merge/file.txt
> > 100644 blob b1d99e581f0bb8138b8997f9268294e41faee05b      33
> > modification/mod_file.txt
> > 100644 blob 46fa903c8af8a92c2714a47ae5a341a99c2ee3b2      18 moved_dir/=
file.txt
> > 100644 blob f49abb7d6c366e6f83470e36439bc162234d7963      24
> > mv_file/moved_file.txt
> > 100644 blob 2e6b03cbbe90d3c9afcfc98967a5a71b4c9cff1a      66
> > out_of_order/file.txt
> > 160000 commit 0ac826865ce7e8bc76022d49424f52e09b16dc87       -
> > submodule/atlassian-refapp
> > 160000 commit 92b18c97d9d92d2bd02cfd1d268f22fddddafb67       -
> > submodule/bamboo-git-plugin
> > 160000 commit 996b4f5a7e242a29fe573582d98f5174142bb97c       - submodul=
e/stash
> > 120000 blob 4cbb553f3f4ac2ee7b01ff6c951d6bf583c39c15      10 symlink/li=
nk.txt
> > 100644 blob 57a3592bb2cf8e76e2faef7660945a2fe0e24360      27 symlink/ta=
rget.txt
> >
> > The same ls-tree command in 2.36.0-rc0 fails:
> >
> > $ /opt/git/2.36.0-rc0/bin/git ls-tree -r -l
> > ecf42d8adc4d7eb4386e37882d053704067712d4: --
> > 100644 blob c0de405f50ea72f9d2b973dd504671ba63ea7189     346 .gitmodule=
s
> > 100644 blob 493021b1c9e0ecfebcd5ebce646a44138bc60b39      20
> > add_file/add_file.txt
> > 100644 blob d8c00a7fe6eb6a00378e103a46e3c472c084a949      25
> > basic_branching/file.txt
> > 100644 blob 927b01c060cf0dc5036e19abeab8e332d9075ea0     167 binary/B.z=
ip
> > 100644 blob 72555d02a139700be930a6734b57c5fab84512b9     167 binary/C.z=
ip
> > 100644 blob 72555d02a139700be930a6734b57c5fab84512b9     167 binary/D.z=
ip
> > 100644 blob 668076c308990933c2df66efb87b946704252486      46
> > branch_mod_merge/file.txt
> > 100644 blob b1d99e581f0bb8138b8997f9268294e41faee05b      33
> > modification/mod_file.txt
> > 100644 blob 46fa903c8af8a92c2714a47ae5a341a99c2ee3b2      18 moved_dir/=
file.txt
> > 100644 blob f49abb7d6c366e6f83470e36439bc162234d7963      24
> > mv_file/moved_file.txt
> > 100644 blob 2e6b03cbbe90d3c9afcfc98967a5a71b4c9cff1a      66
> > out_of_order/file.txt
> > 160000 commit 0ac826865ce7e8bc76022d49424f52e09b16dc87       -
> > submodule/atlassian-refapp
> > error: Could not read 0ac826865ce7e8bc76022d49424f52e09b16dc87
> > fatal: Invalid commit 0ac826865ce7e8bc76022d49424f52e09b16dc87 in
> > submodule path submodule/atlassian-refapp
> >
> > Bisecting the error selects:
> >
> > $ git bisect good
> > 9c4d58ff2c385f49585197c8650356955e1fa02e is the first bad commit
> > commit 9c4d58ff2c385f49585197c8650356955e1fa02e
> > Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> > Date:   Wed Mar 23 17:13:15 2022 +0800
> >
> >     ls-tree: split up "fast path" callbacks
> >
> >     Make the various if/else in the callbacks for the "fast path" a lot
> >     easier to read by just using common functions for the parts that ar=
e
> >     common, and have per-format callbacks for those parts that are
> >     different.
> >
> >     Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
.com>
> >     Signed-off-by: Teng Long <dyroneteng@gmail.com>
> >     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >
> >  builtin/ls-tree.c | 199 ++++++++++++++++++++++++++++++++++------------=
--------
> >  1 file changed, 125 insertions(+), 74 deletions(-)
> >
> > (I've CC'd =C3=86var and Teng on this message.)
>
> Actually, it looks like =C3=86var might already have a fix up for it in
> [2]. I'll see if I can apply that patch locally and verify it.

Confirmed that what's currently in "next" (which I believe will become
2.36.0-rc1 at some point?) does not manifest this issue.

Thanks for the fix--posted before I could even ask for it--and sorry
for the noise.

Best regards,
Bryan Turner
