Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8F3C001B0
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 20:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjHGURD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 16:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjHGURC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 16:17:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DBC10E9
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 13:17:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d4db57d2982so2391526276.3
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 13:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691439420; x=1692044220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=llnB6QLYOV0zNWAdN9j0K5GY04hGAB5y5QhQJWoDPxM=;
        b=KrMMVXsc6sMJaxs1qPBxkHlYoh3Jeatnnh4MEN1on1FW1mdXik2TcNOJu8ckp3U5AV
         DlnZO5aqClObcbu5dQMHrelzwcUUWuprA0bia+OhOr8KZi/OXU4phk2rdjyvFv5WVmgu
         02SFTzfHedmJ1VkcJQ3rPD34q3s9U5oglIZA5RtT5WrauGDN/R7fwQcpWPeEggCb8lYL
         KsoFPXLJxmZWSXk0b/f32LeSmahGRi7mKRQC7zF2PTzGS9mMBquSc+pfooSt22HqgnRs
         s2uY0biQcbJhoV6Lga80pvpuZc6GNIXPeBSm6PCbc6hqIGuYch9GpPTWFBRCx7wR3ER5
         Y7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691439420; x=1692044220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llnB6QLYOV0zNWAdN9j0K5GY04hGAB5y5QhQJWoDPxM=;
        b=DCtk1J2UqN2XD5wNFieMotRJAWQ3LU35vQuDB4Pig+ygzhIy1QVC24evzep2nF1iaj
         Y0iCs9A4slJCZ3iuh3GI3IFN8L7sjUj+NZEW2sLx9yOsRD2sq3CnI4WtLRv7SVdMH4Y7
         rh4WH5s4bybrGIKXABrjA5Ktnw9OW5wUUfdLN8NyhgM5plssswTkDGZKr3mbYk1kpUJv
         BiJZQolbKOofZxvBCndmZQB+g4C/AyBLkWXTuGhj74OeaE61UuVx1v4nUkOM8BvOV51X
         XGusEY8mN5W11brlsS0z4S9xRT4bLZwNUA38gY6bdGzlMuY562kz5d2RB10OQni2Gj7z
         s5rQ==
X-Gm-Message-State: AOJu0YxZu0mWs2HyLrYa2eqO8P/IpT+WQTVNrOpQnB/mPBGs8NPao+Yb
        /wgs5NV8YJc9E7TXwBjIKqnDzGETahltxg==
X-Google-Smtp-Source: AGHT+IE2F6igK9lUqz/OC2/uBzX1MaCEpZ3ISozaEZ+tuKS1C91lNyLLfrJgX4B23BFs4jWGYkoMl64n8PMg+A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:3756:0:b0:d08:ea77:52d4 with SMTP id
 e83-20020a253756000000b00d08ea7752d4mr51564yba.12.1691439420752; Mon, 07 Aug
 2023 13:17:00 -0700 (PDT)
Date:   Mon, 07 Aug 2023 13:16:51 -0700
In-Reply-To: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com> <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
Message-ID: <kl6l4jla38wc.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 0/7] rebase -i: impove handling of failed commands
From:   Glen Choo <chooglen@google.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip!

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series fixes several bugs in the way we handle a commit cannot be
> picked because it would overwrite an untracked file.
>
>  * after a failed pick "git rebase --continue" will happily commit any
>    staged changes even though no commit was picked.
>
>  * the commit of the failed pick is recorded as rewritten even though no
>    commit was picked.
>
>  * the "done" file used by "git status" to show the recently executed
>    commands contains an incorrect entry.
>
> Thanks to Eric, Glen and Junio for their comments on v2. Here are the
> changes since v2:

Thanks for sending this version, and apologies for not getting to it
sooner (I tried a few times, but it was hard to reconstruct the context
around something as complicated as sequencer.c..). Unfortunately, I
don't think I will be able to chime in on subsequent rounds.

> Patch 1 - Reworded the commit message.
>
> Patch 2 - Reworded the commit message, added a test and fixed error message
> pointed out by Glen.
>
> Patch 3 - New cleanup.
>
> Patch 4 - Reworded the commit message, now only increments
> todo_list->current if there is no error.
>
> Patch 5 - Swapped with next patch. Reworded the commit message, stopped
> testing implementation (suggested by Glen). Expanded post-rewrite hook test.
>
> Patch 6 - Reworded the commit message, now uses the message file rather than
> the author script to check if "rebase --continue" should commit staged
> changes. Junio suggested using a separate file for this but I think that
> would end up being more involved as we'd need to be careful about creating
> and removing it.
>
> Patch 7 - Reworded the commit message.

I found the updated commit messages much easier to understand, and the
change to no longer test implementation is also very welcome, so
overall, I think this is a marked improvement over the previous version.

Like Junio, I'm not familiar enough with sequencer or its 'expected
behavior' to feel comfortable LGTM-ing the later patches.
