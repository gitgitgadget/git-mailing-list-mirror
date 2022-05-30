Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7652DC433F5
	for <git@archiver.kernel.org>; Mon, 30 May 2022 18:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241950AbiE3Ssg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 May 2022 14:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242979AbiE3Ss0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 May 2022 14:48:26 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C982AC77
        for <git@vger.kernel.org>; Mon, 30 May 2022 11:48:25 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id v25so6599297eda.6
        for <git@vger.kernel.org>; Mon, 30 May 2022 11:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yyi/FwlHHmFS2HvxWMyLvDp/hypMqx/v/Z9R0a/Z/SM=;
        b=BgsYGmoeUBjnQFTmZQxypd/dyt8hz0F9CVwc5kY2whvAkn9q/7r6YlMpuIXxNHTdl9
         ZkID4qss3vnH6J91TjXsQhE20TlUirrf6XcIQ4Nm58nsRUx+uiqoOxPTvnYnM29GzwxX
         Q6XQLCiIATKrZm7abJRZgmVverv8MA4ASo5UWVSG0os36lQLUjHWBrEgjww8Fvuh6koZ
         JJBnMYH5hk/nqs8qrSL6Dr7fqHnOQOp/5QUxDtOMwdzf7YXm2LhnH66C6XhOVROtK8fq
         REEzRLzdVVE3DmSmeX3XA3a7taTzPYOJdftbfTZ0KLkozICTFPTSNyNmuMzswcIAI/D6
         yiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yyi/FwlHHmFS2HvxWMyLvDp/hypMqx/v/Z9R0a/Z/SM=;
        b=cNj91Lx51N/PcE2cmpPy3KhZF6HSOCWfILebcMdZeVegx0EMOFWHwiZ8stSnnpOpwH
         V66DSl5svEdWdsB3ZEJIksj7sPT4UeZl3wC7KFSFMJY1pIP92ADeOLx1I3mxI+cvSUQV
         q/g5bfVgGyNLV7LabmaG/oWuLjzMw8qqFnos7+adSRrZImBaUOH4Ze1AC2osxBZgUy1R
         oh4xTmzCvp0mG32Ue1jFEJdwZx798AKIMKQLCugG8K3Wt0I7pwvlepnirOzOQEhVMyZM
         TCB7VobtGYQpevMjv0VYXy8LZWQt9qxJMfSAEKlwRQsy4/7Lew5fw5BIPPU1Rxus1jr/
         CrHw==
X-Gm-Message-State: AOAM5332L3hrdaosZBbqWK0403HwPvN24cECecmOSHYYGcXYNk9H58W8
        GPtUXmjnoQv4FnBJDmAWwAr2wLP6pts5PUa1HeM=
X-Google-Smtp-Source: ABdhPJwBbxnstQkfEgMxQktkldsyB1isW+kRQnVvmGEGqTdbYDHsWwtmctJYU4E6BFelxyrs5UKFItluaSQasPL6eTg=
X-Received: by 2002:a05:6402:1941:b0:413:2b5f:9074 with SMTP id
 f1-20020a056402194100b004132b5f9074mr60235027edz.414.1653936503729; Mon, 30
 May 2022 11:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220505203234.21586-1-ggossdev@gmail.com> <20220510171527.25778-1-ggossdev@gmail.com>
 <20220510171527.25778-2-ggossdev@gmail.com> <900d91cb-1982-b892-17e3-ad678e711dc9@github.com>
In-Reply-To: <900d91cb-1982-b892-17e3-ad678e711dc9@github.com>
From:   oss dev <gg.oss.dev@gmail.com>
Date:   Mon, 30 May 2022 14:48:12 -0400
Message-ID: <CAAA5oLnAwcH+Kr9UT1+V-_bjNNJS+8=U1+uMZUETSmP+nfM7kA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dir: consider worktree config in path recursion
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This could be strbuf_add(&sb, ".git", 4); to avoid a (minor)
> strlen() computation.

I checked gcc's disassembly--the strbuf_addstr is inlined and the
strlen is evaluated at compile time. I believe gcc has evaluated
strlen at compile time for string literals for quite some time. Also
seems common in the rest of the code base to use strbuf_addstr with
string literals.


> With regards to Junio's comment about repeating real_pathdup()
> on the_repository->gitdir, we might be able to short-circuit
> this by making real_gitdir static and only calling
> real_pathdup() if real_gitdir is NULL. It would cut the cost
> of these checks by half for big traversals.

Yeah, I couldn't come up with a super clean way of caching
real_pathdup (assuming we don't want to leak the memory), but based on
subsequent comments it sounds like it was more a kicking-the-tires
question than real concern.


> The test description should be a single line. The longer paragraph
> could be a comment before your "setup" test case.

I'm not sure what the current best practice is, but I expected best
practice to be reflected here [1] and many other tests use multi-line
descriptions (see e.g. t0000 [2] or t1512 [3] for a nice ascii graphic
right in the description).

[1]: https://git-scm.com/docs/MyFirstContribution#write-new-test
[2]: https://github.com/git/git/blob/8ddf593a250e07d388059f7e3f471078e1d2ed5c/t/t0000-basic.sh
[3]: https://github.com/git/git/blob/8ddf593a250e07d388059f7e3f471078e1d2ed5c/t/t1512-rev-parse-disambiguation.sh


> Also, there is no need to number your tests in their names, as the
> testing infrastructure will apply numbers based on their order in
> the test file. These labels will grow stale if tests are removed
> or inserted into the order.

In v1 of the patch, I was asked to include a comment in the code that
refers to a test for which the changes that are being made in this
patch are meaningful. Grepping for other instances where this was
done, similar comments generally refer to numbered testcases (see e.g.
[1]). I figured if I don't number it then someone might suggest that
similar comments generally refer to numbered test cases. Though I'll
concede that referring to any specific tests will likely eventually
result in stale references. For example, t6043 referenced by [1]
(currently in master) appears to have been moved elsewhere.
Personally, I'm indifferent.

[1]: https://github.com/git/git/blob/8ddf593a250e07d388059f7e3f471078e1d2ed5c/merge-recursive.c#L1620


> This use of .gitignore to ignore the helper files being used
> during the test is interesting. I was thinking it would be better
> to create isolated directories where the only activity was that
> which you were testing:
>
>         mkdir -p worktree &&
>         test_create_repo worktree/contains-git &&
>
> ...or something like that. The names are more descriptive, and
> we don't need the .gitignore trick.

While trying to figure out what section this test should go into, I
looked through several tests and was likely inspired by e.g. [1] or
[2]. I also think there could be a benefit to ensuring that .gitignore
works correctly with the new traversal behavior in the nested repo,
i.e. the .gitignore becomes part of the test.  In principle, I don't
mind testing .gitignore more explicitly, but I also think the tests
are quite lengthy already for a small patch and doing more with less
seems attractive.

[1]: https://github.com/git/git/blob/8ddf593a250e07d388059f7e3f471078e1d2ed5c/t/t1501-work-tree.sh#L198-L202
[2]: https://github.com/git/git/blob/8ddf593a250e07d388059f7e3f471078e1d2ed5c/t/t2202-add-addremove.sh#L13-L17


> I was surprised by this "local". It isn't needed at this
> point in the test script. We use it for helper methods to
> be sure that we aren't stomping variables from test scripts,
> but since the test is being executed inside an eval(), this
> local isn't important.

I tend to default to `local` or `declare` to limit unintended side
effects after refactoring, etc., but I don't mind removing it if it's
not desired. I'm ok either way, pls confirm.

> You can avoid the sub-shell using "git -C test1 ls-files ..."
> right?

Ok, I can update this and similar instances.


> This also checks to see if _any_ of these "git add"
> commands fail, as opposed to failing immediately after
> the first one fails. I think your approach is simpler and
> should be relatively simple to identify which command did
> the wrong thing by looking at the test_cmp output.

Agreed, I'm combining several `git add`s into one test here -- I
didn't want to get too long-winded since it seems like a minor patch.

Thanks for the comments; v3 of the patch had already been sent prior
to these, so none is incorporated there.  I'll include confirmed
changes in the next version.
