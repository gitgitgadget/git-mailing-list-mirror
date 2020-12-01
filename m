Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C75C64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 11:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34C952080A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 11:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb5jfwZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbgLALqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 06:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730694AbgLALqF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 06:46:05 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B46C0613D4
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 03:45:25 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y22so2800098edv.1
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 03:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=i7dXmfN5/zv4143j8Yz+nps4e6UURagP9ibBTDCubPY=;
        b=jb5jfwZYUImVrYsXq6FPPQqAMbxjP8xvQqhVS7eIj5vJqfPboeD/9lgzjbfjdoXGbr
         l7WnHR6jR1bfcNIsN24Vu1iZEtTo2AM0o8d8B5Z2n4PGOVJx7usmYSmalK4RkOEFy225
         hwSga2WCtY8s3Pt5JzGxBPbAW4u91GEmy5nFoLrO2RnHQPRdkTyaDQHPEt+N5stv5V7X
         KAqqpRZuT/+i4zUXrXSlc87DG/LqJ8sOS6nPmmzp5Tm0Dx9DFd60/QlA8icLyUxj1Uw7
         XxkYPAMNgIPqK5KomLgSHgNtWh5ptYG3cBY0KLiMlE3tTI3rTv3u7YphDOKh0Pp+OS7v
         harQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=i7dXmfN5/zv4143j8Yz+nps4e6UURagP9ibBTDCubPY=;
        b=F25KUNgPOjdmJ7QiwvXx5UsOaLMxkj+norjaMOX933MhP8nyI4nUoTcCrq1RUs5WIW
         pMYffJyLm82G4MnxYlrA8fJ+CGCwU6ly0beH5sNntn4TAbgAh3bTXubLFJMTy++ebCV1
         e0QgdPZwfrBrJrig92nt7IgF5xofYsT11y+V8/UFNT5GdPomLp/sd0dKR/MlMneuoeo+
         PMjicjzSSI2fXCIr7aVTNYZBBSdJ/8XqYbLifNQaiN0GO8aqpp4U/6aApWggS82lkJyo
         1LjO/GNhpCIGIUoBM+Bv7hB44PgZKF1K9TrqkPj2oZIYkaAwbaj0xv0t35uAR+HMpSyP
         0fpw==
X-Gm-Message-State: AOAM5303ZBlla0ztFPnE+bWQ1EK2p4irBo84QdwQQzngN3syeudj7Lb7
        31s5U1Qbg0f76LxaWvk9FMa/ZZwOGjQ/Fg==
X-Google-Smtp-Source: ABdhPJx4raxnFO8ZtGlePCKXWD3slkEsSfUpeh3bgOb90Gr+lMFJBPcIxTYrUXu29IICj7nN11BDzQ==
X-Received: by 2002:a50:fe02:: with SMTP id f2mr2564281edt.97.1606823123109;
        Tue, 01 Dec 2020 03:45:23 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id mc25sm715250ejb.58.2020.12.01.03.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 03:45:22 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 03/16] reftable: add LICENSE
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
 <91c3ac2449edc45db643b0ba6cba66ef31176600.1606419752.git.gitgitgadget@gmail.com>
 <87lfennln8.fsf@evledraar.gmail.com>
 <CAFQ2z_NEkJQM6xtppW9kkAyjFrBeEiXmhhiPB8A7pmssjXHhKg@mail.gmail.com>
 <CAFQ2z_MXF0wO76tVTcBuJJp0CwjVoVfE11BOYYQ7Y7h1h_VwJg@mail.gmail.com>
 <CAMP44s0zoekLZYQ=r516jjdsGGQ2Y7m1fXpwW2BBJsGjQ5sseA@mail.gmail.com>
 <CAFQ2z_PaPdiJC71WGdePFVgxyJFFHZY_DFbmLg9sRFm=vc7XYw@mail.gmail.com>
 <CAMP44s0v92C+uUwoeBJxRv2MPCd2RuCPn8FVBUztNM9VOdjJgA@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <CAMP44s0v92C+uUwoeBJxRv2MPCd2RuCPn8FVBUztNM9VOdjJgA@mail.gmail.com>
Date:   Tue, 01 Dec 2020 12:45:19 +0100
Message-ID: <87wny1vjg0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 01 2020, Felipe Contreras wrote:

> On Tue, Dec 1, 2020 at 3:51 AM Han-Wen Nienhuys <hanwen@google.com> wrote:
>> On Mon, Nov 30, 2020 at 10:21 PM Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>> > On Mon, Nov 30, 2020 at 2:28 PM Han-Wen Nienhuys <hanwen@google.com> wrote:
>
>> > Sounds to me Google has not made its mind about actually contributing
>> > these changes.
>> >
>> > Or am I missing something?
>>
>> The restrictions are not about the patches themselves. They are about
>> restricting what gets posted under github.com/google/ .
>
> I see.
>
> But it doesn't have to be posted on github.com/google/, it doesn't
> have to be posted on github.com at all. If the code is under an open
> source license, you (or anyone) can post it anywhere.

The libgit2.git and git.git codebases are under different
licenses. Therefore if the goal is to have code that's used in both it's
not viable to e.g. store it in git.git under our current contribution
policies.

The first contributor to submit a fix to it under GPLv2 as opposed to
"any GPL or LGPL version" or whatever will preclude its subsequent
import into libgit2.

Assigning copyright to Google is a way around that. They own your work,
and then they re-license it under whatever license those two projects
use.

But as I pointed out in [1] it requires contributors to git.git's
reftable/ directory & Junio to play along with that scheme, least the
whole process come to a halt. Maybe that's worth it, maybe not. But
seems like something the series should very explicitly highlight and
document e.g. in Documentation/SubmittingPatches.

We do have some in-tree code in that state already, but it's
mostly/entirely one-off imports of GNU/FSF code like compat/regex/ or
sh-i18n--envsubst.c that we're not actively working on in any way, and
isn't core to git like the reftable would be.

There's individual contributors who just don't like the idea of
copyright assignment and wouldn't do it for that reason, but there's
also contributors who do paid-for work for their employers on git.git
sometimes.

E.g. I've done such work under terms that were basically "you can
contribute to open source as part of your job, and under the license the
relevant project uses". Going through the legal process of changing that
to "we, your employer, who own copyright to your work, agree to license
it to this third party project/company/whatever for the purposes of an
open source contribution" would in my experience be *very much* an
uphill battle.

So I think even if the individual contributor wouldn't mind the
copyright assignment (I'd personally be fine with that), e.g. I've been
in employment relationships where I'd just forget about sending a patch
if it needed assignment, because there's no way I'd be getting it past
legal, in the same way Han-Wen seems to be having an uphill battle with
Google's lawyers.

1. https://lore.kernel.org/git/873625i9tc.fsf@evledraar.gmail.com/
