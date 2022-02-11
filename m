Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CA0C433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 21:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353659AbiBKVbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 16:31:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353650AbiBKVbM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 16:31:12 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E944EC57
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 13:31:06 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id co28so18404832edb.1
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 13:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=LdVV64/qrmtpyHUeE1ho3jXTe3AK4Iv0DDXAAS+ZzOU=;
        b=MmtzCNTjCtUYqB5VhjJOufJVhJz7XiLSNVaIS3tdpN1JyXDR8z8124KPwCeUGW4ue0
         6Vrre21Nw25iXnKinjD+8LThPE+DQOUlmOaVVyrkXjGVbiUH6og5N/Vjd1GXYYVLf4wx
         L6ZB8+wEkRk4/c18sl6fPs0Y3UCGVR1Te+I1svWkHl3tMIpn4V9GrOzVUy8H7sPAtmn9
         kXbZzhyZFj2S+dzvyG45XNpiQBhcZlYfa8FBvaGcdYdlqFTMyHBKPJM2pAgLgKWCBR0B
         mfpVAJYUIFBtdLkFxVmBnFlfayoEs0WXHMcp2YAHzlyvrDPTucL4+UHYAif+lAy2Vewc
         3/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=LdVV64/qrmtpyHUeE1ho3jXTe3AK4Iv0DDXAAS+ZzOU=;
        b=aU7PJED3s+gu6yTNpsivyjInCqCtqbdhphFFAkkNqEd2EPalhRCG7yv37tJvhhO0JJ
         mQYb/Kf7gp6duAiniR06fnPgLyH7kQH7op0CXInp8riT6OmoOhvNBa2rldQWuqFENLUW
         NinPlpG2pPA8YjuKvqqoLL6gwvKS2t8nFQFkaKl7rBRS4BwaBw59cxhuR8vzw9xAr8sP
         IEbxwMTQfgImlUGtpu+aB6iJ9m2Cu4bOmVltdtnZmWHVjb5yBWSdX85eYB1rwcIxx8mI
         Yq+hijDfVyOcAu6yWAu48GbXU+h7olBxxwJ4y1ee8sKYtaGgZwGDlN9vCgamJXlj7EVP
         qUxg==
X-Gm-Message-State: AOAM5300CAtMNU/wAjOpa3iFE56P3NgCKspTnhsBgz6PkG5WczxzNQJx
        KMOXqL+8aYC5Q6mGyY/wtFU=
X-Google-Smtp-Source: ABdhPJyqSIuJSGl4SSteqOYHWaJCueldbo2kV3Uu+T27YlJuEbGbCjMpSt6K/rSn05DuUq+uQ1136A==
X-Received: by 2002:a05:6402:5216:: with SMTP id s22mr3904038edd.359.1644615064732;
        Fri, 11 Feb 2022 13:31:04 -0800 (PST)
Received: from [10.37.129.2] (guest-pat-13-128.njit.edu. [128.235.13.128])
        by smtp.gmail.com with ESMTPSA id m23sm10078221eda.66.2022.02.11.13.31.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Feb 2022 13:31:04 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 3/3] cat-file: add --batch-command mode
Date:   Fri, 11 Feb 2022 16:30:58 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <06C925DC-DAAC-4BA6-8CFA-E4ACF2039BB6@gmail.com>
In-Reply-To: <xmqqpmnt9ngx.fsf@gitster.g>
References: <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
 <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com>
 <6c51324a6623b62c385ec707a773c21375596584.1644465706.git.gitgitgadget@gmail.com>
 <0b40d1bb-4db1-002f-d665-f51db6c2882c@gmail.com> <xmqq5ypmwt1m.fsf@gitster.g>
 <9B08BF05-1C35-4C4F-9C76-CC34A8E7D0F0@gmail.com> <xmqqpmnt9ngx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 11 Feb 2022, at 15:07, Junio C Hamano wrote:

> John Cai <johncai86@gmail.com> writes:
>
>> Let me see if I understand you. What I'm hearing is that it's hard to test a git
>> processes (A) that read/write from/to pipes without knowing exactly how (A) will
>> behave. By necessity, the test logic will have embedded some logic in it that
>> assumes certain behavior from (A), which might or might not be the case.
>>
>> This can lead to a hanging test if, say, it is waiting around for (A) to output
>> data when due to a bug in the code, it never does. Did I get that right?
>
> Exactly.  And we've seen such tests that are designed to hang, when
> they detect bugs, which made us very unhappy and we fixed them not
> to hang but reliably fail.  Otherwise, such tests weren't very
> useful in unattended CI environment, which we do not want to wait
> for 3 hours to timeout and leave later steps in the same script
> untested.

That makes sense. Do you have an example of one of these tests? I'd like to see
how it was converted from a test that hung to a test that failed reliably. As
I'm thinking about converting run_buffer_test_flush() and run_buffer_test_no_flush()
into tests that fail rather than hang, I'm having a hard time avoiding the
pattern of A writes to B and waits for B to respond.

>
> Thanks.
