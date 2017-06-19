Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 920C220401
	for <e@80x24.org>; Mon, 19 Jun 2017 04:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbdFSEqi (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 00:46:38 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34387 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdFSEqg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 00:46:36 -0400
Received: by mail-pg0-f67.google.com with SMTP id j186so14054720pge.1
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 21:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=a2kvDCI4y4swd1FUGuyp3vNbKI2q1zxONE/s+PnPlt4=;
        b=OcTs04fbCGxB3wKOg7EcBREl46uilkzDqcbwVNv1sV89q9TR3tiJ8UwUzcJ9Qw8kkX
         A5WxLUfxYL4kFbR/qXyFr02vz3XuMf6V3avyS/j3i+UjcIn6qLKnRE1AmWluRPq8tgrf
         UKnwfOGI2S1JGLyLE4RXNJSwsGlbawW+gdvCLXrp8zvm9aBIt0GhJp7sIin/Oa7iDIcC
         YwNuCVRbAsdeigMDFoTK8/FWs/HazKepuuHsSiFJIPdcYFKyfwQ5/5aJn6Qu2T/4LDga
         spDdn5oU8FPOmXgiqiX4yGBq0plNL76vOfw0H1IRZPaYqBHnYoWo0i/uPsGS0tWw1/sK
         Utng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=a2kvDCI4y4swd1FUGuyp3vNbKI2q1zxONE/s+PnPlt4=;
        b=SOujRPpCUhW3fDTj9hMjpozNLJ5ZVVqi5FVT4FbgRVu6V6lKhlGWtqa1/EKqHscRME
         XvW3V8VWoulo24mei2wCpfLVHq5e++GWgKqRe9zyEmVkrnh4xlG4pteTImjQAp8UeQWS
         Sm1lAmz/h553Ep52r/2t5C9Xo+zs2I1RaV6XKvgkxLgX/R97WuvsiBSOPMVh5gGbPa2K
         gYcMtNBFR6ryTh1GpEPv7EXHr4gYHjDalRH4coyTdIpwy9TDGdIUk5d/tCA+PTLhi0GO
         IuZTq0iYle4qOEkUX2uKgwHiRGMTZNbBJYNiaay/0TVp5iVn7kta/5g1qcweyx7QVNRW
         L1Bg==
X-Gm-Message-State: AKS2vOwPC7/5q73qHIISOLhjaulZ+S/2drS8XA2X+f+vGB7rqotl47ZR
        OtpPKlLv8j6gOQ==
X-Received: by 10.99.111.79 with SMTP id k76mr23652517pgc.200.1497847596053;
        Sun, 18 Jun 2017 21:46:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec96:eb20:667b:9e2b])
        by smtp.gmail.com with ESMTPSA id x11sm6968886pfa.98.2017.06.18.21.46.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 18 Jun 2017 21:46:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Michael Giuffrida <michaelpg@chromium.org>,
        git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1?= =?utf-8?Q?bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [BUG] add_again() off-by-one error in custom format
References: <xmqqd1a8n7o8.fsf@gitster.mtv.corp.google.com>
        <d229403a-d078-87b4-f3e8-89058fa4b548@web.de>
        <xmqqtw3j68rc.fsf@gitster.mtv.corp.google.com>
        <99d19e5a-9f79-9c1e-3a23-7b2437b04ce9@web.de>
        <xmqqwp8f4mb2.fsf@gitster.mtv.corp.google.com>
        <dae96f72-761c-3ed1-4567-0933acc7618a@web.de>
        <20170615055654.efvsouhr3leszz3i@sigill.intra.peff.net>
        <ec36f9fa-5f3e-b511-3985-3d0301b4847f@web.de>
        <20170615132532.nivmj22dctowxssm@sigill.intra.peff.net>
        <b728352d-7fa5-2adb-af00-5f232b85b2bf@web.de>
        <20170618115017.wyroncb3jka6lrdt@sigill.intra.peff.net>
Date:   Sun, 18 Jun 2017 21:46:34 -0700
In-Reply-To: <20170618115017.wyroncb3jka6lrdt@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 18 Jun 2017 07:50:17 -0400")
Message-ID: <xmqqd1a0vb2t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Jun 18, 2017 at 12:58:49PM +0200, René Scharfe wrote:
>
>> Anyway, here's a patch for stat-based invalidation, on top of the other
>> one.  Array removal is really slow (hope I didn't sneak a bug in there,
>> but my confidence in this code isn't very high).  No locking is done;
>> parallel threads removing and adding entries could make a mess, but
>> that's not an issue for log.
>> 
>> Timings for "time git log --pretty=%h >/dev/null" in my git repository
>> with 5094 loose objects on Debian:
>> 
>>         master       first patch  this patch
>> real    0m1.065s     0m0.581s     0m0.633s
>> user    0m0.648s     0m0.564s     0m0.580s
>> sys     0m0.412s     0m0.016s     0m0.052s
>> 
>> 
>> And on mingw with 227 loose objects:
>> 
>>         master       first patch  this patch
>> real    0m1.756s     0m0.546s     0m1.659s
>> user    0m0.000s     0m0.000s     0m0.000s
>> sys     0m0.000s     0m0.000s     0m0.000s
>> 
>> So at least for Windows it would be really nice if we could avoid
>> calling stat..
>
> Thanks for doing the timings. Given those numbers and the earlier
> discussion, I'd be inclined to skip the mtime check.

Yeah, thanks for these experiments.  With or without invalidation,
we already accept that racing with other processes will make the
result inaccurate, so I am also inclined to say that it would be
best to take the first one alone.

