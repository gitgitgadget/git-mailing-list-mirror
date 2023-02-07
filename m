Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F9EC636D3
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 17:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjBGRjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 12:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjBGRjC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 12:39:02 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548C712862
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 09:38:59 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id b5so16417102plz.5
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 09:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5g0+JZpZ2Ec2mwpCbSaLcL2tDIUWLYdF4r6lTWQOv6Q=;
        b=cggsyEhvXzNhDSxlmK8Qc7+0AsoaZa0i59ZhiHY+/TURkxYpKeuFVaqY9PxUOGhmhs
         N/0sVXQOA6KEADar8XLE8Y0sUV6k7q5AxblTb54DibdrjzMMn9R9swcm6hWGWh6I2jac
         UFF4H0CvNE8hAmGJRSPECEmyjZTTVuLOLHiI0zJ69kbxbbO3/o+mqabzEtUZj9dYeEcW
         KhU7yWbdIF1Bkkg2ub3ilmgL1gwwIvYVLTkxuZInFINWqJyjPTBJCPNnbHd3f/nNhIU/
         9qQB99UYGQgQ8TTbxlHIzWr1h/gRzccCMVMsNwo8C4WJQLXf75eygBMo3VBkCX9Q86hU
         hYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5g0+JZpZ2Ec2mwpCbSaLcL2tDIUWLYdF4r6lTWQOv6Q=;
        b=XWISdWESkcC6wV471K1fiNm0kZYe74QPmqVlzTLpH31rlZltrnaAns5GXyV8jLFEME
         gG6PNyM+EldN8zu1LgMX6wiXDDkUY/xZwHUT8qwRrCR5AXCjqfScvOfKv6c9Q0ecgSxi
         tQTg/WLnzTVhhO7tTG720o4JjsapNwjjO3ayFZvHxcD7+Zmtsdi6YpEmPIAglRo3jxAl
         KZ93+F7utlX3uyaV4VmsmeAtky3XLPjOgA+98dt5Taoh4C2POa4MaER6KC8Y2reJF891
         kPTP3XxGFcM3alDHk2nndGrS3E/yQwryd2FipEAUuLXNH3Rpi386LkM2FnyqCb/vAtGI
         roPg==
X-Gm-Message-State: AO0yUKW9QNR5aZQewjIKtTpvrzgQqmP9E7DpXKp6WjOeAEVsXETy/Rm/
        agcvAAtZAZZw9+K/3F2+e7HoOI1+Apo=
X-Google-Smtp-Source: AK7set978r3OTCBY+41l2p9sRPgWxKhoXH5Y/NqXnrRuZNSJdMFNG3NlUPIt3GpcyaTVlBubfsI24w==
X-Received: by 2002:a17:90a:154a:b0:230:c248:e332 with SMTP id y10-20020a17090a154a00b00230c248e332mr5019371pja.19.1675791538663;
        Tue, 07 Feb 2023 09:38:58 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id b25-20020a63a119000000b0045ff216a0casm1859158pgf.3.2023.02.07.09.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 09:38:58 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com
Subject: Re: [PATCH v5 00/10] config API: make "multi" safe, fix segfaults,
 propagate "ret"
References: <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
        <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>
Date:   Tue, 07 Feb 2023 09:38:57 -0800
In-Reply-To: <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 7 Feb
 2023 17:10:40
        +0100")
Message-ID: <xmqqr0v1z87i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> * Added tests for value-less at the end of a list to 2/10, per Junio's
>   request.

I do not "request" anything during my reviews, and I prefer not to
see that verb.  If you find what a reviewer suggests is valuable,
you take it, otherwise you explain why it is better to go without
what was suggested.

>   As the much of the point of this series is to make that API less of
>   a special snowflake a new 6/10 instead finishes up the work of
>   having most of the rest of the API return the un-coerced "ret" from
>   the depths of the config API.
>
>   That patch is quite large by line count, but pretty trivial in
>   complexity. All of those functions are copy/pasted versions of one
>   another with very minor variations.
>
> * Updated the 8/10 commit message, which was stale from a previous
>   version of this topic.

This is now 9/10, thanks to the new 6/10 step being added, and it
reads well.

Thanks, will queue.
