Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB56C433EF
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 00:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbhL2AEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 19:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhL2AEm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 19:04:42 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F05BC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 16:04:42 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id w16so79667905edc.11
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 16:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=INmRiyCaAyqK6kXu/yxL7Hj2e8QUz9rgdP2urLkLfxs=;
        b=WSgMuCejAzn9Joxf8G6q6ZZ+yH7A+b7dBkc7DHi/PcYQjA+QtSVHn6OJlr2dXZiTff
         iLhSP10tiA2A9TnXk8AvkqTtT7ngPGxDV9y47GnaXOhmDBk5H70c45R8nNkOc+0kuAGP
         sAsGSz/0QDLiyxptmL5dvvUTIR2Adck2vdVpKi6L+VKFi2Zu6fWyIARzVMz2lI0missV
         R61Lv6jADK1c4Qw6Yf4fhhpyNa9om7ifvxUZeWKXZ8lFfuIiocygcmm0zK7Bm4U9phHD
         WjXFWqp8cD5D9cC1eAJGHsG/3f2tle1mWqkblDAGBqe/mc6FtAeo8NkAd9t+IGnjOr+o
         6XXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=INmRiyCaAyqK6kXu/yxL7Hj2e8QUz9rgdP2urLkLfxs=;
        b=It6lPQ01+JzLKLkrCSvk2CtZB/ZS1BBze9rJgdM2C2U1eYukg9sRxo1lZprfU4uOmD
         9xIBrwVxlcw7CuDGEQ6rfFktPNQRd7Apyjtv36kplN3CfCJmAiOtXjm29nUhzAZsy0hq
         4vv4h9YbaHZobjCM1CbWJzg+vXDDfftIXEZfdqKUCK6oGZGa1tOHZ7pTbw3Sg1d5WYBW
         Eo3ajcWPCznf3xjWFoINJ35cng8RwUMP+B1N1c5LOSQPd0WNPXpGSJdfndlaXLqGjI1a
         2dTaVZG6cTF0i4PuQ0PuKNdzYCZgsmg75OlxpuMH1NUFry57AymiDjfDZkm/2PxrA2It
         zcVg==
X-Gm-Message-State: AOAM532kdhDbkihy3GVSa7Kzd7zX9HH6O0k80Z77qSaQQ2fx6yzsoUNh
        J9yL46hY2PshxN8QG0d7Z9Y=
X-Google-Smtp-Source: ABdhPJyM+IaxG21SwCMhpyg/Ip2btn9emRQTdFitZOh22JyF4e5TOPFn/L4I9d7tTmxFW8l/ylBuxw==
X-Received: by 2002:a05:6402:1a4f:: with SMTP id bf15mr23407745edb.260.1640736280909;
        Tue, 28 Dec 2021 16:04:40 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id 4sm6356621ejc.168.2021.12.28.16.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 16:04:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n2MSN-000GGg-5G;
        Wed, 29 Dec 2021 01:04:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 5/7] help: error if [-a|-g|-c] and [-i|-m|-w] are combined
Date:   Wed, 29 Dec 2021 01:04:35 +0100
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
 <patch-5.7-12ff152bd57-20211228T153456Z-avarab@gmail.com>
 <CAPig+cSVLPiGUAiK8tt1dp3BVLAwXCAeMvM9LenBUY4s_xBQ+A@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAPig+cSVLPiGUAiK8tt1dp3BVLAwXCAeMvM9LenBUY4s_xBQ+A@mail.gmail.com>
Message-ID: <211229.86v8z8gtt4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 28 2021, Eric Sunshine wrote:

> On Tue, Dec 28, 2021 at 10:36 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> Add more sanity checking to "git help" usage by erroring out if these
>> man viewer options are combined with incompatible command-modes that
>> will never use these documentation viewers.
>>
>> This continues the work started in d35d03cf93e (help: simplify by
>> moving to OPT_CMDMODE(), 2021-09-22) of adding more sanity checking to
>> "git help". Doing this allows us to clarify the "SYNOPSIS" in the
>> documentation, and the "git help -h" output.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>> diff --git a/builtin/help.c b/builtin/help.c
>> @@ -581,6 +581,13 @@ static void no_extra_argc(int argc)
>> +static void no_format(void)
>> +{
>> +       if (help_format !=3D HELP_FORMAT_NONE)
>> +               usage_msg_opt(_("[-a|--all] cannot be combined with [[-i=
|--info] [-m|--man] [-w|--web]]"),
>> +                             builtin_help_usage, builtin_help_options);
>> +}
>
> Nit: The square brackets in the message may be unnecessarily
> confusing. (Indeed, what exactly do they mean in this context?) Also,
> the short options may not add much value: the user who typed `-w`
> knows presumably that it is shorthand for `--web`. So, one
> simplification would be:
>
>     '--all' cannot be combined with '--info', '--man', or '--web'

Thanks, will change it.
