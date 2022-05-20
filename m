Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2DFC433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 07:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346423AbiETHbH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 03:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiETHbE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 03:31:04 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067A713D28
        for <git@vger.kernel.org>; Fri, 20 May 2022 00:31:01 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ck4so9733352ejb.8
        for <git@vger.kernel.org>; Fri, 20 May 2022 00:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=xC9GPXHNTbQ8L5AwxcqkeThoNWgAN/7S4aIuem0xbug=;
        b=boywQOWXDQa+5r7/PW5/P54+W5K86Tqzs9U5eccY58I4uw6hdJABh6wooynG1DK51b
         zOp+mA7pmh90SpLsoXNSkZ55hTJ0JwonOlq1LR1NkstQYipKBIoKMnxxZx+WQUq6GcCF
         62I9NSGgjF+9Kttypi3M3LnkD2kqzQ/7+1m6zYzvi76YtZ32fjN26UyfUgTfh1Umq1TR
         6tyXXkdbhe/5fMnSyy76krpSWnkKO4godosJhjKvTRBcdtQgYchPLzHoNC4D16U83n+Z
         uH9C+wPEOZiRp5jc/ORfS++oU7HxBR797Jw+wMuXzFvqVJlGEe73zrCEDzrYG0o1q0uE
         L0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=xC9GPXHNTbQ8L5AwxcqkeThoNWgAN/7S4aIuem0xbug=;
        b=U89P1djahGhdIgCMX/YaLMxc58G56WVtTbeG9TJMTh+Y4tk7K+pgFqYfUe8q6N+IPw
         OC/TTqTvFNm+2N6Id+28W85LE+kaPVI5b5s9fXTar7VebjeJruOVNRV+aru2d+mSywcq
         aQxmnN3c69ixE3oGSHXMvDDdMshEyZRMBRWhrgLVT/rVixTF/wypwt+p/xZoZ4Q71xA9
         4Mfi6QVtrwjTwx1vUlWSiunA1GEmXMziSEgNhu40yox8oNh0kECbS+MxK1i4zfMWTHYI
         /lMWbaddozQ4/x3ffMWvK5u4eZ90JtY9r01r9FsyycykxVr4XDS0M8+VE11Ykp2irqq/
         RopQ==
X-Gm-Message-State: AOAM533jUymwAfmFsucSpEh6Vr5b/2MF63SvEVFvhE3tnUpxY03B4oOf
        iB//KTi0Op3SgLGJUSviHns=
X-Google-Smtp-Source: ABdhPJwgL0PaVCnCN6mU+CkIVp+gEj7F+nYZFZfM9l5VaBrnI6gwLYH7b/lNvM/kadvhYHK06xun0w==
X-Received: by 2002:a17:906:6985:b0:6fe:988b:d248 with SMTP id i5-20020a170906698500b006fe988bd248mr6254518ejr.226.1653031859512;
        Fri, 20 May 2022 00:30:59 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id m25-20020a17090672d900b006f3ef214e1dsm2943795ejl.131.2022.05.20.00.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 00:30:58 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nrx68-002P5R-G2;
        Fri, 20 May 2022 09:30:56 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 3/7] scalar: validate the optional enlistment argument
Date:   Fri, 20 May 2022 09:30:22 +0200
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
 <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
 <da9f52a82406ffc909e9c5f2b6b5e77818d972c0.1652210824.git.gitgitgadget@gmail.com>
 <220517.867d6k6wjr.gmgdl@evledraar.gmail.com> <xmqqbkvuwxps.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqbkvuwxps.fsf@gitster.g>
Message-ID: <220520.86fsl43bkf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 18 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> +test_expect_success '`scalar [...] <dir>` errors out when dir is missi=
ng' '
>>> +	! scalar run config cloned 2>err &&
>>
>> Needs to use test_must_fail, not !
>
> Good eyes and careful reading are very much appreciated, but in this
> case, doesn't such an improvement depend on an update to teach
> test_must_fail_acceptable about scalar being whitelisted?

Yes, I think so (but haven't tested it just now), but it's a relatively
small change to t/test-lib-functions.sh.

I was just noting the potential hidden segfault etc., the issue remains
in v5.
