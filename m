Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C029ACCA47A
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 04:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356753AbiFVE6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 00:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiFVE5x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 00:57:53 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A8D1A7
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 21:57:51 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ay16so12309991ejb.6
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 21:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kcuslFxqmg2FNuHZjRdFnpm1dZKelvnP0Hm/8KiAqiM=;
        b=argPKik5mXvLPQ7/iyMIk8kTCINGTxeHZJOMTx5WGBBN4+KCj2XBgDb4ut5rGvFufy
         rKg0dWz+g+C8CZG3fJoFNr8W3jMGm8AbFzq5Ug7C78PoJc1wezQ7Q9XOUoxqZ6supi8l
         v0JkbbugIU+bwXO4m0hfICjI31pp+CqePmn0bwYJ/Y0EWuG3xNGv6X8xoJU0nKaAgeZu
         m//1QASdN63TjJhVjZ8JK81wHDjqvSqDGyuYl05IeR1rydgIjdErypdyeTatxXhFPTXf
         4VKz6hqa8vPhc5xj+9bgRzYsT+Mub9K4gAql29RMXiHOmpK4lcP0H9Z74D/RCBEChmF4
         +2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kcuslFxqmg2FNuHZjRdFnpm1dZKelvnP0Hm/8KiAqiM=;
        b=DPvZAATO15sV/du+UCPJlk3/EKkNnQTTSWjkL52+4E1i+Z/eXJCjZJgWTyRf44eS0/
         fi59sapw8uu21ONqDB1RH76q0S73Z2dWO/djq12C17XM24OO74KsREuG31vS++khmPM/
         PoeRRoaGheCruLFYfMHs7F7Vi5yOnDYdo9G0I4TFnsekAHRe0DTODvyK9zqnbTumTJUv
         7+KPXdBQIUFTLvSXTXzcZqbD9xApVQawA8mSsRai9IjPnX7/82Y+A7U9TES5wLfosynt
         7E1jsIB6XonKOQBU3sQT/nTV4EkISZBdTXyHI5nKPE8YS/6Kn9HfXwFw/Ni1OOh3mWE3
         WUKA==
X-Gm-Message-State: AJIora/FROgEhVVZaJkGF8BbwLL894vEBOhybY6kexbnsCdQE2xsHov7
        4/lik4WaxTPDSc5682NPY3Wlu9jHQ6dPyDj6FuM=
X-Google-Smtp-Source: AGRyM1u12sa3PEtPsG3J2GrBTg7eSMP7ZFINqbmQl34KuIjyYFS9I6aDPzjfkBI1Jpt26xCSvsIDT2atyxPvppM1eCE=
X-Received: by 2002:a17:907:9715:b0:711:ca06:ca50 with SMTP id
 jg21-20020a170907971500b00711ca06ca50mr1371193ejc.192.1655873869995; Tue, 21
 Jun 2022 21:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220505203234.21586-1-ggossdev@gmail.com> <DM6PR13MB29876A53962557131120EF619DAC9@DM6PR13MB2987.namprd13.prod.outlook.com>
In-Reply-To: <DM6PR13MB29876A53962557131120EF619DAC9@DM6PR13MB2987.namprd13.prod.outlook.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 21 Jun 2022 21:57:38 -0700
Message-ID: <CABPp-BExinbGArOQQTkyPWz-KhJL7T6D0fsvP88quv-TM=zF3A@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] dir: traverse into repository
To:     Goss Geppert <gg.oss@outlook.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        christian w <usebees@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 16, 2022 at 4:20 PM Goss Geppert <gg.oss@outlook.com> wrote:
>
> From: Goss Geppert <ggossdev@gmail.com>
>
> This latest version of the patch series contains relatively minor
> modifications relative to the previous version.  Let me know if there
> is anything else I need to do.
>
> Changes compared to v3:
> * remove the commit that caches the gitdir's realpath as this was deemed
>   a premature optimization given the amount of code churn
> * use git option `-C` in some of the testcases to avoid creating a
>   subshell
>
> Goss Geppert (2):
>   dir: traverse into repository
>   dir: minor refactoring / clean-up
>
>  dir.c                          |  35 ++++-
>  t/t2205-add-worktree-config.sh | 265 +++++++++++++++++++++++++++++++++
>  2 files changed, 293 insertions(+), 7 deletions(-)
>  create mode 100755 t/t2205-add-worktree-config.sh
>
> Range-diff against v3:
> 1:  0fc8886f1e ! 1:  f84cefe731 dir: traverse into repository
>     @@ t/t2205-add-worktree-config.sh (new)
>      +  (
>      +  cd test1 &&
>      +  local parent_dir="$(pwd)" &&
>     -+  (
>     -+          cd repo &&
>     -+          git ls-files -o --exclude-standard "$parent_dir" >../actual-all-unsorted
>     -+  ) &&
>     ++  git -C repo ls-files -o --exclude-standard "$parent_dir" >actual-all-unsorted &&
>      +  sort actual-all-unsorted >actual-all &&
>      +  sort expect-all-unsorted >expect-all &&
>      +  test_cmp expect-all actual-all
>     @@ t/t2205-add-worktree-config.sh (new)
>      +  (
>      +  cd test1 &&
>      +  local parent_dir="$(pwd)" &&
>     -+  (
>     -+          cd repo &&
>     -+          git ls-files -o --directory --exclude-standard "$parent_dir" >../actual-all-dir-unsorted
>     -+  ) &&
>     ++  git -C repo ls-files -o --directory --exclude-standard "$parent_dir" >actual-all-dir-unsorted &&
>      +  sort actual-all-dir-unsorted >actual-all &&
>      +  sort expect-all-dir-unsorted >expect-all &&
>      +  test_cmp expect-all actual-all
>     @@ t/t2205-add-worktree-config.sh (new)
>      +  (
>      +  cd test1 &&
>      +  local parent_dir="$(pwd)" &&
>     -+  (
>     -+          cd repo &&
>     -+          git ls-files -o --exclude-standard "$parent_dir" >../actual-untracked-unsorted
>     -+  ) &&
>     ++  git -C repo ls-files -o --exclude-standard "$parent_dir" >actual-untracked-unsorted &&
>      +  sort actual-untracked-unsorted >actual-untracked &&
>      +  sort expect-untracked-unsorted >expect-untracked &&
>      +  test_cmp expect-untracked actual-untracked
> 2:  a80cbd5517 < -:  ---------- dir: cache git_dir's realpath
> 3:  899c69300c = 2:  d4ff1bd40a dir: minor refactoring / clean-up

Thanks, this version looks good to me.

Reviewed-by: Elijah Newren <newren@gmail.com>
