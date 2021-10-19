Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20514C433EF
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 16:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8AE36113D
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 16:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbhJSQw2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 12:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhJSQw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 12:52:26 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05389C06161C
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 09:50:14 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id o133so455236pfg.7
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 09:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bNKcSqd0Ai/K8J/804qUgbJt7U7ssx2BgRXjVZ+1pes=;
        b=QFO90EXnKmr41JgLokoqnxmr/OhZjmh4flNyzelBGbtYumXvd/3jYBUGUlj961Xi6L
         eeBZXKv2FkpeA/mZjPY6T0zZ5AccHa3bt3U8cLbEoSzm4o0DMlTNKEX+uA/lQCdm/ao5
         DsWjiDN7+zyvke5sX9TU4YgwledunZ8BpvzZhOsDwBVb/FCgEQtjzXMe/PKSZKCYGm8p
         E/2aRQYpxKkYi3/fbsJRnIET96WCNuTS0BDD7l/3xaMPBgj0rvNupKlaRAXgvoPq/Rv6
         m9yC6MPLsJcKF/pDAtSAtdywZO7Q4A1UzdqvfC4aPy/gL2CHQAmtnf4HU/DWvVSTRny9
         BJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bNKcSqd0Ai/K8J/804qUgbJt7U7ssx2BgRXjVZ+1pes=;
        b=jAYzfidSozQkDK9I7uq9xflBRrASGL+1jJ6ukX3zA+PfJiVYVekr895Z7m6hQySSi2
         75yVPhlaiTyMyopNLn69UUr0Zhl5qxaC+vX3nl6KvRpzFOiADBq91uGAKUZTey0XVN+E
         DwFIaOmRabdQkSORA42PYaNfJXNAKDcIJuCYr94L/PSPrteT2vFqZiW74sc2zGDhBZD1
         icUblZSAgcwnglYwvMV7xpJa/cfZ0SaH3NR9a/HDJoW0NL3kARMQQGgmedI5+HeabPtL
         uGd2ahl20bZrjy2JAwB19mzTjNJCLtHX97N9VVfNSC81/wZPT2idyG1B427WYns+imgJ
         AxdA==
X-Gm-Message-State: AOAM531rMX1GxqKww7r5X6/awK1jGSVUojx2qcicnfhotvQ+X0Wt/bVf
        n0BnaY60MOQ7efO3F7Q4ep/z5A==
X-Google-Smtp-Source: ABdhPJzkoZrDu0PL1Y/wbWg/JSJrAPKa7RV8OIinIO7ONKcq3/6GWsrx4ORa0xR9fm+V7uiuX7Dqzw==
X-Received: by 2002:a62:7b87:0:b0:44d:3e28:a2ac with SMTP id w129-20020a627b87000000b0044d3e28a2acmr956216pfc.67.1634662213241;
        Tue, 19 Oct 2021 09:50:13 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w15sm16845181pfc.220.2021.10.19.09.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 09:50:12 -0700 (PDT)
Date:   Tue, 19 Oct 2021 16:50:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        matheus.bernardino@usp.br, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 00/14] Sparse-checkout: modify 'git add', 'git rm',
 and 'git add' behavior
Message-ID: <YW73QD7a+NzHd8dq@google.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
 <YW3nAKAUj/HF15OR@google.com>
 <00188c99-386f-8d4f-08f6-11a49d31184c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00188c99-386f-8d4f-08f6-11a49d31184c@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 19, 2021, Derrick Stolee wrote:
> On 10/18/2021 5:28 PM, Sean Christopherson wrote:
> > On Sun, Sep 12, 2021, Derrick Stolee via GitGitGadget wrote:
> >> This series is based on ds/mergies-with-sparse-index.
> >>
> >> As requested, this series looks to update the behavior of git add, git rm,
> >> and git mv when they attempt to modify paths outside of the sparse-checkout
> >> cone. In particular, this care is expanded to not just cache entries with
> >> the SKIP_WORKTREE bit, but also paths that do not match the sparse-checkout
> >> definition.
> > 
> > I suspect something in this series broke 'git add' and friends with "odd" sparse
> > definitions (I haven't actually bisected).  git 2.33.0 rejects attempts to add
> > files with the below sparse-checkout and modified files.  There appears to be a
> > discrepancy in the query vs. checkout logic as the rejected files are checked out
> > in the working tree, e.g. git sees that the local file was deleted, yet will not
> > stage the deletion.
> 
> Are you using v2.33.0? This change is not in that version.

Hrm, it's an internal build that says v2.33.0 is the bsae, but the --sparse option
is available so who knows what's actually underneath the hood.  I can try vanilla
upstream builds if that would help narrow down the issue.

> However, mt/add-rm-in-sparse-checkout [1] was introduced in v2.33.0 and
> introduced these advice suggestions.
> 
> [1] https://github.com/git/git/compare/a5828ae6b52137b913b978e16cd2334482eb4c1f...d5f4b8260f623d6fdef36d5eaa8a0c2350390472
>
> The series you are commenting on goes even farther in restricting adds to
> be within the sparse-checkout definitions, even for unstaged files or files
> that removed the skip-worktree bit due to a merge conflict. It also creates
> an override '--sparse' option that allows you to ignore these protections.
> 
> > There's also arguably a flaw in the "advise" trigger.  AFAICT, the help message
> > is displayed if and only if the entire path is excluded from the working tree.
> > In my perfect world, git would complain and advise if there are unstaged changes
> > for tracked files covered by the specified path.
> >> Note, my sparse-checkout is very much the result of trial and error to get the
> > exact files I care about.  It's entirely possible I'm doing something weird, but
> > at the same time git itself is obviously confused.
> > 
> > Thanks!
> > 
> > $ cat .git/info/sparse-checkout
> > !arch/*
> > !tools/arch/*
> > !virt/kvm/arm/*
> > /*
> > arch/.gitignore
> > arch/Kconfig
> > arch/x86
> > tools/arch/x86
> > tools/include/uapi/linux/kvm.h
> > !Documentation
> > !drivers
> 
> Have you tried using 'arch/x86/' and 'tools/arch/x86/' to specify
> that these are directories? Just a thought.

Nice!  That workaround resolves the issue.  I vaguely recall intentionally omitting
the trailing slash, but adding it back doesn't seem to have any unwanted side effects
on the current git versions I'm using.

> > $ git read-tree -mu HEAD
> > 
> > $ rm arch/x86/kvm/x86.c
> > 
> > $ git commit -a
> ...
> > 	deleted:    arch/x86/kvm/x86.c
> 
> This is certainly odd. Worth more investigation that I don't have
> time for at this moment.

I've no objection to punting on this now that I have a workaround.  The man pages
are quite clear that sparse checkouts are still experimental and it's no trouble
for me to whine again if something breaks in the future :-)

Thanks again!
