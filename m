Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B035C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 05:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F135A60F70
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 05:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbhIUFSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 01:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhIUFSX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 01:18:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42DBC061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 22:16:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id h3-20020a17090a580300b0019ce70f8243so1110368pji.4
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 22:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1B3Ut8jVIVQuMCptzDzJJu6GVj5N0I4t0bBBWKdsub8=;
        b=Si5IfrZO0tod69G3jBPDcqNirlqEtC8sJYP/1UlfvwjeqxQytL0ezV1cpjXVzHS44L
         f8kingOhhcpamgzNyi/5mSO0Wu8/sQOAlZFsrWnCVVXbdFc2dWDjxBxrag3YkpvV1Crs
         k1wipgA2qDj27WZpjZl/HvIz2WDoAiug8iywFGtN3xgXoeaex6pnC1V/S47K5W6nlIpg
         p8o1qG/03AnG+PiA0LYwabUxxUQI7Z9McBcCbYVG1L0twD9YsV/YFYlbbc0M9C1pe9MI
         5BNBUza1DQlQEEeTzkoc2BqwoffcPzMbLNGBqBZiyBfSLBer0tt76b2bZ2po9YpQEz00
         GVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1B3Ut8jVIVQuMCptzDzJJu6GVj5N0I4t0bBBWKdsub8=;
        b=y/F0aSVTu+QviGHNTjEgXWDKOuxQAA/2Fgi/OINY2zg/CkDaCHnHvLopJahb1RtJpG
         xcJCa4cCugscxbHFEmbw4K/5W/+IUWHaSDMP4F4wznexsxec64ltsBBT2TdtWbK8jD8x
         gK54YvNEmfMFilvEldIp9kIBLQuR3fCFWFKLNwJt4pozhPTMUrlNNSTTLscnpj2PSH90
         sFi9ewH6jZkARNCYli8zox7HpjPjLtO2D3WBANAY4F8Z0cA9LMHaxCltgCIOsCk9iEcL
         MbBqG35IE81cCLeOnM8o3xfhkMjS9bOPsSBYCD5MvBUXedjENuLLj7GEDeq7hBpZcgTc
         Oe/g==
X-Gm-Message-State: AOAM531VHaxeJaYnYeR1RXGeZo55XRORSugHOJ4w1gmRlhNYZK02jJAq
        4JbmRzRx/bjCJ6l8i9MHfBTHOO0BzdH6PNz3FCDt5WH7dCA=
X-Google-Smtp-Source: ABdhPJzwGKEWGtbNhHJDeQ8YZdjNhS0nUo9JLHFUuBraDs54msQDAChP5+oSRAOEgh/IFsHX9oNTEXBoOk764FKMx9A=
X-Received: by 2002:a17:90b:4a88:: with SMTP id lp8mr3077003pjb.159.1632201415106;
 Mon, 20 Sep 2021 22:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <CADzhcq7uoSji_PwTDU1zkgB-xWDSn5mQ+55+3JX_wkOr2s7H9w@mail.gmail.com>
In-Reply-To: <CADzhcq7uoSji_PwTDU1zkgB-xWDSn5mQ+55+3JX_wkOr2s7H9w@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 20 Sep 2021 22:16:44 -0700
Message-ID: <CAGyf7-FAHJOb6iQYqYNt0WSk+zUHUJ_FjrU1xis1bBQd9Z6KPQ@mail.gmail.com>
Subject: Re: Git submodule lists reference to a different tag than specified
 when checking out tag for submodule
To:     Sergii Shmarkatiuk <sergii.shmarkatiuk@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 7:22 PM Sergii Shmarkatiuk
<sergii.shmarkatiuk@gmail.com> wrote:
>
> Hi! I want to report an unexpected behavior of the latest version of
> git that I faced today.
>
> > What did you do before the bug happened? (Steps to reproduce your issue)
>
> I have initialized two tags Dev/0.x.0 and User/0.x.0 in a repository
> that is referenced as a submodule in another repository. Both tags
> refer to the latest commit. First I created Dev/0.x.0, then
> User/0.x.0:
>
> cd ~/projects/repo1
> git tag Dev/0.x.0
> git tag User/0.x.0
> git push --tags
>
> cd ~/projects/repo2
> git submodule add https://path-to-repo1/repo1.git
> cd repo1
> git checkout User/0.x.0
> cd ..
> git add repo1
> git commit -m "moved repo1 to the tag User/0.x.0"
> git push
>
> > What did you expect to happen? (Expected behavior)
>
> After performing all the steps above I expected the output of the 'git
> submodule' command to look as follows:
> git submodule
>  c575d777d33a0f1095875c7b55753eb59a51daba repo1 (User/0.x.0)
>
> > What happened instead? (Actual behavior)
>
> Instead, output looks as follows:
>
> git submodule
>  c575d777d33a0f1095875c7b55753eb59a51daba repo1 (Dev/0.x.0)

I suspect the answer here is going to be that this is how it's
designed. The "commit" entry in the tree records exactly that--the
commit hash in the submodule repository; it doesn't record any name.
That means any ref name shown has to be inferred. Couple that with the
fact that ref names are alphabetized (so the "Dev" version of the tag
will always appear first) and the "Dev" tag will be the one it shows.

This same issue existed for "git clone" for quite a while, before Git
started including symref details for "HEAD" explicitly in the wire
protocol. Before that, the client would see "HEAD <some-hash>" and it
would find the first ref matching that hash and it would check out
that ref. The end result was a lot of bugs being raised (both here on
the list and in issue trackers for forges like Bitbucket Server)
because Git was checking out the "wrong branch"--and sometimes
"randomly" (for example if a workflow is in use where multiple refs
_sometimes_ address the same commit hash, but don't always).

>
> > What's different between what you expected and what actually happened?
>
> Submodule references different tag than specified in the checkout
> command (Dev/0.x.0 instead of User/0.x.0)
>
> [System Info]
> git version:
> git version 2.33.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.11.0-34-generic #36~20.04.1-Ubuntu SMP Fri Aug 27
> 08:06:32 UTC 2021 x86_64
> compiler info: gnuc: 9.3
> libc info: glibc: 2.31
> $SHELL (typically, interactive shell): /bin/bash
