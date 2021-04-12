Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82701C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 12:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A5461246
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 12:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbhDLMl5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 08:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241214AbhDLMlz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 08:41:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FDCC061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 05:41:37 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e7so14850823edu.10
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 05:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Zg6UDmXoHLtyVnM8ebgcqOpi+F3i2iKBo8EksA8oL3w=;
        b=mqLx3xamr5UdNMgH/6sgBMd6u+Rkc6jlFXrI9Z4z7IrdjMw6sXTcVrcihYTqFiP4fL
         TDhP93c4kpTtYsxw0gxLUgmqVGF7IDu3Ome+ILPw5tjVBjXj7OxldezC31J97OboGXG4
         VmErnL0/ukzvfz7aT/u7cpxW9Dq4X0TkFypLXS68tApTOmtKGYnQHYVMl3zNC0Q/24LX
         bF1OHgHKLtwNu0glSqmLT8WN+xUpXUI6sXR705N1R0D+E8400sMaiptOayNRmwKpNzSE
         zFJw4IF+qHdeik5RFwKhe4VlSh7e0Y5RQlNF3/wX0a+e0ba+7i8bj2KR07g1VielF8xa
         IEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Zg6UDmXoHLtyVnM8ebgcqOpi+F3i2iKBo8EksA8oL3w=;
        b=YUY8ugtmNnzvOveNStk/5S0QEL3cShbDjmEOnQ/OMZBaA5GDGA6UoW/TntLGnA0d6P
         z9WO0s45sDJ++g/cafgXn0W9+YTGj9AOqgKwUscSGGnD6vVg0yTSltHwmgKSd2x+e3Yf
         vRK0UQoZoS1mSvJuSEnmwEQKEP3+Ov5LFpPlCc6+RIayn/WqEQGtISVxdVxzVtlNNxzt
         wRn8WVX8foUGxWTlidGKi5x/qrls8bkWg53ZO+Ojf5h3AHawD+aMPuCbgYmf/NIUe3Ho
         svsas7185/SWUybwMKMKMuEv5F9bMnEtg0H+/dNXZjSbR/Gvp+YbmR4E2UP6WXZmXtH+
         oegw==
X-Gm-Message-State: AOAM530DheIPf1b3K9pzwGFNOT1/am1w21iwP6rKfzWGfEbOnfd8qdjw
        82QExykI8ycpzNg3V5krewc=
X-Google-Smtp-Source: ABdhPJzDw5MUZFjaw4kg5UPRfwnLqIgngqYFJ2g+ke1ULc9eIw3+mQpK8MmBT50i/D4FcGThwdM/lw==
X-Received: by 2002:a05:6402:a4a:: with SMTP id bt10mr28040052edb.39.1618231296509;
        Mon, 12 Apr 2021 05:41:36 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id a22sm6590096edu.14.2021.04.12.05.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 05:41:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] C99: harder dependency on variadic macros
References: <YHOLo36MfuTj6YeD@camp.crustytoothpaste.net>
 <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com>
 <67645f4b-b320-3ed6-bf5d-552bae0c2688@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <67645f4b-b320-3ed6-bf5d-552bae0c2688@gmail.com>
Date:   Mon, 12 Apr 2021 14:41:35 +0200
Message-ID: <87r1jfeku8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 12 2021, Bagas Sanjaya wrote:

> On 12/04/21 18.02, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> But I'm submitting this because of brian m. carlson's note[3] about
>> wanting to submit more general patches for declaring a hard dependency
>> on all of C99.
>
> I think we should bump standard requirement to C99, right?

I think that's worth discussing, but isn't the topic of this more narrow
change.

As noted in
http://lore.kernel.org/git/87wnt8eai1.fsf@evledraar.gmail.com if we
simply do that some of our MSVC CI will start failing.

I don't know what other compilers we need to support that may support
our current subset of C99 features, but not the full set, or if e.g. the
CI can simply have its MSVC compiler version bumped.
