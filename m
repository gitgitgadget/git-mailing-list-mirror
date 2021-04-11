Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2724C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 21:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51AD661006
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 21:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbhDKV7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 17:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbhDKV7B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 17:59:01 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0D9C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 14:58:44 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n8so18280622lfh.1
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 14:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uCvqhRN7zthtthfNwVdsIFCCHPRZeGPItH+I3rOnysE=;
        b=sTR2KfE7pJVNc0M9tWxR6PnbIPCWT++nmkcHn/1Hi+Ahd1Gs0QPzcRUKIajKaB0Q/W
         6SLRhL+Ls9egZNAbl3BL81Bv1by0VEfT+F8bL7HSnRfGMuzwLUSLPkPpOVAOLifOQ5Rt
         P+HenVX6wdS9ayRKRc6YjdzrJcjldGnxSq3RQnC65XTcmqGe08AOF/5MKxYpHGCbvqQX
         OZLVRPCO4txGsFxrx7WZJfzYv0Qi2qMIhwZrJLE67rKW3oZ4v6m5gafEWWmlUWVbztiA
         vQwdwi0EG+RpFhVL0B2RbOSoqmUqwN+VG3fMYyV3Lz0ToINnE82bcOF8s1x3Hjl+/8Wz
         8sQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=uCvqhRN7zthtthfNwVdsIFCCHPRZeGPItH+I3rOnysE=;
        b=sGMmnrXYOifr9vscmSMp30pNPPR8ljXxOIBN/mfsmVXe1vxPPulzBvhlKRp3HDISny
         TGTwligREL73FtCqRqWtsjv9ZKbLd1q2e5OnJr0658fGnuKqJ2AdV0PCUFZ+6QrYNePr
         Sv2893wY3AgtGEMvsSmsB2RaH+JGtdRGs2U5QNB6zX1dTW7Mo4GpghrMtY9cleU+dUwj
         Pyceq1yt9kEYYupEYHjCt4pEYkfoU4aEsd7W49yugGnID3Ssru458YRM63Snudmha0OF
         TM1E/rilPRFDf7ha8R81SxWPCbKZ3zi8MGeP2K21Wv9bm++poUg5D9MUXgD+QTp2o4PJ
         2IhA==
X-Gm-Message-State: AOAM530UlgirxAacROIH38GhQ3srVdA2Jp1jVvqm042SSELS3DZRm9Yn
        vjuSflmhJoFZ3+/GLVcR6axnQhJj0vk=
X-Google-Smtp-Source: ABdhPJxBZ8r6eVgurqb/MHkAq3SYiu+gA330VNX0qLMQIZPK9F3yktOVxXJ9a98X9hD0XdLBWgWiWw==
X-Received: by 2002:a05:6512:3587:: with SMTP id m7mr17212094lfr.546.1618178322771;
        Sun, 11 Apr 2021 14:58:42 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k18sm1830849lfg.32.2021.04.11.14.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 14:58:42 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 0/5] git log: configurable default format for merge
 diffs
References: <20210407225608.14611-1-sorganov@gmail.com>
        <20210410171657.20159-1-sorganov@gmail.com>
        <xmqqsg3whka6.fsf@gitster.g> <87wnt84s0h.fsf@osv.gnss.ru>
        <xmqqo8ekhcfy.fsf@gitster.g>
Date:   Mon, 12 Apr 2021 00:58:41 +0300
In-Reply-To: <xmqqo8ekhcfy.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        11 Apr 2021 12:02:25 -0700")
Message-ID: <87tuoc32lq.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> 2. We have descriptive long name for every other option, and it'd be an
>> exception if we'd have none for --diff-merges=m. In fact, it's
>> --diff-merges=m that could have been removed, but it'd break resemblance
>> with --cc and -c that both do have their --diff-merges=cc and
>> --diff-merges=c counterparts.
>
> Hmph, a devil's advocate in me suspects that it may just be arguing
> why user-configurable 'default' is a bad idea, though.

After you've said this I figured the option might have been simply
called --diff-merges=on. Recall that we already have --diff-merges=off.

Makes more sense than --diff-merges=default?

-- Sergey Organov
