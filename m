Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B572C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 01:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiLBBpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 20:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiLBBpM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 20:45:12 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518B4D3A1A
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 17:45:12 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so6925695pjc.3
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 17:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sflAX6owefvUzFGWUcYcsV8BYcevXt8iLY003P/eb/s=;
        b=cvTJ8uN9ALyrzI44nIuqfezjQM3wXNNlu3kgCYTSXa3U4HsF+Lz+uQ8fjCBqLzlkHN
         j/FSG7jPZfAG1V8Dt5VpSXnKFixPv7jX91/3Z7I+Kynq/95xheuxEUy9NQHb3v2wIGSq
         JYW7hizs/nCNWC0AZmHIPQQFk5SjiltB5nhYzL5FG2TCoG4L4OU8UqlLJ3eKFenaZ/BX
         nMatKG/TQ+yjJHIMegVMubsY2Dy0aP1QcsCJX+ltCqLOEgzKdLYHqN6pDf2Vv6lRoKxg
         tOKQzJ+WXblWbZEWubwW+iWLGc3OZMpP8IQyK+AN14UfT+gUNCo7N0pMi/8pwBFyLovS
         j5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sflAX6owefvUzFGWUcYcsV8BYcevXt8iLY003P/eb/s=;
        b=vIQwwI3ZluhfM0iRklqwXU43kiAhRzQPJyWhr8eo8RQTCbIxN47T1+gzTBAXwFfuX+
         HWXTz/8RIPW5P9OrloC7WRvqkC0whcA5auhx4Mgm9OdfQQdIrMRIusEhOh1QAl5Cf+hZ
         DKj+bIOxZj7ftF7yD0cniBmvZ/4qoqZ84ZrBCElbsRWg3fCg3SrHHUJnkCvtm9I0tKxp
         ZpyoAe+i5vZzXyAcD7b0HyBEd43qqsx6mVqHVIvEmsIROHwiyTuH9weKpSN4G1n+mVzc
         XOg8FktLd0W4STdJSILD4+JJPxaderAt+ZWlLWjJNUPRl28CQA0+E/wqa+IDzZEssotF
         Dc0w==
X-Gm-Message-State: ANoB5pn+uOza7SdfYySBBA5PhPYr0unVUIWIjIRnZaf7EKDxz1Lg021M
        XK3GsiE6pmutqwgobyIq0j8=
X-Google-Smtp-Source: AA0mqf7ssygz9uRNiIoYWoD7rgj3ZwCmzw2iL2pagABRVw/hL24HDRyKyUG76pY8UMQFnj6TZN2iQQ==
X-Received: by 2002:a17:90a:2e16:b0:20a:bb1f:44a with SMTP id q22-20020a17090a2e1600b0020abb1f044amr81577619pjd.160.1669945511670;
        Thu, 01 Dec 2022 17:45:11 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id g200-20020a6252d1000000b00575bf29d1e6sm3863532pfb.46.2022.12.01.17.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 17:45:10 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t4205: don't exit test script on failure
References: <c5b4d091-23c1-5a75-a255-99ec83973d8d@web.de>
        <221202.86edtihgga.gmgdl@evledraar.gmail.com>
        <xmqqr0xir9lk.fsf@gitster.g>
        <221202.86a646hdb6.gmgdl@evledraar.gmail.com>
Date:   Fri, 02 Dec 2022 10:45:10 +0900
In-Reply-To: <221202.86a646hdb6.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 02 Dec 2022 01:07:56 +0100")
Message-ID: <xmqq5yeur32x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I think it's a productive comment on a patch to point out that it's the
> exact same change someone else has submitted independently before.
>
> In my mind that's better than a "LGTM" or "Reviewed-by". Those are both
> versions of "I looked over your work", but if you independently come up
> with the same thing that's usually a stronger sign that the proposed
> solution is a good one.

Not necessarily.

Past effort that did not fare well needs to be re-examined to make
sure it was not picked up because it was crappy, because two people
independently coming up with the same crappiness does not help us
build more confidence.  Instead of forcing other reviewers waste
their time looking at older threads, it would help to explain what
you find good in the patch you are reviewing.

