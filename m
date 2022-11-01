Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5FDC4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 21:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiKAVAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 17:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiKAVAG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 17:00:06 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835DB1AF3B
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 14:00:03 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id 7so8459317ilg.11
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 14:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UvSRLOMl5bDU0FC7xVTr7DVCkuhI1avQII0g1/uaMFM=;
        b=mXu+5OdbOsEETd2X2B8WDZRKZ3XrVX9gHBhRRjFU1l8ZbLj4cXLuf1t1FwE74uAqO7
         g8GeGfT6adE1mvlDyP6yuiWZuWzFqLUvZZLVGF0uePWhKmI3z6m8HxF3dvoyB/3XX2ZP
         ekIdgSpiYAa64mWhAcJl5OzVzq5qExhyUbdpk3DnSzW73teGbDN9bVYp/lvWVWwo38X6
         98ROaRCVACF7MW8Ed90EvrI01rmyZxSnTLDV1w/Zqpn7duk4wQoA1Blpcz9c0PEW1ZP+
         +BLqLnX/WPNZLwMMnFcS2roG6DBEbGDskHkNw5ielxX83UbGzHqB5I3gVpOt+3HT4Op1
         g1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvSRLOMl5bDU0FC7xVTr7DVCkuhI1avQII0g1/uaMFM=;
        b=Tj5p0YvrIjOG2R7MA+Io+i9ObYCiR0OWFQ2Id8f+c7buwf6E0mhXsyKkRjkC2Fhla7
         ZfHgOkGHD7b41gjHyA5Iv+aDE67lZ6tFqS3ba2vRaZTfv+74IEM57EeSnRSIhSPhaQZI
         uJ8EXiZ7DHrghEHbIKmjDjHQ9pyL07cqEBLjnIRwrciBBudwtNFDOkta/WhfbhmngYxp
         uhQhSoNuqkH7uce4C+jErrg+NLJRNvUJnpw1rJmQkkQMd1DX6vt3ulfHuQsfx6hbEYfn
         CsAjnvefDaL6HzrBIWtOq3aW7Z45tLMGaLhMBHF6Q3mhnGEXtAt/u4B8OZB4NQbwzE8Z
         Pomg==
X-Gm-Message-State: ACrzQf17lpvQQhX2LKd1zwWQLYPLFIo0r96GLIQ+DwKXTx+yI8hslaue
        UB6Oin50geN+7v8mwEH/97Hfqg==
X-Google-Smtp-Source: AMsMyM7WVwQCOp0DyWhDBbmW7FMy2I8YkUOocnOE517szfXQbL/rs4SYYJx6ltZn4/U2iJo0BdbAyQ==
X-Received: by 2002:a92:607:0:b0:2ff:f117:25e with SMTP id x7-20020a920607000000b002fff117025emr11472156ilg.55.1667336402844;
        Tue, 01 Nov 2022 14:00:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c65-20020a029647000000b00373157978d2sm4224281jai.127.2022.11.01.14.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 14:00:02 -0700 (PDT)
Date:   Tue, 1 Nov 2022 17:00:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC PATCH] fetch: stop emitting duplicate
 transfer.credentialsInUrl=warn warnings
Message-ID: <Y2GI0R6pJmdZNgHn@nand.local>
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com>
 <Y2CFRJLFRXvGwFBC@coredump.intra.peff.net>
 <Y2Doe0ZGb3Zmmmen@coredump.intra.peff.net>
 <221101.86o7tq4vsn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221101.86o7tq4vsn.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 02:07:39PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > You can also put it lower in the function, when we actually warn, which
> > saves adding to the environment when there is nothing to warn about
> > (though this way, we avoid doing the redundant work).
> >
> > Compared to munging the config, this seems shorter and simpler, and
> > there's no chance of us ever getting confused between the fake
> > "suppress" value and something the user actually asked for.
>
> Sure, we can do it with an environment variable, in the end that's all
> git_config_push_parameter() is doing too. It's just setting things in
> "GIT_CONFIG_PARAMETERS".
>
> And yes, we can set this in the low-level function instead of with
> git_config_push_parameter() in builtin/*.c as I did. I was aiming for
> something demonstrably narrow, at the cost of some verbosity.
>
> But I don't get how other things being equal you think sticking this in
> "GIT_CHECKED_CREDENTIALS_IN_URL" instead of "GIT_CONFIG_PARAMETERS"
> helps.

I vaguely prefer calling this GIT_CHECKED_CREDENTIALS_IN_URL instead of
stuffing it in the configuration. All other things *aren't* equal here,
since we're not lying to sub-processes about configuration values set
by the user.

Instead, we're saying: "regardless of what value the user assigned
transfer.credentialsInUrl, we can avoid looking at it because we have
already checked for the presence of credentials in the URL".

Thanks,
Taylor
