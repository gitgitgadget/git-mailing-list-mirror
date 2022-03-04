Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4954EC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 07:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiCDHDA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 02:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiCDHDA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 02:03:00 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537D318E3DF
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 23:02:12 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id qa43so15445797ejc.12
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 23:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Gyj08L9b2lDycryxtuCW2mltAxHG6R3PK/eAm8DUJg8=;
        b=owg5J7Cnxw/laS3OxrWJJRo5p9Rf8tEdhSosARJ04sQTne4IPNBIPe5KR4ksiMZ8Hg
         d2GHohKqzSmJw0HyH1Stj9UIRCNqZ6JyiBZHNlbmQbeEJ2DF+ZZCPsNl56rtlEODdYHb
         sog4A4UFYIV+mMn4uAA+9f4g5wXFrAuTFbt1UPc/NUC2+hoxIDuDcHQNwZS+o4nyT/g8
         vGd5o3cKDNJ1wL2Cj9RyVba/yt6H+dpnEDr2h1tlQtEKBsIZRqAupyV9bvhtQsUKV5ks
         sGepZwfMK9Gxxm4wNJzVhtfBhIJsnEI3sVA8K0oDcqcHi8RTvrP22N6gzgUpYUHBu61B
         VOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Gyj08L9b2lDycryxtuCW2mltAxHG6R3PK/eAm8DUJg8=;
        b=TCQMqwuzbgKRkePlNY12VhGu84RhkmmSjegmG6zfz+IsSWlShjXq2v5U/W6tOyzGZN
         rKCnSSMUQXqP9f+TYY0aNa44jN+ASbNhSnqmAuxfw9bEzK8TaI866ZI8FbiSm1kIIOFW
         nymWaZBCYI5p/sG5j5g6SbfbtlKH7WFh00sSBzwBFPMjZnOs2scwfqTfkDSddj68nY8i
         4l/j7BBob1av7166PMrUMs49tQgyWXvIfsTk1Wpv+Q5rRlIjyH64x9KSUnGAoMgsjxvJ
         mkiIdw4+UAWehEHie8binlptSMaoywepH11JWA3i1SenDkr6XADoCBXjhmDX1I63ok20
         S+zg==
X-Gm-Message-State: AOAM532hsWcm0rCvZIC+oeF3/Lo12AHwMbup4RtoSl/zgu9q5KknjjZz
        a5+mR8yKxVY1xtOHb6F45ctNbfWwimg/8w==
X-Google-Smtp-Source: ABdhPJzC4N30kOO+LQNKgWqgwYqWbAjFSSBvhGQl1Iz4C+D8s1gaVCWpjNN/YzlJexocZNoPetZnzA==
X-Received: by 2002:a17:906:a0ce:b0:6d1:cb30:3b3b with SMTP id bh14-20020a170906a0ce00b006d1cb303b3bmr30235939ejb.582.1646377330652;
        Thu, 03 Mar 2022 23:02:10 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q9-20020a17090609a900b006cd30a3c4f0sm1471265eje.147.2022.03.03.23.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 23:02:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nQ1x3-0006Xl-Do;
        Fri, 04 Mar 2022 08:02:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Silly 'git am' UI issue
Date:   Fri, 04 Mar 2022 08:01:15 +0100
References: <CAHk-=wi2HkQ648sYe3BusCEh5tBYjJbQ9c5T-DrykfEdgRbi=g@mail.gmail.com>
 <xmqqlexq8zqo.fsf@gitster.g>
 <CAHk-=wjQP8PwYZMYUhKu3s9wMhE2yDqdAO_OKagqXuvPrHRyAQ@mail.gmail.com>
 <xmqq1qzi4bpk.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq1qzi4bpk.fsf@gitster.g>
Message-ID: <220304.86v8wufbf2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 03 2022, Junio C Hamano wrote:

>> +static int parse_opt_whitespace(const struct option *opt, const char *arg, int unset)
>> +{
>> +	struct apply_state dummy = { };
>
> It is rare to see a completely empty initializer in this codebase, I
> think.

I don't think we use them at all. It's GNU GCC-specific syntax that
translates to the equivalent of { 0 }, which we can use instead.
