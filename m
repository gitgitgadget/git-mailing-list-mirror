Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA4DC433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 01:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D278C2098B
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 01:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSuN+RCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgFQBiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 21:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFQBiB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 21:38:01 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CE0C061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 18:37:59 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id e5so325885ote.11
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 18:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=AqmfZSol7Wmphylo3EoB2oHcqqtlhqvIptlK9MNjxX0=;
        b=dSuN+RCnT2n8k9EnmibdjPjIAAV0bYR2BiRUyihj1pRqUaAk6C3IKYGzpVx2TFmcCZ
         FdUItQisnldILZY+CdeL4xS1EDeMbnVSQtIj28hnIQX++cFTGUaqKJ9KtrESHiCZL/bq
         CsOM7ZdlHraa3JtsIIBJtn8dV4qO0JuUIlC75z2lPoh059CBwYmHnRSzzPoLp5+aNm+r
         bisyBhuV/nK7RkyVdgKfpWFHQGfrLnfRq6sd2ks4L51TUdw4s4aoK5jXtC3DVMeWIsc2
         iIXMqZN0yns+tGwnqPxTINFtmmstXuN7YFgDMk3kImMlRuVkh9KFoaiTiUcdg/+v+m+h
         a+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AqmfZSol7Wmphylo3EoB2oHcqqtlhqvIptlK9MNjxX0=;
        b=ou0SnknJiKg2YzBfJTZTDjB+cYfXKDvMQjgDIt75luJZPJ6oh9uDnPTbThHkAgQBw0
         ByvqNCl30CAwiGmaUcUxD0lntGUU9QQcZjT515bVeMQheNm6R/D8Bd7f8o+Ftx/c2ruu
         KzZVEHFg6sJ1+FbgmN+VOJSdEiaSuvYwWBr7uRtlIdQuzc62ifdUwGkCbzVFupo5JhuS
         AbitiQXKJkCWOQNhT3HRO25594Sv2KsvSIRbVNL/LnO2ChE9Ss2Z31z1Mi4JBUhQztaV
         o/PuZbl7rfeyLuDb06sZD6bJlCQjO3T+sUlxGsf3qx1JJnMIZgaVOnEK1fpiiE7zqbxb
         MEaw==
X-Gm-Message-State: AOAM531tCltBdOkyA2q0PNUyn1tZb7xQ13V6QwbQcr3bMkZdqr3e1lHH
        Tq74mwrR2dFGqKAqD6rUA1q23AQ/c+/YqUmGpg61osGnX5U=
X-Google-Smtp-Source: ABdhPJz7tNmdQm/cSf7xwuIqjtLshKJdscaqisNYB6UdbG1bQUhCROvV4Qr+odzBNpH0ojbzpuefwT8gjvAa/R7eAQA=
X-Received: by 2002:a05:6830:1d8c:: with SMTP id y12mr4949939oti.162.1592357877951;
 Tue, 16 Jun 2020 18:37:57 -0700 (PDT)
MIME-Version: 1.0
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 16 Jun 2020 18:37:46 -0700
Message-ID: <CABPp-BHzRjcxSfsFSR519VmQfmiwVW=at3VDRJNQMf8rwh9dRA@mail.gmail.com>
Subject: sparse-checkout papercuts
To:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I just sent off a few series to address some small sparse-checkout
issues, but there are a couple others that I wasn't sure of a good
initial solution for and wanted to solicit ideas from everyone else:

A) Users surprised at left-behind directories after doing a sparse checkout

This is similar to my "mention sparsity state in git status" series I
sent off, but instead of being about users coming back to a directory
and having forgotten that they sparsified and then being surprised
about files and directories missing, this issue is about users being
surprised by directories left around immediately after trying to
sparsify.

In particular, after people do some builds in a non-sparse project and
then go to sparsify, the .gitignore'd build artifacts are not removed
when all the sources are.  I recently modified my 'sparsify' wrapper,
so that at the time people go to sparsify they will see a message
like:

    $ ./sparsify --modules $module1 $module2 $module 3
    You are now in a sparse checkout with only 21458 of the 56079 files.
    Note: You have leftover .gitignore'd files in 33 directories;
          these likely represent build artifacts.
          To remove, run: ./sparsify --update --remove-old-ignores

Further, that special --remove-old-ignores basically runs `git clean
-fX <directories-outside-sparse-cone>`, where it does some work to
figure out which directories are outside the sparse cone, of course.

Is this something that would make sense to add to sparse-checkout
init/set?  Should it go in git status instead?  Should git clean get a
special flag for looking just at directories outside of the sparse
cone (and simplifying my logic in sparsify so it doesn't have to
handle this)?  Or is this behavior too specific to our usecases?


B) Double updating and unnecessary dirtying of files

`git sparse-checkout` docs say the correct way to get into a sparse
checkout is to run the combination of commands:
   git sparse-checkout init [--cone]
   git sparse-checkout set $DIR1 $DIR2 ...

Unfortunately, the first step removes virtually all files from the
working directory, then the second step (in our case) adds many of
them back and sometimes even a majority.  For other wrappers or tools
that do dependency analysis between directories and wrap this
behavior, this results in behavior that looks like:

   $ ./sparsify --modules maindir1 maindir2
   Updating files: 100% (56059/56059), done.
   Updating files: 100% (24853/24853), done.
   You are now in a sparse checkout with only 24873 of the 56079 files.

There are three problems here: (1) the user watches two progress bars,
which seems kind of suboptimal.  (2) This process deletes tens of
thousands of files from the working directory just to immediately add
them back.  (3) Adding the files back to the working directory updated
the modification timestamps of the files, so any subsequent build they
invoke has to rebuild everything present regardless of whether they
were up-to-date before sparsifying.

Any ideas or preferences on whether (a) a tool could combine the two
sparse-checkout commands, (b) specify an extra flag to init that
didn't immediately try to apply all the changes to the working tree,
or (c) something else that'd avoid these problems?


Thanks,
Elijah
