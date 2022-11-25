Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF08C4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 08:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiKYIIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 03:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiKYIIt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 03:08:49 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA961C911
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 00:08:47 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5so2863305wmo.1
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 00:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YRhE69hsnba1NOnVhM4XojqTk1WG+kj6OQViYtaCaic=;
        b=jZeIUPoOu+I9gvFc92KLbR7a/c81WvLxyfjAHAPmHuFZZcQzy5DNjVOrzgC1fULOwQ
         7p+hxBhZB9NIyi+WFepviIZsoAtxBdgMWne7j86lwn8TNBrOhgXiz1WqU+DpsPM3QrAS
         OtNRJx7zL2gLseR+kcJwcw3yFWD0QA+zoIgGZngAPChUtaZCTqtsmO/kzjrbMQGf7vE/
         j0639cIFcWOiQ7VcijMu2KlTo3oZo29OPND7VQGD9IJrQjxR71B04OsOvPne5XRJADXW
         c2PofmyKUNXMpEibbHQQc9MDLWB3sweRaUq2onbMgIbE5Dn+L6ImrVYy2iBaftfwZJTD
         sjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YRhE69hsnba1NOnVhM4XojqTk1WG+kj6OQViYtaCaic=;
        b=CCyIJE0CepWlYg1up7Uo+Ni/W6jvJaGMvVQxkX9k6rh4BaWqIuy4XR/cveqsMlyleh
         MAw3UKOKQ2av+pHFrBXFX+0hkpcSEwEdalMsEzBYYUPgoxRnAiyR1+W72iSshNmWkmNw
         61A3qadrFSWzCL1jb2eMNiE/gcP8SkElFo9GMwyPuce5SSI1w37fwx8+xpH2MJszPShO
         DfdtH/ZO5ACGo/B2aJbU99Ev/FDO7NruZJUJaUGt9BKfciD4mbQf5dAgIoGCpmbktyWW
         yflG0JdndY2E2kqrgaQvZwyChnkHfiMl4HsaMJAlyCAc73yayj4sSXL6wOKGxT7PLEyj
         EXXA==
X-Gm-Message-State: ANoB5pnpWhf/hsgiUSTNHpJN34IwWI5OCZnC9awoOD8d6j/O+K9YkWwz
        aBPMMIhFKWgLJAeqDIUKdKY=
X-Google-Smtp-Source: AA0mqf6oHaYLubw/g+BbrjQqkgax7auiIbkfxFyXqIYemNfxNhHm1Y1vkDbr99EQ7WBU23ONfL778Q==
X-Received: by 2002:a1c:f712:0:b0:3cc:a9be:d9e9 with SMTP id v18-20020a1cf712000000b003cca9bed9e9mr25825873wmh.173.1669363725558;
        Fri, 25 Nov 2022 00:08:45 -0800 (PST)
Received: from gmgdl ([149.38.4.46])
        by smtp.gmail.com with ESMTPSA id dn7-20020a05600c654700b003cf6e1df4a8sm4352938wmb.15.2022.11.25.00.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 00:08:45 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oyTjG-000QLH-2E;
        Fri, 25 Nov 2022 09:06:34 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
        "Randall S . Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH] trace2 tests: guard pthread test with "PTHREAD"
Date:   Fri, 25 Nov 2022 09:05:20 +0100
References: <patch-1.1-f7f21c94a6c-20221124T214813Z-avarab@gmail.com>
 <xmqqilj3edtr.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqilj3edtr.fsf@gitster.g>
Message-ID: <221125.867czjo3ud.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 25 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Since 81071626ba1 (trace2: add global counter mechanism, 2022-10-24)
>> these tests have been failing when git is compiled with NO_PTHREADS=3DY,
>> which is always the case e.g. if 'uname -s' is "NONSTOP_KERNEL".
>>
>> Reported-by: Randall S. Becker <randall.becker@nexbridge.ca>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  t/t0211-trace2-perf.sh | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Makes sense, to sweep the immediate breakage under prerequisite.
>
> But why would a global counter need threading?  I know that the
> counters can optionally report per-thread stats, but that is
> optional and it would still be useful if we can count events in a
> single-threaded program, no?

That was my thought as well, but these tests are specifically testing
how it interacts with threading. The counter mechanism works in general
without threading.

The test descriptions don't help, and should really say that they're to
do with threading in particular, but I wanted to keep this as small as
possible for rc[12] and the final, so I didn't fix that while-at-it.
