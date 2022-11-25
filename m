Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A8DC4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 04:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKYE7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 23:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKYE67 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 23:58:59 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E251EEDF
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 20:58:56 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id b11so2773727pjp.2
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 20:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RA6eGezBRE3dBGL6OgSRGSkR00nCuqfnCC2NRmcb7qA=;
        b=ezAgigGbsEYQ5o/HevHY76BJDZW1d5fOKt0oofA7JFi+DIrzIb1IQIAq4Un7lVbm1D
         o5MrjFexIY3eohXvZYWIy2cO8zy0epnNIYVhs2a0PXfVgP8K+nkHMr/+N0dljcOyzJ1R
         VRyQEu3jWTh6K1tgy3abhA7A8nGSbjNUm4DHtr41lHBMMlmU/fbfh7hiJnbQPKf6WCq3
         Zpwo7NCqkSQuRzCZPxa/pZuV6yl+MphEobNb/FN3TnV1gHFF0JtGJD5Kgjw340FxWY9j
         n2eCB9Tyq0BQt0mvP1OcTSU/p3vrZX08Civy9M4iGowFsYrzJeQ57XNlztZzNPVSXmmx
         Nqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RA6eGezBRE3dBGL6OgSRGSkR00nCuqfnCC2NRmcb7qA=;
        b=qFaLcpuh34XfhttPz+x6uTrKRRBS/5bn33w3VnvYWVRbZtQDLtNoLzotgOgT/+E3N5
         KXkwQkIV8U8JrorPW+9FUTrlz+q6kIH2BKR6P7A+qQNUzO2EHQYP9veRwc46DWy0c6Rg
         hRqX7deU59En+dGWqpL3TwVLSfYA2RgZC+P20NmVbuybh1VN5EbGBcAr+uzqZDrxR560
         5sCnBdTh0D8bJaFSd8iY3OeT1yk7cGXdc42evQ9nUof56sUQTm8/xlHAm71MsHoblrac
         JBQ9gzriKELRmGDATpFFnlAN23CObUSZqiCP71uEGBVqqfINxrlRa4rt9LLLWBamH65I
         MQ+A==
X-Gm-Message-State: ANoB5pkLip0EwAMGUC09+GsH/ow9dwGC4+hvmosMdKp5JMNKRRoj7LiT
        s9oU4UDgJKBeeKGDS2JDu9U=
X-Google-Smtp-Source: AA0mqf7ahu1Bi1expVnd72MqtmBYqH8JKr698erqIx3IoifehmVw+wWloErg0e0QjdJhLU4SX/I9Pg==
X-Received: by 2002:a17:90a:460b:b0:218:8a84:aeca with SMTP id w11-20020a17090a460b00b002188a84aecamr32593798pjg.63.1669352336092;
        Thu, 24 Nov 2022 20:58:56 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id ik7-20020a170902ab0700b00189529ed580sm2264076plb.60.2022.11.24.20.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 20:58:55 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Kyle Zhao <kylezhao@tencent.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] t5516: fail to run in verbose mode
References: <20221121134040.12260-1-worldhello.net@gmail.com>
        <xmqqo7szsjs4.fsf@gitster.g>
        <Y30eK/mNYeLNtOi2@coredump.intra.peff.net>
        <xmqqwn7mo4eu.fsf@gitster.g>
        <Y37F1nxifC8o8qEQ@coredump.intra.peff.net>
Date:   Fri, 25 Nov 2022 13:58:55 +0900
Message-ID: <xmqqzgcfeik0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> One thing I'd worry about is buffering. One of the nice things about
> "-v" is that there is nothing between you and the running programs, so
> you are much less likely to be fooled about the order of events in the
> output. Or wondering why nothing is happening because real-time output
> seems to have stalled. But piping through "cat" may end up with weird
> pauses while it fills up a 4k buffer. Using stdbuf could help, but
> that's far from portable.

We could pipe to "dd bs=1 conv=fsync" (tongue-in-cheek---I think
conv=fsync is a GNU thing).
