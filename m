Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4E3C4167B
	for <git@archiver.kernel.org>; Sun, 25 Dec 2022 14:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiLYOqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Dec 2022 09:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLYOqC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2022 09:46:02 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1F7276
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 06:46:01 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id s196so6000257pgs.3
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 06:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaKJ4Xl9irUZ9UbWKOy3XqCdOfoGut0YVMLH1Gva4qY=;
        b=aeX0v/m0ZI/8aaNi7vysIQnuauntc2u43UNjywi+V9Q0AySYhrdyNEPvyeRN2PHbdh
         TnZ3v5nHrfvW4QZYRMlCz5zgAC9/OvFJB4z+gYlOFNu6QCCXxRftoaSoKXmjldqtesQD
         8sl2srq7xyQVr9Xh+gej/BgpEiX1NNXxdyOc6vz2z/nkMka/r6+Mj6GY/h5dUT9kVAOB
         jGlBuBO5DtOrLPR1QpI3kHvo/mNUzdaZ2UxwCEfBqNkusWUmp9WAON2Kb300WVYFgd4o
         XzBpbAyQRFaRjVhvyiNVWruK/nle9pPqX4ZflQueM2O4tE3/1gXuyNRB8mmI/9i4Slv5
         GEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaKJ4Xl9irUZ9UbWKOy3XqCdOfoGut0YVMLH1Gva4qY=;
        b=0MQMplFjz7zs0WiGM1rngcbCXdjx9hmvGj+aeKH//DZmRKYc/AAa5bZyTdnLA2YVXg
         hk6sO3NvyRhM6HVzwWcEXgV/YiJZFZOJbAhfwgiB+DaSmblJPLRkp6/96qsBftpWMuAG
         +lkODv6i0aN0D4GP+fsL8a8RwiGw4VuvzD/AejARJlk5fQEEGpWy05wOzEOwQaxcjoBP
         G/265+apsQXDYLO0SmNoymgEjIey50guuSHvBTAZIV9GVCYfTPCuq1v2IS3T+d77sQwO
         X5R6vx54ovBTkEHHMoTFQmBiiMDGsjc/20DR52ZxCY2yLWbIvFTLBpEBjXT1fmtO+Sme
         ymQA==
X-Gm-Message-State: AFqh2kpD8s+WDKIXmgMWLImB6QuW2k9xIsov7exDC+Umt1aq1p+byl6L
        +Y1g/xmIm1bWkpnisW70oZ8=
X-Google-Smtp-Source: AMrXdXviNg3KSCiBNQXmE+FOFMkHzVWWGgDfhaLZECHTuW+KP/9QrrubNUmiTHXRFQIg0W9gJ54yxQ==
X-Received: by 2002:a05:6a00:f8d:b0:577:501c:c154 with SMTP id ct13-20020a056a000f8d00b00577501cc154mr32130108pfb.6.1671979560760;
        Sun, 25 Dec 2022 06:46:00 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x8-20020aa79ac8000000b005736209dc01sm5395675pfp.47.2022.12.25.06.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 06:45:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: js/drop-mingw-test-cmp, was Re: What's cooking in git.git (Dec
 2022, #03; Sun, 11)
References: <xmqqpmcqv7qh.fsf@gitster.g>
        <o428pr88-sn2p-o715-52ns-1r6750762572@tzk.qr>
        <xmqqa63ss3fl.fsf@gitster.g>
        <c57ecd23-7ca7-2501-983f-6661c7872a01@gmx.de>
        <xmqq7cyksy88.fsf@gitster.g>
        <3c55ac67-5090-b7af-a212-2996bad66fb2@kdbg.org>
        <2090204b-52e9-a22f-f0c9-f812d1231863@web.de>
Date:   Sun, 25 Dec 2022 23:45:59 +0900
Message-ID: <xmqq3593o82g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>> Things did not turn out to be as simple. After ripping out all
>> special-casing of GIT_TEST_CMP from a MinGW build, I notice at least one
>> case that needs special treatment (it's `tar tf` that writes CRLF
>> output).
>
> That would affect t6132 and perhaps t9502, right?
>
> How can I reproduce it?  I get only LF:
> ...
> NATIVE_CRLF seems intended to track the macro of the same name, so it
> probably makes sense to mirror config.mak.uname, but a test helper (or
> "git version --build-options" line) that returns the actual value would
> probably be more robust.

I take the above as an indication that it is not yet clear if we can
use the same GIT_TEST_CMP as others on MinGW.  And ...

>> For the time being, I suggest to take Dscho's patch.
>
> The patch is intended to make comparisons faster.  That works for big
> files, but the test suite compares small ones.   The total duration of
> a test suite run is about one minute longer with the patch than without
> it for me [1].  I retried with 7c2ef319c5 (The first batch for 2.40,
> 2022-12-19), and that's still the case.  Do you get different numbers?

... this indeed is a valid concern.  With or without the patch,
platform tools on MinGW that are muddy about CRLF vs LF are taken
care of with the special cased GIT_TEST_CMP either way.


