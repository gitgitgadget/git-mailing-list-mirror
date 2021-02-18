Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B055CC433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F0264E6F
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhBRABH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 19:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBRABA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 19:01:00 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691C9C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 16:00:20 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g3so16970906edb.11
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 16:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=kfLQh5XDY70HsbQN+fljO33fm/J4ZxLt48GTJ1QWG+c=;
        b=pAegls9gFogjMzVfvzZMAMq+Oh6SzK3Q11gFm8cUrWuKi+7heiT/0Mt3gX6lXdh7hH
         KuDvXtvrCrNP4lP0MgBc0WIoKElioM4SYMlySSQszlh7RiQOEMJxTK3xYVo3ML7kj9K4
         yezyslm3YyyfQSBo9g/uGiUVZF9YSxCSpJT9gqN8D49vdS69xd/iBFEOXt7A6HZ9UKus
         Fhsl8TpHax76OxUsgFrKya0aV/PG9g4kJRaBK84PxRvto4nqvyRLcmR+sAC59dF18EZj
         bCYgoxF9OZGilre8hHYXNWm9JiTwygn7nsqSafC3TAs+S/QJ05nvwPPOm8+V1ZrY9tot
         bAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=kfLQh5XDY70HsbQN+fljO33fm/J4ZxLt48GTJ1QWG+c=;
        b=hURRDcvjtskGRpRv5Uzgk6OLGWVeIfOyInw02e26ROUkaTnR514G8qkmlfL5/NBmH6
         nYFkyTFZK1QxXvLpHVCnLz67FxcwjhejIYFsCV6Wozw3smq0uF4yS8LKhRxbaX9fN8lR
         zfFoMpnC8xtK2/Z6OtgiCcV9TkQONyUwZBcQvrirKlbGO0vRXyt+oafwkGuneLbtO1yI
         M8i6LSGImXVsgT4nKzIpcMEaKeY8cvliwz6v9wJuPYeN+dgVa8g7fEgVsyuabYH+EwTD
         u0vb9x4jbnupM3uJ/2u0FvcAYE9e/oWxdfy+1lLz0vlWbaxOde3LCDqKKPgyD4wjL+wj
         l90w==
X-Gm-Message-State: AOAM5315F2iUq+kDsUViGaIHO1Hl+y+inu8JXq33f8MyVuf4WKXZbNFt
        1WyDQ4l/+LLFZ3IRqNF11SY=
X-Google-Smtp-Source: ABdhPJwYu8UOIXs51MlWwLQBlE2JSuWGPhp77zLRqBsTwVL5+2Jj399N9pnYrDI+g9EeB/ytrL2kcw==
X-Received: by 2002:a05:6402:5206:: with SMTP id s6mr1309473edd.92.1613606418988;
        Wed, 17 Feb 2021 16:00:18 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id kv24sm1601664ejc.117.2021.02.17.16.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 16:00:18 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/14] fsck: API improvements
References: <87blcja2ha.fsf@evledraar.gmail.com>
 <20210217194246.25342-1-avarab@gmail.com> <xmqqo8gijtl7.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqo8gijtl7.fsf@gitster.g>
Date:   Thu, 18 Feb 2021 01:00:18 +0100
Message-ID: <87zh028ctp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 17 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Jonathan Tan pointed out that the fsck error_func doesn't pass you the
>> ID of the fsck failure in [1]. This series improves the API so it
>> does, and moves the gitmodules_{found,done} variables into the
>> fsck_options struct.
>>
>> The result is that instead of the "print_dangling_gitmodules" member
>> in that series we can just implement that with the diff at the end of
>> this cover letter (goes on top of a merge of this series & "seen"),
>> and without any changes to fsck_finish().
>>
>> This conflicts with other in-flight fsck changes but the conflict is
>> rather trivial. Jeff King has another concurrent series to add a
>> couple of new fsck checks, those need to be moved to fsck.h, and
>> there's another trivial conflict in 2 hunks due to the
>> gitmodules_{found,done} move.
>>
>> 1. https://lore.kernel.org/git/87blcja2ha.fsf@evledraar.gmail.com/
>
> Let's get this reviewed now, but with expectation that it will be
> rebased after the dust settles.

Makes sense. Pending a review of this would you be interested in queuing
a v2 of this that doesn't conflict with in-flight topics?

Patches 01..09 & 13/14 can live conflict-free with what's in "seen" now
(I'd have made the 13th the 10th in v1 if I'd noticed). Then I could
re-roll the remainder of this once the other topics land.
