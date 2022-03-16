Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79046C433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 03:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353453AbiCPDam (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 23:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353450AbiCPDak (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 23:30:40 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A864C7BC
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 20:29:25 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id z8so1355658oix.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 20:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mv0kHY+jzB4wsnV4mnHkMQTr45+mxtc/gcR9mA/fYlI=;
        b=W27wfmvWCnpY3MVwVGYVupk8d2/H78zxMZVGUaCyJINodLD+O9r4pqTLnS/JXuE+QX
         doq2dcsqWCW+2M1SqlztZhJDLhg19rnnqCiBs/CRI8RvYYPM8uLGpwo+emU1rZdmZr6C
         5THmqO2pJj6cD4kpsmOVcSbh2Se+bfT0OiPwBDZZq/mWuuY2Db4j/uQ7gwE+hYD8Fe1U
         /Cd9lsUtpYH/HvBl4079gGhAHNWlZf39lKLRlTGgi7oRXdzVXYJm9fuuK5PXPdM8Art9
         QXU6rtmQWiRjzPMVDWudilDW5aosX/50ba0+8fd3ErMiNaVLQE2ygKTd71fHKda7abRv
         PsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mv0kHY+jzB4wsnV4mnHkMQTr45+mxtc/gcR9mA/fYlI=;
        b=nmC265ngcUhGuf8wQ8MxtaqZronFXO8zCJWGE4yKvZH9zG3IMHWtwLwYAO09YH1lKB
         VcpBDaQ+z+Pp0tbbx9UZxYdYptkXO2SJuumYu4L6s6LTjqvWSkjqYdFuA0c4F/odE56t
         o/WGpB6birpzJ06GqSByK2VsK6gdIF6xfk+RAro2u/sjuZIgj5gxR8ZQGXhuhO40rX/V
         g/NWGdmMR7BbBBBBJ6/xJZimP/OXDwSn9LR+f8WGIwDiKBfRPdGLo85GIxCi/EQPKVuR
         eR4wVBCBfBu/ZASls2fBSqTHN0rUKeKaNW8ArWzNrIuhNOhKL0z2nF4twgCGPPT7mcqF
         2+PA==
X-Gm-Message-State: AOAM533E9/OG1p4Q0UY0stAjAlf4BZiC2mxONlULsR5iojgkL9rRbzgI
        f8WJxSqYuR6hO8iwwEG6HwTAd8neotpiPLDpMJIFjJMnwL4=
X-Google-Smtp-Source: ABdhPJy9hoNcIWSpe1dv1EgP61jcshy/5Slfyyg6udy8M2W2k+FaOhpUsNk5Mv76LoxqK+nSX+upPq2ZCrlbUnj4iPc=
X-Received: by 2002:a05:6808:f8a:b0:2da:1e9b:e85d with SMTP id
 o10-20020a0568080f8a00b002da1e9be85dmr3154396oiw.111.1647401365302; Tue, 15
 Mar 2022 20:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
 <20220315100145.214054-2-shaoxuan.yuan02@gmail.com> <1ab24e4b-1feb-e1bc-4ae4-c28a69f77e05@github.com>
 <20ffd93d-e3dd-4df6-5ec7-d3577cac910d@github.com>
In-Reply-To: <20ffd93d-e3dd-4df6-5ec7-d3577cac910d@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Wed, 16 Mar 2022 11:29:14 +0800
Message-ID: <CAJyCBOTATLNyhE8A7_M9HnuS_QM0dR0H2yQ2_4VRP=XgEKP7ow@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] mv: integrate with sparse-index
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Victoria Dye <vdye@github.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 16, 2022 at 1:14 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> Hello!

Hi Derrick,

>
> > I'll answer your question "are the tests on the right track?" [1] inline
> > with the tests here.
> > In 't1092', I've tried to write test cases around some of the
> > characteristics relevant to sparse checkout/sparse index. For example:
> >
> > - files inside vs. outside of sparse cone (e.g., 'deep/a' vs 'folder1/a')
> > - "normal" directories vs. sparse directories (e.g., 'deep/' vs. 'folder1/')
> > - directories inside a sparse directory vs. "toplevel" sparse directories
> >   (e.g., 'folder1/0/' vs. 'folder1/')
> > - options that follow different code paths, especially if those code paths
> >   interact with the index differently (e.g., 'git reset --hard' vs 'git
> >   reset --mixed')
> > - (probably not relevant for 'git mv') files with vs. without staged changes
> >   in the index
> >
> > I've found that exercising these characteristics provides good baseline
> > coverage for a sparse index integration, not leaving any major gaps. I'll
> > also typically add cases specific to any workarounds I need to add to a
> > command (like for 'git read-tree --prefix' [2]).
>
> This, and other advice that Victoria mentions, are really
> good points to keep in mind.
>
> > My recommendations:
> >
> > - add tests covering outside-of-sparse-cone 'mv' arguments
> > - add tests covering 'mv' attempting to move directories (in-cone and
> >   sparse)
> > - add some "test_must_fail" tests to see what happens when you do something
> >   "wrong", e.g. to try to overwrite a file without '-f' (I've found some
> >   really interesting issues in the past where you expect something to fail
> >   and it doesn't)
> > - add 'git status --porcelain=v2' checks to confirm that the 'mv' worked the
> >   same across the different checkouts
> > - remove multiples of test cases that test the same general behavior (e.g.,
> >   'git mv <in-cone file> <in-cone file>' only needs to be done once)
> > - double-check whether '-v' and '-k' have the ability to affect
> >   full-checkout/sparse-checkout/sparse-index differently - if not, you
> >   probably don't need to test them
> >
> > Thanks for working on this, and I hope this helps!
>
> You mention in your cover letter that the ensure_not_expanded tests
> are not added yet (same with performance tests). Now that you've
> gotten feedback on this version of the patch, I might recommend the
> organization you might want for a full series:
>
> 1. Add these 'mv' tests to t1092 _without_ the code change. These
>    tests should work when the index is expanded, and making the
>    code change to not expand the index shouldn't change the
>    behavior.
>
> 2. Add the performance test so we have a baseline to measure how
>    well 'mv' does in the normal case (and how it is slower when
>    expanding the index).
>
> 3. Make the code change and add the ensure_not_expanded test,
>    since the functionality from the tests added in (1) will not
>    change and we can report the results from the perf tests
>    added in (2). The only thing to test is the new, internal
>    behavior that the index is not expanded when doing these
>    actions. (Keep in mind that we expect the index to be
>    expanded for out-of-cone moves, but it's the in-cone moves
>    that we expect to not expand.)

Thanks for the recommendations, they are really helpful! I will try to
address them in the next patch :)

-- 
Thanks & Regards,
Shaoxuan
