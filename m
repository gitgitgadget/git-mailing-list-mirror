Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C92C7EE2D
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 18:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjCCSFP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 13:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjCCSFN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 13:05:13 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F25521D5
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 10:05:07 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id v11so3560074plz.8
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 10:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECNF4LG65V4AFB1wpq9mv8ToxBY6hFjMCeNFLK6gur4=;
        b=jiKTD2rTPwTBU1zzRpx3PW/oasPdhT/EitjUEeZFkHCYd1TPoSRRJnYQeRbDBZ7vj0
         8cFaByctBLcWYsYpFZxYhsTOVodqD1p4ZGMKhNOKQliD+8FMUlVsYB2UPe+YAgKZ5mqu
         bc1j8gQ3biXKerSxyaztLWKEjUoZ7NJMZ8qhM1TmGh9mPf7jcHjZk4Fne/LLl43hQ3mH
         9+Fm6gop8C5OQSXZ6mwjSet7tJ6INpZTZJjnq8zl2rs8UGVCY3HFmrxCv4N9XNk4xnxL
         raK8uhY6+4VQUZdjdcefIisq8bQOc7TZgyde2cuXs5WhuzukRy/mJXWC1txW3rEHmTQb
         gECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ECNF4LG65V4AFB1wpq9mv8ToxBY6hFjMCeNFLK6gur4=;
        b=YYcPaLuYiplEuHc4ycGw9SA0P73wpRHy3qjINMFLJ8b3SPEQnkJ7oqeDvC6KI5ek+5
         3n7xoII6AZMECmcUsDcJn15A925SAjsdbc7YINb9gbja03K7c4v9yaBcuUUg/qpp9sa1
         SubCzSif5Rwp9MmFCc+VoDSSmGarUZzrYYKZ3WTcK1fjrR7Czze3H74HH6Ohh34Hzlmr
         zQyz0F4rzbGlRK/wXm1H+8jfFX43NRVkj58btxWj3XwxEXsZAwgR5O7ZtHko315RZaAn
         3/DIMbsUH9iaGyENLRH043OrxXYN+Nwgy+VpQT4D4qRL3NzdlqFebA2TpEcEV/oJXfic
         DOhg==
X-Gm-Message-State: AO0yUKWQwyp5Un27EZFnOAkhJJ6/jwf5hvemunzK5KdbiEKDtvtRSITB
        WyaDLKnSXIbWKHSea7RuU6M=
X-Google-Smtp-Source: AK7set9kYzb9+G92uEiaCDRe5hmKqrqxVtl3RoaFe0vkAJUlRcjV+g5M8IThWVb7gqs44yekcJAYmg==
X-Received: by 2002:a17:903:22cc:b0:19c:d5a5:1f52 with SMTP id y12-20020a17090322cc00b0019cd5a51f52mr3525522plg.18.1677866707166;
        Fri, 03 Mar 2023 10:05:07 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id c17-20020a170903235100b0019e76a99cdbsm1786229plh.243.2023.03.03.10.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 10:05:06 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 3/6] config.c: create config_reader and the_reader
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
        <751ce3e927d392530038006a3f1e3a9538ce2127.1677631097.git.gitgitgadget@gmail.com>
Date:   Fri, 03 Mar 2023 10:05:06 -0800
In-Reply-To: <751ce3e927d392530038006a3f1e3a9538ce2127.1677631097.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Wed, 01 Mar 2023 00:38:14
        +0000")
Message-ID: <xmqq8rgdg17x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> A more typical approach would be to put this struct on "the_repository",
> but that's a worse fit for this use case since config reading is not
> scoped to a repository.

Good thinking.

> We could have also replaced the references to "cf" in callback functions
> (which are the only ones left), but we'll eventually plumb "the_reader"
> through the callback "*data" arg,...

Good.
