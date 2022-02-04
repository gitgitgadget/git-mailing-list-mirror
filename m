Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470D9C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 04:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244549AbiBDE2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 23:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbiBDE2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 23:28:24 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A7FC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 20:28:23 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id u24so10497006eds.11
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 20:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=q58cchLonvmKm+4IaF+kTndtB/hSox+0odYU5cm5ASQ=;
        b=P3LJdwaCmOnJ76iFCmODXiDkL7/QegF4lcsCbsItfUsKj18gLbJsaLM7lxL0WWTsmk
         7BlM1bKkUeJTAP2JuUZGX7bFSEJwi1AvIt2sNKHvxsxSgDT45aOyDQoWFjxtOWoVh72U
         tzKj6MuMTcgf58wyxg+Zw3sEIJ4EEaXnrxWbVHDzglymeAqBSAOpS/r2/7XyIgMbg96y
         8iTOszaQ2xWPCPAwSKTVjWQ+0TiJ4cTmm5fzyJ29kMLxF+dKrpiYjFhY3O6IOy6iKsaG
         C0BfH5aqc4xNegKeLGD72p1ElWyiUB5Kst8gA35bVC9AwEqVA71Qn31Ekvl0V5IOegin
         CM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=q58cchLonvmKm+4IaF+kTndtB/hSox+0odYU5cm5ASQ=;
        b=NNcwDoRGoGzBSbY/U9JNxmuaj0eNZJkX6PtCDHZn11+8OQzhAQGioHnfUO+7Jg/xqY
         uDngvGSieK0o7AoSEAmsj9nnKG7xiygBivDNM0l+d7D6+iCaZKG1FRahkd7ZMew/SgVb
         rntkDocXsOBhRz8eUFyxzWXFeHn+aBlzKx4su4SC3WmcOCY6YMhalL/jI+ril14nljfa
         uFnmaUPgi5K8xkZJ86volAYIIakjvlQ5op6leq+i0/ksmX9CrFQFjd1NvrWs5XrBmLqS
         GMQ8sC4Y7OH3Mw2I/MZVj3XV9NH5pcGf5cnnVu3GZf+oARZYoKQqpMQwfOaMSYsc6E9C
         Aq1w==
X-Gm-Message-State: AOAM531ZHGcE49RLiii+zF9RW9UbUFxfNKHFbRpg+E3+q0iZZWokxsrN
        TqavpbGgvgBxi0jDNzN4of2x0VzduTtqGg==
X-Google-Smtp-Source: ABdhPJzdPcEDqLuAOW10vgCC2s08PtvDmW9Jteb6seF6CrZfQ0HAqDHagg1TMg+EmVvHrSvGWxFzsA==
X-Received: by 2002:a05:6402:548:: with SMTP id i8mr1278113edx.60.1643948902087;
        Thu, 03 Feb 2022 20:28:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lo15sm247975ejb.28.2022.02.03.20.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 20:28:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFqCr-005nJk-0E;
        Fri, 04 Feb 2022 05:28:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH v5 3/3] completion: handle unusual characters for
 sparse-checkout
Date:   Fri, 04 Feb 2022 05:25:38 +0100
References: <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
 <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
 <ddf5e583dd71a729d6fb0513aed9fc4eb6ebbdd7.1643921091.git.gitgitgadget@gmail.com>
 <CABPp-BFD51BTsG7gQFD4BuqVLLBV2iJOKnrnya89otoGonzVvA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABPp-BFD51BTsG7gQFD4BuqVLLBV2iJOKnrnya89otoGonzVvA@mail.gmail.com>
Message-ID: <220204.86h79f45nf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, Elijah Newren wrote:

> On Thu, Feb 3, 2022 at 12:44 PM Lessley Dennington via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Lessley Dennington <lessleydennington@gmail.com>
>> +# use FUNNYNAMES to avoid running on Windows, which doesn't permit back=
slashes in paths
>> +test_expect_success FUNNYNAMES 'cone mode sparse-checkout completes dir=
ectory names with special characters' '
>> +       # reset sparse-checkout
>> +       git -C sparse-checkout sparse-checkout disable &&
>> +       (
>> +               cd sparse-checkout &&
>> +               mkdir "directory with spaces" &&
>> +               mkdir "$(printf "directory\twith\ttabs")" &&
>> +               mkdir "directory\with\backslashes" &&
>> +               mkdir "directory-with-=C3=A1ccent" &&
>> +               >"directory with spaces/randomfile" &&
>> +               >"$(printf "directory\twith\ttabs")/randomfile" &&
>> +               >"directory\with\backslashes/randomfile" &&
>> +               >"directory-with-=C3=A1ccent/randomfile" &&
>> +               git add . &&
>> +               git commit -m "Add directories containing unusual charac=
ters" &&
>> +               git sparse-checkout set --cone "directory with spaces" \
>> +                       "$(printf "directory\twith\ttabs")" "directory\w=
ith\backslashes" \
>> +                       "directory-with-=C3=A1ccent" &&
>> +               test_completion "git sparse-checkout add dir" <<-\EOF
>> +               directory with spaces/
>> +               directory       with    tabs/
>> +               directory\with\backslashes/
>> +               directory-with-=C3=A1ccent/
>> +               EOF
>> +       )
>> +'
>
> I'm glad you tested with lots of special characters -- spaces, tabs,
> backslashes, and accents.  Newlines might also be nice, but probably
> makes the test hard.  Anyway, looks good to me, other than the
> indentation change.

This looks like its over-skipping tests, the comment says Windows
doesn't like \ in paths, but there's a lo more being skipped here than
that.

Shouldn't e.g. "directory-with-=C3=A1ccent/" be pulled out into another tes=
t,
leaving the directory\with\backslashes/ etc. as non-Windows?

Another useful method is to just try to create those paths
unconditionally, but with "mkdir" etc., and if that works run the test
with git. After all if the OS can create a given path, but we're not
handling it that's our bug.

But if the FS just doesn't support the path we'd catch that in the
"mkdir" (or whatever), which we can assume behaves sanely on that
platform (or we're horribly broken anyway...).

