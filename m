Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922BDECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 19:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJ1TQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 15:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJ1TQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 15:16:27 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F81B23478B
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 12:16:26 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id k22so5578749pfd.3
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 12:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMcqE0juTmV8/BEN8V7XjfYgOcWiMO3w0qf0mlPMlwc=;
        b=gKgmABwIYqDK+KcDdzJ5veQ/V+1jsww8UtrXnDMLhP9VL5m8TlsPBOmLvzlm0yk55J
         WIXys3OqHye2GLPA7mV2TNu2DSUv0/T1xfwV1VjXSUj7AufySdKFcnoEivcaEcTP40hM
         CPLwsZ9h3h0XZk2c7UVkaS3hSxb4T4X36lBCiKfFQSDamBFzJGyL9daU10CfUG6Fj1hO
         AR0OZiQyfxUU4RI5JqJfZ1pbfPjobXwIfN1CReg3UCB7Fg0cQJXburtwJuJFwyYLQgGf
         C8kX+cq4984GOBu5c1B6YV3BFnnNfBcNzMoA1BGXZ+UwFHVSCzn70yskUatP/SI1TdSC
         9HDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMcqE0juTmV8/BEN8V7XjfYgOcWiMO3w0qf0mlPMlwc=;
        b=Cqc0f1E8sjcAjjtvFQFMfSSXrodxZGPU27/9LPYCQgEI768rD4faq24tFgoIkd9Pfc
         otMHzlPSOjNByy6RvoZkjGESjPfgNqdDuUv8Z0UctqlsMIN1OESO99P1goHoKjLBcI4E
         AvARHd46jZXnmShiDmn8HPWceosuJMnjkHSOd8Mva4hJ2XGcnjdYru56H9D+RxHgl2++
         h5qCbgtpCVnhZZXQNOVMBgfiac55XsETrWAzu94awZXT82BZj2ivksnhhPdePrsTq+tX
         /kCvMOzWr+Hoz2epJ8WCa/BAwRIzOeEH/8M3aH5XUnwuV2KIAvQNDoIBIKdWsCJDq7F9
         MW+Q==
X-Gm-Message-State: ACrzQf14DlDnvkiHdLEOhyKC/qoNbHninnBr7poDfrXAOnQ4OVLQ8OtC
        hfek+4Jriddh6QVcbBrd0ck=
X-Google-Smtp-Source: AMsMyM5xs+zw3LMprLmGjFfrqKfoaFMDw0hIHFfoEVoKQFWh2E4WtnMB+D1wjBUa90jt4l8mejl/vA==
X-Received: by 2002:a05:6a00:15c3:b0:56c:e8d0:aaf1 with SMTP id o3-20020a056a0015c300b0056ce8d0aaf1mr620347pfu.75.1666984585653;
        Fri, 28 Oct 2022 12:16:25 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p28-20020aa79e9c000000b0056b9ec7e2desm3140851pfq.125.2022.10.28.12.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 12:16:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH 09/10] config API: add "string" version of
 *_value_multi(), fix segfaults
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
        <patch-09.10-bda9d504b89-20221026T151328Z-avarab@gmail.com>
        <xmqq4jvpkpxd.fsf@gitster.g> <xmqqzgdhjb89.fsf@gitster.g>
        <221028.861qqsajx6.gmgdl@evledraar.gmail.com>
Date:   Fri, 28 Oct 2022 12:16:24 -0700
In-Reply-To: <221028.861qqsajx6.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 28 Oct 2022 01:44:19 +0200")
Message-ID: <xmqqmt9fiws7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> Actually, I take it back.  Instead of introducing _string(), how
>> about introducing _bool() and convert those minority callers that do
>> want to see boolean values to use the new one, while rejecting NULLs
>> for everybody else that calls the traditional "get_value" family of
>> functions?  That would "optimize" for the majority of simpler users,
>> wouldn't it?
>
> I don't think the goal should be just to optimize for those current
> users, but to leave the config API in a state where it makes sense
> conceptually.

It is more like guiding a conceptually clean design using the need
of the current users to rein in pursuit of theoretical "elegance".

> Now, if we don't supply the equivalent of the "raw, but multi-value"
> function we'll make it hard to use the API, because now you can't think
> about it as the "multi" just being a list version of what you get with
> the scalar version.

I am not interested in _bool() variant that "stringifies" NULL to
"true" at all.  What I was suggesting was:

 * Reserve the current get and get_multi for those who should have
   been calling config_error_nonbool() themselves (because your
   _string() has not been available to them, they were lazy not to
   bother, leading to NULL dereference given certain end-user data).
   And do the config_error_nonbool() inside the updated get and
   get_multi without introducing _string() variant at all.

 * The above alone WILL break callers who are prepared to handle
   "bool" and "bool plus some other string", because they are fully
   expecting that the get API will give them NULL but the above
   update will instead stop before they see the NULL they are
   prepared to handle themselves.  Introduce _bool variants and make
   them call them.

without any "stringifying" at all.

