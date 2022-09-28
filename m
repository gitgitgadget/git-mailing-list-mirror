Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4771C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 17:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbiI1RC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 13:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbiI1RC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 13:02:57 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9020EEBD42
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 10:02:54 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id 13so28469326ejn.3
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 10:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=TZuO9r9JXW99SGhL0xBcAwaZYulE+RPR7CaYo0NdEwk=;
        b=oTs0TO2x8ue+izxHXtnX36M3gtQGKXMgR4OTZqYm6zZ2hAE2zQnXpAgKr4/A617LC4
         YwsK2IvPWfcEeCf52oubqIvNy6Gd08vxBDGG5scvMpqNybRT4NV+blJVppVPCAGUTVhc
         QexPUbPyhXKqx/kG8hUE7On/saSmvQ0ppyNDvj1Cqp/1F4rfYOkRVBUeJHrSrd4HWu0z
         SJLfDQ/sOXaoLu/LV8voKVDvbGprJoNooHC0N0u2dtOtxmamsW+uMmCxwLAL2tHxpJRO
         0ksa0s8CFGb961Gy6zD5tilHIWr4ju13AYCdHnHbLz1F4f4P490LFM0rLrIqS+QNr69I
         Io4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=TZuO9r9JXW99SGhL0xBcAwaZYulE+RPR7CaYo0NdEwk=;
        b=JWGj83zwHxBbysrlVQY/Y83NAFbNvORxQIeqyzh+PRbnHRXcwRep7qOM/GLEINQVU/
         kCMZL9xo+ubSOwSORYrz1sUI+Wauv94w7J5fO/8VYa/2CwHYDNpGgSCFyieQSJ66ujEr
         Q8hZ8sK7e+qbkn+6IWoMhDWegidN/VBA5/2nXjqn1MAKDSgwkXxr9ZJTz5MYYxi9NxiE
         acdaWm6rJsA+hpru69SZMdZNltG4XliRvC/TMn7WIq6mx6PFMZ7oENbuvNtEUeFFwEvT
         nTl0TsrdvX8Wq2S1wWStpbWg+yi8SZ1zP9Qx5IzK/zFGC+FYc24CzuNjQR0RgjW/xkjh
         EVfQ==
X-Gm-Message-State: ACrzQf0HPLfKmCGNXipg9CCNVU6tH2YxM57QEIJ1H8EDWMMjPjYXtvsN
        +ZlRAtJC2TtEY63AENVdM1hKyutuybZY9g==
X-Google-Smtp-Source: AMsMyM52dU1jtvs8DNrTQ1Ei0w032x3UUABQpJDrVOPRl8vcJlBak19oM9xxF0y5jYjJN8RCJ0Pilg==
X-Received: by 2002:a17:906:9bdb:b0:787:afc4:d088 with SMTP id de27-20020a1709069bdb00b00787afc4d088mr390339ejc.611.1664384572711;
        Wed, 28 Sep 2022 10:02:52 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id p22-20020aa7cc96000000b00457b5ba968csm3460605edt.27.2022.09.28.10.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 10:02:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1odaSR-00142l-07;
        Wed, 28 Sep 2022 19:02:51 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Victoria Dye <vdye@github.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: vd/fix-unaligned-read-index-v4, was Re: What's cooking in
 git.git (Sep 2022, #08; Tue, 27)
Date:   Wed, 28 Sep 2022 19:01:59 +0200
References: <xmqqtu4s1q1m.fsf@gitster.g>
 <be8f11f2-c4ad-0542-066b-3bbc99a16dae@github.com>
 <YzPLBN09zzlTdNgc@coredump.intra.peff.net> <xmqqv8p7xxi3.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqv8p7xxi3.fsf@gitster.g>
Message-ID: <220928.86h70rwhxh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 28 2022, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> ... I have no objection to adding more comments, but I am
>> happy enough without them (like Junio, it may be that I'm overly
>> familiar with how I expect our get_be() functions to handle alignment).
>> ...
>> So it's mostly just a minor annoyance for running the tests; we're
>> probably better not to change any code, even trivially, this late in the
>> release cycle.
>
> Yup.  I never planned to merge the topic to 'master'.  The finishing
> touch I expected was to help Phillip and friends with a bit of
> explanation in the log message, and then it would be ready to wait
> in 'next' for the next cycle.

In the interim are we interested in a minimal patch to the specific
scalar test that's finding this under SANITIZE=undefined, as running
un-cleanly will be new in this release?
