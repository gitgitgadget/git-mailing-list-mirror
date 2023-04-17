Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E559C77B7A
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 18:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjDQSbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 14:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjDQSbh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 14:31:37 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC19BBAA
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 11:31:15 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b5465fc13so931244b3a.3
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 11:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681756272; x=1684348272;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxDKLVVhObFut7PnkBm4BJXZqTHQtroO9MVPEWH1FGA=;
        b=KwdKEugqqprUmDQEjRrYbK0cKK62OXdv83oAEh4uc8x4EPpMS17iTFwlJbhJn4fR2L
         XmaCAQ3OZ/ZIHV+9tyRsnHB98UObKbIk8P40THIAYElOtOi0lnye3+EjQVmFSie+iC9W
         poN3XcwajV3IvU0O531QUxyosK6eE+NXbDUzK6yCvtGrA8Ly/d2OpXlu0qw0m6u+yFI+
         r9nDOt8sfhzYHH6/RrMnzmHIw8cTFwSVJAwa7qIWg758s8glKsJAR2852hBJ9uZtLA5C
         h8Lp5fmIdtmj5RK6itxk84hHMuOKsFL/8/hKW7E3Pvgv9L5lzJ9MCdS76lSN39NWPPry
         bwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681756272; x=1684348272;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rxDKLVVhObFut7PnkBm4BJXZqTHQtroO9MVPEWH1FGA=;
        b=bw60DDOTxRkfQuPRaite6gGRl4pptMtUkIwnAuQdtNwRRuseMPRpsQ1oct5Ca2HI0G
         HS5Gml5GjxqwNZ2Txdi3BKIq0n3z4KfC6v/MLLXK1N9Oh8WX3vh5Km04kj/f/tF81QJe
         tLQ35MgwJJuNeHxux9MmyQHcUmdW3busz2QO+gCDBN24QNx+j8MbaxLQOOi3nqITkH3V
         +RAw5UzPy93hXDzSFpDK6Himdc2ssf+RzR4JRzj8fpPXrZJzlmdb3Zdhg5UlVey6p8BO
         +KPpQ0fwwJgiBoJjdc9hVxNKG8teu1Ty09nnplbFoDGogxU6XygwBFU6fQPyInjc+r/s
         C0yA==
X-Gm-Message-State: AAQBX9dvi95ZfRMjvC7j6rZzIfZxZPhnHGo9zy8zZzKdRRYXFMdWiIxX
        qVUQsKrgADTuXo810WOCOAw=
X-Google-Smtp-Source: AKy350bncgnIQixdMVzFzXrFboD/6SAr40v9dMnm3huUdKD6NykjQnJ1o2U8JgxXjo8bgW0HzqZMjQ==
X-Received: by 2002:a05:6a00:2d14:b0:63d:254a:3909 with SMTP id fa20-20020a056a002d1400b0063d254a3909mr4330971pfb.32.1681756271800;
        Mon, 17 Apr 2023 11:31:11 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id q13-20020a62e10d000000b0063d2dae6243sm1052047pfh.115.2023.04.17.11.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 11:31:11 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>, Michael J Gruber <git@grubix.eu>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH/RFD] fix connection via git protocol
References: <5d4e0ce10f537b4bb795a70dd51db12ecaf0206d.1681556597.git.git@grubix.eu>
        <20230416054735.3386065-1-newren@gmail.com>
        <20230417073827.GA39931@coredump.intra.peff.net>
        <xmqq1qkio4cq.fsf@gitster.g>
Date:   Mon, 17 Apr 2023 11:31:11 -0700
In-Reply-To: <xmqq1qkio4cq.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        17 Apr 2023 09:33:57 -0700")
Message-ID: <xmqqildumkcw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  #define STR_(s)	# s
>> -#define STR(s)	STR_(s)
>> +#define STR(s) (STR_(s) + BUILD_ASSERT_OR_ZERO(s))
>
> OOoooh.  Clever.  A pointer plus N indexes into an array, but if the
> offset is N then the pointer is left intact so the caller does not

Sorry, but s/N/0/ obviously.

> see the difference.
>
>> ... But the
>> BUILD_ASSERT doesn't seem too bad to me.
>
> Indeed.
