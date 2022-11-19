Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7831C433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 11:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiKSLtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 06:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiKSLtv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 06:49:51 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6D54AF0B
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 03:49:49 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id me22so2293460ejb.8
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 03:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vlci4faf6UbXk8pli0L13YMrWZwWnWOFB0WHqs921Cw=;
        b=DmYEhOhqSXgXXl0277x+pf0m2JkD6sBReulPVxU6Oc7sJzqVWo9d68ClzzOL5c9iNp
         KtX9PgZWj/ojrxBcio56GibYCIA0oZchYPVtyZ8gPigIL4u3Vau1XuHbLb4H9Ym+Mtey
         BsLq/PgMkb018BD4fsqIWhl97kmiURuV7cYw/lfxA9GTJM4bWaa5C77jO0ZUihN9BZqO
         EGVMd4j1o7+ZnCsEHmVPQ4JhEdgjbCCzgbXrqA5GhcGOXdDezL589/Tym1bTwRGerNpf
         cy+YQqDz58Zsfn3AIpevI9UCYtMn98Z+AtTBhmq6u4JfLAjZ/oXUZFLhBU8Z0nfUDDCi
         frNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vlci4faf6UbXk8pli0L13YMrWZwWnWOFB0WHqs921Cw=;
        b=7fFaRxI1AVq/X2wigY+1o8v4SQManUijyuu0iFb8zGxU4DlUe305bhF/MfJKSACIO2
         9X87Oxp9aiRt740FPQBILR56G0IvN8AUqMZg7M/nf+OEMPzjvtR18rybvDQwEiG5dcAZ
         QTdKKIaODISFKBIOFu2QxpJA6guhpwSG1klhoWWj0YRVlRF1L2GQtD1Dw2QUMwJL3QcV
         wTH7VqVNwLjoh76+LEklpDmveOIOr+Mto8gIVJ/pUGtPrqOvA8U3xquA4/JmG9EAitko
         s8vBzGsO2WSifiWyVdaRckk41plX/DCDZGkOZJZEU5+cUl45+gmyVxFZMZjcgTx091xU
         qujA==
X-Gm-Message-State: ANoB5pnDBEsyqxSMv/swG0E+VaSZ8AilV5E6KMG3mnXb9qBERErIhc5b
        SD6ZkWEGnEoP2WcgO769PGSkfVlDQ10=
X-Google-Smtp-Source: AA0mqf567Mp/J8W9oZck/ePH+Y6vgtYlVR/+2jj+llPTlcuKGHLTtYCzIrKOmA0mq06ITKBEuimKDQ==
X-Received: by 2002:a17:907:78ce:b0:7b2:bb8e:707e with SMTP id kv14-20020a17090778ce00b007b2bb8e707emr5233770ejc.544.1668858587943;
        Sat, 19 Nov 2022 03:49:47 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id i18-20020a170906a29200b0078bfff89de4sm2829959ejz.58.2022.11.19.03.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 03:49:47 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1owMLy-006AWx-39;
        Sat, 19 Nov 2022 12:49:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/2] worktree: Support `--orphan` when creating new
 worktrees
Date:   Sat, 19 Nov 2022 12:48:22 +0100
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev>
 <CAPig+cTTn764ObHJuw8epOtBdTUwocVRV=tLieCa4zf-PGCegw@mail.gmail.com>
 <221117.86sfihj3mw.gmgdl@evledraar.gmail.com>
 <20221119034728.m4kxh4tdpof7us7j@phi>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221119034728.m4kxh4tdpof7us7j@phi>
Message-ID: <221119.86a64nf9k5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 19 2022, Jacob Abel wrote:

> On 22/11/17 11:00AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> On Tue, Nov 15 2022, Eric Sunshine wrote:
>>
>> > On Thu, Nov 10, 2022 at 6:32 PM Jacob Abel <jacobabel@nullpo.dev> wrot=
e:
>> >> While working with the worktree based git workflow, I realised that s=
etting
>> >> up a new git repository required switching between the traditional and
>> >> worktree based workflows. Searching online I found a SO answer [1] wh=
ich
>> >> seemed to support this and which indicated that adding support for th=
is should
>> >> not be technically difficult.
>> >>
>> >>   * adding orphan branch functionality (as is present in `git-switch`)
>> >>     to `git-worktree-add`
>> >
>> > I haven't had a chance yet to read v3, but can we take a step back for
>> > a moment and look at this topic from a slightly different angle?
>> > Setting aside the value of adding --orphan to `git worktree add`
>> > (which, I'm perfectly fine with, as mentioned earlier), I have a
>> > question about whether the solution proposed by this series is the
>> > best we can do.
>> >
>> > As I understand it, the actual problem this series wants to solve is
>> > that it's not possible to create a new worktree from an empty bare
>> > repository; for instance:
>> >
>> >     % git init --bare foo.git
>> >     % git -C foo.git worktree add -b main bar
>> >     Preparing worktree (new branch 'main')
>> >     fatal: not a valid object name: 'HEAD'
>> >     %
>> >
>> > This series addresses that shortcoming by adding --orphan, so that the
>> > following works:
>> >
>> >     % git init --bare foo.git
>> >     % git -C foo.git worktree add --orphan main bar
>> >     Preparing worktree (new branch 'main')
>> >     %
>> >
>> > However, is this really the best and most user-friendly and most
>> > discoverable solution? Is it likely that users are somehow going to
>> > instinctively use --orphan when they see the "fatal: not a valid
>> > object name: 'HEAD'" error message?
>> >
>> > Wouldn't a better solution be to somehow fix `git worktree add -b
>> > <branch>` so that it just works rather than erroring out? I haven't
>> > delved into the implementation to determine if this is possible, but
>> > if it is, it seems a far superior "fix" for the problem shown above
>> > since it requires no extra effort on the user's part, and doesn't
>> > raise any discoverability red-flags (since nothing needs to be
>> > "discovered" if `-b <branch>` works as expected in the first place).
>> >
>> > If fixing `-b <branch>` to "just work" is possible, then --orphan is
>> > no longer a needed workaround but becomes "icing on the cake".
>>
>> That's a really good point, and we *could* "fix" that.
>>
>> But I don't see how to do it without overloading "-b" even further, in a
>> way that some users either might not mean, or at least would be
>> confusing.
>>
>> E.g. one script "manually clones" a repo because it does "git init",
>> "git remote set-url", "git fetch" etc. Another one makes worktrees from
>> those fresh checkouts once set up.
>>
>> If we "DWYM" here that second step will carry forward the bad state
>> instead of erroring early.
>>
>> I haven't fully thought this throuh, so maybe it's fine, just
>> wondering...
>>
>> ...an alternate way to perhaps to do this would be to detect this
>> situation in add(), and emit an advise() telling the user that maybe
>> they want to use "--orphan" for this?
>>
>
> Prior to writing this patch, I tried to determine if there was a succinct=
 way
> to make `-b` "just work" however I wasn't able to find one that wouldn't
> introduce unintuitive behavior. My conclusion was that it was probably be=
st
> to break it out into a separate command as the other tools had.
>
> I'd support adding an `advise()` for at least the basic case where you tr=
y to
> create a worktree and no branches currently exist in the repository.
> i.e. something like this:
>
>     % git init --bare foo.git
>     % git -C foo.git branch --list
>
>     % git -C foo.git worktree add foobar/
>     hint: If you meant to create a new initial branch for this repository,
>     hint: e.g. 'main', you can do so using the --orphan option:
>     hint:
>     hint:   git worktree add --orphan main main/
>     hint:
>     fatal: invalid reference: 'foobar'
>
> and
>
>     % git init --bare foo.git
>     % git -C foo.git --no-pager branch --list
>
>     % git -C foo.git worktree add -b foobar foobardir/
>     hint: If you meant to create a new initial branch for this repository,
>     hint: e.g. 'main', you can do so using the --orphan option:
>     hint:
>     hint:   git worktree add --orphan main main/
>     hint:
>     fatal: invalid reference: 'foobar'

I think those would make sense, yes.

> but not in the following circumstances:
>
>     % git init --bare foo.git
>     % ...
>     % git -C foo.git --no-pager branch --list
>     + foo
>       bar
>     % git -C foo.git worktree add foobar/
>     Preparing worktree (new branch 'foobar')
>     HEAD is now at 319605f8f0 This is a commit message
>
> or
>
>     % git init --bare foo.git
>     % ...
>     % git -C foo.git --no-pager branch --list
>     + foo
>       bar
>     % git -C foo.git worktree add -b foobar foobardir/
>     Preparing worktree (new branch 'foobar)
>     HEAD is now at 319605f8f0 This is a commit message

*nod*

> Would there be any other circumstances where we'd definitely want an `adv=
ise()`?
> Generally I'd assume that outside of those two circumstances, most users =
will
> rarely intend to make an orphan without already knowing they absolutely n=
eed to
> make an orphan.

I'm not familiar enough with the use-cases & workflow around "worktree"
to say, sorry.
