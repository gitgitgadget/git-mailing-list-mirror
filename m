Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA994C3DA7D
	for <git@archiver.kernel.org>; Thu,  5 Jan 2023 17:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjAERAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Jan 2023 12:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjAERAP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2023 12:00:15 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082BF58D3A
        for <git@vger.kernel.org>; Thu,  5 Jan 2023 09:00:13 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id d13so25895325qvj.8
        for <git@vger.kernel.org>; Thu, 05 Jan 2023 09:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Glqu2oxzxOHr76VPrkOno8CGbeMHGxdjK7jZHa24n7k=;
        b=IH6JDLyILqj9zNykwnsuuKFzElhbGBRjw2HzWsDXMtP3z/gOOqYpxRXt/3QQ2R06Mk
         C2D+wFwdj6dS6HEGUXEtjdtcWdDaTiZQXRre0ccnr2Lqll83DZAjGSkmCcNC3bNDLs3k
         DLvoC1SBoDWeJ+TzaIUlwlNrWml1qQP7ZPcPJDnS0vF3Jy7h6qyxStRZpP21mAY/wbq/
         FIQt336A9cbfI99PMOY1kQGqNtH8mNOBpmWcavLZZ9MNfN0Pf/LEkAzR/aRI4IqQkP/d
         7KaHaWqFk9RdeWoKtDl60/4pq5B8UjU44dwplVmjc5HcYOuzx6p4vwVjnpv51IEuQVpl
         QIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Glqu2oxzxOHr76VPrkOno8CGbeMHGxdjK7jZHa24n7k=;
        b=myXnd1oIE7k4R0oGdF8MMJ9RXJqiV++avoOiH5HNLNzsbLn8Fmfnb6gM2FkZYEViOI
         XaFPwnsxQwLqTnPl+jC/UonCm6I1+SKVGijvI42730x3u+uw0POldBI9S/qxQqP2DuPE
         rf5aRsGHydPrUYt5swd5oyzXabXeKDXJFnPk7Tdm/EeO6NvKmsA4wECPhpEF39oqzp6n
         XO8bT1YTogi9a/zkn2mIsQCXOSUPaEr+mmz6+KlC96YSxv4HreAtvzcEzX1/xrYOR189
         s7BDJJXaZ1wnUkCJNVRG6HvJO5TUgTVXkujjXso5uRo7QoLRUXmpar8PjxOLWYM9gv5E
         Lfkw==
X-Gm-Message-State: AFqh2kqvKCx0+MOpQ7tWCZQvtq2BiY0uIUgjkPI7clZs1TwclDPnhtFs
        rElKm4PM4c+0UTv8LRMBLr00hnRzkYVK9ztZWnrH0EHJxgavcDSAPF8=
X-Google-Smtp-Source: AMrXdXu/77i/vE5pCQzqFGz53SxCjH21rhcGHsMl+TA10j/tcINjXmd/zSwfDpSIgjJcqKnLizDvkcMO2R6XRFCt/cc=
X-Received: by 2002:ad4:4d86:0:b0:4c7:5bae:94c5 with SMTP id
 cv6-20020ad44d86000000b004c75bae94c5mr3097523qvb.125.1672938012501; Thu, 05
 Jan 2023 09:00:12 -0800 (PST)
MIME-Version: 1.0
References: <CAAYtLELp4v=id-UUdGT+BoCxLuTV05Z0fFMQmPfd3Mt-yXJ9Tw@mail.gmail.com>
 <Y7Pvqk00sj3R7cZv@coredump.intra.peff.net>
In-Reply-To: <Y7Pvqk00sj3R7cZv@coredump.intra.peff.net>
From:   Andrew Hlynskyi <ahlincq@gmail.com>
Date:   Thu, 5 Jan 2023 18:59:36 +0200
Message-ID: <CAAYtLE+PWK_v0cc8uqaiKnTHKghrkxuCCgfWyo9bhD23+vxK1g@mail.gmail.com>
Subject: Re: [BUG] `git gc` or `git pack-refs` wipes all notes for `git notes` command
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 3, 2023 at 11:04 AM Jeff King <peff@peff.net> wrote:

> That would be very surprising. The lookup of the ref in the notes code
> uses the same generic ref code that the rest of Git uses, which
> understands packed-refs and so on.

Thank you Jeff for looking at this also.

I tried to debug the issue by myself and found that the
`find_reference_location` function can't find the record for
`refs/notes/commits` in a repo.
I recall that a year ago I had trouble with a repo and it was damaged,
I restored it with the `git fsck` command and took some info from the
`git reflog`.
But somehow there was an issue in the `.git/packed-refs` file that was
there unexplored all past year.
The core of the issue I can demonstrate with two `.git/packed-refs` excerpts.

The issue excerpt:
```
dca1abdb5b870d46deae3717e87d0085b62d7242 refs/heads/tmp
d5ec01136b79a59a9e39d3ab02d92e1d91558579 refs/heads/tdf
c60f96a3f76e99e1b42f07204ad830c1483647b0 refs/heads/trunk
93119b80d4c7676a0ebe1bd6ae46574f96dfc7ed refs/notes/commits
452a23af3cfac6eef3bb1045894521fac8e51e2a refs/heads/cargo-config-toml
f5599d73873c451041fde857a09b5f12662357c1 refs/heads/custom
64076392359c4d4989320bde5712a8b389056f49 refs/heads/main
2119ff71ca66bec5117534907a127cee32680788 refs/heads/next
7e0016059ee7a87e3d04f7e59154529a9616a238 refs/recovery/1
de2876aa45022af815e717eb92becd61564efe32 refs/recovery/10
```

The correct excerpt:
```
dca1abdb5b870d46deae3717e87d0085b62d7242 refs/heads/tmp
d5ec01136b79a59a9e39d3ab02d92e1d91558579 refs/heads/tdf
c60f96a3f76e99e1b42f07204ad830c1483647b0 refs/heads/trunk
452a23af3cfac6eef3bb1045894521fac8e51e2a refs/heads/cargo-config-toml
f5599d73873c451041fde857a09b5f12662357c1 refs/heads/custom
64076392359c4d4989320bde5712a8b389056f49 refs/heads/main
2119ff71ca66bec5117534907a127cee32680788 refs/heads/next
93119b80d4c7676a0ebe1bd6ae46574f96dfc7ed refs/notes/commits
7e0016059ee7a87e3d04f7e59154529a9616a238 refs/recovery/1
de2876aa45022af815e717eb92becd61564efe32 refs/recovery/10
```

As you may notice that on the first except there is an issue with
sorting and after `ref/notes/*` there are several `ref/heads/*`.
So I suspect that the issue was introduced by myself a year ago when I
was recovering the repo.

> Can you share the .git directory of a repository that exhibits this
> behavior? It's possible there's a bug or something in the packed-refs
> code, though I find it pretty unlikely, as it's fairly well exercised in
> normal use.

The above excerpts completely describe the issue and there is no more
special in the repo.

I was surprised that such an issue can remain in the
`.git/packed-refs` for more than a year.
I thought that commands like `git fsck` would report such unordering
problems and `git gc` or `git pack-refs`
make ordering checks and make full resorting of the `.git/packed-refs`
file in case of issues with ordering.
I understand that the `.git/packed-refs` file is for machines and not
for humans but sometimes
it's the fastest way to make several simple corrections in it manually.

P.S: What was most surprising is that `git pack-refs` was able to
correctly update a hash even for an unordered record.

-Andrew
