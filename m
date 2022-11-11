Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA69C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 19:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiKKTpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 14:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiKKTo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 14:44:58 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9476465
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 11:44:57 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id k19so5609073lji.2
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 11:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=digp64BITl5fXCnVwPi6FpMjmwqPGQ3/NK7+Z+skOZY=;
        b=TVsax2F6UOVylrBZ6EpzINpIj7/H8vrwLKH909Y3B35Lpww9q5gbfKUmSVOXdUYmnl
         HUsK8lF3mReavb18+6krOwyvewoIUb+WND5dopDDKo/tN022epXNHuc4U4vs2EoAg9VU
         65CUx1WtypYdlKozypxSAI+GcCS5ALeb5c4XqBfPo/WXU8e+JNd97qRO2dqXteDVypSs
         D21QSG+d2miMq/a/qTmEqsI5J8C+T7a80Y9Eka0U/0XVkysImx64nRRNZOqZ4QNqotCl
         jtOEY+YlaSM2iIUtXwjWM8ud685vpDfV0Jlr8Sr/4K3p+wkNopEzjRlmLf1RfhOyD8Dk
         jfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=digp64BITl5fXCnVwPi6FpMjmwqPGQ3/NK7+Z+skOZY=;
        b=u8PxfWLLj4kve/aorjDJj6GXEi3XP+1NLl0Td/Z0zVd8ngOucwpgH8CxsqvLO/+HaU
         ZmA57RVdeiQQfOAlFqn2ERAa5XSH7mxtUbpBy9OPjb4CoWpPECZr8DsvO0SN9cmwu575
         oZh683lr/voksQeo42LHeCAlpZDwfE2Puxqm3rT2A74OWFY/orsAzbTaR5F/5mhEr9o4
         23dU1h5Q+p2EYWIkqpcqSPNNrM4+QKYOxQqkgwerAVSJR40NDa01ZPeIHleNSE4VIP3t
         89205xo+HAJXJ2NddsesHdA9XIh6TFkftvrKNZlAXq3+tow/myqf1QEJEk+qpYK23MM7
         2O9g==
X-Gm-Message-State: ANoB5plgDlYETG3PT16Y0Q7CD/jd+EQoyh3DDRgSKCW6KLb0SvJ91J1M
        uWxEomOGjytLbnSruuGv4ETWbdVIT2n5vZZurMFb/xEE
X-Google-Smtp-Source: AA0mqf7LlHeUdSsBSKS/8y93FZNf85O5GHdUuIWyVj0v1bjWm1OeRjRdT9ymSf7GOKlBUY9LbgHUHg9ofzGzK5Ov+G8=
X-Received: by 2002:a05:651c:117:b0:277:423a:fcc4 with SMTP id
 a23-20020a05651c011700b00277423afcc4mr1218764ljb.325.1668195895816; Fri, 11
 Nov 2022 11:44:55 -0800 (PST)
MIME-Version: 1.0
References: <pull.1397.v5.git.1667446182.gitgitgadget@gmail.com>
 <pull.1397.v6.git.1667472621.gitgitgadget@gmail.com> <40d56544e6e319605d02bab743a6e957ff0a5926.1667472621.git.gitgitgadget@gmail.com>
In-Reply-To: <40d56544e6e319605d02bab743a6e957ff0a5926.1667472621.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Nov 2022 11:44:43 -0800
Message-ID: <CABPp-BFgjT7b5EyVU7P4YpGvGZk9xfV+nDJG2UBtGc2c3VqeFw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] merge-tree.c: allow specifying the merge-base when
 --stdin is passed
To:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Kyle Zhao <kylezhao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the delay; my Git time has sadly been quite limited.  :-(

On Thu, Nov 3, 2022 at 3:50 AM Kyle Zhao via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> +# Since the earlier tests have verified that individual merge-tree calls
> +# are doing the right thing, this test case is only used to test whether
> +# the input format is available.

"the input format is available"?  I'm not sure exactly what that
means, but it seems almost certainly to not be the only thing it is
testing.  Perhaps you meant something like:

# Since the earlier tests have verified that individual merge-tree calls
# are doing the right thing, this test case is only used to verify that
# we can also trigger merges via --stdin, and that when we do we get
# the same answer as running a bunch of separate merges.

> +
> +test_expect_success 'check the input format when --stdin is passed' '
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       test_commit -C repo c1 &&
> +       test_commit -C repo c2 &&
> +       test_commit -C repo c3 &&
> +       printf "c1 c3\nc2 -- c1 c3\nc2 c3" | git -C repo merge-tree --stdin >actual &&
> +
> +       printf "1\0" >expect &&
> +       git -C repo merge-tree --write-tree -z c1 c3 >>expect &&
> +       printf "\0" >>expect &&
> +
> +       printf "1\0" >>expect &&
> +       git -C repo merge-tree --write-tree -z --merge-base=c2 c1 c3 >>expect &&
> +       printf "\0" >>expect &&
> +
> +       printf "1\0" >>expect &&
> +       git -C repo merge-tree --write-tree -z c2 c3 >>expect &&
> +       printf "\0" >>expect &&
> +
> +       test_cmp expect actual
> +'
> +
>  test_done

My above nit on your comment is my only remaining issue with your
implementation.  Looks good.

As an aside, I am still a little disappointed that the sole reason for
this series is limited to a usecase where this solution is at best an
interim hack[1][2]...but since I have had very limited time to work on
Git stuff including providing a proper solution for that usecase (in
the form of git-replay), and since it makes sense to include this
capability from a completeness perspective.

Anyway, thanks for patiently fixing everything up.  I think this
series should be ready to merge down once the comment is fixed up.

[1] https://lore.kernel.org/git/CABPp-BGBFyoY7m+KCA9MTifKmpZ0ccLgsYHahMCgPxuTpuUGPg@mail.gmail.com/
[2] https://lore.kernel.org/git/CABPp-BGXM=iRAgjNbZ0o3FSjj583GpkuFB6emUYwWjdFWb9-jQ@mail.gmail.com/
