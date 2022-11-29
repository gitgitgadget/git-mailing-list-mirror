Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A23C43217
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 01:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiK2Bqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 20:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbiK2Bqb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 20:46:31 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F4F429B9
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:46:29 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id 9so12269075pfx.11
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=veLj4ai3JQMHIb8FIvmBzjhDuAXP1+Yp3H5MCRrUZsY=;
        b=Qeb/iSkVq1UmVdMi7nIZ7Wt1TgpRd7ChuygvpCoGye8DvghGliCAFbN8dwiK7Nxph4
         X5HPBnIr+A6jS9XFnMb5tXSiiQqoq8iCtFFgMxsdBKnvbqaPHLA4h+g7oOEnqcmd+h30
         9zHRPbm6KkeBIfnmGuO4bzAzCwoKxdOPOS/s9GPsEUbYhE8rVKKSR7MrBApBPZE5E1F0
         r87FSiODXpLIHuv9nkrNCN5arur3hUrKT+bKiBVCetmXcH2g3gHNlpgsf7GMhJYmgPHb
         BEyBUjNATvMGs+oY1Bs4jOUwCSl21AaMy1v7673bhsC8YTs0F8hQVmntEA/sdMawUDlZ
         yDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=veLj4ai3JQMHIb8FIvmBzjhDuAXP1+Yp3H5MCRrUZsY=;
        b=mq0Ys2VIIksoeo5NzBNc30iCuLxglYj2CyMcR+HJFqIRs6yZjpqlNuqRm9FKhIgIFa
         vJleCUj8lxK3AOVNPCNc4fkZcFM/lqI1wbNFFkcJOJmONn9SK5NdPqnKewcsHiEZkqtV
         WiGLnpt0glrYVlVky5dmaZ7t0gnUoMUQSNN52vM/nIT3kyK0yWlU2gxW5sKoYfPOVeFn
         c7tSiMBAaVBR2laaPGl6WZe+rR1zCUCJ6YfZHRnLxjKu0jvXixBCKl3r/ViRRqOjgh5+
         Fnh3RcnQ/K55uEsyug0gIx7JMuavf2gKv4DRqSfTZ0BPfcaVd/qymyLTp/eXEOgt82rd
         7TPQ==
X-Gm-Message-State: ANoB5pkI6CsVUmy+fHyeaz0TufIU43gcDZrVyaxvngQZWz8ElUTt2p0S
        NaUUhtLkejA5c+ghFwi28oI=
X-Google-Smtp-Source: AA0mqf7hbsTXPj5VbjuvcKeZQVcC+NMTc42XgDRihgYejF3YTOnjGVEumCY3QUcw1JOzcWKrpPp0/A==
X-Received: by 2002:a63:6347:0:b0:478:3375:a1bc with SMTP id x68-20020a636347000000b004783375a1bcmr3997390pgb.239.1669686389191;
        Mon, 28 Nov 2022 17:46:29 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z21-20020a63e555000000b004777c56747csm7291607pgj.11.2022.11.28.17.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 17:46:28 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Git List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/3] Revert "pack-objects: lazily set up "struct
 rev_info", don't leak"
References: <f5779e19-813c-cda9-2f84-9fe58f745e89@web.de>
        <xmqqv8mz5ras.fsf@gitster.g>
        <d10de9b5-e5ff-18d6-d950-1d090d87b113@web.de>
        <221128.864jujmhgp.gmgdl@evledraar.gmail.com>
        <c5aeb93c-763d-3eae-0150-15f6ca675319@web.de>
        <221128.865yezkule.gmgdl@evledraar.gmail.com>
        <59431916-9f55-d0f4-da54-e7369803eb4c@web.de>
        <2488058d-dc59-e8c1-0611-fbcaeb083d73@web.de>
        <221128.86o7sqkjcj.gmgdl@evledraar.gmail.com>
        <0b86ae8b-5523-3857-cdba-12275f727cde@web.de>
        <Y4VfrsYwWkestQ05@coredump.intra.peff.net>
Date:   Tue, 29 Nov 2022 10:46:28 +0900
In-Reply-To: <Y4VfrsYwWkestQ05@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 28 Nov 2022 20:26:06 -0500")
Message-ID: <xmqqk03e4jnv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This is the actual reason I responded to your message. ;) Try:
>
>   https://github.com/avar/git/commit/e02a15f6206.patch
>
> etc. I don't think there's a "raw patch" link or similar in the
> interface, though. You have to just know about it.

;-)
