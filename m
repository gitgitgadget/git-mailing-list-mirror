Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FED4C433FE
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 15:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbiK2PWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 10:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbiK2PWK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 10:22:10 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164D5B7D5
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 07:22:04 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id i131so17837353ybc.9
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 07:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RAZ/Hr87LSTIZTCb7Wxs3zhIrvER/YPKf3yjQBgVAuM=;
        b=qslPD8C4GglreQQY5ky98JTSGjdFo8OXaa5NgMfuLuJPoyfUkvKhHBPPRm6dvbRzJo
         XS1/NOcBr4l2fIEPYi0s1TYcCvi+WOMqh+VOUccjq4CAcyJ6O4XFZveLFgfNkO7pIjBG
         ZytegfJ9Ml9RMFqb3ZzwazQUrixALdU1WoagBLHMPXzQL9GJjaYMpuwwj8uzM0ADlPrL
         K/y9lAMY1Zx+dBYtVOkK4QagFU3uF94hslANZbKRlLJID/lSj5zWUScKTNo0sViSAtlM
         gAC+M2mtc643wjsebePifWhPlV2Gkg/PMqxWec7KVTJXy2wZSyCEuLGcliyEWL4aqhXG
         N6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAZ/Hr87LSTIZTCb7Wxs3zhIrvER/YPKf3yjQBgVAuM=;
        b=ChFpQrX+0KVKZuxC699c1C0ruD28wRmLxfx4C8SZ0HvZ0NeQrKiaqaj3pQ/H7PwjsZ
         p6t+Q094K7RQRb/u9rZwEmcHlZSm+xeJSoLXUMZZVrWC1EtzHUbDryjPkUFBnkTZOnc9
         h2zJKZE8z19srL1acsbJzhY8pZa2V/ur7K44YctPRq0mkREksvjpoLmgkoN7838dkMfK
         75jOpT76iW7gfdJ0sdho6yzbT4yl1JJJijbpKtKFJcygby8NRVg9wAnmdZaS1wg9zsjg
         +0fBA6pXo7YGyTiX00ALsOI5SATYz57K2lKL0KkWDtoMi2m1AY/ppKi+qBWMeTucgIkl
         uTAg==
X-Gm-Message-State: ANoB5pl0h/wdb7Afd0i/BSAxxYaUPShjNIdXIu91MD3pYRGYEgNHfe6L
        Rv8N03xnknUPxYlIO7E+QpPO9eie0IA58USQnIvyL6g0IIY=
X-Google-Smtp-Source: AA0mqf4qpyFzrLGualytYJ2Cj9vnqqjzf7LANoBwKs14yMClz5ZcLQtma+uZqiQKsF1YmO2bxMZkuAP8li4+7SiZYEE=
X-Received: by 2002:a25:2fc3:0:b0:6f2:2176:43d9 with SMTP id
 v186-20020a252fc3000000b006f2217643d9mr23977080ybv.414.1669735322898; Tue, 29
 Nov 2022 07:22:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v7.git.1669136378754.gitgitgadget@gmail.com>
 <pull.1384.v8.git.1669154823035.gitgitgadget@gmail.com> <xmqq5yf3fx4s.fsf@gitster.g>
In-Reply-To: <xmqq5yf3fx4s.fsf@gitster.g>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Tue, 29 Nov 2022 09:21:51 -0600
Message-ID: <CANaDLW+ukK2GU7NzkCvXVNc9DX3_93Pp+PHq-WcLpRJizPidVA@mail.gmail.com>
Subject: Re: [PATCH v8] status: modernize git-status "slow untracked files" advice
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the amazing feedback, and sorry for the delay.


> "time" I can sort of understand ("can reduce the time taken to
> enumerate untracked files" is how I may phrase it, though), but
> what did you want to say with "size"?

This bit was provided by a past reviewer so I hope I don't
misrepresent it, but I think the idea was to convey that the reason
it's faster is because the part of the codebase it will do active work
on is smaller. I don't think it provides compellingly more information
for end users, compared to just mentioning time, so I'll simplify with
your proposal here.


> Additionally (read: you do not _have_ to do this to make this topic
> acceptable, but it probably is worth thinking about), if we need to
> introduce a new helper function uf_was_slow() anyway, a much better
> change may be to make the 2 seconds cut-off configurable, than
> inventing GIT_TEST_UF_DETAIL_WARNING used only for tests.

I agree it would be an improvement, I'm going to try to do this. This
doesn't feel like a much more involved change compared to your
alternative suggestion of setting a hardcoded test value for
`s->untracked_in_ms`, so it feels like there's not much to lose from
doing it this way, while users would gain some nice configurability.

For transparency, my intuition is that I'm not sure there will be use
cases where the config will be meaningfully leveraged by users. My gut
is that the current cut-off time is an arbitrary UX perception
cut-off, so I'm not sure it would need to be different depending on
given repo situations. But I'm also very aware that I could be wrong,
and this could open use cases that I'm not thinking about. And to your
point, it would be sensible to use it as a test input anyway, so we
might as well make it a user-facing tweak; so, I'm on board.


> Wouldn't it be redacted into "It took 9X seconds to enumerate"?
> It probably does not happen, only because you are forcing the code
> to pretend that it took 2.001 seconds or something, I suspect.

Yup, you guessed right. I'll be sure to change the regular expression
to be resilient to double-digit times.


> Also, what do you need /g modifier in "sed" script for?  I do not
> think we give more than one such number in the message we are
> testing.

Indeed, it's not useful to anything, and shouldn't be there, I'll fix this too.


All of the other comments are crystal clear, and I intend to implement
them exactly as advised. You can expect a new patch this week, maybe
even today.


Thanks a lot again!
