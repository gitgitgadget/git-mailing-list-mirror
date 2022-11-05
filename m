Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E714C4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 12:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiKEMqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 08:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKEMqW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 08:46:22 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C6523BF1
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 05:46:21 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id f5so19587839ejc.5
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 05:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fN2+nHhpalyq8B0tTv4m5sEzs5mE5y/PV0V/AnSEruw=;
        b=Ioi++eZYtBBKenAOiEioWBnJ1dy72o5lc04ZtVZVVN2qbPLgPuzpYAjPNKvhAgZ8my
         RcFEPWtmCcXSKRH+JcWLCMlSPUWj68Z/+kqW/h3w80d0r35uit1V13aT31kc9K/3m7kJ
         AihohiK8yH6af76GlR+3BOQ4pyL1+Noz83LvvNHyCfJxspOoFRM2Y8MCeLUNVCbOAjZo
         symg0/v7yhohkni6TT0QDXIrPlEyBJs3wCH4eJmJed4FJuTJqNy/EtY+uCAZh4sZSdbs
         W+WhnqWy4CAaPh54stZb47pmgW5/OVEQkYmnmNXmbhBLUwXB3QihdT0jSwi+46ozv6E2
         s0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fN2+nHhpalyq8B0tTv4m5sEzs5mE5y/PV0V/AnSEruw=;
        b=jYC/MFpMpAOTc8Xy7NAvdPHx5P2yyLJqFv6dnGp62omMMtBRl4N2an7VJD/bRvVKSt
         8yz7qoLA8lTi6RKzF3A3mj84HsxvJ4g8dJpSMoJvGux8dAo7L7UXRl0i080xKZ2gaec8
         FrJSq3PIbq8Vx9Tn1+YBLS3dt7hA81lETBkH2WHA2OX53rg2BhsxJxX2LjEgLSB22O4f
         6MO0iVZaR9ISsywQjXudZcPJXhBabHaesGiI4S6VZQPtGf0X7uzwYyXg38jeTO5zlxG0
         NpOZiPYVDO2Wns3XTaxvoZcxv5BxDJJE8DppIaQ6BZrye9/PnwdNutmHntEAqlJx1l5b
         +VTw==
X-Gm-Message-State: ACrzQf2Ou3LPqIygqwQuqcsJ6Bq/3PGhl96NGl7+FFLHwaO+kdtBSkpU
        2dJ7wOrw4BaEuq6Duj/4ys3OE8mtUsczAA==
X-Google-Smtp-Source: AMsMyM6MUw6TwkMToqKvCkJbMJK0x2FRAY0zd1xxfFs8XV2SMcJfndecf9Nrjo4cMgGeVbE4RyQc+Q==
X-Received: by 2002:a17:907:8a24:b0:795:bb7d:643b with SMTP id sc36-20020a1709078a2400b00795bb7d643bmr39880082ejc.115.1667652379679;
        Sat, 05 Nov 2022 05:46:19 -0700 (PDT)
Received: from gmgdl (31-151-3-230.dynamic.upc.nl. [31.151.3.230])
        by smtp.gmail.com with ESMTPSA id v2-20020a170906292200b00779cde476e4sm879851ejd.62.2022.11.05.05.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 05:46:19 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1orIZ0-000MdO-0x;
        Sat, 05 Nov 2022 13:46:18 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 10/17] sequencer.c: fix "opts->strategy" leak in
 read_strategy_opts()
Date:   Sat, 05 Nov 2022 13:43:34 +0100
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
 <patch-10.17-9c70bfa334e-20221103T164632Z-avarab@gmail.com>
 <b9f08244-36bc-b74f-ac1a-b665423bc2e7@dunelm.org.uk>
 <Y2WHxveDDH5YLpZq@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2WHxveDDH5YLpZq@nand.local>
Message-ID: <221105.86a655y3fp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 04 2022, Taylor Blau wrote:

> On Fri, Nov 04, 2022 at 02:50:02PM +0000, Phillip Wood wrote:
>> > Along with the preceding commit this change various
>> > rebase-related tests pass.
>>
>> Really? at a glance the previous patch looks unrelated and there are no
>> tests marked as passing in this one.
>
> Yeah, I wondered the same thing. What are we missing here?

I see I was using "tests that pass" in an arguably ambiguous way.

This does make more tests pass, but not in such a way that the entire
set of tests in any given file in t/t[0-9]*.sh now pases in its
entirety, which is the point at which we can add:

	TEST_PASSES_SANITIZE_LEAK=true


