Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F824C433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 23:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346664AbiAKXWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 18:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiAKXWW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 18:22:22 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEB6C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 15:22:22 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id n23-20020a17090a161700b001b3ea76b406so1810811pja.5
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 15:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TyKzLtXA2LkxH5pFjfehoBghG41OGfJ48eBLaCeedO8=;
        b=Ew/YfmSlJlfXVMbhuMSmCP+M+VpNEkhDQGvba5uPQAQmzFxYpx4UYfsOoix5UAKZVM
         mMXBJMttq+7/MTds/vScs+gmYAE+uquNlFfLrFAqJE5OhdiedGKVvaQE5vdZZFRzJ8zA
         OAmucXv4fORLIDMmeGDOvdUusZ90H+AfmvvXLeZ5pDbeYfsEWPrMzMM6HPFEfkd9SnB0
         Kj7Hw31FqGJg5E5I6NrLKhKD3on++6rGPgU+7f0/5+As1vIEglZgVnHrzinhY2q7K+99
         5P2FuBS4ONWSjH+otQgUzcswIUaCcIl6w3CU3raLF2zKUWpZvWsevyyAo1xA7nC1hkBp
         w1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TyKzLtXA2LkxH5pFjfehoBghG41OGfJ48eBLaCeedO8=;
        b=nX5MNqKrwafQ+QWWYEC7hLS0Ro+7YPaRqFH5wfz1ZK2fzNuHHsS807DxIdkBlv3JBF
         MPBBZU2WCWEdtOdFQFNBAU8AHuSaKp2GkDCHXfZHSJTJflsHqk3aw2HQoQWSG5HB1HZW
         YY97Zb/xDXh6zfyEshZzb2/lEWhgkIa/Bx4zNoCokdln9v5AvMOaf3GjrV9jKB+DTQ3O
         7TyGJ/YOSWzukJCBdiINBSXkYt40McE6zDaNgzMpTY8ZEiFPcZBJkN2LPablJbFeYvZv
         38APUzV4gk9VpMbmpB3DDI9BY1b/r7MCBH/LDkLdqQt8WsG92BcBfIZZ4+ByIgzsMyIy
         USEw==
X-Gm-Message-State: AOAM533ZfMIgMJbZ0llW5vThvzXuVArZc/LmM3XqhPoPMYOtb9JCLYlt
        JAAYzdgpj5vBizrIbI16Sww9UqQsM11DEw==
X-Google-Smtp-Source: ABdhPJyQzDbj5EmuOA/MrrJozPz9ehGNK4z/avfItglyV/cEEaCmfhyPd+H2orKbAbqrGIyTxgQ88pGNPBIIQw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:e88e:b0:14a:5eb3:5adb with SMTP
 id w14-20020a170902e88e00b0014a5eb35adbmr2931136plg.160.1641943341480; Tue,
 11 Jan 2022 15:22:21 -0800 (PST)
Date:   Tue, 11 Jan 2022 15:22:11 -0800
In-Reply-To: <20220111201556.26345-1-jonathantanmy@google.com>
Message-Id: <kl6lzgo1j1ss.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6l4k6akurn.fsf@chooglen-macbookpro.roam.corp.google.com> <20220111201556.26345-1-jonathantanmy@google.com>
Subject: Re: [PATCH v6 5/5] branch: add --recurse-submodules option for branch creation
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     jonathantanmy@google.com, git@vger.kernel.org, steadmon@google.com,
        emilyshaffer@google.com, avarab@gmail.com,
        levraiphilippeblain@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Glen Choo <chooglen@google.com> writes:
>> >> +test_expect_success 'should create branches if branch exists and --force is given' '
>> >> +	test_when_finished "cleanup_branches super branch-a" &&
>> >> +	(
>> >> +		cd super &&
>> >> +		git -C sub rev-parse HEAD >expected &&
>> >> +		test_commit -C sub baz &&
>> >> +		git -C sub branch branch-a HEAD~1 &&
>> >> +		git branch --recurse-submodules --force branch-a &&
>> >> +		git rev-parse branch-a &&
>> >> +		# assert that sub:branch-a was moved
>> >> +		git -C sub rev-parse branch-a >actual &&
>> >> +		test_cmp expected actual
>> >> +	)
>> >> +'
>> >
>> > Should we create branch-a at HEAD instead of HEAD~1?
>> 
>> If we create branch-a at HEAD, we won't be testing that --force moves
>> the branch head. 
>
> Walking through the lines of the test:
>
>> >> +		git -C sub rev-parse HEAD >expected &&
>
> So "expected" is sub's HEAD at the start of the test. Let's call this
> old-head.
>
>> >> +		test_commit -C sub baz &&
>
> We create a new commit on top, whose parent is old-head. Let's call this
> new-head.
>
>> >> +		git -C sub branch branch-a HEAD~1 &&
>
> We create a new branch at HEAD~1, which is new-head's parent, which is
> old-head. So this branch points to the same thing as "expected".
>
>> >> +		git branch --recurse-submodules --force branch-a &&
>
> When creating new branches with "--force", any branch information in the
> submodule is ignored. So we would expect "branch-a" in sub to be
> overridden from "old-head" to "old-head".
>
>> >> +		git rev-parse branch-a &&
>
> Verifying that branch-a exists, although upon second look, this would
> work whether or not we recursed, so maybe this line can be deleted.
>
>> >> +		# assert that sub:branch-a was moved
>> >> +		git -C sub rev-parse branch-a >actual &&
>> >> +		test_cmp expected actual
>
> A check, as expected.
>
> Unless I missed something, branch-a was never moved - it was created at
> "old-head" and then the "branch --force" is supposed to create it at
> "old-head" anyway. It would make more sense to me if the branch was
> created at "new-head", and then "branch --force" moved it to "old-head".

Oh, yes, I tested this and you're right. That's a really good catch - it
would have been hard to spot amongst all of the tests. Yes, I should
have set it up the way you described. I'll modify the test to assert
that "branch --force" moved the branch and instead of creating it where
we expected.

>> This means that the test might pass if we simply ignore
>> any existing branch-a - which is not the intended behavior of --force,
>> but this is behavior that we might want in the future (probably using
>> another option).
>
> By "ignore", supposing that there is an existing branch-a, do you mean
> overwrite branch-a, or not create any branch at all?

What I meant was that if branch-a was not moved, the test would pass
if we did not create branch-a at all (and that we might want an option
that will not create a branch if it already exists).

But.. that comment was made under wrong assumptions - I had assumed that
branch-a was moved, and that your proposed fix would not move branch-a
(which is the complete opposite of reality). We agree that the test
makes more sense if branch-a is moved.
