Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3159FC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 19:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbiCITnm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiCITnl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 14:43:41 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CC5A645C
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 11:42:41 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qx21so7349800ejb.13
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 11:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=yldBNWuLcd7xFxej5FQfuFpwBgsIXgaTrNugLQykxx0=;
        b=pV+RmzMNp6W2fkbTH9fARCK0ZFvfCHeiyh8iYDNHBXsN4BZWyzGIitMwgfSbtY01gZ
         JrZUrhPsyckCXDFVCAJ4CAzT6ncDwQO/wLT36rQpcRiClnBAOgrl0MfStLYuF9FFZB2r
         1IR2iYFNxnEyE4FWQ8L1SnVnhlTwyZj5WFRtPpuvg7gWQrCzjJb/vDQKDmLMwTZBpX+5
         ESXGhJDYuDtwSe4hg6BVWYBEOCuL1wnkMEtpbonnIUFxe+IlgPrkSeXEJd7q/u8Fi2Kp
         aklFyNBYbNQaIKkXo+CloRFEytgwHdN5MAOA6HQ8W0YiLprlUnL5WoLDBrc7U1degHTC
         O4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=yldBNWuLcd7xFxej5FQfuFpwBgsIXgaTrNugLQykxx0=;
        b=lXblc1UZFC0Kc3Dn3BIihpuBxr/WoHEG7FwyZ6foUQIgz1vM4QrvYCeaO2JS/YcMCg
         cdtxD9MUEsxTXJc3bfgpUMiBKMfiZ25TJ222ni9jw01hlkywpX1RzZYJnYxmsOC4Fab7
         LDA/+WR12DKsDm3GT9XSQkSXAW2fJs5ek0rvvlSqjw02pFTIjRPTiNSJzHATaQmNf40o
         8+evO294+J1Cj4fHUPT2pvw4ln08xDdO0aUot3tIa7voTwbjQkpgrJD7wDnecTmRey3g
         J1iwFagSgtXweAm4FMvmy0E810mW33FgCLJQgouPTkMkDSneShaiTQGslva3fxpzGvuW
         mzIA==
X-Gm-Message-State: AOAM532lfWLWvi6UWRIB10JFN9EuqTtnXm82UpPtQLDfP/xTdkQ7lwgf
        tEeHa9BgFFaWZTL76W4FmjY=
X-Google-Smtp-Source: ABdhPJxI7RuRLmd/7YswvDqlWM2dlGQDrxH/N1xxVpFiysfRnNFV5X5zX+4+lQazocCmv20Kqh9XyQ==
X-Received: by 2002:a17:906:b7d2:b0:6db:385:dafd with SMTP id fy18-20020a170906b7d200b006db0385dafdmr1272333ejb.139.1646854959933;
        Wed, 09 Mar 2022 11:42:39 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bm24-20020a170906c05800b006d58518e55fsm1075275ejb.46.2022.03.09.11.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:42:39 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nS2Ck-000DrX-OJ;
        Wed, 09 Mar 2022 20:42:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/24] revision.[ch]: add and use release_revisions()
Date:   Wed, 09 Mar 2022 20:39:14 +0100
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <77c8ef4b-5dce-401b-e703-cfa32e18c853@github.com>
 <94242ef8-2e68-1b77-a108-2ed3604741fa@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <94242ef8-2e68-1b77-a108-2ed3604741fa@github.com>
Message-ID: <220309.86y21ilxox.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 09 2022, Derrick Stolee wrote:

> On 3/9/2022 9:34 AM, Derrick Stolee wrote:
>> On 3/9/2022 8:16 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>> =3D=3D For Junio =3D=3D
>>>
>>> This has a trivially resolved conflict with Derrick Stolee's
>>> aaf251cdc5c (revision: put object filter into struct rev_info,
>>> 2022-03-08) currently in "seen" in builtin/rev-list.c.
>>>
>>> The resolution is to just keep the "goto cleanup" in place of "return
>>> 0" in the conflicting lines, but to otherwise keep Derrick's version.
>>>
>>> It will pass with/without SANITIZE=3Dleak when applied to both "master"
>>> and "seen". I omitted one test change (described in a relevant commit
>>> message) due to the latter not being true (no fault of "seen", just a
>>> new leaking command being added to a test).
>>=20
>> Since ds/partial-bundles will soon be updated in v4 to change the
>> pointer added to struct rev_info, it is even more likely that there
>> will be more important things to do with regards to clearing the
>> memory of rev_infos based on that change. It might be better to wait
>> for that update (coming soon) and then rebase directly on top.
>
> I took a look at the series as it stands now and have a few nits
> here and there. Generally, things are pretty standard in this kind
> of series you've been working diligently on for a while.

Thanks for the review. From a quick skim I didn't see anything I needed
to address other than with an eventual re-roll, so I'll incorporate it
into a v2, pending some further feedback.

> The only thing I can recommend is to check that your leak-check
> statements are still true when reaching the end of the series, now
> that the filter member exists. Likely the tests that you are marking
> as leak-free do nothing with object filters, so they will still be
> true. Just something to keep in mind and maybe add a patch that
> recursively frees the contents of 'revs->filter' at the end.

*nod*. For what it's worth I tested this with 'git rebase -x' and a
local patch I have that allows you to run the tests in a mode where it
asserts that there's a 1=3D1 mapping between tests marked for the
linux-leaks job, and those that currently pass. I.e. a passing test that
isn't opted-in via TEST_PASSES_SANITIZE_LEAK=3Dtrue will fail if it passes
with SANITIZE=3Dleak.

I'll run the v2 with that again, and will lean on the side of just
ejecting any changes that step on the toes of other in-flight topics.

I.e. as noted in the cover letter this isn't all of the revisions.[ch]
leaks, just most of them, so I can always eject a few and leave those
for a follow-up series (which I already have patches for, but those are
all a bit more complex, so I left them out for now).

