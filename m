Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BAFC433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 20:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238564AbiKOU6Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 15:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiKOU6P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 15:58:15 -0500
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F521C403
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 12:58:14 -0800 (PST)
Received: by mail-il1-f171.google.com with SMTP id o13so8076144ilc.7
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 12:58:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AUe3HFvYnQNJZibuSFmwu3eAaYo8yLV0HC3WDZB4X4w=;
        b=au/7DdRmJlnD2f+nSJTcAuTDhSvztOhpr521y/8OekTt4xAphfEQiEBA7EtQjQjse7
         gaDqLRyTViQge6vreK2oxuOYAONfYq1F3GkoCsuMmxzU/A7+rwkAXsmdmt9wA5cBjvAG
         f9o7MX5WIMj/xTjzL1uHYj6u++PW28SqxaLzqYLJbEncOXKHB1WMtMhOlgJIn61UTcvq
         TCID+4omLPic/Oyqs32WFJB3+7EICACRlzr0QwvblCKI+42hrU/2XuDvpSqbJH+UFP6X
         rFk1txzzL47nbPpxdQ13P9NQANmW0z1S3TtZNCP5A8mJn2LTlXIzcq1NqS3OMJP4VsmU
         PJRQ==
X-Gm-Message-State: ANoB5pk6v2jdbsNnTu7GK6sJwjKvA1g/HVF368zMqzK7j1IzQRl8LZHz
        NePlKDGb72ou5kdRTkJqh3UOaD9yWq2Veuvl0Mxeq8xcknA=
X-Google-Smtp-Source: AA0mqf7wEIoBj0yWAuRIXg8mazITo+DmzNsa0X/iVCCPYkrFvZReg5wpLF9V9AxAZXSauUm86lfZdzE8+1EpztEJWMM=
X-Received: by 2002:a92:2612:0:b0:302:557a:dba7 with SMTP id
 n18-20020a922612000000b00302557adba7mr6479733ile.249.1668545893547; Tue, 15
 Nov 2022 12:58:13 -0800 (PST)
MIME-Version: 1.0
References: <Y3Mag8qG2D3qjlmg@nand.local>
In-Reply-To: <Y3Mag8qG2D3qjlmg@nand.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 15 Nov 2022 15:58:02 -0500
Message-ID: <CAPig+cSKaW0ejeVgS7XEphMibdmExxO_T+xjMo6My5SAfwou_Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2022, #03; Mon, 14)
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jacob Abel <jacobabel@nullpo.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2022 at 11:53 PM Taylor Blau <me@ttaylorr.com> wrote:
> * ja/worktree-orphan (2022-11-10) 2 commits
>  - worktree add: add --orphan flag
>  - worktree add: Include -B in usage docs
>
>  'git worktree add' learned how to create a worktree based on an
>  orphaned branch with `--orphan`.
>
>  Waiting for review discussion to settle, but leaning negative.
>  source: <20221110233137.10414-1-jacobabel@nullpo.dev>

I haven't had a chance yet to look at Jacob's v3, but this series does
close a gap in worktree usability[*], and v3 addresses a stated
concern of mine against earlier iterations, so I think a "negative
lean" may not be warranted.

[*] In particular, it is currently impossible to create a worktree
from a brand new bare repository:

    % git init --bare foo.git
    % git -C foo.git worktree add -b main bar
    Preparing worktree (new branch 'main')
    fatal: not a valid object name: 'HEAD'
    %

whereas, with this patch series:

    % git init --bare foo.git
    % git -C foo.git worktree add --orphan main bar
    Preparing worktree (new branch 'main')
    %

(The commit message can probably be improved to spell this out since
it wasn't obvious to me, simply from reading the commit message, that
this problem existed.)
