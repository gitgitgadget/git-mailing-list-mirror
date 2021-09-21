Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D461C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 12:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07EE56115A
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 12:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhIUMHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 08:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhIUMHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 08:07:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF60BC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 05:05:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id u27so1244766edi.9
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 05:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=v5ANEYFS4r/MI7ZEFvsJymu92nr/JHbmZON2NRNgSCI=;
        b=nCGlRGbx1NQ6aUh4tCCOrR/cesTx/TMWXTn8pD9n1X9JKNZfr4uzKpPaEe1n4KeoH3
         M7Kh6AqIz8dpdkh9DZTSAaHjf8DfalHbuI9yr2UZHJAQd1/D3eXwkvxpgm4Btw8Q3JnI
         0HUbhulDZo0p+MORZ/TF2YzBrBy5/Sk7LVAibaIwmwmtpU7BqUOYu4j67VSdPNBpxjHO
         Qa9so28/u+4WbNrIJyVBVYNn5nP/gcWMFxMtLy0gboKIfsU7R+3bWsnfeQ7ucfXkkCRK
         awSbFz9lXm5D5Ix+JNLMl5ZGfDWbdNKXSz5qgTAy4RlJO2WBbS6tbeXgmX8bZjX/+wGj
         W3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=v5ANEYFS4r/MI7ZEFvsJymu92nr/JHbmZON2NRNgSCI=;
        b=B3ZR6RTTVJtlq93nbVbJv0i2GYQFPnAtQTpEG1EwnNK9c1FFrWA0gji7NZNFiD71aI
         X9o2ppU26azo58V1Xv3q39PxbEaw2Q7JzNdEjoCW4BqoLiMcd4geCItj0LCb1Yqd1XP5
         in5Tbd++iVU+gJv2Au2bHZaX24LuCQjRvYqg4WI/+fcVa+Eq9QBMRDLBJYA3N2Co9Ltw
         QKMazCEwhV1wexrm9bNLu3hOwb1VkoEU66go1Sg/epWTgMSfzrP6r/J3M9XP71cTzOQr
         Q6Cr7YUK+R3wEEngAWGGA+VO6vIFa0lbHss59/Y02iBtvZGYxSMhGkVEliwSij7UGsIR
         nb1g==
X-Gm-Message-State: AOAM531pnfNYvWcTVeJ2qyiQinMJKUrHg0/nRiNhnn36i9ptuCe29f9I
        YFpYed8UdEJO/pOSfDyoSLs=
X-Google-Smtp-Source: ABdhPJz/IM00ULe8vXGceNCpc2qpV9wlPJ828yaV1NmMZTV/6YUyX2rwWWPUklMPjiXYaGX5gLmfgA==
X-Received: by 2002:a17:906:1510:: with SMTP id b16mr35803441ejd.332.1632225905387;
        Tue, 21 Sep 2021 05:05:05 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t19sm7288476ejb.115.2021.09.21.05.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 05:05:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH 4/5] grep: mark "haystack" buffers as const
Date:   Tue, 21 Sep 2021 14:04:12 +0200
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
 <YUlWXRYv1KtZrxZ6@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUlWXRYv1KtZrxZ6@coredump.intra.peff.net>
Message-ID: <87h7ee9lsf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 20 2021, Jeff King wrote:

> -static int patmatch(struct grep_pat *p, char *line, char *eol,
> +static int patmatch(struct grep_pat *p,
> +		    const char *line, const char *eol,
>  		    regmatch_t *match, int eflags)

nit; not worth a re-roll, over-line-wrapping here? You usually stay at
column 79. In this case both line and eol would fit on the patmatch()
lin, which is being changed anyway...
