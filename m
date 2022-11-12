Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AEDC43217
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 01:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiKLBLK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 20:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiKLBLI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 20:11:08 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170AC391F3
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 17:11:07 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id k11-20020aa792cb000000b00558674e8e7fso3446323pfa.6
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 17:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dwRprehlIoWj6PjxBS+Ru2uLF6jxG8uKgHnJc8h1+LE=;
        b=A+4iI/yv9f0fPUOXf23H0Sw27zGRC8YR/UeU5QqY0B091BFWivth/j/M6JcELZlOEd
         6lTNhd+Tp8PNo1qPFtYfjzPdtNjCyo2G/Tan52675JflzB/XmlBwF+Yp0rbTwRfFXl62
         DvcSTrGrp1NPqxn8cVFHXezS3UBFPNsdoRjvSUona6iKTyAxM7+VGdDXsMKTkHoi1Jj2
         86Hx5dWPAkR2h3hnXO3irNuitqeMFBIBWA1njbK9mTAFfFCztkFvKkF8rxR+r27cJ6sQ
         bidJt3AQ1sEml6/PimfAvoiiE4mQ+Uwg/7g7Cy1B6Ef0s1qMIEKGWuQVyA5Yzut9kBUp
         X8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dwRprehlIoWj6PjxBS+Ru2uLF6jxG8uKgHnJc8h1+LE=;
        b=BBRXhGLXBX4ohLksxMBIpbLAfBHdfRQrAWc/s2BOeqkS/Ks8IYNr2kML3DPsE4umQb
         qqTjYNrMIhHbJCxEbIq3VSYFg/bgaUaIv3qFTsLUbQxkXSpzCMFea6hF+1nQPpt+Ij9o
         AzAiqbGj1URylz+czri7aLoGJ58jGONU3Vstr6hcVGngL6+aF0RZG2AXI2dbdb8qxNYp
         UaiakiSoVHKtNwq69mYj00DwwCHnwKgEIesTdvYsM1Rk5XRUqxIgHI3WIk+nE0OBO+6M
         ZYNX60eq3WuiPr+FHUeW0V1zDnZqYXBGDvoMhlEWRjupyaR0A152Xplz11chB18mAAca
         VX1A==
X-Gm-Message-State: ANoB5pkDiR9N6T3zi4yhSWRb8GCUmbT1X/u7uLxjND6JCcBJeK2yfrxr
        BL3xjv1gHlvIKdGI2QMH9p3H36F2EbNtMA==
X-Google-Smtp-Source: AA0mqf52bKCphjubDYeBYh5fTn+S7WF83Mz/jqzVWN/10uVJTVKFpbGUHITIULla9DsR8XVVgRUFrqho+9cLpA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:9156:0:b0:56c:a60d:54d7 with SMTP id
 22-20020aa79156000000b0056ca60d54d7mr5054090pfi.18.1668215466481; Fri, 11 Nov
 2022 17:11:06 -0800 (PST)
Date:   Fri, 11 Nov 2022 17:10:58 -0800
In-Reply-To: <221111.86fsepmbhe.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
References: <20221109004708.97668-1-chooglen@google.com> <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <kl6ltu373ae5.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221110.86zgcznjah.gmgdl@evledraar.gmail.com> <kl6l5yfm2taf.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lv8nl1h19.fsf@chooglen-macbookpro.roam.corp.google.com> <221111.86fsepmbhe.gmgdl@evledraar.gmail.com>
Message-ID: <kl6lsfip0yfx.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH 0/8] Get rid of "git --super-prefix"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Nov 11 2022, Glen Choo wrote:
>
>> Glen Choo <chooglen@google.com> writes:
>>
>>> Rereading this series and thinking about this some more, let's go with
>>> your approach, primarily because it avoids global state.
>>>
>>> From this series, it seems that it's not that hard to make this change
>>> and support whatever use cases we currently have.
>>>
>>> This does make it more tedious to add more "--super-prefix" in the
>>> future, but that's a good push for us to do more things in-process
>>> and/or be more principled about passing context objects through the cal=
l
>>> stack instead of relying on globals.
>>>
>>> Let me know what I can add to this effort besides reviewing :)
>>
>> Specifically, if you have other things on your plate, I'd be happy to
>> pick up where where this RFC has left off.
>
> I was going to get around to re-rolling this in the next few days, but
> I'd also be happy to have you beat me to it.

Ah, well, I didn't mean that I was planning to work on this over the
weekend, but I can certainly get to it on Monday. I meant something
closer to "If you didn't want to think about git-submodule.sh for the
next week or so, I can pick this up".

Alternatively, I think it also makes sense if you want to reroll only
the submodule--helper bits (1-7/8) to unblock your git-submodule.sh
work, and I can prepare the rest of the "nuke --super-prefix" stuff on
top of that. That should save you a context switch, and since I sent out
[1], nuking --super-prefix shouldn't be urgent.

If you don't really care any which way, I'll just re-roll this :)

[1] https://lore.kernel.org/git/pull.1378.git.git.1668210935360.gitgitgadge=
t@gmail.com

>
> My plan was basically:
>
>  * Steal the test from your series, put them at the beginning, and for
>    those that fail make them "test_expect_failure", then
>    "test_expect_success" later when they pass.
>
>  * Pretty much my RFC as-is. If you're re-rolling it I'll leave to you
>    whether it makes sense to do it with the "read-tree" included (I
>    think probably yes, but "just the submodule--helper" is smaller).
>
>    Rewording the commit message referring to "the other approach"
>    (i.e. your series) probably makes sense in light of later discussion
>    (probably just dropping it).
>
>  * Right now I can't remember if that one test failed until the
>    "read-tree" patch, or if the "submodule--helper" was sufficient, so
>    maybe we need the "read-tree" one to flip the
>    "test_expect_failure"...
>
>  * The 8/8 has a wart where I just removed "SUPPORT_SUPER_PREFIX" from
>    git.c, but didn't adjust the rest of the bitfields, i.e. it should be
>    1<<0..6, not 1<<0..3,5..9 at the end (having removed "1<<4". You got
>    that right in your version...

Yeah, this plan makes sense. One thing I'd add is that I'd also use
OPT__SUPER_PREFIX to handle "git fetch --submodule-prefix".

>
> If you can do that and address any other nits/issues you find that would
> be great. I don't think I'd get to it before next week otherwise, but
> it's earlier in the -0800 TZ :)
