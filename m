Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463DAC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C0061875
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhKSMMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 07:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhKSMMe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 07:12:34 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1E5C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:09:32 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id t5so42160598edd.0
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=IBFPjmMCY9MNwd6iozRnIzPMRPVI3sCsG/wAvbd7SFo=;
        b=LansByP6RTKHciEHmgKLbR62gsGxxX02PJ74VAKw759jEHo+RBI+rRHUz+Hc9F8cIb
         gM2EIb/YI+5dTeuB5dPf0V6mnxUcG7XKEAm0ti210mpWGPMcKr64LAvNR5figLfU+Lvn
         vsbrWytWvWCe8FdNsfyHsavnaV5xU3rpXc76ubjmBhdSxLJNNY9d/UanAzgIcGMckhPn
         U8oDmpe4vV59fLtpiIkz+sMCE0DMjYAHsy+q67JmZ+gNIgqNRg126f/HDbsTh1TEngWR
         W52orBARy9oBSG+pCVL3ApyasJHY8RpdlZVjrzsr0M2LpP8vAjcRG44Es8FizbhBkSaj
         S8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=IBFPjmMCY9MNwd6iozRnIzPMRPVI3sCsG/wAvbd7SFo=;
        b=u9bNAwR4BGcrIZUpWF+bukTs5wzDOPWgPte2bT864jeK4iOs5HXjyzQKZYyRuG+vDa
         Z5ENG2W0xnYzGtYnn1cXE+H1mm+M4UEj0F0edDbZ812YDzDccCZh7qFU2RU6o7ZoVR8/
         GDZ3R3P3/8IkNZ5iEMFiQ6VrydZfmKkqtX7/HII8UZEc2LJgjWWlWVbKyz72Spkjq8LS
         hMUptdRxFfs/PW4LVkgYbDHhh5c5qBJd7kdvmq/LhWRo0qAZ+OFieuBkaeN89Rpidh36
         Y45GobykcDQ6VA4GTVmuZEl6ecycLoth01iKsJon0q1N2IyeRC1ifgTh35rm7eUVcWSQ
         erWg==
X-Gm-Message-State: AOAM530PFLh+ZP3v2BiYDHOx3FvPsaHe7q+6ubHt9eypV70pUKaZiKMq
        mQH0q4qApE2TVc/d25gAAB4=
X-Google-Smtp-Source: ABdhPJznALP/udo6jVLKoX6YZBMhY2lzF6UbvT3o3FsSscRTHX2XjrOu7knFY1NsRYnDOiz1iI6nyQ==
X-Received: by 2002:a17:906:79c8:: with SMTP id m8mr6825835ejo.511.1637323771200;
        Fri, 19 Nov 2021 04:09:31 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l18sm1139087ejo.114.2021.11.19.04.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 04:09:30 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mo2ht-000hBH-Vl;
        Fri, 19 Nov 2021 13:09:29 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] test-lib: introduce required prereq for test runs
Date:   Fri, 19 Nov 2021 12:13:43 +0100
References: <20211117090410.8013-1-fs@gigacodes.de>
 <20211117090410.8013-3-fs@gigacodes.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211117090410.8013-3-fs@gigacodes.de>
Message-ID: <211119.865yso4a9y.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 17 2021, Fabian Stelzer wrote:

> In certain environments or for specific test scenarios we might expect a
> specific prerequisite check to succeed. Therefore we would like to
> trigger an error when running our tests if this is not the case.

trigger an error but...

> To remedy this we add the environment variable GIT_TEST_REQUIRE_PREREQ
> which can be set to a comma separated list of prereqs. If one of these
> prereq tests fail then the whole test run will abort.

..here it's "abort the whole test run". If that's what you want use
BAIL_OUT, not error. See: 234383cd401 (test-lib.sh: use "Bail out!"
syntax on bad SANITIZE=leak use, 2021-10-14)

> +GIT_TEST_REQUIRE_PREREQ=<list> allows specifying a comma speparated list of
> +prereqs that are required to succeed. If a prereq in this list is triggered by
> +a test and then fails then the whole test run will abort. This can help to make
> +sure the expected tests are executed and not silently skipped when their
> +dependency breaks or is simply not present in a new environment.
> +
>  Naming Tests
>  ------------

For other things we specify via lists such as GIT_SKIP_TESTS that's
space-separated, but here it's comma-separated, isn't that just a leaky
abstraction in this case? I.e. this is exposing a previously
internal-only implementation detail of the prereq code.

It's less painful in shellscript if anything like this supports
space-separated parameters, as you can interpolate them more easily in
any wrapper script without using "tr" or the like...
