Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8A3C4167B
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 03:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiK3DIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 22:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiK3DIx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 22:08:53 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE02C554FA
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 19:08:52 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d18so4564434pls.4
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 19:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7SMWDt9yTy3ezCfIRQdI3P1r3HRkGWLN0l5Xu8iJUo=;
        b=ndJBOuxhkvWbdUXMVtBvahe+KulYtjElahyM9Xc6qImm7Gs6EIbjIYPhe2lfyYuBYI
         2cXGpi4WTaqgnTq12TZZionldsqtVwaxCy1pHidsNnX3tYz5Js1aMiBK3TUL1AWxsPxD
         YNcdbs0JWltlrOkugpM4rLFoxPqujQFI+4AJM/uoU4vS2QI3Mu/B0XK8l0iXG3jkLZ3u
         +DY8oob53xJ5GwcDPKf08QsHns6O6gtm8T8JU60i4ZlGlrJ820MMoABxiE7gRUN2q+Xb
         GYbKu9gRLkOx+SDj4/JErPJRT9Wt+vK35kQu1xB2ayggRdsG71eu5AM/1u55BbDYR43i
         14nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7SMWDt9yTy3ezCfIRQdI3P1r3HRkGWLN0l5Xu8iJUo=;
        b=RAvHKDnVgcJy9MPT7bQIKucjUNJlxy1B3S2v+CvmbsCQgNOQT5WmC7uoN0pKbDKkKY
         PUscXKJ+yGsVpy6mJm2/ZzJbKDIQ2xHKcfyrrM4wKoOGJVqfb+zw3MIU+0jRhiqrO2It
         Wj/Xb8T5QZMpaMHd47LBLIlY56lnqdFyeuzmV0/rWIcPjTnretW18v7fETycpOcIaLc5
         Zh6gWc5NVPbRFLmyHBR+vdALyS2uNPi7qzIm32aVwCd3kt1mMHxOQhKWLrMDCSvmiU87
         amYkVyv5ztNYAvNEFf6a8cFLke4ERJqrgo7UwJUx89s2OerIzad9f76dhYsDiAN698PR
         9Kvw==
X-Gm-Message-State: ANoB5pnr47o+mICpH2MxSxMJU8S06ytReJrd0cE1TEPPcmL39bHHUtgd
        HJ9swdvZ4vJ2LZAg7eL75M0=
X-Google-Smtp-Source: AA0mqf703bS7eNjFnCj5A32MUX43vrnd503BLUvc67H0L60Ipy+m8uBMEDMgSE0pkXXdMffvv4jbzA==
X-Received: by 2002:a17:90a:668b:b0:218:8666:e77f with SMTP id m11-20020a17090a668b00b002188666e77fmr57767787pjj.0.1669777732174;
        Tue, 29 Nov 2022 19:08:52 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x12-20020a1709029a4c00b00186a2dd3ffdsm68432plv.15.2022.11.29.19.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 19:08:51 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Alison Winters <alisonatwork@outlook.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alison Winters via GitGitGadget <gitgitgadget@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] add case insensitivity option to bash completion
References: <pull.1374.git.git.1667669315.gitgitgadget@gmail.com>
        <xmqqedtm4h93.fsf@gitster.g>
        <PRAP192MB1506B74F9BB25061419FA228DE129@PRAP192MB1506.EURP192.PROD.OUTLOOK.COM>
        <221129.86y1rtirhl.gmgdl@evledraar.gmail.com>
        <PRAP192MB15064FE07E86792F36FCE267DE159@PRAP192MB1506.EURP192.PROD.OUTLOOK.COM>
Date:   Wed, 30 Nov 2022 12:08:51 +0900
In-Reply-To: <PRAP192MB15064FE07E86792F36FCE267DE159@PRAP192MB1506.EURP192.PROD.OUTLOOK.COM>
        (Alison Winters's message of "Wed, 30 Nov 2022 08:37:07 +0800")
Message-ID: <xmqqmt8916m4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alison Winters <alisonatwork@outlook.com> writes:

> In this case, I think the easiest solution will be to move the
> aw/complete-case-insensitive branch forward to the v2 patch (posted to
> the list @ 2022-11-21  0:26 UTC), which no longer includes this line.

Indeed.  With <pull.1374.v2.git.git.1668990419.gitgitgadget@gmail.com>
merged on top of a known-good subset of 'seen', cmake-ctest thing did
not fail.

https://github.com/git/git/actions/runs/3579752650/jobs/6021251201

Thanks.

P.S. Ignore the osx-gcc job that was cancelled in the same run; as
this is not the only topic I have to deal with, I submitted a trial
merge into 'seen' of another topic after seeing cmake-ctest job
finish, but because of recent CI change to cancel an earlier job
when a new job is started, it got auto-cancelled (which is mostly a
good thing for regular developer workflow, but not for me X-<)

