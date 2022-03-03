Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C1CC433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 09:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiCCJ57 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 04:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiCCJ56 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 04:57:58 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5D115F615
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 01:57:13 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id o1so4827158edc.3
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 01:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qxA9AaNw4zelfBnw4/qv4tl3+SLbrEUNnGb06PcQT6A=;
        b=BLyMEhmI8EMwdUSsCk2aMdmPlA5ewASJgu9AsdKTboPxzcMem6rqcj5TJ2Bw1Qu8pt
         eJRseuuaMzEehseonryAAculSDd9JocvGLSQRkh7kFJoPXJrBsYezXSiMfgEUhWaf8s7
         F32xdtwhui/r4QxcYVFagyZkqqGBgiEtje8dDms3nIzpE0D2eL7TtP3C5LV0xTrocYRq
         jk5K4q/cxpj9tB7j8WtZsjWWVeR+S6QMfOKs8m0KcsEr+f397F6L3feBRBy5Rt2Jxz0q
         G/epKQhKes6PFxEZv1uu7S2GZjr/dUzRQ549bAP2ZCEO2uGLNpfgFpHTOk3XHpffQPQU
         L/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qxA9AaNw4zelfBnw4/qv4tl3+SLbrEUNnGb06PcQT6A=;
        b=LvjEFl4s3w00nITUAyvm4lQc/XLyR/hjjv5giRGn8mCcGjS+OwdjrDtwwyvdYwWd1j
         LgBpHE8ytsRqW7OqWfSnbSgttU1CmxNXrEVM9O0bOLBcqQ9Fqe4clWGKGz42xbAkluGN
         1n7l3o4lMh4mGD7Qb5TLWZg0okz9Ij948xYRlFjcxYTOevzNhKntU/CE6q1L42KbyJ8E
         7xX3gUz0VYZ7MeuopVbuAFovrl5V5UDjFtUpHNfC5zBo2vAAtKBA8JmubnmBmitVAJoL
         qP9YCeB3GloIfUVGl8qMydB8+i8rC/tb3ZhYeDauJZO+Mg55B7ZUb159YIJxo1D5X/U3
         liEQ==
X-Gm-Message-State: AOAM532/Sm3Y/46qPsivdE30YajddRxhYQE40QwrXn9pIp9uh9wDNm+0
        fq4LT5LuxCxJ0l0mz8UYs6sk+RqOTINVKw==
X-Google-Smtp-Source: ABdhPJxK+qMA/wXQaqf7Jp8BiYkji2pTM5ZLpPfuPpiX1JIti8iKHMXl+HsVYDQyBrN5NLr3nff2gA==
X-Received: by 2002:a05:6402:17c4:b0:415:ed36:52cb with SMTP id s4-20020a05640217c400b00415ed3652cbmr221898edy.379.1646301431724;
        Thu, 03 Mar 2022 01:57:11 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h24-20020a170906261800b006da94c9ccc9sm308199ejc.129.2022.03.03.01.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 01:57:11 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPiCs-000OoZ-6E;
        Thu, 03 Mar 2022 10:57:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Shubham Mishra <shivam828787@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 00/15] tests: don't ignore "git" exit codes
Date:   Thu, 03 Mar 2022 10:53:20 +0100
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
 <CAC316V7jcHTVs7f_p5zMRqpvTZBPCa6X7=L_MUEy0Zx0PJZZ_A@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAC316V7jcHTVs7f_p5zMRqpvTZBPCa6X7=L_MUEy0Zx0PJZZ_A@mail.gmail.com>
Message-ID: <220303.86wnhb5pft.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 03 2022, Shubham Mishra wrote:

> Thanks =C3=86var for CCing me. Your patch is insightful for me.
>
>> This series is not made by string-replacing things in our test suite,
>> if it was it would be much larger. These are all tests I've seen real
>> hide real failures under SANITIZE=3Dleak, either on current "master", or
>> in combination with various local leak fixes I've got unsubmitted.
>
> Can you please tell me what "SANITIZE=3Dleak" do?
>
> Thanks,
> Shubham

SANITIZE=3Daddress and SANITIZE=3Dleak are the flags we use to turn on the
AddressSanitizer
(https://github.com/google/sanitizers/wiki/AddressSanitizer) and
LeakSanitizer
(https://github.com/google/sanitizers/wiki/AddressSanitizerLeakSanitizer).

As the latter URL shows it's a way to instrument a program to die on
exit if unreferenced malloc'd memory wasn't free'd.
