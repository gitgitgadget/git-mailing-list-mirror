Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969CFC4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 18:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbiKVSoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 13:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiKVSo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 13:44:28 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C077EC8D
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 10:44:27 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 62-20020a250541000000b006ef62e56e90so855422ybf.7
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 10:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1fGJ4u8jFn3YQyTghb8k+d4AnI2c4ULMCvyMnNfS/vo=;
        b=h8LQvmJMy0spmESmhaJPMB3loneJlh0T81Mgc32qtCzFGDVUMg60P0xNcAvJT2dcza
         hVfCcTOUbuCmrJBK6S6RCw0x1t2E2XfvyIoy0S5QsENZyNvpuZ3igNg2ng0YvfYYltuG
         m9g5mkDuXuzlBFMqtncu4U961A4YuTNI8Ga94m50rQNSeYYNF1blcXtNdwYAnx6SefS4
         gFP+A7n//lZuKd5p+wNV9kgd5FWWarmxzTgkNoZpVFMV4VOHZG6Clry+o/KagXR75jUv
         5qGhRtqmDGy75x9XBdSjAzYH2DyzuIAFgCTTscFgxWW53Q7mK3DgCwDr9tXzRzIHtsxM
         RaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fGJ4u8jFn3YQyTghb8k+d4AnI2c4ULMCvyMnNfS/vo=;
        b=z2JhYzYNVmCLMKtslEegnIe/4yllQbeej9mgYUraM8ohxbD8/5RsKceI11WchcrV3L
         d2fXcZgNB0X2VieoZrNMwQak2qek8bx/8IiJXHj6mAHYcGroKOIydEkCSO6YcjODhjna
         u6kvHzaDDPzuvp6SMmDSXmU5t6OdWrNNjurLKVjDVap5xQWvhMnBbEs4XEPRL8iN8JUa
         gO4Kp/HVtj8ejU80ZYjCxq2ARu21sB9WRN4X/v89pahRlItHJLwUasnu81qyCDS5m49j
         +6BV2v/PDTwDnSxrmtf8xtWkB7RSuZn5+3K7IKQv/s14NM2WJTnXKfpxC8GoZPTh8o+B
         5KtA==
X-Gm-Message-State: ANoB5pl27nXWtyeIrFp+Pdpa8Pn8cMXipaEuY6SJneDkbGcfZQTRlqTu
        JScLXwIJb3/6kER838Ut0yV75O2qnMqpSg==
X-Google-Smtp-Source: AA0mqf4kycVL/+ykqdIdnNlxMGwlYqJeSXbX38jvS1VTJdRRpOSL5RILu3MA8yXmKvbFYfhxbfupPQRbY3DwIg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:7b47:0:b0:6ef:ce30:2026 with SMTP id
 w68-20020a257b47000000b006efce302026mr92396ybc.480.1669142666712; Tue, 22 Nov
 2022 10:44:26 -0800 (PST)
Date:   Tue, 22 Nov 2022 10:44:25 -0800
In-Reply-To: <20221115181524.164472-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20221115181524.164472-1-jonathantanmy@google.com>
Message-ID: <kl6lmt8iesmu.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 8/8] clone, submodule update: create and check out branches
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the thoughtful response, Jonathan :)

Jonathan Tan <jonathantanmy@google.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> +# Test the behavior of an already-cloned submodule.
>> +# NEEDSWORK When updating with branches, we always use the branch instead of the
>> +# gitlink's OID. This results in some imperfect behavior:
>> +#
>> +# - If the gitlink's OID disagrees with the branch OID, updating with branches
>> +#   may result in a dirty worktree
>> +# - If the branch does not exist, the update fails.
>> +#
>> +# We will reevaluate when "git checkout --recurse-submodules" supports branches
>> +# For now, just test for this imperfect behavior.
>
> I think the rationale for this behavior is as follows:
>
> We want a world in which submodules have branches and Git commands use them
> wherever possible. There are a few options for "git submodule update" when the
> superproject has a branch checked out:
>
> 1. Checkout the branch, ignoring OID (as in this patch).
> 2. Checkout the branch, erroring out if the OID is wrong.
> 3. 1 + creating the branch if it does not exist.
> 4. 2 + creating the branch if it does not exist.
> 5. Always forcibly create the branch at the gitlink's OID and then checking
>    it out.
>
> At this point in the discussion, for a low-level command like "git submodule
> update", doing as little as possible makes sense to me, which is 1.
>
> But since we do not automatically create the branch if it does not exist, this
> means that we have to do it when we clone the submodule. Our options are:
>
> A. Create only the branch that is checked out in the superproject (as in this
>    patch).
> B. Create all branches that are present in the superproject.
> C. Go back on our previous decision, switching to 3.
>
> My instinct is that we want to maintain, as much as possible, the invariant
> that for each branch in the superproject, if the branch tip has a gitlink
> pointing to a submodule, that submodule has a branch of the same name. And I
> think that this invariant can only be maintained by "git submodule update" if
> we use B or C.

I think C is good to have in this series, though for slightly different
reasons.

I agree that the invariant should be preserved when we check out
branches both in the initial clone and in subsequent checkouts. However,
I don't think that we necessarily need to have all superproject branches
after the initial clone. Even if the submodule only has a single
superproject branch, that's enough to have an ephemeral clone for
writing small changes. We could defer the "all superproject branches"
problem til after we worry about subsequent checkouts (i.e. "git
checkout" with branches).

We can handle "initial clone" and "subsequent checkout" as smaller, more
digestible series as long as the work for "initial clone" doesn't get in
the way of "subsequent checkout". My plan (as of v2) was:

- For the intial clone, create only the checked out superproject branch
  at clone time and check it out (aka A)
- For subsequent checkouts, check out the superproject branch, creating
  it if it does not exist (aka C)

But it doesn't make sense to mix both A _and_ C, since C would already
give us the same result as A, so it probably makes sense to go straight
to C in this series (i.e. only for the initial clone, not subsequent
checkouts). I'll do that in v3.

I prefer C in the long run, since both A and B require that the list of
submodule branches never get out of sync with the superproject, which is
hard to enforce, e.g.:

- The user could create a branch in the superproject without recursing
  in to submodules.
- The user could delete the branch in the submodule.
- (Worst yet) The process that creates branches in the submodule _after_
  creating the branch in the superproject could exit unexpectedly (e.g.
  SIGINT). There is no atomic way to create branches in both repos.

We could create a command that would repair broken branch states ("git
submodule repair"?), but C can self-repair, which avoids this problem
entirely.
