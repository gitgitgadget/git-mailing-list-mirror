Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0B6C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 13:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiKHNxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 08:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbiKHNxd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 08:53:33 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEDBBC3B
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 05:53:19 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id o8so10249203qvw.5
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 05:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtiNQiIF3gnxZFXT1JgX1YMMLIVU1gVE8woTQ2Jzcn4=;
        b=dFRS4vABC8cpQUNZA1HZ8JJFsLLuK4M8BrXTit4fJ4EyAol/cU/88oN4B/xITaejjG
         mxeMnbnQdNzFd+ptXBx8fEXEtDuUzs/jsjA68x64Arv02q3ObXuRuTxxhqHGal8ydiIm
         PyvjRJvC6oLOYHn/xo0WBrY54tJkg3DFP33XEXqH7yRLIMD8Ej5NYsiqF2UOLj7RGGZg
         XYs9IAjU9XV//qT0a2VSUzUO+3iuUJ/k2Zms0PbZfpQnFGQDSLHTlS/jm147NGmUTXAZ
         bcp0TxmdXT0+OcP9Y0E6nkXp/rffKcDpSUI+DcGYXac0sfSRjqbVkhIggw6Cz+gHEFaZ
         gkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtiNQiIF3gnxZFXT1JgX1YMMLIVU1gVE8woTQ2Jzcn4=;
        b=JFuk0WHcsGT2e0O5B8/u6y+ipikoPiFvBeReoLhyyAK6MO5oD+V8PhFwr3Rbq8oXwC
         oqTj5rpLtgEjkChpj6l6iAXrf+/z5ppNcBWYbfd7WnCv/hgKEx6+3OExX3hgqkkZ26uI
         LLYE9v1WEuZUU5kkijpdosISY/u7E+tONI4a4CSsKUvosw/TQ8Xi8I78tJVR0+sTRWxw
         CQzthj79cxUYSs7k33um159VmdXV2gmsp4DRZGigpB5LSnAdKQUKlQ35NCYAKrXgP6pz
         wR70UIArBdYk12MPX9y3kDnRkr0+KyMVgz6lbQXlYTZHEXIAM5jew5eXImctC3n7LMVB
         FZBQ==
X-Gm-Message-State: ACrzQf0GWULUkVRaQRt0lu5W6RLlo0XHzY3WHA5E53Uvv34obl+wioSq
        BPzDFKJ6xISTrI0V7Hs7e50=
X-Google-Smtp-Source: AMsMyM5XEuK+Ohz9m3zn1Bp19oznPxes/Py1xhZAf+j6RiPrfJ3xhi5yraQOCPG2b3DcmMb9P9Te2A==
X-Received: by 2002:a05:6214:242a:b0:4b9:98bf:92d2 with SMTP id gy10-20020a056214242a00b004b998bf92d2mr49885083qvb.89.1667915599015;
        Tue, 08 Nov 2022 05:53:19 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id i18-20020a05620a405200b006cf8fc6e922sm9396664qko.119.2022.11.08.05.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 05:53:18 -0800 (PST)
Subject: Re: [PATCH v3 8/8] clone, submodule update: create and check out
 branches
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>
References: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
 <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
 <7cdd6c4184da2d3109498589167f10ecf972edc9.1666988096.git.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <e6949ea0-8053-3487-81bb-6fe50fd34814@gmail.com>
Date:   Tue, 8 Nov 2022 08:53:17 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <7cdd6c4184da2d3109498589167f10ecf972edc9.1666988096.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,

Le 2022-10-28 à 16:14, Glen Choo via GitGitGadget a écrit :
> From: Glen Choo <chooglen@google.com>
> 
> Teach "git submodule update" to:
> 
> - create the branch with the same name as the current superproject
>   branch when cloning a submodule
> - check out that branch (instead of the commit OID) when updating
>   the submodule worktree
> 
> when submodule branching is enabled (submodule.propagateBranches = true)
> on the superproject and a branch is checked out. "git clone
> --recurse-submodules" also learns this trick because it is implemented
> with "git submodule update --recursive".
> 
> This approach of checking out the branch will not result in a dirty
> worktree for freshly cloned submodules because we can ensure that the
> submodule branch points to the superproject gitlink. In other cases, it
> does not work as well, but we can handle them incrementally:
> 
> - "git pull --recurse-submodules" merges the superproject tree,
>   (changing the gitlink without updating the submodule branches), and
>   runs "git submodule update" to update the worktrees, so it is almost
>   guaranteed to result in a dirty worktree.

OK, here you mean that 'git -c submodule.propagateBranches=true submodule update'
would just checkout the submodule branch (or do nothing if it's already checked out),
but that branch would most likely not be up to date with the newly updated gitlink
in the superproject, resulting in a dirty worktree.

> 
>   The implementation of "git pull --recurse-submodules" is likely to
>   change drastically as submodule.propagateBranches work progresses
>   (e.g. "git merge" learns to recurse in to submodules), and we may be
>   able to replace the "git submodule update" invocation, or teach it new
>   tricks that make the update behave well.
> 
> - The user might make changes to the submodule branch without committing
>   them back to superproject. This is primarily affects "git checkout
>   --recurse-submodules", since that is the primary way of switching away
>   from a branch and leaving behind WIP (as opposed to "git submodule
>   update", which is run post-checkout).
> 
>   In a future series, "git checkout --recurse-submodules" will learn to
>   consider submodule branches. We can introduce appropriate guardrails
>   then, e.g. requiring that the superproject working tree is not dirty
>   before switching away.
> 
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  builtin/submodule--helper.c |  37 ++++++++-
>  t/t5617-clone-submodules.sh |  38 +++++++++
>  t/t7406-submodule-update.sh | 156 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 227 insertions(+), 4 deletions(-)
> 

--8<--

> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index f094e3d7f36..b749d35f784 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh

--8<--

> +# Test the behavior of an already-cloned submodule.
> +# NEEDSWORK When updating with branches, we always use the branch instead of the
> +# gitlink's OID. This results in some imperfect behavior:
> +#
> +# - If the gitlink's OID disagrees with the branch OID, updating with branches
> +#   may result in a dirty worktree
> +# - If the branch does not exist, the update fails.
> +#
> +# We will reevaluate when "git checkout --recurse-submodules" supports branches
> +# For now, just test for this imperfect behavior.

OK. Maybe it would be a good idea to explicitely flag which tests below have
an imperfect behaviour ? This way it's easier to spot where the NEEDSWORK applies...

--8<--

This following test show the imperfect behaviour:

> +test_expect_success 'branches - correct branch checked out, OIDs disagree' '
> +	test_when_finished "rm -fr branch-super-cloned" &&
> +	cp -r branch-super-clean branch-super-cloned &&
> +
> +	git -C branch-super-cloned branch --recurse-submodules new-branch &&
> +	git -C branch-super-cloned checkout new-branch &&
> +	git -C branch-super-cloned/sub1 checkout new-branch &&
> +	test_commit -C branch-super-cloned/sub1 new-commit &&
> +	git -C branch-super-cloned submodule update &&
> +
> +	HEAD_BRANCH1=$(git -C branch-super-cloned/sub1 symbolic-ref HEAD) &&
> +	test $HEAD_BRANCH1 = "refs/heads/new-branch" &&
> +	test_clean_submodule ! branch-super-cloned sub1
> +'

--8<--

This one also:

> +
> +test_expect_success 'branches - other branch checked out, correct branch exists, OIDs disagree' '
> +	test_when_finished "rm -fr branch-super-cloned" &&
> +	cp -r branch-super-clean branch-super-cloned &&
> +
> +	git -C branch-super-cloned branch --recurse-submodules new-branch &&
> +	git -C branch-super-cloned checkout new-branch &&
> +	git -C branch-super-cloned/sub1 checkout new-branch &&
> +	test_commit -C branch-super-cloned/sub1 new-commit &&
> +	git -C branch-super-cloned/sub1 checkout main &&
> +	git -C branch-super-cloned submodule update &&
> +
> +	HEAD_BRANCH1=$(git -C branch-super-cloned/sub1 symbolic-ref HEAD) &&
> +	test $HEAD_BRANCH1 = "refs/heads/new-branch" &&
> +	test_clean_submodule ! branch-super-cloned sub1
> +'
> +

This one I'm not sure about: with this series 'git submodule update' does not create
submodule branches at other times than at clone time, so I think this behviour would not change.
I think this one is really an edge case where the user mixes submodule branching on/off.

> +test_expect_success 'branches - other branch checked out, correct branch does not exist' '
> +	test_when_finished "rm -fr branch-super-cloned" &&
> +	cp -r branch-super-clean branch-super-cloned &&
> +
> +	git -C branch-super-cloned branch new-branch &&
> +	git -C branch-super-cloned checkout new-branch &&
> +	test_must_fail git -C branch-super-cloned submodule update
> +'
> +
>  test_done
