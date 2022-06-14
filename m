Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A41C433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 00:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbiFNAh0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 20:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiFNAhX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 20:37:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3520D137
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 17:37:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y19so14145784ejq.6
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 17:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=4/P+wMU/n5Vz1P8OAqHWy2cgEGP13TqcE4WE+r4PFrs=;
        b=qRvN+52bh+RHwaEXVo4sGWQX3ean6tUpMCnNktT+bKmV38dwEnmPYrAzVoFkmi4VYK
         r9igxFbNw1GFnFtFQHlvK5YU5CaN1ZqtHUUnIabhJQ8JtWAF9kCiiLORRuYjQYoqH5Xk
         9aXIPsqwFAFClFu3Ud2nX8tJSX68PvEwVfz3Of4j8fjUPEfm8mvqxWKgRtIHJGhMmVXR
         a4cQ0Pxly9Gxk2eHLoS3XgDc0vwPpCHBNcRvlD6digWLlpxtDGMb32WKCgQfg23WT1QJ
         bww6Y0Mwjw8vCePnffzSoSsafwsFCJxBAvhwaMeOVeMXRcvWwpvn3xWv71IkVE3LiRDn
         0rOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=4/P+wMU/n5Vz1P8OAqHWy2cgEGP13TqcE4WE+r4PFrs=;
        b=l9530/prGO8sXUuf6gl2pAIRltqCRYzsbvy6u3TNw+XBEYV3kAEL+xuEcZPBmiqQmE
         wAGa0wbcrljvLFh+QwE7jppExWODZvMDioq9VMr3HQClFLJvh2IhFbyNEIw+m+P0KTll
         NYQaI9AGmtFjndVcFHYgoNyAlZE4QQineRtnEFYk2enxIEjkkj0DLFYoEt+r36wjdD+M
         W/VGAiDZZ+7V+oph8KUExY9BKgsCosFPtjIyPSw0LfQaeBgKrBARp/+jL3xhaDXSVPya
         n+g4qTk/jIOBxd6cBGSKvWTOXUAf3ec9Cx4nbihQKpp1IDnYoKbO/fFdVAeoCshjA9ox
         1DbA==
X-Gm-Message-State: AOAM5338rtl4VnhXt8p97laLaGs+Bwu5wPKoUGFKcLEohO2P3WGAITio
        mMZyCwzOfEE6kNXJm3eNbHG1RIrlJEUlSA==
X-Google-Smtp-Source: AGRyM1t1FfbkUuWe0eGsu9ZocZJj0NwzRBySeiVS4C4JHWRF8/fo/Uhvs54REdtgPC2sGXQwFxuy9g==
X-Received: by 2002:a17:906:74c6:b0:712:10f2:7c87 with SMTP id z6-20020a17090674c600b0071210f27c87mr2030191ejl.416.1655167039622;
        Mon, 13 Jun 2022 17:37:19 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id da26-20020a056402177a00b004315050d7dfsm5939534edb.81.2022.06.13.17.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 17:37:18 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o0uYY-000JFc-0S;
        Tue, 14 Jun 2022 02:37:18 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        me@ttaylorr.com, Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/5] branch: fix branch_checked_out() leaks
Date:   Tue, 14 Jun 2022 02:33:59 +0200
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
 <6cd7db33-6ab5-9843-4483-4cce9835b177@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <6cd7db33-6ab5-9843-4483-4cce9835b177@github.com>
Message-ID: <220614.868rq0ytaa.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 13 2022, Derrick Stolee wrote:

> On 6/8/2022 4:08 PM, Derrick Stolee via GitGitGadget wrote:
>> This is a replacement for some patches from v2 of my 'git rebase
>> --update-refs' topic [1]. After some feedback from Philip, I've decided to
>> pull that topic while I rework how I track the refs to rewrite [2]. This
>> series moves forward with the branch_checked_out() helper that was a bit
>> more complicated than expected at first glance. This series is a culmination
>> of the discussion started by Junio at [3].
>> 
>
> Junio pointed out that patch 1 introduced a memory leak when a ref
> is checked out in multiple places. Here is a patch to fix that
> scenario. It applies cleanly on top of patch 4, so I include it as
> a new "patch 5". I will include it in any v2 of the full series, if
> needed.
>
> Thanks,
> -Stolee
>
> ---- >8 ----
>
> From c3842b36ebb4053ac49b0306154b840431f9bf6f Mon Sep 17 00:00:00 2001
> From: Derrick Stolee <derrickstolee@github.com>
> Date: Mon, 13 Jun 2022 10:33:20 -0400
> Subject: [PATCH 5/5] branch: fix branch_checked_out() leaks
>
> The branch_checked_out() method populates a strmap linking a refname to
> a worktree that has that branch checked out. While unlikely, it is
> possible that a bug or filesystem manipulation could create a scenario
> where the same ref is checked out in multiple places. Further, there are
> some states in an interactive rebase where HEAD and REBASE_HEAD point to
> the same ref, leading to multiple insertions into the strmap. In either
> case, the strmap_put() method returns the old value which is leaked.
>
> Update branch_checked_out() to consume that pointer and free it.
>
> Add a test in t2407 that checks this erroneous case. The test "checks
> itself" by first confirming that the filesystem manipulations it makes
> trigger the branch_checked_out() logic, and then sets up similar
> manipulations to make it look like there are multiple worktrees pointing
> to the same ref.
>
> While TEST_PASSES_SANITIZE_LEAK would be helpful to demonstrate the
> leakage and prevent it in the future, t2407 uses helpers such as 'git
> clone' that cause the test to fail under that mode.

If you apply this:
	
	diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
	index 0760595337b..d41171acb83 100755
	--- a/t/t2407-worktree-heads.sh
	+++ b/t/t2407-worktree-heads.sh
	@@ -10,16 +10,8 @@ test_expect_success 'setup' '
	 		test_commit $i &&
	 		git branch wt-$i &&
	 		git worktree add wt-$i wt-$i || return 1
	-	done &&
	-
	-	# Create a server that updates each branch by one commit
	-	git clone . server &&
	-	git remote add server ./server &&
	-	for i in 1 2 3 4
	-	do
	-		git -C server checkout wt-$i &&
	-		test_commit -C server A-$i || return 1
	 	done
	+
	 '
	 
	 test_expect_success 'refuse to overwrite: checked out in worktree' '

And compile with SANITIZE=leak then this will pass as:

	./t2407-worktree-heads.sh  --run=1,6

I.e. you only needed the earlier part of the setup, and not "clone.

Given that I think it makes sense to just create a
t2408-worktree-heads-leak.sh or something for this new test, then you
can use TEST_PASSES_SANITIZE_LEAK.

Normally I'd just say "let's leave it for later", but in this case the
entire point of the commit and the relatively lengthy test is to deal
with a memory leak, so just copy/pasting the few lines of setup you
actually need to a new test & testing with SANITIZE=leak seems worth the
effort in this case.
