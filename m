Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC74C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD86206D7
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbgFOKDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:03:35 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50537 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbgFOKDf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 06:03:35 -0400
X-Originating-IP: 157.36.11.232
Received: from localhost (unknown [157.36.11.232])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 369E5E001D;
        Mon, 15 Jun 2020 10:03:30 +0000 (UTC)
Date:   Mon, 15 Jun 2020 15:33:27 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/9] Allow overriding the default name of the default
 branch
Message-ID: <20200615100327.3mwft27oj7h2bixg@yadavpratyush.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.656.git.1591823971.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 10/06/20 09:19PM, Johannes Schindelin via GitGitGadget wrote:
> A growing number of open source projects aims to avoid the branch name 
> master due to its negative connotation. See [1] for an existing discussion
> on this. The links [2], [3], and [4] describe community-driven ways for
> users to rename their default branches or use template edits to set a new
> default branch name.
> 
> [1] 
> https://lore.kernel.org/git/CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com/
> 
> [2] https://twitter.com/mislav/status/1270388510684598272
> 
> [3] 
> https://www.hanselman.com/blog/EasilyRenameYourGitDefaultBranchFromMasterToMain.aspx
> 
> [4] https://github.com/ethomson/retarget_prs
> 
> By necessity, existing repositories require a lot of manual work to move
> away from that branch name, but it should be much easier for new
> repositories.
> 
> This patch series allows overriding the branch name being used for new
> repositories' main branch. The main way to do this is the new 
> core.defaultBranchName config option. This first patch was contributed by
> newcomer Dan Goodman-Wilson. Thanks for the contribution!
> 
> The other patches follow other places where "master" is hard-coded and use
> the new git_default_branch_name() method to consume the config option before
> falling back to "master".
> 
> The last patch updates documentation only after the config option is ready
> to apply to all of these scenarios.
> 
> This series DOES NOT change the default automatically, but only provides an
> opt-in mechanism for interested users. It also presents a way forward for
> such a transition, if and when we decide to do so. Specifically, the new
> GIT_TEST_DEFAULT_BRANCH_NAME environment variable could be used to update
> test scripts on an individual basis instead of all-at-once.

Many people have expressed reservations against this change. Some on the 
list here, others in private conversation. I personally don't have a 
strong opinion on either side. So I'll refrain from saying too much on 
the issue. Reading through the list, I sense that the Git maintainer has 
already decided it is something good for the project. And so I think 
this change has a high chance of making it in a near future Git release.  

One argument from those in favor of this change is that it doesn't 
affect you if you don't care about the default branch name. You can just 
go on using 'master' for all _your_ repos. I'd like to highlight the 
"your" here. Sure, I can keep on using 'master' if I so prefer, but I 
don't just use my repos. I also pull repos from other people, and I have 
no control over what they call their main/primary/master branch (I'll 
use "main" for the rest of the email). The cost here is that people now 
need to update their scripts and workflow to account for other people's 
naming preferences.

For example, my vim plugins are submodules in the '~/.vim/bundle' 
directory. When I want to update them, I run:

  git submodule foreach 'git remote update && git reset --hard origin/master'

With this change hitting a Git release, more and more people would call 
their main branch different names they like. So what is the recommended 
way to do something like this now? How do I checkout the tip of the main 
branch? How do I push to the main branch? How do I pull from the main 
branch? And so on...

-- 
Regards,
Pratyush Yadav
