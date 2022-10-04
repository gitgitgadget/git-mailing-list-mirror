Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99523C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 18:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJDSMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 14:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJDSMv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 14:12:51 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB944F672
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 11:12:51 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id w14-20020a170902e88e00b00177ab7a12f6so10576838plg.16
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 11:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YCQnrxvzsjuIUqFvGHJ5laR69xd3tCB233dwPSFvq/E=;
        b=tEYMPx8RauYDV6kNV+RemhXjiSUagXF9iJODWTiPvyHhq8EhL1WZ9nPFFBWQXy2vkL
         XvexWgf50ft1CLJy/R3rTRzDdCZJzIAqLPsTkCBP8AFN0q6caUegHwFDkYTDunSK+ub2
         WiOETyO1roIpRG16lALPyyBVNrvZ4s0oEIJTQ+hX83RFdIWNfaf39o3zP65vDZuYrx6M
         KsPUG/nBLX2XcMyV1IjVeZchh8Xngdf7E90ae0ZqQdWOS5EM7CrzjOx93TZjvGb4Sf0U
         F0Vy2EiUT2QRDInarYApcnYzXeqsUOwtK8HUGBjAPn7/kXzh9N9I4P3osOgLq1cTA7dP
         8KTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCQnrxvzsjuIUqFvGHJ5laR69xd3tCB233dwPSFvq/E=;
        b=gOdD44rQj61c9TR2Zu+UJiKbrR4OP/v5JtTXxnQmeTCvjx2sC+Uku56MRmGMGTS1zk
         bkz5vRBurrCk4WenQXmMjRAXQN+MvTHeyHBfimEnP2DvF8ZszkRj9wnJ6LWmSeZfX+AK
         PqXlEfadsepfJKZ5q2/FoEWEf/W7Yg/Cb7fll30rG7Ec+7Gkd4EcEUY8dKHdb6ENzgBN
         l/MlaiRMjjqG3xHT9bHlqq5jE7v/9U5NUH8bJPumyFqbDkky7tLPPZpW7IuWhFmUMo/9
         EsTSELKTyytwHDok51BsT9opJtIuvWDMdbVr6rGWWH98IFknkondLNLn46uQGCzIJ+pi
         zhOA==
X-Gm-Message-State: ACrzQf3JWjJEKifqN1oNCp0N7Qc01qeJ9at6NT/+d03Wt3EQvIPKe84H
        cZ2BFnjO5cXmzAZoIzwAIHXmJpHnMfIbvg==
X-Google-Smtp-Source: AMsMyM5OooVLY0TNjnlA0naRu7/8HKy3tQEUHpw9N56ZHTzj5fcmsFx3TzstqfsYv6u0JfvnN0BAdv63wZD4uQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:edcd:b0:17a:6fa:228d with SMTP id
 q13-20020a170902edcd00b0017a06fa228dmr28223373plk.29.1664907170748; Tue, 04
 Oct 2022 11:12:50 -0700 (PDT)
Date:   Tue, 04 Oct 2022 11:12:41 -0700
In-Reply-To: <CA+P7+xrnAXceHJbBYV8Z9Ay9xbkzpiX3P0wXLwN7jfnifW2OBQ@mail.gmail.com>
Mime-Version: 1.0
References: <CA+P7+xrnAXceHJbBYV8Z9Ay9xbkzpiX3P0wXLwN7jfnifW2OBQ@mail.gmail.com>
Message-ID: <kl6lzgeblap2.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: issue with submodules using origin remote unexpectadly
From:   Glen Choo <chooglen@google.com>
To:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jacob! Thanks for the report!

I think we'd need a bit more info, specifically:

- How did you rename the remote?
- What command is doing the submodule fetch?

Or, if you could include a reproduction script, that would be really
helpful :)

Jacob Keller <jacob.keller@gmail.com> writes:

> Hi,
>
> I've been running into an issue with submodules trying to fetch using
> "origin" even though the submodule does not have a remote by that
> name. (I recently switched the submodule remote name)

How did you rename the remote? e.g. did you run `git remote rename`, or
did you rename it manually? I'll come back to why this might be
important...

>
> remote: Enumerating objects: 210, done.
> remote: Counting objects: 100% (207/207), done.
> remote: Compressing objects: 100% (54/54), done.
> remote: Total 210 (delta 123), reused 197 (delta 119), pack-reused 3
> Receiving objects: 100% (210/210), 107.20 KiB | 4.29 MiB/s, done.
> Resolving deltas: 100% (123/123), completed with 48 local objects.
> From <redacted>
> ...
> Fetching submodule submodule
> From <redacted>
>    85e0da7533d9..80cc886f1187  <redacted>
> Fetching submodule submodule2
> fatal: 'origin' does not appear to be a git repository
> fatal: Could not read from remote repository.
>
> Please make sure you have the correct access rights
> and the repository exists.
> Errors during submodule fetch:
>         submodule2

I assume this is `git fetch` running in the superproject?

> I thought at first there might be some configuration value in the
> parent that is selecting origin, but I can 't find one. I also thought
> maybe its some sort of defaulting to origin but I looked through
> submodule code and didn't find one.
>
> Is it just that submodule code is not resilient against changing the
> default remote name away from origin?

Yes, in a sense, though I'm not sure if this is the source of your
problems.

When fetching with `git fetch`, submodules are fetched without
specifying the remote name, which means Git guesses which remote you
want to fetch from, which is documented at
https://git-scm.com/docs/git-fetch. I believe (I haven't reread this
very closely) this is, in order:

- The remote of your branch, i.e. the value of the config value
  `branch.<name>.remote`
- origin

This is why `git remote rename` matters, because `git remote rename`
will also rename `branch.<name>.remote`. If you have a branch checked
out in your submodule, you might want to double-check your .git/config.

But... I'll mention another wrinkle for completeness' sake (though I
don't think it applies to you). If you fetch using `git submodule
update`, the submodule is fetched using a _named_ remote, specifically:

- If the superproject has a branch checked out, it uses the name of the
  superproject branch's remote.
- If the superproject does not have a branch checked out, it uses
  "origin".

>
> Thanks,
> Jake
