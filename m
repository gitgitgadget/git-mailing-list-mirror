Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7177C05027
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 22:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjBIWZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 17:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBIWZf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 17:25:35 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0024328D25
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 14:25:34 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id v3so2551834pgh.4
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 14:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KyYH4ORxdh/frq7tJyIXAcLM0fR350eH6xMSUm/e4Dc=;
        b=Q/tVH88O7jd8A9cnBpHTBb+nuNtQ57kNqhE8mG4wJE4Wj/aQd4BkE2ILXLgy+q6ajQ
         oTei2OX8hHbv2o9IPraayhx9jSp55k9GJ1qHLktTryFyP1YdRXue7aQNWwfKQFDkQI9k
         fvHoXlEh5wL4Ez2rEufuqq5BFBSf+AOlrHmPwteo8lOfCjAyLhVsXMAUbALIosuU/3tq
         B3Umcwx48LjhLCugWFSp9/RAN3cW7DEKi23QO8cr8J05XncFS5LiCPax4JcnReQdV1qG
         u1p30szHHyJXaEWY/YugBP4hopURiZTfmuESba1mx15kYtazmT8qeCy3pgwGzGQjWi+D
         0IKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KyYH4ORxdh/frq7tJyIXAcLM0fR350eH6xMSUm/e4Dc=;
        b=Si/pMPgBMDEI8dPmy7RbctJ1pXBZ9h5ZfmFw3LE3xY3xnwvs/hsA9KRJl5Nj7wHvJK
         ScSM3uJzQ+3eGj+kUblVhyF3YWyqgueB9dnRSPfnpCaC793kqfEskvdaKRyPZyOIpSML
         jOn16BTip5gaa2JhaAGMGR2jFuFJS+45nycwC1La6+i5yHddw6Snx0FsKPjr+jOmoV+j
         W+6mEiqt209lF+xuZ3IVVSqbHOIQUD5scNvBX9f56gRJduVayJX777UpTTJ2C9B01YYP
         dWJ2CW/Gg0TkahkX71J1GgzVG+SyySduq6KCKz2BXXAgAkvMTReVsYxGgSl5rJOdTiN6
         6DBA==
X-Gm-Message-State: AO0yUKV32zwtRHdPtyCi+Kv2Zw4asDxFo0xOmOL4X5R+gJW64KeUbiRY
        Ya2SC7UBsTuvM9awb3L6WlNZEN5il60=
X-Google-Smtp-Source: AK7set87n4Lyiy7YIwHRSOXdx02bodIz5rlNFV/Um3b2abUBdwkUaZM78RUXFQ+FNL9w3NQ+Bk3wgQ==
X-Received: by 2002:a62:7b82:0:b0:582:a212:d92c with SMTP id w124-20020a627b82000000b00582a212d92cmr9948294pfc.10.1675981534380;
        Thu, 09 Feb 2023 14:25:34 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id z9-20020aa791c9000000b0059416691b64sm2014921pfa.19.2023.02.09.14.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 14:25:33 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, chooglen@google.com,
        newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v8 0/6] submodule: parallelize diff
References: <20230207181706.363453-1-calvinwan@google.com>
        <20230209000212.1892457-1-calvinwan@google.com>
        <xmqqwn4qmxds.fsf@gitster.g>
        <CAFySSZAy=k+hgvg9r2NmroUs=BviZjS_KMW_+yO2nPs1dUsc-A@mail.gmail.com>
Date:   Thu, 09 Feb 2023 14:25:33 -0800
In-Reply-To: <CAFySSZAy=k+hgvg9r2NmroUs=BviZjS_KMW_+yO2nPs1dUsc-A@mail.gmail.com>
        (Calvin Wan's message of "Thu, 9 Feb 2023 13:52:31 -0800")
Message-ID: <xmqqttzulbmq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

>> By the way, how are you driving send-email when sending a
>> multi-patch series with a cover letter?  It seems that all
>> messages in this series including its cover are marked as if they
>> are replies to the cover letter of the previous round, which is a
>> bit harder to follow than making only [v8 0/6] as a reply to [v7 0/X]
>> and all [v8 n/6] (n > 0) to be replies to [v8 0/6].
>
> I'll do that from now on -- didn't realize that make it harder to follow

"a bit harder" may even have been an exaggeration.  It is just being
different from how other topics by many other people are formatted.

Thanks.
