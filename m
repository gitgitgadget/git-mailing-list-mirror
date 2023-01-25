Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3053DC27C76
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 16:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbjAYQtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 11:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbjAYQtK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 11:49:10 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2724C2ED42
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 08:48:55 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id o12so2102743ljp.11
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 08:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TXy2uYjnw4sE63NzS+CqTz9doF8FKI3ELwKfUeFwZmM=;
        b=k3/b+4ctQ4BsOk+6M6QRtLmhtHwZNtaAayB/KbKyxxRpaCIIzI6QyPbb0qedDNBxJS
         1dwF9N6Z8uhkbEEmgCk2AQVB8ACcTu3Ep0H5M36CzI/eSoqtNAdqNIFQavExCxrO8Ko0
         mP8X8iDaF3PKwJANDoqES1xhSjmKqIadSTZOtRcjBeiYHMsZ/px4b5/+bpelS1Ws1Fjm
         1pEJwWSvgVpmRWUaHP51nhr8VYgLf9PmqWPy1bFnVz7umFsXL7v0gn9lSmJJmguDWzzU
         BaGSlcXZ/5D3gbxxG0b5Cz6lrXZvCkqDIvWPzF2QTDBZFbw+lxe5YjwbVeu2ZVnfXGKC
         xHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXy2uYjnw4sE63NzS+CqTz9doF8FKI3ELwKfUeFwZmM=;
        b=MGDDiyjKmbSLqLVmAXQnujeC9DvlkkNqykcUIyvdrRuF5ILiTLhb7PNt0mvwlyzeZ1
         uqMGKEz6sQk3H4CyI5xRHx2jEGRzG3JWLmwPmpZGHPu+pElfEhi+R4q3us3oYp42dvTn
         v7oqmIsIHft8rCUBVbb3S1IHtJ5Mn6cyVfSqILiZvaqTa3uXkv9e838aTatbflcAQnzV
         ZV3NKD/xIKSXbV7aw8APgBRVU6brM9yN6TrkwJ6TDAg4XKqcAq2wBX8tctJqDJMQZuwt
         8xywhng8zK9bC6I/bKzfSVssSCjnZtdKq1l01/XDDVeGSmaOR4xAb4N6zZVMhK0E3Yl3
         wYRw==
X-Gm-Message-State: AFqh2kqrg+98zJFlUYdXW4r5XUqo7+k682NgLiL8wAAjYgrFOl6XXray
        mSdXCGbufElrwKLfBWGd+0THryHuGWVGu1rUqMY=
X-Google-Smtp-Source: AMrXdXslbgaDC5AUZT10nD7d6Q2HspmiI16zG6EBN1SvH8QwZyvjI27i6iOjpJiKAgnJYZ8mNma9DYPlizJBGze2Epw=
X-Received: by 2002:a2e:9d99:0:b0:27f:e221:293c with SMTP id
 c25-20020a2e9d99000000b0027fe221293cmr3068020ljj.163.1674665333282; Wed, 25
 Jan 2023 08:48:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
 <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com> <xmqqa626fu0x.fsf@gitster.g>
In-Reply-To: <xmqqa626fu0x.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 25 Jan 2023 08:48:39 -0800
Message-ID: <CABPp-BEWC_GQXLKvokLVgd4-Hq16MoZggyp6r-sj29SYyLippQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] rebase: fix several code/testing/documentation
 issues around flag incompatibilities
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2023 at 8:39 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Changes since v4:
> >
> >  * Pulled out the changes regarding incompatibility detection for
> >    --[no-]reapply-cherry-picks into a separate patch. Phillip helped a lot
> >    with understanding the behavior, suggesting changes, and getting the
> >    wording right, and I think it deserves its own patch with its own
> >    explanation.
>
> Hmph, does this replace the previous round that has already been in
> 'next' for two days?  I do not mind reverting the merge and requeuing
> it, but just wanted ot make sure before doing anything.

Sorry, I didn't realize it had merged to next.  With Phillip's ongoing
reviews and requests for changes, which you had even commented on
(https://lore.kernel.org/git/xmqqpmb4j8e9.fsf@gitster.g/ and the
thread that was in the middle of), I assumed it was still only in
seen.

But yes, if you could revert from next and replace, that would be
great.  Now that v5 has Phillip's blessing (and multiple of his
corrections), I think it's good to merge down.
