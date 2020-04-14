Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79970C2BA19
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 09:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 439802063A
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 09:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBt8N4dp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437475AbgDNJMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437467AbgDNJLv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 05:11:51 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF611C0A3BD0
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 02:11:50 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z6so13121384wml.2
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 02:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CgIeQt/f/7LRRyj3Hh51aoyd4Memf9H0hVfRFeX/crE=;
        b=XBt8N4dpzy1+CjdlW6+oFpxUCDI5Pwrq4r/lzG8dOWau7z6hPWxeFM+hzGZTbfLBaR
         HCtl6vm87+5EqxGNF6Mai06GX1kKEBUKTFMFgG5Jad1iDufYdNJ/w1NHDHG+lPjiiuVM
         1+ACak26gbCSfZr/oECSELjS/vRk6wdcvRHD8VJfE22vgy5K2XX9z4cliUsH+zwCLR2S
         lK23aRvzGhLHyed9WvOvHu3g+ESjIv9qjorDBmehVlTp+yVW975aJ94u7CVEx2U/iOXj
         0DZF8YqUWizd2NGTbhYpt5kp86c4aSEl/OAKt2SlcQtgXZPqOtq1vwDEqcX9vSiP1Hf0
         F1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CgIeQt/f/7LRRyj3Hh51aoyd4Memf9H0hVfRFeX/crE=;
        b=A921Re8kv7jLISe8L6eCwSqIcSIcKZZRLLERPP4lOZKnqIaTtsaExOOfgjK66vI0q7
         5yUYsZzUkYojG/aSk2w/Z1N7IlyOwUZgkTGegJIApbWN2shmRmbhcMhrQL3qN05A10FB
         mrOd582kHg44X9SOIIHUo6Km7xQnHa/xyewopQ/C/MwcdAPoQjkHKdjMErl242lZO6ch
         Gz29f8vhjLaJbXsJueHj8BiChn1kZSd9tPDiCyTs+J5hRCl9bTgiFp3bTe5Pg5Ibuyf/
         3z8CrUCjGDAt6+a3JYj/OB467110I7m798AHk/sc0HBAWGYGSW0/X2XxmC+bM/QHdTQJ
         ytDQ==
X-Gm-Message-State: AGi0PuZ8O9cX767dhw0o432cGj+Ph0kvAXLbdwG105Pq4kQU3AF9xMig
        wDmudJE2J3lJe7ZykdNYrIM=
X-Google-Smtp-Source: APiQypJHDbib01Mou1+moPOHEFjYbHuSduhlFGhs5dObO+pBcdzUvQmouM5y/Xdq4oONpUN/LDfTfQ==
X-Received: by 2002:a1c:f205:: with SMTP id s5mr22429016wmc.101.1586855509455;
        Tue, 14 Apr 2020 02:11:49 -0700 (PDT)
Received: from [192.168.1.240] (155.20.198.146.dyn.plus.net. [146.198.20.155])
        by smtp.gmail.com with ESMTPSA id d133sm19092164wmc.27.2020.04.14.02.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 02:11:48 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/4] rebase -i: mark commits that begin empty in todo
 editor
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     jonathantanmy@google.com, Johannes.Schindelin@gmx.de,
        bturner@atlassian.com, sami@boukortt.com,
        Elijah Newren <newren@gmail.com>
References: <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com>
 <pull.757.v3.git.git.1586573067.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <2ba9f811-3589-3284-cd4b-0ea9c315a2c0@gmail.com>
Date:   Tue, 14 Apr 2020 10:11:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <pull.757.v3.git.git.1586573067.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 11/04/2020 03:44, Elijah Newren via GitGitGadget wrote:
> Changes since v2:
> 
>   * Addressed feedback from Junio in patch 2, including moving some of the
>     wording to the new patch (see next point)
>   * Edited jt/rebase-allow-duplicate to include the changes Jonathan
>     mentioned on the list, then rebased it on top of this series, and made
>     the related options mention each other.
> 
> Elijah Newren (3):
>    rebase -i: mark commits that begin empty in todo editor

I think this is a useful addition

>    rebase: reinstate --no-keep-empty

This looks like a good compromise - we're still changing the default but 
keeping the ability to drop commits that start empty. One thought on 
this patch - previously we would comment out the empty commits in the 
todo list so the user could decide what to do. Now we just don't add 
them to the list so the user has no way to selectively add them back. I 
guess this doesn't matter too much as they can use the new '# empty' 
label and comment out the commits they want to drop rather than 
uncommenting the ones they want to keep

>    rebase: fix an incompatible-options error message

good catch!

Best Wishes

Phillip

> 
> Jonathan Tan (1):
>    rebase --merge: optionally skip upstreamed commits
> 
>   Documentation/git-rebase.txt      | 70 +++++++++++++++++++++-------
>   builtin/rebase.c                  | 24 +++++++---
>   sequencer.c                       | 14 +++++-
>   sequencer.h                       |  4 +-
>   t/t3402-rebase-merge.sh           | 77 +++++++++++++++++++++++++++++++
>   t/t3421-rebase-topology-linear.sh | 10 ++--
>   t/t3424-rebase-empty.sh           | 36 +++++++++++++++
>   7 files changed, 202 insertions(+), 33 deletions(-)
> 
> 
> base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-757%2Fnewren%2Frebase-mark-empty-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-757/newren/rebase-mark-empty-v3
> Pull-Request: https://github.com/git/git/pull/757
> 
> Range-diff vs v2:
> 
>   1:  0d94eea376a = 1:  0d94eea376a rebase -i: mark commits that begin empty in todo editor
>   2:  e15c599c874 ! 2:  3a5bedc68d6 rebase: reinstate --no-keep-empty
>       @@ Commit message
>        
>            Commit d48e5e21da ("rebase (interactive-backend): make --keep-empty the
>            default", 2020-02-15) turned --keep-empty (for keeping commits which
>       -    start empty) into the default.  That commit viewed this, though as
>       -    turning that flag into a no-op.  As such, --no-keep-empty was translated
>       -    into undoing a no-op, i.e. also a no-op.  The logic underpinning that
>       -    commit was:
>       +    start empty) into the default.  The logic underpinning that commit was:
>        
>              1) 'git commit' errors out on the creation of empty commits without an
>                 override flag
>       @@ Commit message
>            look really weird despite making perfect sense (the first will drop
>            commits which become empty, but keep commits that started empty; the
>            second will keep commits which become empty, but drop commits which
>       -    started empty).
>       +    started empty).  However, --no-keep-empty was named years ago and we are
>       +    predominantly keeping it for backward compatibility; also we suspect it
>       +    will only be used rarely since folks already have a simple way to drop
>       +    commits they don't want with an interactive rebase.
>        
>            Reported-by: Bryan Turner <bturner@atlassian.com>
>            Reported-by: Sami Boukortt <sami@boukortt.com>
>       @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
>        -always dropped.
>        +Note that commits which start empty are kept (unless --no-keep-empty
>        +is specified), and commits which are clean cherry-picks (as determined
>       -+by `git log --cherry-mark ...`) are detected and dropped as a preliminary
>       -+step (unless --keep-cherry-picks is passed).
>       ++by `git log --cherry-mark ...`) are always dropped.
>         +
>         See also INCOMPATIBLE OPTIONS below.
>         
>       @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
>        -	to halt.
>        +	Do not keep commits that start empty before the rebase
>        +	(i.e. that do not change anything from its parent) in the
>       -+	result.  For commits which become empty after rebasing, see
>       -+	the --empty and --keep-cherry-pick flags.
>       ++	result.  The default is to keep commits which start empty,
>       ++	since creating such commits requires passing the --allow-empty
>       ++	override flag to `git commit`, signifying that a user is very
>       ++	intentionally creating such a commit and thus wants to keep
>       ++	it.
>         +
>        -See also BEHAVIORAL DIFFERENCES and INCOMPATIBLE OPTIONS below.
>       ++Usage of this flag will probably be rare, since you can get rid of
>       ++commits that start empty by just firing up an interactive rebase and
>       ++removing the lines corresponding to the commits you don't want.  This
>       ++flag exists as a convenient shortcut, such as for cases where external
>       ++tools generate many empty commits and you want them all removed.
>       +++
>       ++For commits which do not start empty but become empty after rebasing,
>       ++see the --empty flag.
>       +++
>        +See also INCOMPATIBLE OPTIONS below.
>         
>         --allow-empty-message::
>   3:  ee5e42361fc = 3:  5c8863b9d34 rebase: fix an incompatible-options error message
>   -:  ----------- > 4:  20d3a50f5a4 rebase --merge: optionally skip upstreamed commits
> 
