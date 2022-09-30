Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2220C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiI3SBW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiI3SBU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:01:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86A71A0D32
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:01:18 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id u21so2793264edi.9
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=KmwVD5qNGw79gzZdwFoHXxa5f/9VfSveYWTXOHh1qAU=;
        b=GAjO0XZobWTvJJKqYNeGmVruREuuDxQxnsfuCjmV4UtUkyyM27+97DevpcUYkjSGaZ
         TZj+jvxwrF195VqclRa36CCOTl6PtqckQwOiQwUum0MzOVrov9EhCJaIdIJvP1zQFftN
         /dMdW3j6OjtBAORtdrbTbFBgAMRupvS03L8CAW4NM7yMQFb247B7yaw1QdAsXD5fs+7m
         u7PGHswbDg/wXaDNOY0EkoBDHTFBSqh4MgJb6dYbMR5dROd0fYc93JGflXviXddnj0aC
         vzMZ6/8DBobq7Nc4Dp/QtUO3BBFsP574MwXP/HyRT/s7zdoOGg3O82LwqXyw/CQVH00v
         arLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=KmwVD5qNGw79gzZdwFoHXxa5f/9VfSveYWTXOHh1qAU=;
        b=N9jXlZL2XDselF8f8RipwmQnxzaPiVq6+VjTRa34stwTvUdHoYmgzw3BFsY44xKFyg
         2q0atwupMiEP/QeI5TphlZZqnVKIZ+YFMRKhv46GCGR8gE6OvMBWF+E9wITkmypw6zwt
         c8LfoyXdmPxvBm8UcBKxvXTuEVPImvwJNT2vbTWJYhyEEshMulTXXX4hKBRmzVwX4x2n
         TXt/FugBO7vGJJXThvmFMft9RqxX9w7nxOgXYKozUJ4oz3SrYTlnFnx1Hl59o51m1PGk
         tra5Sh0zpsxCK/pLCqit9Au2Gm1aaJaktS6ZbBwV+WKmdtwXfVj5KuPMKOAXNwOWb/Qg
         vkqg==
X-Gm-Message-State: ACrzQf0bulSWg6V1cbQ/VkMEMxGZuaBfdp6ULLHgFgJk1KzsUSiukPV4
        3eIrYuQgEnSUeJ8SHoVdeAbB5VASpVUQOw==
X-Google-Smtp-Source: AMsMyM7cBnATYeUg9+AMLI7+K0amDd8lOFzfJGLmKrRJGRT/k9gLAZe62nmt3mpOzOS9ADJlZ1PU0A==
X-Received: by 2002:a05:6402:1911:b0:451:6e0b:7eee with SMTP id e17-20020a056402191100b004516e0b7eeemr8889904edz.170.1664560877313;
        Fri, 30 Sep 2022 11:01:17 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c20-20020a1709060fd400b0078167cb4536sm1485279ejk.118.2022.09.30.11.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:01:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oeKK1-001nio-1C;
        Fri, 30 Sep 2022 20:01:13 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] branch: do not fail a no-op --edit-desc
Date:   Fri, 30 Sep 2022 19:58:03 +0200
References: <xmqqczbftina.fsf@gitster.g> <xmqq8rm1mz1d.fsf@gitster.g>
 <220930.86v8p5updv.gmgdl@evledraar.gmail.com> <xmqq7d1klrua.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqq7d1klrua.fsf@gitster.g>
Message-ID: <220930.861qrsvj12.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 30 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> The end result is OK in that the configuration variable does not
>>> exist in the resulting repository, but we should do better, by using
>>> git_config_set_gently() and ignoring only the specific error that is
>>> returned when removing a missing configuration variable.
>> ...
>> I was curious to follow up on your suggestion in your 3rd paragraph, so
>> I tried implementing this in the config API, results below, if you're
>> interested in it assume my SOB.
>
> Did I make any suggestion?  I am assuming that what I left in the
> quote above is the paragraph you are referring to, and that is not a
> suggestion but a description of what the patch did, so I am puzzled.

I think I just misread "by using git_config_set_gently() and ignoring
only the specific error that is returned when removing a missing
configuration variable." as "an alternative of this might do this via
the config API"...

>> But, having done that I discovered that your code here has a bug,
>> admittedly a pretty obscure one. The CONFIG_NOTHING_SET flag on "set"
>> doesn't mean "nothing to set, because it's there already", it means
>> "either <that>, or the key is multi-value and I'm bailing out".
>
> Ah, OK, so in short, _gently() is still unusable to use for that.  I
> guess it means that the approach taken by v1 would be a better
> solution, then.

As you noted it's got a TOCTOU instead, so we might wipe away good
config entirely.

I think between the two I'd go with v2, bugs and all, it's pretty
unlikely that someone has two "description" entries.

