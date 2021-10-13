Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F5DC433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 21:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C665610FE
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 21:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhJMV6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 17:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhJMV6e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 17:58:34 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58031C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 14:56:30 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id ot13-20020a17090b3b4d00b001a04f094a68so4289593pjb.2
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 14:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=m8kiGnAL5hivUnJY8a4tUdjv/9vHn0kuqSRaumQZ1Ds=;
        b=HjIDDjdcoIP8FvXmRMMEDAskBNH0m9jGMrZtLCUmPCPzDWBI41hGq3DlzMueo+4UNu
         EaGpUzUcJoHWlJOjYxC3OgDtB8zbRAJkXC7HO7BGXpE2EP2EdbLPGvVXPhqjWSwO+KGc
         ExUPd/tigVkUaf301AwfDuDW93rAMegkFRo+wMxU/VTa2yGt7zikdw2Q/xM7f5f6eWaF
         GZOgG3GdRObvONnCAi3+f1emVbYzIOkVzXD+A25QvysvnGTfbUWKM1fFlOJVPSW75lLe
         q+c86DGHDxpO85J2atXNxJJhjt0Rb4VrBMEoDDxXYtJlCubf35e4ErR7gPvZDQxsWAK+
         M9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m8kiGnAL5hivUnJY8a4tUdjv/9vHn0kuqSRaumQZ1Ds=;
        b=ULCnssy+kONrJ+R16S6FKSscsz81bHP3KKguRwP/81qbwkk5Yl/Du1lbQiDjEKknxm
         9Kv7Sj0d3nPwNuupnzuwDmUnxUp65MQKm2ApTRX2Xr2wfZOt1HQcaFCEAF/QtttI8EuT
         YKXo2lxLbv6OGuQaW8XS35JBMd9TCPOPfvGrmn/nrfyo+AODfbmFw15equ9KS//Bbnnx
         zsth0YvNmwuoch4YhHNpAHYAUIzbvpqC7QI+81tLQO9JIsmHWQSCAs0BmGSUFPWJQ6uH
         xW0Kuv3nCw1rYKtG61I9G/I2vxQrf+5C3ZArYT8KgExQPnOMrQgaAeCpuXWQt3G/YGtj
         rGGw==
X-Gm-Message-State: AOAM533q4WO+FhrRebbLgozPqMzpwRNqehU+2dYoBOinjb6H2HYcEJV+
        Zw9Ns9xD+B7MDSohQ/zpI57rZytCYZ66bQ==
X-Google-Smtp-Source: ABdhPJwWKYz3ngkdGc4klYm7ORlVcXUy0RT8eZ0CVdNTZwytPlCfNNQJ2nS6r1Yy62hyrObrY4mUWCRLRrHLng==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4c8d:: with SMTP id
 my13mr2023081pjb.101.1634162189789; Wed, 13 Oct 2021 14:56:29 -0700 (PDT)
Date:   Wed, 13 Oct 2021 14:56:27 -0700
In-Reply-To: <xmqqtuhkfzw8.fsf@gitster.g>
Message-Id: <kl6ltuhk1tdg.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1103.git.git.1633633635.gitgitgadget@gmail.com>
 <20211013193127.76537-1-chooglen@google.com> <xmqqtuhkfzw8.fsf@gitster.g>
Subject: Re: [PATCH v2 0/3] remote: replace static variables with struct remote_state
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>    However, I believe that some questions *shouldn't* be answered by
>>    just struct branch. The prime example in this series is
>>    branch_get_push() - it conceptually answers 'What is the pushremote
>>    of this branch', but the behavior we want is closer to 'If
>>    configured, give me the pushremote for the branch. Otherwise, give me
>>    the default pushremote of the repo.'. This is arguably a relevant
>>    detail that should be exposed to callers.
>
> It is a good example why such a function can just take an instance
> of branch, and the caller,
>
>  (1) who does care about the fallback, can be assured that the logic
>      falls back to the correct repository; and
>
>  (2) who does not care about the fallback and sees it a mere
>      implementation detail of "I am on this branch; give me the
>      remote to push to", do not have to know what, other than the
>      branch object, needs to be passed.
>
> if we explicitly record a branch object which repository it was
> taken from.
>
> There may be some other (real) reason where the resistance comes
> from, that you may not be telling us, though.  But in what was
> described in the message I am responding to, I didn't see much
> convincing reason to argue _for_ keeping the contained objects
> ignorant of the container and forcing callers to pass both to
> functions that use both the container and contained to compute
> something.

My primary line of thinking is that adding the backpointer from struct
branch to struct repository adds "unnecessary" coupling between the two
objects, which causes the more concrete problems of:

* Inconsistency between other functions that use struct repository as a
  "context object". We now find ourselves having to justify why branch
  functions can bypass the context object using a special pointer,
  whereas other functions and structs (say, struct object) cannot.
* Interface misuse, where callers can now dereference branch->repository
  even though it is meant to be internal. This is also a possible source
  of inconsistency.
* Extra memory consumption.

A counterpoint to what I said is [1], where Jonathan eventually added
the backpointer from struct ref_store to struct repository, which does
give the nice benefits of referential integrity and abstraction that you
cited. However in most of that series, struct ref_store is meant to be
the context object, but due to poor internal abstraction, ref_store ends
up depending on repository in some form or another and thus the
backpointer is more defensible (as opposed to passing two context
objects). I do not think we are in the same position with struct branch;
struct branch seems sufficiently separated to me.

I'm not opposed to adding a backpointer if it helps us get to a good
final state, but I currently suspect that the final state still involves
passing around struct repository as a context object.

[1] https://lore.kernel.org/git/xmqqlf3gib0p.fsf@gitster.g/
