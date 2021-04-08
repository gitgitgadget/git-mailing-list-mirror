Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5ABC43460
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 14:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E79696024A
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 14:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhDHOVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 10:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhDHOVW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 10:21:22 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25049C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 07:21:11 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id o16so2494837ljp.3
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 07:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=BnT/asvZQaUji+52ucDidiQSzIk2ISzrmBxc7j76ko8=;
        b=UQFGvMKlpSVhYFtrRboBWaYLcWf1tG5TqArOADcLVcwfaByfQpNU4HA842xz0kAGty
         wDSEJjnBtTIHF6Cqjb96OWr76qOYFozKSzZZX35KhmDa9YC+fgcYH2lbJdRigHHSoq8a
         quu0o3zrv+42jxrMjYCvjXzIDdpRwe4x76WgVfehqd3N7EsLNSi1FzWGwvmBjPWlhuQ2
         Nd17+BGsJH28FIpiAVgkoA/BB7Y0GzznmGxoQQUw12gGSliLQZNXs1K88jH61OdC2Q3D
         C5luyYnbBxvrKV0iR7f7EvUJWU+3DUINYetUsMeyzrwj7wNA2oVNB3+Dbgp+kYUy/K9q
         Ltuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=BnT/asvZQaUji+52ucDidiQSzIk2ISzrmBxc7j76ko8=;
        b=XoLFOP84ORthwrGKq77b6hwEexOp3OjHWqt9GPf6G+ONkvr0D2APHoLo/qR953sv8i
         XFluDWLzZa1XK0H7MgCzy/nbaGbF5T9ifKgJz4NvJkTyZgjseF6/YlT0CPeESTYwEfVS
         u8+mqo0PvRGSFoy0p6GFKqmzNiAWdBKmFeZ9elvKRvoUmxs2VZ/LZZREmuMOxsjl73nr
         LYzWUl0Ink4MFoyZNAmM6YMbGJxX/tCitG6VYvVpHzQMgMePkW4xqrfkd672u9Hgl3HR
         alRo4NzQhvXVXYfIPKzUCiafTC3owRUZqXdYZaHhmfanI1Z4D7F8ynWQDGBaF7Azka79
         N8HA==
X-Gm-Message-State: AOAM531F2t9OZJFeV4bpzylt+VOQWgbNjdDy6aPx5yJoDQewrA//yCos
        RG1NVKEgclQsG9DIMksf6vuLuSM8/bk=
X-Google-Smtp-Source: ABdhPJwmoqpIzO/xpIPD8raKZy3hteTVPzSeZCnT/ZOayjPoEbtfRKvoRnnY2tLr5tlDdLNAO2ExoQ==
X-Received: by 2002:a05:651c:212a:: with SMTP id a42mr5868152ljq.505.1617891669388;
        Thu, 08 Apr 2021 07:21:09 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o139sm2843691lfa.129.2021.04.08.07.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 07:21:08 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/9] diff-merges: introduce --diff-merges=def
References: <20210407225608.14611-1-sorganov@gmail.com>
        <20210407225608.14611-2-sorganov@gmail.com>
        <f6b25ea6-88b1-c167-7fd4-440be8782fcb@iee.email>
Date:   Thu, 08 Apr 2021 17:21:07 +0300
In-Reply-To: <f6b25ea6-88b1-c167-7fd4-440be8782fcb@iee.email> (Philip Oakley's
        message of "Thu, 8 Apr 2021 12:48:11 +0100")
Message-ID: <87eefkdfho.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Philip Oakley <philipoakley@iee.email> writes:
> Hi,
>
> On 07/04/2021 23:56, Sergey Organov wrote:
>> Introduce the notion of default diff format for merges, and the option
>> "def" to select it. The default is "separate" and can't yet be
> "def" feels a bit too short and sounds similar to "define" - why not
> spell out in full?

Dunno, it just happened. No sound reason. Will change to "default" for
the next re-roll.

>> changed, so effectively "dev" is just a synonym for "separate" for
> did you mean "def"?  i.e. s/dev/def/   (..spell out in full ;-)

Yep, thanks!

-- Sergey
