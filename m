Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F64C54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 16:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiIGQBt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 12:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiIGQAw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 12:00:52 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAFB303DC
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 09:00:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so882202wmk.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 09:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=v6JSphU54ZfAwvweQc/5y3dxamwewZzTAXtXIHX6w4w=;
        b=B2WEocXsZGc7dR9b4Xe5rnxuYnnua8PmCnGUmKi6nLiD5XMeCBiguLm+yfH5sZXewk
         cD/JiRj/EVuItirxROYIQ62Z2S7MsBO8AeeymEXDqXf9SuDa9uQoiWJN9DtC4xw1v/VY
         uRA5NZVbhebBe4+IfifZeQp82r5eVup89NHDsWQAKz5wW8cif0Ha+wslEO8zqcYTpcHg
         rg9bgwNb2yKuBaGx4KMMBvIXt50riZQX52GaVEzKx+JYml07PK7FLnUWJdPc8PjSlqwY
         7xQ1/jBjrTJIB3hznsBEhPkrmTCfDXiB2U42Mie+nT/rdC4ntjvsAYAiABJhQJ5SgCAR
         ryOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=v6JSphU54ZfAwvweQc/5y3dxamwewZzTAXtXIHX6w4w=;
        b=qIQECKAzqYvOftRP1+xM6tipSo0Ml1tJuZBI9cA7H//HsTqqsuOcASj7uNM2GRVRDT
         6J/lB3kbqfhRXpWc8mwR6+PGwEZY9cRtwPO3nR+yYa3+kzsSTRkAY77q82jAQGs0BJ7t
         ePwNFSHqVG4bHObt33bhXFBJvQJkdaB92pMWaTaBc5ln1MUXMcamyHDJI2ETBOsKChO6
         1vVX+PLpEombsLzCLpfLqOpgB919bd+vHcAm6uDSyhr7GPDytJo75fPmTGCsBm+OgkgF
         PjMYKK34I+g+Fe2kP5kfByLch4r7ihvYrOk+iZVfPrHYRu0ZjPc6yVKwG1aPp0AmknzK
         DFSQ==
X-Gm-Message-State: ACgBeo2fkl6Ao7buXm95uukJBckWLiLqSFu+0SOzZZ862zgjEU7ZmSdp
        zg+IM/yzcnFZFnBe2o7PIte0H/24rbP+sZ+04GXFuNuWFFY=
X-Google-Smtp-Source: AA6agR63w7+Ox2NQdqm1AQaIQvgvUfMNSoEoTJvHnBA4z98LKD2nX6kcnkEy/FahckZTXCHtL3oVS0goY4oUaFwbzx8=
X-Received: by 2002:a1c:241:0:b0:3a6:655c:391b with SMTP id
 62-20020a1c0241000000b003a6655c391bmr17028199wmc.67.1662566411475; Wed, 07
 Sep 2022 09:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
 <YxJkn7K3zRm1u3Vn@tapette.crustytoothpaste.net> <CA+4x=b_KP4rMH-EDmVCD_4LHPiLx32J2OJC6Mm5xpQ-QUcSKuA@mail.gmail.com>
 <s46p34qn-rq84-20q6-nr36-594sos6q5qq9@tzk.qr>
In-Reply-To: <s46p34qn-rq84-20q6-nr36-594sos6q5qq9@tzk.qr>
From:   Lana Deere <lana.deere@gmail.com>
Date:   Wed, 7 Sep 2022 11:59:35 -0400
Message-ID: <CA+4x=b8q0hjdT2ZtaPfLqvGjS72veWhiuWwZK6b1rsVEHoAOwA@mail.gmail.com>
Subject: Re: 2.37.2 can't "git pull" but 2.18.0 can
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As you guessed, the only line is "not-for-merge".

$ cat .git/FETCH_HEAD
4a537c911d9b90f002b682badf9a9121f62622d7        not-for-merge   branch
'master' of http://githost:7990/scm/dp/sw

What does that mean?

.. Lana (lana.deere@gmail.com)


On Wed, Sep 7, 2022 at 8:59 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Lana,
>
> as per usual, replies inline.
>
> On Tue, 6 Sep 2022, Lana Deere wrote:
>
> > The 'git ls-remote origin' command on both produces about 3600 lines
> > of output which appears to consist of all the branches in our repo.
> > The two outputs are identical according to diff.  Both include a
> > single mention of the switch-to-qt5 branch,
> >
> > $ diff /tmp/ls-remote*
> > [no output here]
> > $ grep switch-to-qt5 /tmp/ls-remote.*
> > /tmp/ls-remote.2.18:6a9363081d05c313ba6a6ac59183193f1340bb1f
> > refs/heads/feature/switch-to-qt5
> > /tmp/ls-remote.2.37:6a9363081d05c313ba6a6ac59183193f1340bb1f
> > refs/heads/feature/switch-to-qt5
> >
> > The 'git config -l' from both versions is almost the same - two lines
> > have moved around.
> > $ diff /tmp/config*
> > 1,2d0
> > < filter.lfs.required=true
> > < filter.lfs.clean=git-lfs clean -- %f
> > 4a3,4
> > > filter.lfs.required=true
> > > filter.lfs.clean=git-lfs clean -- %f
> >
> > $ cat /tmp/config.2.37
> > filter.lfs.smudge=git-lfs smudge -- %f
> > filter.lfs.process=git-lfs filter-process
> > filter.lfs.required=true
> > filter.lfs.clean=git-lfs clean -- %f
> > user.name=Lana Deere
> > user.email=lana.deere@gmail.com
> > filter.lfs.clean=git-lfs clean -- %f
> > filter.lfs.smudge=git-lfs smudge -- %f
> > filter.lfs.process=git-lfs filter-process
> > filter.lfs.required=true
> > color.branch=false
> > color.diff=false
> > color.grep=false
> > color.interactive=false
> > color.pager=false
> > color.showbranch=false
> > color.status=false
> > color.ui=false
> > core.repositoryformatversion=0
> > core.filemode=true
> > core.bare=false
> > core.logallrefupdates=true
> > remote.origin.url=http://lana@githost:7990/scm/dp/sw.git
> > remote.origin.fetch=+refs/heads/master:refs/remotes/origin/master
>
> At first I thought that this would be the root cause:
> `feature/switch-to-qt5` is not included in the refs to fetch.
>
> But then I added a test case for that specific scenario:
>
> -- snip --
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 081808009b2..6e6ddeb7e63 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -218,6 +218,17 @@ test_expect_success 'fail if upstream branch does not exist' '
>         test_cmp expect file
>  '
>
> +test_expect_success 'fetch upstream branch even if refspec excludes it' '
> +       git branch tirili &&
> +       git branch tirili2 &&
> +       git init -b tirili downstream &&
> +       git -C downstream remote add -t tirili origin "file://$(pwd)/.git" &&
> +       git -C downstream config branch.tirili.remote origin &&
> +       git -C downstream config branch.tirili.merge refs/heads/tirili2 &&
> +       git -C downstream pull 2>err &&
> +       ! grep "configuration specifies to merge" err
> +'
> +
>  test_expect_success 'fail if the index has unresolved entries' '
>         git checkout -b third second^ &&
>         test_when_finished "git checkout -f copy && git branch -D third" &&
>
> -- snap --
>
> And that test case passes!
>
> The reason is that we specifically add the ref that needs to be merged to
> the list of refs to be fetched:
> https://github.com/git/git/blob/v2.37.2/builtin/fetch.c#L605-L614
>
> Now, clearly it is not quite working as intended in your scenario. The
> message you pasted is produced by the code in
> https://github.com/git/git/blob/v2.37.2/builtin/pull.c#L421-L494, which is
> only entered if there are no entries in `.git/FETCH_HEAD` except
> `not-for-merge` ones.
>
> Lana, would you mind pasting the contents of `.git/FETCH_HEAD` just after
> a failed `git pull`?
>
> Ciao,
> Johannes
>
> > branch.master.remote=origin
> > branch.master.merge=refs/heads/master
> > branch.feature/switch-to-qt5.remote=origin
> > branch.feature/switch-to-qt5.merge=refs/heads/feature/switch-to-qt5
> >
> >
> > .. Lana (lana.deere@gmail.com)
> >
> > On Fri, Sep 2, 2022 at 4:16 PM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > >
> > > On 2022-09-02 at 19:27:55, Lana Deere wrote:
> > > > I'm testing an upgrade to git 2.37.2 from the current version we're
> > > > using of 2.18.0.  When I try to pull in my development tree, 2.37.2
> > > > gives me an error but 2.18.0 things all is fine:
> > > >
> > > > $ /tools/linux-x86_64/git/2.37.2/bin/git pull
> > > > Your configuration specifies to merge with the ref
> > > > 'refs/heads/feature/switch-to-qt5'
> > > > from the remote, but no such ref was fetched.
> > > >
> > > > $ /tools/linux-x86_64/git/2.18.0/bin/git pull
> > > > From http://githost:7990/scm/dp/sw
> > > >  * branch                  feature/switch-to-qt5 -> FETCH_HEAD
> > > > Already up to date.
> > > >
> > > > Anyone have any ideas about this?  All I could find on google was a
> > > > suggestion that the "no such ref" message indicates the remote branch
> > > > was deleted, but that's not the case here.
> > >
> > > Can you provide the output of `git ls-remote origin` (assuming that's
> > > the remote you're using) and `git config -l` (the latter with both
> > > versions)?  I don't know of any reason why Git 2.37 should be broken in
> > > this regard, but I suspect that there's a difference in configuration
> > > between the two leading to this.
> > > --
> > > brian m. carlson (he/him or they/them)
> > > Toronto, Ontario, CA
> >
