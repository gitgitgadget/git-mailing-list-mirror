Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C24AC43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 23:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348478AbiFCXFg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 19:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiFCXFf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 19:05:35 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8430959BAC
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 16:05:34 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x62so11939861ede.10
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 16:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=W817M16ID/yZfFMUbItD4SWFASeE1BoH5syxvgZ34HE=;
        b=ZoJkSjuGmq/MK0/XChshNzgOVdOI9hzJuHQSRDNXLl/VEc+FRwxV0JIGmOlwctUwDP
         zg3FkKmATveSk/udJHpscV6gByozbpebdMVSFdYv+S0/wNPdFf6ss1yKyhTU2fDqTsPB
         KXXDIlSbcQDZiDxCMKExKeoLx3p9+ceQQnshHp0GsaK+iv5MkmjbFSRDeK0bwC7MiPOg
         rw4+Xdc+5vpG2Oejp6PF6yMF/hBbesDZa82MLYk2xrNbpGZB0cIF3vwhzI/lUPWTl7qv
         HBzlQefXIPua5SFOwE9cI/NQMcytvzkxqZrDypIGcMGsyHP45/Q4z9pJajVuYRgBesYO
         ks9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=W817M16ID/yZfFMUbItD4SWFASeE1BoH5syxvgZ34HE=;
        b=PDXHzFxisfq2Gr905DXvuhjPlr+yvF+yavm49w8+Y4sfe6WabkiUAlxgVoF4/Dagfa
         nKd+xNpvTTBhdgFnYTN9ooOh8TSN/W0vNbJkCK1NQtlNFNVbStQx8HZ4JLmj8zMaB0P6
         8KZrxMF36Ci4O2clpCndVJKgGFYUoDp75gDP8g3XjdsWwKBjMX7YgjxUMzhYVr62ctuu
         REX4EWYgDt9gXHdA167jh1dne6ub/8mU4jJZhu5m24q2MB3llxGW/kioJX+4+Zrgzp3b
         eN5gKz03OaBNk8bOpZAYtqcwZN8+qrjbY+QyUa6odwjH4FK1dT2VbRo4u0YsDhvUn6HN
         tdvQ==
X-Gm-Message-State: AOAM5307rsOakEtNQMyVWZDXVkJSdyySt/pf8oFU13XWKn/IpZi89wyP
        4jD48FfQ510jln+nqdlj8hU=
X-Google-Smtp-Source: ABdhPJzbB9jWDEdyoEZSFd2KFIyWxtT01CfNIt4fc9FNr8GSLdAszisR1WXjq6da/T7BiAnaiTDPmA==
X-Received: by 2002:a05:6402:14c1:b0:42d:d6f1:ac3d with SMTP id f1-20020a05640214c100b0042dd6f1ac3dmr13170073edx.223.1654297532853;
        Fri, 03 Jun 2022 16:05:32 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090685ce00b00706287ba061sm3274112ejy.180.2022.06.03.16.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 16:05:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nxGMF-001uKr-9g;
        Sat, 04 Jun 2022 01:05:31 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>, John Cai <johncai86@gmail.com>
Subject: Re: [RFC PATCH 1/3] test-tool: don't fake up BUG() exits as code 99
Date:   Sat, 04 Jun 2022 01:03:53 +0200
References: <RFC-cover-0.3-00000000000-20220525T234908Z-avarab@gmail.com>
 <RFC-patch-1.3-78431bdc8f0-20220525T234908Z-avarab@gmail.com>
 <xmqqv8theehf.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqv8theehf.fsf@gitster.g>
Message-ID: <220604.867d5xxs90.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 03 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change the BUG() function invoked be "test-tool" to be the "real" one,
>> instead of one that avoids producing core files. In
>> a86303cb5d5 (test-tool: help verifying BUG() code paths, 2018-05-02)
>> to test the (then recently added) BUG() function we faked up the
>> abort() in favor of an exit with code 99.
>>
>> However, in doing so we've been fooling ourselves when it comes to
>> what trace2 events we log. The events tested for in
>> 0a9dde4a04c (usage: trace2 BUG() invocations, 2021-02-05) are not the
>> real ones, but those that we emit only from the "test-tool".
>
> I can fully agree with the above reasoning, i.e. let's test what we
> do use in production, instead of something nobody uses for real, if
> we were adding a test for BUG() in vacuum, but why did we have to
> "fake" it in the first place?

Per a86303cb5d5 (test-tool: help verifying BUG() code paths, 2018-05-02)
I think it was to get rid of coredump clutter outside of trash
directories (which would require some non-standard config), which
doesn't seem worth it.

>> Let's just stop faking it, and call abort(). As a86303cb5d5 notes this
>> will produce core files on some OS's, but as the default behavior for
>> that is to dump them in the current directory they'll be placed in the
>> trash directory that we'll shortly me "rm -rf"-ing.
>
> Are we sure that the reason no longer applies?  How do we know?  We
> would want to explain that to future developers in the proposed log
> message, I would think.

I was trying to get the above across, i.e. that the reasoning still
applies, but that the fakery isn't worth it.

>> +	elif test_match_signal 6 $exit_code && list_contains "$_test_ok" sigab=
rt
>> +	then
>> +		return 0
>>  	elif test_match_signal 13 $exit_code && list_contains "$_test_ok" sigp=
ipe
>
> Not a new problem, but these numberings are probably not very
> portable.  I am willing to take this as-is and let people on
> minority platforms complain ;-)

I'll test it better for portability before a non-RFC.
