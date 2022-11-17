Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4D2C4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 10:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbiKQKHZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 05:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbiKQKHX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 05:07:23 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC94231
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 02:07:22 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s5so1764525edc.12
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 02:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AROA6HmEhFEaIHEL85t3kdDk3zaDegC5YsLRviBAR8A=;
        b=fcylHpqc21pSx59NJ46F8sSpaYkuzlz04rpM0+IK12CVCiiMaASAHXyIA+csPFsCmG
         PTheJYOYZxw1NuAR4GimWU6XY0UzCblOg/8J06detsOsErC0w/NzvJr0c720wTbCDVGt
         HqUk3O9LI8KxQXIoLy6gXZ9szAsmFKtTf55HR9RHRA3YKHZz8jpisEO14KtQvvmz4H6g
         lAfkMbbpz0cpuNosSgJw0FTcpWgK/I0RkNUI+4Fm2jR3D/02h48oddhhbuON7xNrARE7
         aTQwPUJ5Js/Jrgkqpzv894pqrfFaPf6N+BwUTHMHU0ZCbZyLFREY36sIgm8I2rkCx3Gb
         /kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AROA6HmEhFEaIHEL85t3kdDk3zaDegC5YsLRviBAR8A=;
        b=2fEQnQXAeaKIifHK1ObDq50wWQE4YquLYpCkWwSt7rNn5oqGG+hpGMhmt2TDmHd4X/
         xueHq/ZiG30lrQ/6gKJSJQFw1mAS3uBWzWgb6zJDsTEslVUegII6r9r3hg/iSnbI1Osm
         w5dmbN+Wf3VhRNgjk83WAIAn/aLAHoivkyzWFsRZSrIghWJtcdcHyDVZ+6r/myz8FGml
         XKxNZKVXQfM92YzAKGFRZMXlyFDf4YAi9DgLBfkUthgi1B+Vo6pjtdp5fYHG9ATlEn3O
         wpxN+c4FUTBYpUNdhJIF8BxgcW+cDcNVmdWA84ez1Gc1exlZJpompxJ29h67RANZuC3V
         DXCg==
X-Gm-Message-State: ANoB5pnrN5XUicXEULHkexd+QGxI/cyqn8UUf083UoVrNeGLxoQ6xARv
        D24gDoANZKpfJ4IqLgD+okjF+E1ng8I=
X-Google-Smtp-Source: AA0mqf6+2qc1yqGSmhrUhNhSrBWKebwlc5iG/EHbNqCQeb0+IGAbMihQRZTnLnk/S/R3zOaUuyFvYg==
X-Received: by 2002:a05:6402:4504:b0:463:71ef:b9ce with SMTP id ez4-20020a056402450400b0046371efb9cemr1482080edb.75.1668679640685;
        Thu, 17 Nov 2022 02:07:20 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id kk18-20020a170907767200b007aed2057eaesm150476ejc.161.2022.11.17.02.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 02:07:20 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ovbnj-004iNK-2i;
        Thu, 17 Nov 2022 11:07:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jacob Abel <jacobabel@nullpo.dev>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/2] worktree: Support `--orphan` when creating new
 worktrees
Date:   Thu, 17 Nov 2022 11:00:55 +0100
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev>
 <CAPig+cTTn764ObHJuw8epOtBdTUwocVRV=tLieCa4zf-PGCegw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAPig+cTTn764ObHJuw8epOtBdTUwocVRV=tLieCa4zf-PGCegw@mail.gmail.com>
Message-ID: <221117.86sfihj3mw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 15 2022, Eric Sunshine wrote:

> On Thu, Nov 10, 2022 at 6:32 PM Jacob Abel <jacobabel@nullpo.dev> wrote:
>> While working with the worktree based git workflow, I realised that setting
>> up a new git repository required switching between the traditional and
>> worktree based workflows. Searching online I found a SO answer [1] which
>> seemed to support this and which indicated that adding support for this should
>> not be technically difficult.
>>
>>   * adding orphan branch functionality (as is present in `git-switch`)
>>     to `git-worktree-add`
>
> I haven't had a chance yet to read v3, but can we take a step back for
> a moment and look at this topic from a slightly different angle?
> Setting aside the value of adding --orphan to `git worktree add`
> (which, I'm perfectly fine with, as mentioned earlier), I have a
> question about whether the solution proposed by this series is the
> best we can do.
>
> As I understand it, the actual problem this series wants to solve is
> that it's not possible to create a new worktree from an empty bare
> repository; for instance:
>
>     % git init --bare foo.git
>     % git -C foo.git worktree add -b main bar
>     Preparing worktree (new branch 'main')
>     fatal: not a valid object name: 'HEAD'
>     %
>
> This series addresses that shortcoming by adding --orphan, so that the
> following works:
>
>     % git init --bare foo.git
>     % git -C foo.git worktree add --orphan main bar
>     Preparing worktree (new branch 'main')
>     %
>
> However, is this really the best and most user-friendly and most
> discoverable solution? Is it likely that users are somehow going to
> instinctively use --orphan when they see the "fatal: not a valid
> object name: 'HEAD'" error message?
>
> Wouldn't a better solution be to somehow fix `git worktree add -b
> <branch>` so that it just works rather than erroring out? I haven't
> delved into the implementation to determine if this is possible, but
> if it is, it seems a far superior "fix" for the problem shown above
> since it requires no extra effort on the user's part, and doesn't
> raise any discoverability red-flags (since nothing needs to be
> "discovered" if `-b <branch>` works as expected in the first place).
>
> If fixing `-b <branch>` to "just work" is possible, then --orphan is
> no longer a needed workaround but becomes "icing on the cake".

That's a really good point, and we *could* "fix" that.

But I don't see how to do it without overloading "-b" even further, in a
way that some users either might not mean, or at least would be
confusing.

E.g. one script "manually clones" a repo because it does "git init",
"git remote set-url", "git fetch" etc. Another one makes worktrees from
those fresh checkouts once set up.

If we "DWYM" here that second step will carry forward the bad state
instead of erroring early.

I haven't fully thought this throuh, so maybe it's fine, just
wondering...

...an alternate way to perhaps to do this would be to detect this
situation in add(), and emit an advise() telling the user that maybe
they want to use "--orphan" for this?




