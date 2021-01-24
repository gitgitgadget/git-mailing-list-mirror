Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8B4C433E6
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 10:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086DB22CB9
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 10:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbhAXKVV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 05:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbhAXKVT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 05:21:19 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA12C061573
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 02:20:39 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id r12so13754424ejb.9
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 02:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=QQwINFw3HM5ZAKzgivzCwqa+ThcClDaS07WJJzNB6qU=;
        b=aos2euVTGDoD02JLIS8LRIqZePsuIB4E1D3NXHYGmF/1xLVkETCXoyS7eIUF/AbZNK
         glRKNT2MCNUo1aHjols2/bHlbXw8ru9gwL2u0XVyAUMDIjbMHXQ9sZwBag+UxhiHJgQb
         40jmICL+QQNcmdegC9rz49jyd7bZiKBdRhdksSG0WwPjmuXhmRZ2KwN/+1PH4ulpjqcq
         VpCPUvX6xAQkC4gPnD2V8zv2US9xZEJcjdF9wTOUQzjACGhoi4Q+GfWeV+88+nXRbioP
         VIpplWXseKYMM6gTfjW2t1mr43wkOgU6pcOKz1AYoRRlBQ8OeNh7nrI3x4sSvi/G4sgh
         F0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=QQwINFw3HM5ZAKzgivzCwqa+ThcClDaS07WJJzNB6qU=;
        b=BwC7AHC5XfS827iRmYTd2XqfVWGRMANb/63c0Lx+QqTZF2+Rsto8WarpcuvB85hGc5
         sqtFlhV6rTPccFiLPHVIzSlaD4n5Ji+j6FETjyprJnorOIJAk6lYUbJQRR1GTMMOpHfg
         5egA9kwaLtBpTOVZsgfOtN5GXQxqX1IImCfqdje9mpTtrWsAEML8BtidjBeIUCVSC8y8
         cyJzZKh7HlJ2K11Or/fziT4OKuK4BfTqRTZke/1EkkLZL/oktzXCrT2+HJOV642b9OtI
         3szdSaTBSQqib8Trm8jG8DpYjc9I14uSwM5/cUdAq9P8X9CaLD96ftEbp4mfEXSj+CNz
         Y3YQ==
X-Gm-Message-State: AOAM533x3AG5NgKskpj5jkaNb1ztlLQx6US+C5UzGSSIV2JHS42XQQ2q
        vmfigwfLOlutwgBkdeCJV5rIpdVRjwNiWQ==
X-Google-Smtp-Source: ABdhPJxggvBYN8OzXGTmrZteEp7BDDhIdGdqKdxicMFg5K3UTIXLi1BbPl/iqOyFmoNpU5B4ZPyQ0w==
X-Received: by 2002:a17:906:ca0d:: with SMTP id jt13mr49608ejb.170.1611483638100;
        Sun, 24 Jan 2021 02:20:38 -0800 (PST)
Received: from cpm12071.local ([79.140.115.149])
        by smtp.gmail.com with ESMTPSA id c14sm8794190edr.46.2021.01.24.02.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 02:20:37 -0800 (PST)
References: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
 <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
 <20210119212739.77882-6-rafaeloliveira.cs@gmail.com>
 <CAPig+cRBDSWCmrV+6w0gXaSH+xWEX1354NhfyjhCouDdsfEAGA@mail.gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 5/7] worktree: teach `list --porcelain` to annotate
 locked worktree
In-reply-to: <CAPig+cRBDSWCmrV+6w0gXaSH+xWEX1354NhfyjhCouDdsfEAGA@mail.gmail.com>
Message-ID: <gohp6kim7mocul.fsf@gmail.com>
Date:   Sun, 24 Jan 2021 11:20:36 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Eric Sunshine writes:

> On Tue, Jan 19, 2021 at 4:28 PM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:
>> [...]
>> Teach "list --porcelain" to do the same and add a "locked" attribute
>> followed by its reason, thus making both default and porcelain format
>> consistent. If the locked reason is not available then only "locked"
>> is shown.
>> [...]
>> Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
>> ---
>> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
>> @@ -72,6 +72,36 @@ test_expect_success '"list" all worktrees with locked annotation' '
>> +test_expect_success '"list" all worktrees --porcelain with locked' '
>> +       test_when_finished "rm -rf locked1 locked2 unlocked out actual expect && git worktree prune" &&
>> +       echo "locked" >expect &&
>> +       echo "locked with reason" >>expect &&
>> +       git worktree add --detach locked1 &&
>> +       git worktree add --detach locked2 &&
>> +       # unlocked worktree should not be annotated with "locked"
>> +       git worktree add --detach unlocked &&
>> +       git worktree lock locked1 &&
>> +       git worktree lock locked2 --reason "with reason" &&
>> +       test_when_finished "git worktree unlock locked1 && git worktree unlock locked2" &&
>
> There's a minor problem here. If the second `git worktree lock`
> command fails, test_when_finished() will never be invoked, which means
> that the first lock won't get cleaned up, thus the worktree won't get
> pruned. To fix, you'd want:
>
>     git worktree lock locked1 &&
>     test_when_finished "git worktree unlock locked1" &&
>     git worktree lock locked2 --reason "with reason" &&
>     test_when_finished "git worktree unlock locked2" &&
>

Excellent point. This case didn't occur to me when I was working on v3, I
will make this change in the next revision.

>> +       git worktree list --porcelain >out &&
>> +       grep "^locked" out >actual &&
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success '"list" all worktrees --porcelain with locked reason newline escaped' '
>> +       test_when_finished "rm -rf locked_lf locked_crlf out actual expect && git worktree prune" &&
>> +       printf "locked \"locked\\\\r\\\\nreason\"\n" >expect &&
>> +       printf "locked \"locked\\\\nreason\"\n" >>expect &&
>> +       git worktree add --detach locked_lf &&
>> +       git worktree add --detach locked_crlf &&
>> +       git worktree lock locked_lf --reason "$(printf "locked\nreason")" &&
>> +       git worktree lock locked_crlf --reason "$(printf "locked\r\nreason")" &&
>> +       test_when_finished "git worktree unlock locked_lf && git worktree unlock locked_crlf" &&
>
> Same issue as above.
>
>> +       git worktree list --porcelain >out &&
>> +       grep "^locked" out >actual &&
>> +       test_cmp expect actual
>> +'


-- 
Thanks
Rafael
