Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B5AC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 17:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiJTRzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 13:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJTRzC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 13:55:02 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A8EB97BB
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 10:54:59 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id 187so202542iov.10
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 10:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWZrDWqX7TwqbEL+VtPTnAVQaLUYhZvjuf1oy44hlcU=;
        b=lV93FFyPKVG6xV3UJhGWzgtWZNWx14u4FLLQV1g22s4wZNQPQHMGkpbvlI8BIyyPXL
         QRPUKrjRm7kGyED2cd5oQ3tdWj58toLCkl0FGLw68D0sfGb1uyx6+GtTducIuyPtPk/H
         b0mIzxATH11hsB3z4N/gmFUQRsqzyo/zVcdjNZbZwiFlOqAGkmuxq+NAPzIWsWoVMwex
         8u3I/gAMa++4nFqZoD4SNRYGbEGzFfQdB2JcA5NY0vNAlySDaHcqe7UIkSWPcOqAFpeb
         nmBiqk+ewCXAOndKr8/W44ugZKR5MsVJxybQ7MRp09kv93KkJzxQZ7Dl4ub93LI9L/qh
         rbtQ==
X-Gm-Message-State: ACrzQf2SMujrXeZLxQ1Vy6UNQgkf+Ss3MAt3F4vHVfeR+xJlrZGuWXu3
        rinLY9oZ/ZslH4kxMv6lEwBsVQNW7+ZvJnH/5CY=
X-Google-Smtp-Source: AMsMyM5SeX95t/5AkFmrGO/icL7Quxnq31QK9wUQJ4tlniBbho6RyO9INXOKN5SKcAFG7Z0cQY9jzGIWTX0LM23vyY0=
X-Received: by 2002:a05:6638:3f0d:b0:363:ba76:7397 with SMTP id
 ck13-20020a0566383f0d00b00363ba767397mr10766596jab.177.1666288498664; Thu, 20
 Oct 2022 10:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
 <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com> <kl6l7d0yyu6r.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqo7u9wyt7.fsf@gitster.g> <xmqq8rlamq29.fsf@gitster.g> <CAPig+cRkQLyy8X7y=1jhrVwYERk5ucagAfJkTAOPNODofiZr1g@mail.gmail.com>
 <xmqq35bitooc.fsf@gitster.g>
In-Reply-To: <xmqq35bitooc.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 20 Oct 2022 13:54:46 -0400
Message-ID: <CAPig+cQHTvv3pYEnDVer6JT21Jd7kADuF5LG+nt=hd6K_5PoXA@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric DeCosta <edecosta@mathworks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 1:01 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Thu, Oct 20, 2022 at 12:13 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> All other jobs were using the default DC_SHA1 (which is a
> >> recommended practice), but the default for macOS jobs being Apple's
> >> common crypt, we didn't catch recent breakage soon enough.
> >
> > "recent breakage" is quite vague and probably won't help future
> > readers understand what this is actually fixing. Possible
> > improvements: (1) a prose description of the breakage; (2) the actual
> > compiler error message; (3) a pointer[1] to the email reporting the
> > problem. One or more of the above improvements to the commit message
> > would help future readers.
>
> I do not think (2) or (3) would help all that much.  A finger that
> points at the exact commit that broke the build (with the condition
> under which the build breaks) would probably be the most useful to
> those who read "git log" output.
>
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: [PATCH] ci: use DC_SHA1=YesPlease on osx-clang job for CI
>
> 7b8cfe34 (Merge branch 'ed/fsmonitor-on-networked-macos',
> 2022-10-17) broke the build on macOS with sha1dc by bypassing our
> hash abstraction (git_SHA_CTX etc.), but it wasn't caught before the
> problematic topic was merged down to the 'master' branch.  Nobody
> was even compile testing with DC_SHA1 set, although it is the
> recommended choice in these days for folks when they use SHA-1.
>
> This was because the default for macOS uses Apple Common Crypto, and
> both of the two CI jobs did not override the default.  Tweak one of
> them to use DC_SHA1 to improve the coverage.

Thanks. This revised commit message does a much better job of
explaining the problem the patch is addressing.
