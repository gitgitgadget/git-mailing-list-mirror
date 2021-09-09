Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ABFC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD34961244
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbhIIOnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345095AbhIIOnF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 10:43:05 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D04DC0386DC
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 07:13:07 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso2619146ott.13
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 07:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=avqhsTK56sNDKmsOBiMPQsxKYCAYoN+2BHDzqueURL8=;
        b=Lvq1zFIGi+ilGr0D5zHX2gkY9nRfR8EWkNLJ82WIV7RZBo9HGEwAMG3wihOgOADWI5
         tN8N+83OA1E2O1igQJK39if76TWg7XX9XEN4YfWVw2dK1EnrNBrcx/y1JVGkPJurq9el
         uiNrFwLqm+KVmrxJvBAGEv4DjAX+j5Vv00bVlshwcVfwM9meF0hmIY4ma4R7Ea5EN1bf
         L8jI60EMgvSYeu8TJ1h8MOYDPBkWM25guBu+ejnAYaAaoWAlLNSSMl6GUJ0s4i7nUFIo
         0cKx69MF5d6qT+uXsLY9BekUHHtT3+mkwkrUjFwuLpLgA0t+X4Ryko2H7zHq/gqa2GMW
         S7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=avqhsTK56sNDKmsOBiMPQsxKYCAYoN+2BHDzqueURL8=;
        b=3mU25gGk6S6gNa6+kS9sEIa9MCXWaCqbkhm6OzCeYoZi7DXEiUkWuW/BTT4ic4niVO
         cDLRbfWTfmCoJIeJGwXBX84PRTr19RrQ/LmWd7C48+yY2s6olcSgHvqgNJa9poJCTbAG
         uo3GmwQy30pZ1uZu8thKnrd5k00X40G0oatRfcUCpubX3S71c2BIRaBh3MhF8y3m266g
         sAhL8p2sPaY5EkrUmYeHYuSm//oqz2TIEFad4y9GDemrisYwxpVgatXgRu9PK9dgi3u4
         MF9qntLM8eIXXBb2Pu3xjPWt9E+m2vSjG50tqUuHYFCs3Bp0zbAL4Hx38Pul9iABmTCS
         7YAQ==
X-Gm-Message-State: AOAM532uaPht78AwVjcAhrpl0fp9YCaeJ9bSuvHahWMFd+5C8XmP9eFy
        LP6hXs1OawZrdOyhKRMYQSi2nDaEklcnq35TAKJKsuLF
X-Google-Smtp-Source: ABdhPJx/0vqlfEjvp5UcOhVDz/0EfO8J8PfPj9RYcu6yvxmv9qFpZXD9JU3vG1NiFhmaAJYwH0UgoAMwLNqiibweQrY=
X-Received: by 2002:a9d:609e:: with SMTP id m30mr64019otj.174.1631196786503;
 Thu, 09 Sep 2021 07:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqsfyf5b74.fsf@gitster.g>
In-Reply-To: <xmqqsfyf5b74.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Sep 2021 07:12:54 -0700
Message-ID: <CABPp-BGW4Bfjgi580mXwtQMQt=PLpgGsEWg6fNw41VRj1B3LUg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #02; Wed, 8)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few comments on some topics from other folks...

On Wed, Sep 8, 2021 at 8:40 AM Junio C Hamano <gitster@pobox.com> wrote:

> * pb/test-use-user-env (2021-09-07) 3 commits
>  - test-lib-functions: keep user's debugger config files and TERM in 'debug'
>  - test-lib-functions: optionally keep HOME, TERM and SHELL in 'test_pause'
>  - test-lib-functions: use 'TEST_SHELL_PATH' in 'test_pause'
>
>  Teach test_pause and test_debug to allow using the HOME and TERM
>  environment variables the user usually uses.
>
>  Will merge to 'next'?

Sounds good to me; I'm happy with the latest series.

> * js/retire-preserve-merges (2021-09-07) 11 commits
>  - sequencer: restrict scope of a formerly public function
>  - rebase: remove a no-longer-used function
>  - rebase: stop mentioning the -p option in comments
>  - rebase: remove obsolete code comment
>  - rebase: drop the internal `rebase--interactive` command
>  - git-svn: drop support for `--preserve-merges`
>  - rebase: drop support for `--preserve-merges`
>  - pull: remove support for `--rebase=preserve`
>  - tests: stop testing `git rebase --preserve-merges`
>  - remote: warn about unhandled branch.<name>.rebase values
>  - t5520: do not use `pull.rebase=preserve`
>
>  The "--preserve-merges" option of "git rebase" has been removed.
>
>  Will merge to 'next'?

I came a bit late to the party, but skimmed over the series as well.
I'm very happy with the cleanups.  The direction of the patches looks
good in general, and didn't spot any problems in my spot checking.
Merging down sounds good to me.

> * ds/sparse-index-ignored-files (2021-09-07) 10 commits
>  - sparse-checkout: clear tracked sparse dirs
>  - sparse-index: add SPARSE_INDEX_MEMORY_ONLY flag
>  - attr: be careful about sparse directories
>  - sparse-checkout: create helper methods
>  - sparse-index: use WRITE_TREE_MISSING_OK
>  - sparse-index: silently return when cache tree fails
>  - unpack-trees: fix nested sparse-dir search
>  - sparse-index: silently return when not using cone-mode patterns
>  - t7519: rewrite sparse index test
>  - Merge branch 'ds/add-with-sparse-index' into ds/sparse-index-ignored-files
>  (this branch is used by sg/test-split-index-fix.)
>
>  In cone mode, the sparse-index codepath learned to remove ignored
>  files (like build artifacts) outside the sparse cone, allowing the
>  entire directory outside the sparse cone to be removed, which is
>  especially useful when the sparse patterns change.
>
>  Will merge to 'next'?

I've reviewed each of the rounds in detail and I'm happy with this
one; I think it's ready.
