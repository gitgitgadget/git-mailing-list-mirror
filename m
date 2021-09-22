Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D39CC433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 17:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558AB610D1
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 17:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbhIVR0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 13:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbhIVR0W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 13:26:22 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB6CC061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 10:24:52 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id r18-20020a056214069200b0037a291a6081so12727358qvz.18
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=akbNRFJ24tnlfI8B9+Cr8EoP6JnmI33dCsfF32gLDS4=;
        b=mPKMldbGbdLjOce9iAu785YYFwW2s1L8r/gXxlGClc1u1F3eIr0X260S2Hlujhdg2P
         4Nrv7F5Y63a91gq0TrP6/0BYZsHbtjlmaJmNxTDS1RBW/V4MaZ8ZYSbMVeU++hFgZ/u4
         PUXtJQDgA08A9jOQEr8t+qFv3O1eJK6hY4+34ncPRVw5U3oKz5jFMAv/Tp6xCpe32t41
         /1ObpBByBEoI0d3brvZ1/yh8/Zza2r/4CByqWkrYLYpeuaoRLLHOwJHD8clM6M4scWt5
         LOtB6EXrt4Qq6CEV+YqgFR9r4YaNLSCd0iJV524gdN009aMMmZgOuH2/3HKggBetsClm
         KSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=akbNRFJ24tnlfI8B9+Cr8EoP6JnmI33dCsfF32gLDS4=;
        b=hLd/kCxlmpbAQt24Jnbq+H8+qzIbln939hoM5oQtqGygpw4J7l+Jx7knAGdRiuMgOl
         i8rNYTTUQSM1fivKkP9QLj0Izhvha4DUw9tnkIqWTRW2yMY5Si29QGvcgjhLacejLREl
         EeKKutgwVO4PuSQKzI4xClCOqd+FHFtXkibp+Mbl1GPGyCWpqzcMpcx4bMciK7X9LyPB
         FPQ9s7sGXNYU4wzlCHSONzeGM7uxEiuHHKJA05HLLTedYCPPpFTtwtyumMTr5FDuRSSu
         ofeR1J2qZvAkXtDeuZ/FU4TwkbT8qc4OuuTfB0/kIbaUVxfDp7a+WlEWHb3wiTf7j9NI
         nj/Q==
X-Gm-Message-State: AOAM531NvkC9MruSjua7MdQkJ/K08rdh8h4fut5LxRgs+VFzYX29Lvkd
        xl8NUKfktW7Z7JwqVF/1IKM1NybW1QG4XQ==
X-Google-Smtp-Source: ABdhPJzqwr1jTRA0tH7LQ23E+P0kUi1JBwRgyMz+JcUgJ/JZ0Cs9/7MO7TW8qUVDQ6gA4nyCG2kiqCEQS7ZzpQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6214:3ea:: with SMTP id
 cf10mr228883qvb.53.1632331491884; Wed, 22 Sep 2021 10:24:51 -0700 (PDT)
Date:   Wed, 22 Sep 2021 10:24:50 -0700
In-Reply-To: <084caed9-5854-9fe2-8476-b5325ddac52c@gmail.com>
Message-Id: <kl6lsfxw34m5.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20210921232529.81811-1-chooglen@google.com> <20210921232529.81811-3-chooglen@google.com>
 <084caed9-5854-9fe2-8476-b5325ddac52c@gmail.com>
Subject: Re: [RFC PATCH 2/2] branch: add --recurse-submodules option for
 branch creation
From:   Glen Choo <chooglen@google.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>> git-branch will create the "topic" branch in the superproject and all
>> submodules.
>> 
>> recurse_submodules is only supported for creating a branch. git-branch
>
> small nit: we usually don't refer to the dashed form of commands anymore: 'git branch'
> would be preferable.

Ah, thanks! I really appreciate the style pointers.

> However, I think that for this new feature, I would prefer *also* having
> a new config 'branch.recurseSubmodules' (or similar) that would allow
> more granular control than 'submodule.recurse', which influences several
> commands. Personnally I have 'submodule.recurse' set to true in my '~/.gitconfig',
> because I want the submodules working trees to be updated when I use 'git checkout'
> to change branches, 'git grep' to search the working tree, etc., but I usually
> do not *work* on the submodules in my project and I would not like new branches
> being created in them every time I create a new branch in the superproject.
> In other words, 'branch.recurseSubmodules=false' would have higher priority
> than 'submodule.recurse=true'.

That's a good point. This behavior of git branch --recurse-submodules
has the potential to directly conflict with established workflows.
Opting out via 'branch.recurseSubmodules seems reasonable and I think we
definitely want to give users that fine-grained control. I wonder
if we should take this even further - perhaps --recurse-submodules is
too disruptive to be controlled by the config value as checkout, fetch,
pull, etc.

Perhaps submodule.recurse should be more fine-grained, so we can ship
good defaults for different workflows e.g. options that map to the
current true/false behavior and another option that includes branching
(I wish I could give these names, but I have no clue what to name them).

> Most tests for submodules are usually in separate test files. I don't think
> this is a set-in-stone rule, but if more tests are coming in the future, maybe
> a new test file t????-branch-submodule.sh would be appropriate ? Just a small suggestion.

I think that's a good call. It also looks like the tests in this file
are somewhat old, so it would be nice to start on a clean slate :)

>> In this patchset, branching works slightly differently between the
>> superproject and submodule (skip ahead for specifics). There are two
>> very obvious alternatives that can address this:
 
>> * A: only implement --recurse-submodules behavior after we are able to
>>   eliminate any kind of dependence on the_repository/global state that
>>   shouldn't be shared.
>> * B: implement --recurse-submodules as child processes, which won't be
>>   bothered by global state.

Your comments on the UX make a lot of sense, and I'll think about that
more carefully. Let me know if you also have thoughts on the
implementation itself, particular on in-process vs child process :)
