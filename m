Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD67BC433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90AAD61242
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344234AbhIIOpB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242950AbhIIOov (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 10:44:51 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DE3C03402D
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 07:23:53 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id x10-20020a056830408a00b004f26cead745so2669582ott.10
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 07:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7rATKVkf07nG+rTT8IoM7IH1Wjb3ebLiJSfF+KJG+aI=;
        b=aB8uUU4wutbLfMYccprleO5Pj/SaXUwnObWnDfyinvrf/GtjOawv+WQjHzQsemnB5T
         OPZSQmZEq3wRuOsOLp5Os248uOTVPX1wgngER4Alov5qDGix0JZEJuVHHPiD0L0IvIar
         HgNEoQRWeYrGkXbiVLS2Nlf+FR9CrQp+SUDUyOkxZ5W+iYAGZpTPPRIRwAmuPRJSa+xC
         f4G4oOBoeGtMXF1G0fu5Fnlw+1nFzqunEMtqWZOeRFwbRwnlqj4YaRRzF+EGaUNVdlDF
         UykSqV+pz+JPzr4MF5xfiIF8DuW1wk0yTP25KuoE707t6aD2qBWjqgrNG1P9EZIsNpMC
         l4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7rATKVkf07nG+rTT8IoM7IH1Wjb3ebLiJSfF+KJG+aI=;
        b=tN0he7syNxgCac8ijaE4gZDFDwv6fFZVKKYhYHVQDCN/IUnl75C/wfk24JwqWiHf+K
         vtOBO8nxkjeH73Pz8PmI7wssVYgwGi0RKPqPW8BmLrIl+wXbSzR8gl5KJrQ+tCvr5c3q
         s6fa6N++6hA9NNmJnneFFhpvBYihlH5pLt1vSN2JmxxeJ1Eq4URcCiWi90x5RfOtgZha
         ZNhuyk1xFvmZVkRh332ok5MPtObOJwGcILYNB8EntQooNQr1IqanV3yjJCk9yiJ2pFm6
         dvic8uYPm6gi/VdS6Sug+pB4aQsBcMvBYzAvmAxD+u7aMbE+Q51sSj4L/+tx6DkPcaPf
         a5sA==
X-Gm-Message-State: AOAM532n5bD82NLDJ/LqlWB2Ca8vVegEf2NGx7Yb7sQiE1eLuZCDC+5r
        3XRrAka5n0j5GiTjsZzyYvZSzvNgNLp/PCiHBKg=
X-Google-Smtp-Source: ABdhPJzz0CGSl8a5pbbvH6LT/AcAvAFMq5wVI7/Xc7rVDqhASCg3UrDUlZ0/rQVoSAtRrbTtDf22V7OFQK2ZDB24zFI=
X-Received: by 2002:a05:6830:2b24:: with SMTP id l36mr87782otv.25.1631197432926;
 Thu, 09 Sep 2021 07:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqsfyf5b74.fsf@gitster.g> <d6721839-114a-3309-25aa-1926fa198bf7@gmail.com>
In-Reply-To: <d6721839-114a-3309-25aa-1926fa198bf7@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Sep 2021 07:23:41 -0700
Message-ID: <CABPp-BH1Zdh7esBKeUu9hr4tM9kO=dgpyDwCMnsJ=XGxpZ7RvQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #02; Wed, 8)
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 8, 2021 at 2:57 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 9/8/2021 11:38 AM, Junio C Hamano wrote:> * ds/sparse-index-ignored-files (2021-09-07) 10 commits
> >  - sparse-checkout: clear tracked sparse dirs
> >  - sparse-index: add SPARSE_INDEX_MEMORY_ONLY flag
> >  - attr: be careful about sparse directories
> >  - sparse-checkout: create helper methods
> >  - sparse-index: use WRITE_TREE_MISSING_OK
> >  - sparse-index: silently return when cache tree fails
> >  - unpack-trees: fix nested sparse-dir search
> >  - sparse-index: silently return when not using cone-mode patterns
> >  - t7519: rewrite sparse index test
> >  - Merge branch 'ds/add-with-sparse-index' into ds/sparse-index-ignored-files
> >  (this branch is used by sg/test-split-index-fix.)
> >
> >  In cone mode, the sparse-index codepath learned to remove ignored
> >  files (like build artifacts) outside the sparse cone, allowing the
> >  entire directory outside the sparse cone to be removed, which is
> >  especially useful when the sparse patterns change.
> >
> >  Will merge to 'next'?
>
> I think this one is ready to go. Elijah chimed in on the latest
> version, too.

Yep, looks good to me.

> This also means that perhaps we could start tracking the sparse
> index integrations with merge, rebase, cherry-pick, and revert [1]?
> This series has also had quite a bit of review, but the latest
> version has not had an ack.
>
> [1] https://lore.kernel.org/git/pull.1019.v3.git.1631100241.gitgitgadget@gmail.com

v2 was already nearly ready to go, with just some very minor comments
and questions.  Your email responses to individual patches explained
most of the remaining bits, leaving just the typo, which you corrected
in v3.  So, I went ahead and put my Reviewed-by on it.

If this series had been picked up by Junio and listed in the "What's
cooking" email, I'd suggest it was also ready for next.

> I also plan to send a new version of the --sparse RFC [2], which
> is based on [1]. I don't want to get too far ahead of what the
> community has capacity to review.
>
> [2] https://lore.kernel.org/git/pull.1018.git.1629842085.gitgitgadget@gmail.com/

Sorry for not responding.  I found a simple typo but wanted to have
something more to say than just that.  I was happy with what looked
like the high level direction, and then noticed that Matheus was
giving you lots of good comments and he understood some of the details
better than me.  I'll try to find some time to review when you send
the re-roll.
