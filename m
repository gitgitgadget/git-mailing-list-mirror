Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C732BC433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 13:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240421AbiDGNv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 09:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbiDGNv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 09:51:26 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4FBB0A7D
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 06:49:25 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id c2so4984326pga.10
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 06:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9uoHbF8OlUtHVhwd24OtiajoSKuj8Ozg5iCgz+6DS1c=;
        b=W6bxv0xrphgIu0I6I8gk0hh3QbLvdBi4R4QtLdqV1xgNoruspapWevjn9QDBxiONuu
         9CbnaIZvZ+hriDjyclRRpfjcBhRtoXmsFU6owviGB2eaMMY5pvPMFeoSqHz5kqpxa0IR
         0VnH5Q0iRrZ0ZPywmYtmU9TSlcUmyQdkctj5aqRfkOjwjjcYXcGeFTeadiYZNE8Ja+LW
         EFnihGH4EfeEkigv7JjQ33sf2HvzWXZn4o8KoJteogevkFw2U/8DZHmZ8P8226TvcLH5
         PQSDBMEZTpxqY35499M0ZvAdobFktC3nuSFZ+Q9Ka5KRla5+wtxtd5jM7DBZA9kvZBTw
         fX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9uoHbF8OlUtHVhwd24OtiajoSKuj8Ozg5iCgz+6DS1c=;
        b=VoxJnmMkyrl8u0N+mZyRYfbcXL/RIN62iwNKc+ZpBZJSW3R4bC4QInH9dVLepT65rg
         1+j8uWemauOwVkxL04j5U2QGARlRJn04azLUR/suvop+WYEa5nRbtCNLDk76yxOWdSlz
         wrMH4Cu4lCeUoykZimmWJ03zhMYeGhJlCphB7qJlCYg1O9uDo4zm0En8S6zteqjAbgXL
         AIshgbTARNPc3WTIHpZY740qjXAL6P1oKjoQv7qjFAZzRyVZR1NTwllMQodUru5QVacN
         RUBqb3Ycv/60X4y6OZKD9INtiTF2cv7dG5VE6YcQ4PZNrCdC+ycSCw5t+DvL4KCIpLzx
         MCVw==
X-Gm-Message-State: AOAM530YHQkyT0Al9FDhfs4u1YMv80DyE6915+LQvPgxFnne1BkOFajE
        h1zh0UFPTYkMc3ez/1cbggVFMzrLRfse2aGpOtU=
X-Google-Smtp-Source: ABdhPJy8TIhLx8I9A37NmRFJcq3gEo/cF0WaeDLT7VCkVWo3moS0f/pVHwYfl9RC0bhS2fw7lmac4ioTXgiV5sFQ8a4=
X-Received: by 2002:a05:6a00:8c6:b0:4fe:10df:1cfe with SMTP id
 s6-20020a056a0008c600b004fe10df1cfemr14373473pfu.18.1649339365401; Thu, 07
 Apr 2022 06:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com> <493254ffbb8b11f325f5995790341d70198b5c97.1645441854.git.gitgitgadget@gmail.com>
In-Reply-To: <493254ffbb8b11f325f5995790341d70198b5c97.1645441854.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 7 Apr 2022 15:49:14 +0200
Message-ID: <CAP8UFD0+V38FC8HZenFVRUputH+eD5cfXAQUZug3RWWMv==LBw@mail.gmail.com>
Subject: Re: [PATCH 2/7] rebase --merge: fix reflog when continuing
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 22, 2022 at 6:12 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The reflog message for a conflict resolution committed by "rebase
> --continue" looks like
>
>         rebase (continue): commit subject line
>
> Unfortunately the reflog message each subsequent pick look like
>
>         rebase (continue) (pick): commit subject line
>
> Fix this by setting the reflog message for "rebase --continue" in
> sequencer_continue() so it does not affect subsequent commits. This
> introduces a memory leak similar to the one leaking GIT_REFLOG_ACTION
> in pick_commits(). Both of these will be fixed in a future series that
> stops the sequencer calling setenv().

Yeah, it looks like we will leak only a small string.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/rebase.c          |   2 -
>  sequencer.c               |   5 ++
>  t/t3406-rebase-message.sh | 120 +++++++++++++++++++++++++-------------

The changes to the test script look a bit involved and aren't
explained in the commit message. I wonder if some of those changes
could have been made in a preparatory commit.


>  3 files changed, 86 insertions(+), 41 deletions(-)
