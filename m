Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076E6C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 18:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B96C1613C2
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 18:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhDTSu2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 14:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbhDTSu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 14:50:28 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD25C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 11:49:56 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e2so15859157plh.8
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 11:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mPBJKoOrtzp2v4BIvCquT6eT0NX9D5mT/w+1bo5s3VA=;
        b=u7wKrGO1hah7QN83V8cb403fakC04VIAkG0Cr29QrvKjTIe2xUcQV3zTGibv3IfN24
         5so5Vo0g454cnOT4y3LKqcja8tT7rAr/CVcX89c64Y8RcqPeUdJHow9GsVJ4ahFbrXBy
         FQ/fGEpdxRCRclEqi3Z+LRlMJs8YvwGVUIVd3GSN0U+YjhWeR93IQQ/5rgxP7PdOUopO
         br5jd9DlSP8ilXtIQ+ioH+877U9qjyvwjo2teQ3ZGdGFo/wAsPQTFcHxE0ao1vZ08v6k
         bdcDSnCFCFPVam1OjK2K349lrzgWJslbkDDkFgIP2EHlialw+nkTWTNW1PNcYbZZM/tq
         DtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mPBJKoOrtzp2v4BIvCquT6eT0NX9D5mT/w+1bo5s3VA=;
        b=HNmBJigpHa/YZ92/ksncGfGB4miU9vlOt8CnGCSIrBTBKHWbGIU2C+cZRXtEdR/5lj
         gvdVvAqmgRM3VJZrXHYSxzfr5kIbqDbpOrjbvuB7rVamDnrY9Xd2bddFR7lxSnihC9AN
         RPzBvKB3PCq5NJer9OM+Xr1Kt4lCivmr7RXK9KudORETLGkvP7jV07LE23RxnrEyGlAl
         WxgM26UjCpblkmtFLxOaFrEoDhnqE2pYZNvQhuknZLkGCCPlO9Y3vHZVKQIozc0/0N9V
         aOjgLoUrUjccznlU/LQqWEf/0uOrduGXXNyPGfsdbjFydzDF0hI9ZrVcJ/diMUiYV3Ul
         kWGw==
X-Gm-Message-State: AOAM531xyTUy0Yva2VFkeZCegXf/T6xlRfBbzs185Y9KoosttPlkfG2R
        ooATFWm0Uyv8b7eR+blJnCKOGT8k2p0dBA==
X-Google-Smtp-Source: ABdhPJzFWuxO2PXGI3OUpr7SGDIAZNozr4JK0KYBL10tW/h5O/XrH17hU4O49ow7bR/vJEwhgFvuHA==
X-Received: by 2002:a17:90a:c08f:: with SMTP id o15mr6622363pjs.22.1618944595697;
        Tue, 20 Apr 2021 11:49:55 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:828e:a107:e159:3343])
        by smtp.gmail.com with ESMTPSA id y14sm9082234pfm.123.2021.04.20.11.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 11:49:54 -0700 (PDT)
Date:   Tue, 20 Apr 2021 11:49:48 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, jrnieder@gmail.com,
        albertcui@google.com, gitster@pobox.com, matheus.bernardino@usp.br
Subject: Re: RFC/Discussion - Submodule UX Improvements
Message-ID: <YH8iTDNZpsoCu+lx@google.com>
References: <YHofmWcIAidkvJiD@google.com>
 <YH1+C47AErrCUkHI@pug.qqx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH1+C47AErrCUkHI@pug.qqx.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 08:56:43AM -0400, Aaron Schrab wrote:
> 
> At 16:36 -0700 16 Apr 2021, Emily Shaffer <emilyshaffer@google.com> wrote:
> > - git switch / git checkout
> 
> (snip)
> 
> > 4. A new branch with the same name is created on each submodule.
> >  a. If there is a naming conflict, we could prompt the user to resolve it, or
> >     we could just check out the branch by that name and print a warning to the
> >     user with advice on how to solve it (cd submodule && git switch -c
> >     different-branch-name HEAD@{1}). Maybe we could skip the warning/advice if
> >     the tree is identical to the tree we would have used as the start point
> >     (that is, the user switched branches in the submodule, then said "oh crap"
> >     and went back and switched branches in the superproject).
> >  b. Tracking info is set appropriately on each new branch to the upstream of
> >     the branch referenced by the parent of the new superproject commit, OR to
> >     the default branch's upstream.
> > 5. The new branch is checked out on each of the submodules.
> 
> In many cases the branch name for the superproject isn't going to be
> appropriate for submodules.
> 
> This seems likely to create a LOT of junk branches. Do you also have a
> proposal for cleaning those up?

Yeah, I think we have a point internally for "clean up alllll the
submodule branches that are unreferenced/already merged". You're right
that in a workflow where I have a superproject with eight submodules,
because I need them to build, but only do active development on one
submodule out of the eight, I'll have a ton of junk refs in the other
seven submodules. Yuck :)

 - Emily
