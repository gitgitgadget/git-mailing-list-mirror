Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D1BC636CC
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 00:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjBHAag (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 19:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjBHAae (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 19:30:34 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909633AAC
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 16:30:33 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r2so15217107wrv.7
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 16:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wADX7rxaUybiZcrdUj8SK/6kSssBNLDng9Wp/qsgmGM=;
        b=p4OZKMXsYZ3f3QKRKKcXid503v3TrqRGqHvFhX1Ab7DCUxeCiZpE43H01de9EKyShc
         83gm9UXVarV7Jdr7fJcTW7arOyKrNSUBAFyWnzd6aznZPvmS8oDT4nA7/kEexQYRH2iT
         iiJRP9DQI4fsripY6rCUU6Iv+Xs6Aljab9mzYf7jr3bpKytZEftevzcjdjZhR0pnEiqQ
         7yI7hNCEw5+JMEUJRLTu9C2iM1R8qv2wyBv2NcN3w1jvEv7gGOM2X0DNmp9rv1Htkxx9
         dsic6XGDxfLzIZjTuBj/xPCtBI9ZbrpfYwphthBrcWf3h8X7I4Dpi2rSzsknpZ3E/875
         xcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wADX7rxaUybiZcrdUj8SK/6kSssBNLDng9Wp/qsgmGM=;
        b=aKs+oIHjKPxWg71qwWUGgC4tY1XNE+WIUP4vX8k7F+dujF1fJ8YgXi3PqLFP8JRoqR
         TNeOcnHBnVbVU/vSXMNRv8NqaFJX+TNtPI+pi+OKF3yXwOaSSRksyV26D9t18boLwVqn
         yu2nIf+EybNPGRMkUwmiZB/2VMu0HVPIdxrsXpRtJBqkXwPfzY6ChFbjmK0TYQA+JXwI
         vUX/1DLeaUDAeFbApPdZZZYPVuymr5tIVabJOidEd8YDPp0tAKaL8X96eQRCUyIaWn89
         24Rt10LdWbAXdPrPBN20l/QcW3nn/O+hBHxz4HOxD/GpREG9pd46dew7wEZM4dH4us9t
         +jlA==
X-Gm-Message-State: AO0yUKUkLJfIeZBEvdgk7Fc0zEaUAHLJWSOweWaHaIVxB7uosPnLVez5
        hCt08BV87pnXCWjl+PWGbnI=
X-Google-Smtp-Source: AK7set/shSWfv452dEcueoeuH0m0kXhl0UdbJtN+To8b+TJnC+STFU9t5bmhbXX1lW2Bd5aUcCX5CA==
X-Received: by 2002:adf:e749:0:b0:2c3:e5f5:9faa with SMTP id c9-20020adfe749000000b002c3e5f59faamr5263602wrn.58.1675816231998;
        Tue, 07 Feb 2023 16:30:31 -0800 (PST)
Received: from [192.168.2.52] (141.red-88-14-210.dynamicip.rima-tde.net. [88.14.210.141])
        by smtp.gmail.com with ESMTPSA id bv20-20020a0560001f1400b002bc8130cca7sm12231055wrb.23.2023.02.07.16.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 16:30:30 -0800 (PST)
Subject: Re: [PATCH v2] bisect: fix "reset" when branch is checked out
 elsewhere
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <1c36c334-9f10-3859-c92f-3d889e226769@gmail.com>
 <ada28944-6e9e-d4e7-74c9-ffadaf406e1f@gmail.com> <xmqqwn4u2ztc.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <eb086063-9e47-9fdb-3644-77a843733dcf@gmail.com>
Date:   Wed, 8 Feb 2023 01:30:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqwn4u2ztc.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06-feb-2023 14:29:03, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > Since 1d0fa89 (checkout: add --ignore-other-wortrees, 2015-01-03) we
> > have a safety valve in checkout/switch to prevent the same branch from
> > being checked out simultaneously in multiple worktrees.
> >
> > If a branch is bisected in a worktree while also being checked out in
> > another worktree; when the bisection is finished, checking out the
> > branch back in the current worktree may fail.
> 
> Sorry for asking possibly the same question again (which may mean

No problem.  I am sorry because I don't understand what's worrying you.

> that the phrasing of this paragraph is misleading), but isn't it a
> good thing if in this sequence:
> 
>  - I checkout 'main' and start bisecting (BISECT_HEAD says 'main');
> 
>  - I then checkout 'main' in another worktree; I may even make a
>    commit or two, or even rename 'main' to 'master'.
> 
>  - I finish bisection and "bisect reset" tries to take me back to
>    'main', which may notice that 'main' is checked out in the other
>    worktree, and fail.
> 
> the last one failed?  After the above sequence, I now have two
> worktrees, both checking out 'main', and it is exactly the situation
> the safety valve tries to prevent from occuring, no?

We are considering the initial branch (BISECT_START) as a branch checked
out _implicitly_ in the worktree that is bisecting.  Doesn't that
provide us and the user enough safety?  And is this not enough safety
for us to allow "git bisect reset"?  Just "git bisect reset", without
any other argument.
