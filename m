Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E90DC28CAC
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D63A6124C
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348214AbhIUCXB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbhIUBxY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:53:24 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF04CC035493
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 16:32:29 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v22so62717858edd.11
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 16:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5+d1WQZjGjCT3hpauoFXuAv/RObaecRlUcWlDKhoYAk=;
        b=R7zLoI3vOsAbqjCTmvUSpg+tx/AJonWDUB46HH7cmIdQl2PF7Dvj9LNeaItQ+PJvKR
         12IkUa2JFTZ8dxythCwkdwyAW/+cUWQZVNDVsXtL5aYG9lPslZ4uVnNvZ9KTFM6vXx9o
         6DBMvMuNzdTytjyI+d4E+dZJbdrfU4C+/yeGdv+Pe3/1jhZ3HXaKfKHjzprQwA0F2eF1
         fU44EmwzFV2xMo00s4613GpAzglFfElba4EBMw+AzvKGsmFGvcn5F6iDdLQL2AHLIDAf
         lhsY73rNGDBObtOR5NOIJX6xW0Co3DdfoBUuRA3Mc3sIOIsHlapvLfWT8xOBxbpRomKD
         RE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5+d1WQZjGjCT3hpauoFXuAv/RObaecRlUcWlDKhoYAk=;
        b=k8oJZldivTnr3MXgigOXi8OREwsdpJGSW5HBtbMJxS/M/JsJL6F+6Ft7VkS3TDRkLd
         8hs9QBIglhunmm26ZtVyQmrwFUEnTxeV+ogaDIiqKL52EuaIo2HMojV/ZITW1sHnZBJN
         Dz4s2ua2z+c3fEHKL1cygIQBwAzelwszfNUPd8BnKWYgjTw1GU6dVRMBTrkWTZO0rf4e
         mzhb8qeSFnL+yn2NDsQqM2Pp/HWoe3Yqkk3EeoSPqA0oXXfgKzH3q4iX2ee84F9FWzNW
         0+nyHRCK6ozezLNbqA1DjJV02Nk58NuBL46d8HIGjzlDS722zY0Od3jtsfVdL3YutXIc
         PCxQ==
X-Gm-Message-State: AOAM532ggrESKV/fFv/JnWbfmcD2KdiEKmOPTtPYs+qC+LRwOSXMrRPP
        HS0aTUWeLk1dImN/7MMw0EY=
X-Google-Smtp-Source: ABdhPJwIprPhUdMiuTnfoWVQhYFv83lIf++UaqqLMbRbWAa+wyy/vpAZ/EQ8Ri7JU7YFvLIuctLpqw==
X-Received: by 2002:a17:906:c252:: with SMTP id bl18mr30945408ejb.519.1632180748209;
        Mon, 20 Sep 2021 16:32:28 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s3sm6804995ejm.49.2021.09.20.16.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 16:32:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/5] environment.c: remove test-specific
 "ignore_untracked..." variable
Date:   Tue, 21 Sep 2021 01:27:29 +0200
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
 <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
 <patch-v3-2.5-ece340af764-20210919T084703Z-avarab@gmail.com>
 <YUkG1u7utvi6+VgS@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUkG1u7utvi6+VgS@nand.local>
Message-ID: <87tuieakms.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 20 2021, Taylor Blau wrote:

> On Sun, Sep 19, 2021 at 10:47:16AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Instead of the global ignore_untracked_cache_config variable added in
>> dae6c322fa1 (test-dump-untracked-cache: don't modify the untracked
>> cache, 2016-01-27) we can make use of the new facility to set config
>> via environment variables added in d8d77153eaf (config: allow
>> specifying config entries via envvar pairs, 2021-01-12).
>>
>> It's arguably a bit hacky to use setenv() and getenv() to pass
>> messages between the same program, but since the test helpers are not
>> the main intended audience of repo-settings.c I think it's better than
>> hardcoding the test-only special-case in prepare_repo_settings().
>
> Hmm. I tend to agree that using (a wrapper over) setenv() to pass
> messages between the test helper and the rest of Git is a little bit of
> a hack.
>
> Everything you wrote should work based on my understanding of the
> config-over-environment-variable stuff added recently. But I wish that
> it didn't involve losing some grep-ability between the test-helper and
> library code.

Does that grep-ability between the two have any reason to exist? The
only reason we need this special-case in the test helper is because it's
not setting up "normal" config.

It could also be made to do so, that's a bigger behavior change than
this narrow change, but likewise we'd just end up with a "git config
core.untrackedCache keep" in some test *.sh somewhere, and no
grep-ability between the test helper and library code.

But now that we have GIT_CONFIG_COUNT etc. using the environment has
become a perfectly fine way to pass this data along, we could also do
that in the *.sh setup, but this was easier, and also easier to
guarantee correctness with the new x*() wrapper.

IOW just because it's called t/helper/test-dump-untracked-cache.c it
really doesn't have any business reaching into the guts of
repo-settings.c to tweak how we set up core.untrackedCache. The only
reason it did was because the code pre-dated the
GIT_CONFIG_{COUNT,KEY,VALUE} implementation.

> So I wouldn't be sad to see this patch get dropped, and I also wouldn't
> be overly sad to see it get picked up, either. But I don't think it's a
> necessary step, and we may be slightly better without it.
>
> Thanks,
> Taylor

