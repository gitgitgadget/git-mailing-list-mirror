Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3007AC433F5
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 21:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FFBD61027
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 21:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhJRVat (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 17:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbhJRVat (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 17:30:49 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F06C06161C
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 14:28:37 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id om14so13105411pjb.5
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 14:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wKqYc7gvgWWDWs12v53ca/2+VHLNJE/7gJLWkjRIuIo=;
        b=ViT7/XO8ho3wACk3fKMrgl1uf4O1mMYgD1cV6EW1Y+uI2umpZGB6ONLgrgr7Q5YJYv
         qtpeflIFKmmCgdfddWdpneuiIIkyV8UVSZDULe7alUyzGCrAnXOt4ZJn0rjDYTzAAcNf
         hQVbkQalIfhBhESCsy6850wMmeaxyCWBnXzRDGVPknGLM4oJaw/UxiofEUVH2hVrNKtn
         8JTwHnQqkMuauruVmrhCiBLcsjMZrint76kuWMXYFWrvBuk8dupqNJa09oftPLNeVoQd
         8e1nT69M+VkJqag7icBSlHpvp3ZFYJKr4RCvspQd+aZizvUzADDnIaB1nlbNUG1HSAAR
         bAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wKqYc7gvgWWDWs12v53ca/2+VHLNJE/7gJLWkjRIuIo=;
        b=U56yEnZgeNALdJaRwdbk4q3k98b0xStcAqEaczyF4c6MVtm30xxgxOa2i9Zf6jg5WP
         TFapdi5/68SPHVvXXeCwMTxO9R00AKubvoJGdBWzoz81hyzb19rKRki/UVPJEAVVc+Ow
         WjKAj/uqCLoSmRQH7I5S6PHVcjtjecJCq0fVImqxQ9s4zNM1xafBpOXcRXD2thx0FpNQ
         ZcLBwwclnGWZP/IDYSSvmApautq8peCJThp6MC6pQbyuGdUhM0QrCYod/ml7+zvDAmwB
         nqHVotv0Xg6fRXDfv8ORgr+lB0oxuA+tOEwyN/6PiBjcqGX2ncRTc+rk84ZF3JOWEo2U
         6fFw==
X-Gm-Message-State: AOAM530v2CO9fRpGV4MINSkYkoXNdtpjyFwbPfG6xlsWIsIPwHTtO21c
        IRPLDuav8KeDNOXjfHxWWyjlhg==
X-Google-Smtp-Source: ABdhPJzsEr+49gnKzm9pyyj1mfsxAnAzHGo2l7h4j4a5SxrHEYMguqzqRMGRbGCRqfwPEXA8RTL7dQ==
X-Received: by 2002:a17:90b:1b0b:: with SMTP id nu11mr1533542pjb.103.1634592516926;
        Mon, 18 Oct 2021 14:28:36 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p31sm14330444pfw.201.2021.10.18.14.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 14:28:36 -0700 (PDT)
Date:   Mon, 18 Oct 2021 21:28:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        matheus.bernardino@usp.br, stolee@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 00/14] Sparse-checkout: modify 'git add', 'git rm',
 and 'git add' behavior
Message-ID: <YW3nAKAUj/HF15OR@google.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 12, 2021, Derrick Stolee via GitGitGadget wrote:
> This series is based on ds/mergies-with-sparse-index.
> 
> As requested, this series looks to update the behavior of git add, git rm,
> and git mv when they attempt to modify paths outside of the sparse-checkout
> cone. In particular, this care is expanded to not just cache entries with
> the SKIP_WORKTREE bit, but also paths that do not match the sparse-checkout
> definition.

I suspect something in this series broke 'git add' and friends with "odd" sparse
definitions (I haven't actually bisected).  git 2.33.0 rejects attempts to add
files with the below sparse-checkout and modified files.  There appears to be a
discrepancy in the query vs. checkout logic as the rejected files are checked out
in the working tree, e.g. git sees that the local file was deleted, yet will not
stage the deletion.

There's also arguably a flaw in the "advise" trigger.  AFAICT, the help message
is displayed if and only if the entire path is excluded from the working tree.
In my perfect world, git would complain and advise if there are unstaged changes
for tracked files covered by the specified path.

Note, my sparse-checkout is very much the result of trial and error to get the
exact files I care about.  It's entirely possible I'm doing something weird, but
at the same time git itself is obviously confused.

Thanks!

$ cat .git/info/sparse-checkout
!arch/*
!tools/arch/*
!virt/kvm/arm/*
/*
arch/.gitignore
arch/Kconfig
arch/x86
tools/arch/x86
tools/include/uapi/linux/kvm.h
!Documentation
!drivers

$ git read-tree -mu HEAD

$ rm arch/x86/kvm/x86.c

$ git commit -a
On branch x86/kvm_find_cpuid_entry_index
Your branch is up to date with 'kvm/queue'.

You are in a sparse checkout with 40% of tracked files present.

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	deleted:    arch/x86/kvm/x86.c

no changes added to commit (use "git add" and/or "git commit -a")

$ git add arch

$ git add .

$ git add arch/x86
The following paths and/or pathspecs matched paths that exist
outside of your sparse-checkout definition, so will not be
updated in the index:
arch/x86
hint: If you intend to update such entries, try one of the following:
hint: * Use the --sparse option.
hint: * Disable or modify the sparsity rules.
hint: Disable this message with "git config advice.updateSparsePath false"
