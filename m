Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C010C433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3838F22518
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgLVAOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:14:01 -0500
Received: from mail-ej1-f49.google.com ([209.85.218.49]:34977 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgLVAOB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:14:01 -0500
Received: by mail-ej1-f49.google.com with SMTP id q22so15930693eja.2
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:13:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/6IDlgIuaPiFi3PCG/EBlRQiQL0G1n8iKguDE6+xZs=;
        b=nBgdV7MqqCi0jrnNL0G5vCziPP3hWR5CxMMEFzhlMbSZKDLyYRaNvarFKnJGJNLupm
         +bIB8bRJR9lFOtWcAUAsUPqzb/tS3vHExbRZyl9uIfv6lbu30Hvy/XX457A1oTo317ac
         LlD2spD6FeeMDFwX53Sc2fzxV8efDYFf92gN7v5/VBxc2jllt0sFDXzf04g2aypgVa4P
         kNElU/DJXRSAN5jkLafrH3+j7v4l9UuDRclGdwcjjuFIPn+Ijc69jOgbv1OZgREbU/z4
         DHFTwyyFx3AN3dWJZdsU18VODPzJai1ntmmvTF6wIGttM6vI1/RcDla5a5jDrzDNhaJ9
         IcQg==
X-Gm-Message-State: AOAM530iGpFFPkhAm4hKEARtVv7OeP9Ia9VV0/naLdD/XEpxnAsGwdF1
        F8gahUh4/9D7m3MTNOUZ4cED4SWb6awQz1IKoHE=
X-Google-Smtp-Source: ABdhPJzusk7X/ayupfGQdchbsOaHir2dwkdQ2cTOdWE2vHf6WDcVndleY7zPlgpU8xdEQXTPBc8a10jRzt1zFHvyTCA=
X-Received: by 2002:a17:906:6b88:: with SMTP id l8mr17610287ejr.482.1608595999140;
 Mon, 21 Dec 2020 16:13:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.820.v2.git.1608415117.gitgitgadget@gmail.com>
 <pull.820.v3.git.1608516320.gitgitgadget@gmail.com> <733c674bd1901c931a8917045eb72f661872f462.1608516320.git.gitgitgadget@gmail.com>
 <CAPig+cSaq4vTK7CtvxB2bd0=WTW+d=s0H2RMquyCEf+q0YVn2w@mail.gmail.com>
 <xmqqa6u7m1bu.fsf@gitster.c.googlers.com> <CAPig+cRqa9Y4mEdktdP3d2+PHWanKZ6q6tXfJXEAW9sqcVwHOw@mail.gmail.com>
 <CAN8Z4-UG-watOnJMYUe3KU4JHnmJTxvwKSZ3s2DtBg104PACaA@mail.gmail.com>
In-Reply-To: <CAN8Z4-UG-watOnJMYUe3KU4JHnmJTxvwKSZ3s2DtBg104PACaA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 21 Dec 2020 19:13:08 -0500
Message-ID: <CAPig+cS4F5fhu-ej5ZVpzLR17AUhxzLRKVZxLuKaMCCk937C1A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] test-lib-functions: handle --add in test_config
To:     Nipunn Koorapati <nipunn1313@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Nipunn Koorapati <nipunn@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 21, 2020 at 7:00 PM Nipunn Koorapati <nipunn1313@gmail.com> wrote:
> I found that since test_unconfig uses --unset-all, I can write a test as such
>
>     test_config -C two remote.one.push +: &&
>     test_must_fail git -C two push one &&
>     git -C two config --add remote.one.push ^refs/heads/master &&
>     git -C two push one
>
> The unconfig of the test_config will --unset-all remote.one.push. I can
> use this technique and add a comment to that extent.

Yes, you could do that, though it is somewhat subtle and increases
cognitive load since the reader has to reason about it a bit more --
and perhaps study the internal implementation of test_config() -- to
convince himself or herself that the different methods of setting
configuration (test_config() vs. `git config`) used in the same test
is intentional and works as intended.

The example presented earlier, on the other hand, in which cleanup is
explicit via `test_when_finished "test_unconfig ..."` does not suffer
from such increased cognitive load since it uses `git config`
consistently to set configuration rather than a mix of `git config`
and test_config(). This sort of consideration is important not just
for reviewers, but for people who need to understand the code down the
road. For this reason, I think I favor the version in which the
cleanup is explicit. (But that's just my opinion...)
