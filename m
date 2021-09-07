Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35B2C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9434060F92
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344236AbhIGMok (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344183AbhIGMoj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:44:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FAFC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 05:43:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g8so12476401edt.7
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 05:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=1GXCSCkSTu0cG9JgICd5hRuo7R8UEMtoqgyqdEg4baM=;
        b=ag1eyeEp16uAchjHX1WqS5Pf9l0TEM5cHPNvKK/5hGzXr9d66I6zS/k9YO4+JL1toY
         16AfQBF00A6E+AvP0WlBFAsXYXyTOBpMJOaZwrPGM2pkGtODFzhB9JXoUu3FCPS5ccQK
         oVcBzKmbXtgDzKK7sEw1zWZzI7t1x7lQPEH8b03t1m0iAI+ZfumAwx/hg0kqGc4LHirK
         JKm0iWCKgADmndBPhtCIibaRBGyIIBl+yjiShRyhQavDsWURPlYEYfcU2iktp4KEpqGe
         n/nUg3y1IpMm0ZccRYc+qEm5ib15AunHeZ24CPE1ZjWB9SGMOsN5D5PUAtCsljas2NPu
         G1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=1GXCSCkSTu0cG9JgICd5hRuo7R8UEMtoqgyqdEg4baM=;
        b=pjxBXpH6ENz7uD6ZsyI70RCzQ17RrBqrCQveJNC9HNoBYaIh8IkK0hciDolMaMg87F
         Ao3S7J/dHKwBzAtky+wEBjLhDOg9saS0of/BWz3Yu/vI//JQZfP0P/7Ru2mH7hbW3aN9
         Q/jfRTR9dEf+NIWa+VggtDRE4tfvqRA13sN0j4jBgt+zB2DlfpadiODlnOFGoJtJKZKG
         edBIX4qL6cY0A7BkSMwSyhvCrhtixFhZWYc5JEcLLn8rq7M4OY7XJdb+WCfmW5VWJcNv
         e9RuuXGAYQhIvoa3Vw/2cDY8/nvAUFVCI+9LlENrEi3qpqvjq7JZq33C5gini01OTdIe
         ggSg==
X-Gm-Message-State: AOAM531tzzUoHQDq7jcsiw211SpH1QOV6VqWCiSrvUaSS5TVdCoX1Hhk
        wx+fCNu+QOAkadBVRln6xGaJOT+TA9S29A==
X-Google-Smtp-Source: ABdhPJxo118wrg3s8t7fwq8JlIIj1Ddlae/8/SfwWbDcMKTVphBdxqjf2Qi8IwuIHOkhIfEvIUrWng==
X-Received: by 2002:aa7:d9c1:: with SMTP id v1mr18411054eds.316.1631018609859;
        Tue, 07 Sep 2021 05:43:29 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y20sm5301658eje.113.2021.09.07.05.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:43:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        emilyshaffer@google.com, gitster@pobox.com, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH 06/13] submodule: move core cmd_update() logic to C
Date:   Tue, 07 Sep 2021 14:40:22 +0200
References: <20210907115932.36068-1-raykar.ath@gmail.com>
 <20210907115932.36068-7-raykar.ath@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210907115932.36068-7-raykar.ath@gmail.com>
Message-ID: <87wnnslfnz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Atharva Raykar wrote:

>  struct init_cb {
>  	const char *prefix;
> +	const char *superprefix;
>  	unsigned int flags;
>  };
> -#define INIT_CB_INIT { NULL, 0 }
> +#define INIT_CB_INIT { NULL, NULL, 0 }

Since you're doing some cleanup while you're at it, just changing this
in some earlier step to:

    define INIT_CB_INIT { 0 }

Is better, i.e. the NULL-ing out is implicit here. I have an unsubmitted
series that does that across the codebase.

> +	.references = STRING_LIST_INIT_DUP, \

We do inits here, and append, but it seems nothing clears this string_list.
