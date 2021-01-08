Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7B0C43332
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 07:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AAF9235DD
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 07:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbhAHHuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 02:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbhAHHuF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 02:50:05 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EE6C0612F5
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 23:49:25 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cw27so10278042edb.5
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 23:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:message-id:in-reply-to
         :date:mime-version;
        bh=eVpzq5ZcBLF2Xma64ciGVvgRSW7u9b43wAxX5UrAkcE=;
        b=fOvsiptZNdG92EiGOOwo4x0KsIKoJyfUqUUv8RCw0YHsUOUA7q7v8cWk0JM6TDc1+p
         67e8YGGV4rqaIGOwNyEB6hXGNkmwmmGX5noIqSTI8Iz5mhl4GA9wvkpKVgW6LB26GRCH
         BPPyFR4CmJvX7zA74LkD27yGmnx2kYZnkIsQKdp+iaaGWm7+wzmir+CFGFPoJXHsDbcx
         rEbZDzRCnMnN6JfhYbKdoHTyCSGpPmNFbIP9IllcXaxp8un9T6FbYcRg6QPCzqliNc8m
         LmmzNGhzsu/Jp/K9hEIXQdEw4piVo6klpFOBTOtjJ1P3csnVbrB/ZgxFNOTJf4775sU2
         QlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :message-id:in-reply-to:date:mime-version;
        bh=eVpzq5ZcBLF2Xma64ciGVvgRSW7u9b43wAxX5UrAkcE=;
        b=fQH8Gusz1USQ86HoWMx8SZA7j6wkVzlemmCa9GIvBtffKd2FVWgYyltpOe+dMmv0vQ
         rbJeFzH4dABGaLT91AWWFCt5EhoI9rC3Lrt1Jg/Z/h+1JZ2Ef8cnWz/hutYA95BVvLBT
         sxVztqaj4K+FM6t1xFMB1FluXKWexe2kq3YYEfKNNEF+iH7IGG2U7goKwWCXLlpZv2cA
         NxlAaygJvnq/wDzeu64UCMplciDCTgEhw6GDzysVvKhSpx6/7jxXs/+zlhgZFoF/N9fV
         tcZ51p+fefWTKbpSrkiFlZv61k+2M6EKgS/Hwah2lfQHTHQiz0wUGuo96hyYOPYIpDY3
         SIpQ==
X-Gm-Message-State: AOAM531o9YFZ2ZUVjDj8N+bKaIOTigd7qPu1GDSST/PArZoUQpCsQeU6
        aOuTS4O0Z90sRG8PTNIwMT2wH8aB6bQb8w==
X-Google-Smtp-Source: ABdhPJy7yUJcNqDMel4Nux4J+m/enJzSU9SC2qjYxmkVKawCNX4OCipy+JUvqT5XTlyeN5ZkrWpQXQ==
X-Received: by 2002:aa7:d407:: with SMTP id z7mr4668199edq.234.1610092163887;
        Thu, 07 Jan 2021 23:49:23 -0800 (PST)
Received: from cpm12071.local ([212.86.35.64])
        by smtp.gmail.com with ESMTPSA id ef11sm3257858ejb.15.2021.01.07.23.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 23:49:23 -0800 (PST)
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210104162128.95281-7-rafaeloliveira.cs@gmail.com>
 <CAPig+cRysXpK0e1xXOuVd+EtkeyTk8FR6MUrL=Bg3W4ve8jdNA@mail.gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 6/7] worktree: add tests for `list` verbose and annotations
Message-ID: <gohp6kk0sndhj9.fsf@gmail.com>
In-reply-to: <CAPig+cRysXpK0e1xXOuVd+EtkeyTk8FR6MUrL=Bg3W4ve8jdNA@mail.gmail.com>
Date:   Fri, 08 Jan 2021 08:49:22 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Eric Sunshine writes:

> On Mon, Jan 4, 2021 at 11:22 AM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:
>> Add tests for "git worktree list" verbose mode, prunable and locked
>> annotations for both default and porcelain format and ensure the
>> "prunable" annotation is consistent with what "git worktree prune"
>> command will eventually remove. Additionally, add one test case to
>> ensure any newline characters are escaped from locked reason for the
>> porcelain format to prevent breaking the format.
>>
>> The c57b3367be (worktree: teach `list` to annotate locked worktree,
>> 2020-10-11) introduced a new test to ensure locked worktrees are listed
>> with "locked" annotation. However, the test does not remove the worktree
>> as the "git worktree prune" is not going to remove any locked worktrees.
>> Let's fix that by unlocking the worktree before the "prune" command.
>>
>> Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
>> ---
>> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
>> @@ -62,7 +62,9 @@ test_expect_success '"list" all worktrees --porcelain' '
>>  test_expect_success '"list" all worktrees with locked annotation' '
>> -       test_when_finished "rm -rf locked unlocked out && git worktree prune" &&
>> +       test_when_finished "rm -rf locked unlocked out &&
>> +               git worktree unlock locked &&
>> +               git worktree prune" &&
>>         git worktree add --detach locked master &&
>>         git worktree add --detach unlocked master &&
>>         git worktree lock locked &&
>
> You might need to be a bit more careful here. If the test fails before
> the worktree is locked, then the `git worktree unlock` in the cleanup
> code will return an error, which will make the code executed by
> test_when_finished() fail, as well, which makes it harder to debug
> problems. Moving the `unlock` cleanup after you know the lock
> succeeded will address this issue:
>
>     test_when_finished "rm -rf locked unlocked out && git worktree prune" &&
>     git worktree add --detach locked master &&
>     git worktree add --detach unlocked master &&
>     git worktree lock locked &&
>     test_when_finished "git worktree unlock locked" &&
>     ...
>
> Same comment applies to other new tests added by this patch which lock
> worktrees.
>

This is good point. will change on the next revision.

>> @@ -71,6 +73,96 @@ test_expect_success '"list" all worktrees with locked annotation' '
>> +test_expect_success '"list" all worktrees with prunable consistent with "prune"' '
>> +       test_when_finished "rm -rf prunable out && git worktree prune" &&
>> +       git worktree add --detach prunable &&
>> +       rm -rf prunable &&
>> +       git worktree list >out &&
>> +       grep "/prunable  *[0-9a-f].* prunable$" out &&
>> +       git worktree prune --verbose >out &&
>> +       test_i18ngrep "^Removing worktrees/prunable" out
>> +'
>
> To be trustworthy, doesn't this test also need to have an unprunable
> worktree, and test that `git worktree list` doesn't annotate it as
> "prunable" _and_ that `git worktree prune` didn't prune it? Otherwise,
> we really don't know that the two commands agree about what is and is
> not prunable -- we only know they agree that this particular worktree
> was prunable.
>

You're right this test is missing the case the "unprunable case". Will
add into the next revision.

>> +test_expect_success '"list" all worktrees --porcelain with newline escaped locked reason' '
>> +       test_when_finished "rm -rf locked_lf locked_crlf reason_lf reason_crlf out actual expect reason &&
>> +               git worktree unlock locked_lf &&
>> +               git worktree unlock locked_crlf &&
>> +               git worktree prune" &&
>
> Nit: It's not a big deal, but we don't normally bother cleaning up
> every junk file in tests, such as `out`, `actual`, `expect` if those
> files aren't going to be a problem for subsequent tests. We are
> explicitly cleaning up the worktrees in these tests because this
> script is all about testing worktree behavior, and some random
> leftover worktree could be a problem for other tests. I don't care
> strongly one way or the other, but I worry a tiny bit that the list of
> files being cleaned up could become outdated as changes are made to
> the tests later...
>

Make sense, and ...

>> +test_expect_success '"list" all worktrees --porcelain with prunable' '
>> +       test_when_finished "rm -rf prunable list out && git worktree prune" &&
>> +       git worktree add --detach prunable &&
>> +       rm -rf prunable &&
>> +       git worktree list --porcelain >out &&
>> +       test_i18ngrep "^prunable gitdir file points to non-existent location$" out
>> +'
>
> ... for instance, the file `list` being cleaned up in this test is not
> even created by this test.
>

This is exactly the case of updating the test and forgetting to
remove from the cleanup part because it was not used anymore. I'm also
inclined to make this changes on the next revision.

-- 
Thanks
Rafael
