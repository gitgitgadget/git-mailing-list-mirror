Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEA6C43334
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 02:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbiGZCAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 22:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbiGZCAM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 22:00:12 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4909F3BB
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 19:00:09 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id c3so10077567qko.1
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 19:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q/LWP0g8CCaSYYuPiZRc2ZS65/yDHG0a77oRkJpvbrQ=;
        b=m46h/N+btwnYjqG4BTkwdDLQQDD6F3ewVoT0rozDxJyv9HYpLGZ6tQFftG0nlWEI71
         nn8qMaVhwg9pbhL1dZB3mhMA6HSsmr7uT1+ZNAluTsNCiH639FR8m9llfdfiJWw65VBF
         y7pi5UrG/p04BmwADx4tVQAB1U1PixUBInIyvCRPcPfN7yGEJDXcvpABsOwrhiZs7AyU
         EmJrlV2/6dfa9rU0hojAxfLuvsl4n4j7XcQt6ULvYbvyWMjp+Dcmz/wk45lvke3hjtwO
         fARhNWmPsz4jGgkRAfzO0f56aqLfMaxDqb/IR/3Xnx6jd4h60xo1pN5bPWDqGYR1lfRk
         OSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/LWP0g8CCaSYYuPiZRc2ZS65/yDHG0a77oRkJpvbrQ=;
        b=379hpYk2f1TjlJNEKHIe0pHwU5/f7QLLwKzG0WzKy/eOrLBa6kT/po8mqju3Ucj+tV
         w7WImo/PFhNNBAo97kh/JKgQu8wounRvVLCtiPt7yk+ytt+Aq5eGMzs2B4c0ZjoDUC9n
         3cmC/8oDYg81p53XBnKdPGjPbsd8GbF+iJS9YTQNGh+x9FjgQOsmQ7lWEJGX1bSyO11G
         etHEObJlNXZ+w4e0EDgW2ykOmvhfIHQywN9OpHQ6emHzgFRzX/6gid9ti0FE3VDrAqwd
         BMej9Y/5jOrO9YpSAh7qG5CBKjv1kNNRVZNHOgfPKfDf3y6pVKwKko8kVFKVNM4o9eUE
         +3MA==
X-Gm-Message-State: AJIora/pQNAeSvUXDP86KHlh9fM7hcS9BaxRvLUKBZmTpbu6CkA6aFVQ
        QW9z48Y/5OP0hVTTIDBwAbSFXHdxIDRGT8RAEE2ejK75uNM=
X-Google-Smtp-Source: AGRyM1snwCDspkF1A48/AyoaaekNNkIvEwz5iH5GVTjaYL4bvXuIv6RT5VBZ4Fvr1islyntr6IBYoF7fl1ah6Beg4YQ=
X-Received: by 2002:ae9:eb08:0:b0:6b5:cc8a:a041 with SMTP id
 b8-20020ae9eb08000000b006b5cc8aa041mr11345037qkg.413.1658800806674; Mon, 25
 Jul 2022 19:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
 <pull.1231.v5.git.1658541198.gitgitgadget@gmail.com> <xmqqh7353ti1.fsf@gitster.g>
In-Reply-To: <xmqqh7353ti1.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 25 Jul 2022 18:59:55 -0700
Message-ID: <CABPp-BEMv6r=-Zs4AoachjZxWOVOL2DrZq7CpBEamCnq4vZTWg@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Fix merge restore state
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 25, 2022 at 12:03 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This started as a simple series to fix restore_state() in builtin/merge.c,
> > fixing an issue reported by ZheNing Hu[3]. It now fixes several bugs and has
> > grown so much it's hard to call it simple. Anyway...
>
> Thanks.  Unless we hear any more comments, let's start merging it
> down to 'next' soonish.

Sounds good; let's plan on that.
