Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3CBC74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 15:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjC2PVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 11:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjC2PVk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 11:21:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959DA26A5
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 08:21:37 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso4004040pjc.1
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 08:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680103297;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KrWoMGW/xPuCNrEjKHYSMFJbaCHEpA3Bxme+1hvkcj0=;
        b=g1ls0btkErDO7pQ2E+c7dhaGISsajWiIP7P6ixNLZlIQ1YVp+GPdEh3EmLmm05YdxM
         ptfMP3C/Wj0Nicd5m6VeZKaiJ0r7ECGc8CXoasxGg9OCdAvUHUUTs/3CIWdUR+AXr3K+
         vpb8KRE6EbVooA9I6km2YnZv2gXbED6W6J/lY44lpB+XrCj/IiWRMb9XKH2/FnRlB+/M
         s+Ot1RRWb/qJeCVIMGNMgw4zm+PsShTnSgAido3XMjuabInUIMdzWus64wvgTrnxTYFf
         mOd+wRWyQhV2cknpiADbKNyJwkvdp4vLoOHb7neNZu2OrnbdsF802y+EL7FwRvlQS0v/
         V4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680103297;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KrWoMGW/xPuCNrEjKHYSMFJbaCHEpA3Bxme+1hvkcj0=;
        b=iFgjpdOfci8GXrZfuIcFfDsc6IrXPDqlh7Palzj2P6K6Vl5WtNS50GivpCHKdzhYGQ
         /lg0q741bQ87Zg69bnC2G/Q9SqmvasaBDJjc8bhAIiz0vUQiLuqmxOLbbVMKnU8I3w0M
         Uexdb36EDBfmbFQ5fAjeULZ4P6WKoWV97/4TSwEbQxlBMPX/O5Um/DTrtcS9utDkjMts
         2z1+1fSZTUn+9TVdSC03AedtUJkABf9Ts1Z9G84XN2qHKD2Iotbg3iqcrJ/z0zBBHDOi
         iNS7KBA3LHzsolTL/IqhDj1xNeNxFTiFBLoXUKHNrwj3LRZSr/uI0Ig7gT36YnsJb6w9
         RDqA==
X-Gm-Message-State: AAQBX9eKhjG1q1vqHM7Qb8uxUoa8lyj4Zj8J7j2KkKNRN3Gd6fi0pfqF
        MQWrAWFzwydAIsquy0XH8Bs=
X-Google-Smtp-Source: AKy350aXPC0JAylbCSj9FSL3kvyRnQ82wRlbIBYaHzp2kLzyCNoNx2fMOYAiU46oxJqSqQ5zyiDxuQ==
X-Received: by 2002:a17:902:f9cc:b0:1a1:8860:70d7 with SMTP id kz12-20020a170902f9cc00b001a1886070d7mr16376264plb.48.1680103296977;
        Wed, 29 Mar 2023 08:21:36 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id iz1-20020a170902ef8100b0019edc1b421asm12097842plb.163.2023.03.29.08.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:21:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/7] unused argc/argv/prefix parameters
References: <20230328205253.GA1753925@coredump.intra.peff.net>
        <90a8dd7d-59ed-8de8-27c7-c7dc9cf8a77a@github.com>
Date:   Wed, 29 Mar 2023 08:21:36 -0700
In-Reply-To: <90a8dd7d-59ed-8de8-27c7-c7dc9cf8a77a@github.com> (Derrick
        Stolee's message of "Wed, 29 Mar 2023 09:17:18 -0400")
Message-ID: <xmqqv8ijd1mn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 3/28/2023 4:52 PM, Jeff King wrote:
>> More from my -Wunused-parameter silencing. The first one actually fixes
>> a bug. The second is a cleanup, and the rest are just UNUSED annotations
>> (but grouped into similar cases).
>
> This was easy to read and LGTM.

Thanks, both, for writing and reviewing.  I agree that the series
was a clear and easy read.

Let's merge it down to 'next'.

