Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0472ECAAD2
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 05:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiH2Fg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 01:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiH2FgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 01:36:25 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF26A3D58C
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 22:36:24 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 199so7105053pfz.2
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 22:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc;
        bh=OAnMdZ4Txq2pO3Cffj8Xa7q4CpA4MGXolIMfTOLS7CI=;
        b=NtRcbEASxPSyr4Dp3meRzM3HpJMFCb9RrFC1T8s4bK4mCU8+lhUf4nv/8Jb0oPjcI8
         OtENrafKL2naptduflaeL+od8qSJU137ITtlB1fIw6vQCjqezlwMefxrIkuDWwGJXXUh
         wafu3fKpLjc44GcoBcYhHtwNgOzZf0NQ+oXrqZwliK6GwrKTwOtMqW/Kc35npw4yy2zB
         AsQwkfG81GTx4wnIHjXp59cVXb9rFVo+8q7kDjmMuFMuxvKVBvcx8VJIarZTQygjxbco
         mOL9BVkWnsEBkhahcnSWZkbx3b1NmRxSeO8L06J1R3wkL6vSyouZ77wGmJAeJ780NBWz
         7qkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc;
        bh=OAnMdZ4Txq2pO3Cffj8Xa7q4CpA4MGXolIMfTOLS7CI=;
        b=ilpkbPIGxj1mN7e9FcNjpuT1ZZoHVlpR52puC1kN1p65M2T/KYKlyp8A23gZumJEvq
         6coSYrpDawLsH8UY1Hnv9WFWnQRFa+jAoNgxyMZwQ5lfXpV4xiSaF+haajW+FeLHrhJ1
         st3ODZTm1fQeagajeQGKlsT0teb5Mq0oK8KS+Sjred2g6vGip1llRnR7pmkDs8NJwtYd
         2QoZKZZ/8CF9JXhvEeFGSyFNwyrNjCbfIz5XmdtYxf6ISCJvnO2jSb9LHrZdpTLHuo3r
         HHreIhf60F9kwE09wEk1qaeFNNdrJ2Cx8t8hYGNZebHKTs4jLoJV9QOmHE83jJNgJ2U5
         88Eg==
X-Gm-Message-State: ACgBeo1Y6IddfTqQBfnk46vhI53uNBWXlAdLxmIwu5/p1S2mHd6zhjH1
        50a9XjjdOcmVXrpTf9w3jn4=
X-Google-Smtp-Source: AA6agR5zh7Inzq/NRsAJApTLzv+D1qE0XV7O4QlLonCB40vVpRLse6bCHfRdpByan9xN2jdmgLRmMg==
X-Received: by 2002:a63:182:0:b0:42b:291d:59fd with SMTP id 124-20020a630182000000b0042b291d59fdmr13104460pgb.90.1661751384230;
        Sun, 28 Aug 2022 22:36:24 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902e54f00b0016dbaf3ff2esm692060plf.22.2022.08.28.22.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 22:36:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/3] fix failing t4301 test and &&-chain breakage
References: <pull.1339.git.1661663879.gitgitgadget@gmail.com>
        <xmqq35dgt9ph.fsf@gitster.g>
        <CAPig+cSzQAwQLVXbQRLpOJOC=APP-T0DfCzw87xuXKfM8nzSWw@mail.gmail.com>
Date:   Sun, 28 Aug 2022 22:36:23 -0700
Message-ID: <xmqq4jxvsjag.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Aug 28, 2022 at 4:05 PM Junio C Hamano <gitster@pobox.com> wrote:
>> "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> >   t4301: account for behavior differences between sed implementations
>> >   t4031: fix broken &&-chains and add missing loop termination
>> >   t4301: emit blank line in more idiomatic fashion
>>
>> The second one is off by 270.
>
> Shall I re-roll or will you fix it while queuing (assuming you queue it)?

I plan to fix it up when I queue.
