Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA6EC433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13EB613A3
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbhKSMPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 07:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhKSMPw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 07:15:52 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB11C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:12:50 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w1so41759159edd.10
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=vxdh9gwHQm9yvEcffP6pGUQ9z0wxCn6/+/1jtOTAVwo=;
        b=T2poN91XUWLj+C9jF1hYUC4MgBduekgF8Lu4WVh10kGN7HE2lLxZl1rUYhwdy6YvOg
         7tjCvdad7TjE9KePPh1PJcBez6YvVkNnRqJ3PFV0Ms1PiBUh3BfadnEw8wX0aJKxAa24
         fJa9xuiilUWIg1pJeMOWuWkbXSddmj8gH5RrlvMbZlLJlwhgEruJWQhDveaowyIauZlE
         kGmJOra62tNQFPpeBcHDNaQWrKfF9+NcPwAboqNlLJclKBEmrCb33BmO1l33PGw4Jj39
         E2+Cq9e1ofzSySUxpQOkT4wSnT5ThlXFhICSj9RJoS2qzY7bpjlFWDiMItXw3azU0zsO
         dG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=vxdh9gwHQm9yvEcffP6pGUQ9z0wxCn6/+/1jtOTAVwo=;
        b=zKoqfwiTAf6KlOQJosd3Sxg0K+t0RClU4PPaKOSC+Qwhld6PPCQbfjsJZpwQ268VcX
         L8tRlb8c3ReGSftSVuAfnOMUU/VUg1HHWLTgghg9zUMOE/AJEtlXyAaf4KXN5L97hU2t
         qQCfnLRc0iWAtzS2QjFwPZb7mvUFN6HfhmcnbH155FtaXQ/HAg0zFUm6JYzkwDzUjn/u
         gNLca5K9jQw0vaTxhgQyErSchj5BB0RpxyqaByMbuAM2gmHbAXpml79fzIB98TRbnT6P
         dCQann+l/9YMRflPU8bRkVbju0MiizYY+CfWJjL0kttWFkkz4nSfprvCXMOX0w1YioQ2
         RWRA==
X-Gm-Message-State: AOAM530NgfRNpWMyYTBiUMVQJOMRRkpimqu2RmUR0FPvKmpYv4OTYNU2
        6C0PU0VcCWW7IPL25fJXX8nv4MuFIcQ=
X-Google-Smtp-Source: ABdhPJyZAYw56xKc5a5HFp8gpcfVnKqDkwiJ5PsDpQReejNe+qoaYrjW2oZ3h0WKl5HlAJ8JJUg6pg==
X-Received: by 2002:a17:907:7294:: with SMTP id dt20mr7279275ejc.321.1637323968629;
        Fri, 19 Nov 2021 04:12:48 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f22sm764682edf.93.2021.11.19.04.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 04:12:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mo2l5-000hHj-MW;
        Fri, 19 Nov 2021 13:12:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Aleen via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v6 2/3] am: support --empty option to handle empty patches
Date:   Fri, 19 Nov 2021 13:10:52 +0100
References: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
 <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
 <96d8573dc808bc32990842675ca32a0d1e8a8cef.1637232636.git.gitgitgadget@gmail.com>
 <877e2b84-347d-8687-d3dc-6c7ce508ac1d@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <877e2b84-347d-8687-d3dc-6c7ce508ac1d@gmail.com>
Message-ID: <211119.861r3c4a4g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 19 2021, Bagas Sanjaya wrote:

> On 18/11/21 17.50, Aleen via GitGitGadget wrote:
>> +test_expect_success 'still output error with --empty when meeting empty files' '
>> +	test_must_fail git am --empty=drop empty.patch 2>actual &&
>> +	echo Patch format detection failed. >expected &&
>> +	test_cmp expected actual
>> +'
>
> Why isn't the echo string quoted?

There's no need to quote the arguments given to echo in cases like
these.

It's not the same, i.e. it'll get N arguments on argv and not on, but it
makes it easier to spot things that do need quoting, rather than
over-quoting everything.
