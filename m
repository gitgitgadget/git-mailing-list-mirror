Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6DFC77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 16:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjECQxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 12:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjECQxG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 12:53:06 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A592655AD
        for <git@vger.kernel.org>; Wed,  3 May 2023 09:53:05 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b5465fb99so4306348b3a.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 09:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683132785; x=1685724785;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/o5q4+dUmlz8cLNhZ2VFErkavLes3QAjO1qd+tqf/s=;
        b=p7QN8TUblKmv4RZkcBx3/obsuxtIrBZ4oTnZy2SL/Kbvfqeq40NwR1d3ZbL1LI2RcD
         8luwgpHwwhO1RS7o5Vhxyxh5i1Z3FLCx0LfeTA2iib+QuIvA0sAtmlwPIAA8gXzDIMlI
         NRai3NIPCnuxOmjt7LI2EwrOgYQDrH8U6p+ygsUzvHp++MAubrjZbwy3SlfPFc/wbN7S
         0UTx8wiivU2q8lGSPTXDYNr3bApC1YSar7E1R8RBvp9k8odLTiJgPPawosuRncT2aLCq
         7ot3jAhN5tyGu9dTzyzKehz1fHdBXYBlyM9aewbL9mHTjYnYUwVEC4Zm0fVi4lXR/gll
         hswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683132785; x=1685724785;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O/o5q4+dUmlz8cLNhZ2VFErkavLes3QAjO1qd+tqf/s=;
        b=dyvkwaeo/CkpACqs7xaYywpwN1Nb4NR8uFe3EWkc+bKMBnQ4gXpRpHa73J3pE2ndPA
         9E70V9tIM/ZeoYs1w9ov2NrpVGvtIjq8GLCKoRuO1AiWiiSwP2/uOqVtgc/0xqcM9NZM
         +tUYluQUrHU3KhtcF+mHpeBxDI855xKFx/q1B7AKmu+qGzkeudQpdBxI92Ut1GERmYZs
         UTQVdd54l9th+53cvlLOj52NmlqNAd5TmxYqqk4C3tP9kbEsj6lPHfDesNikHwcJpvN2
         fQ5v6Ht3L6frWUAic3FQmLCTC5BRoa5U7j0LlT5fqv0uJ28SVcPiPrMrAviF2fSA/Um9
         4rXA==
X-Gm-Message-State: AC+VfDxmA6SGmLPtckAloQi2oP6f/v18UhD16WE57ATkcN3/oaBkOSB1
        qnVzrjJpTl4F1n9roJBlPSfLbD88hEc=
X-Google-Smtp-Source: ACHHUZ4+SCixQhYvTfIYOs9QHyi4saEesspfsfPHTK4HFNFvAHnvK8UzPDdQF/me5D+ts7OU/NRCPQ==
X-Received: by 2002:a05:6a00:b8c:b0:634:7ba3:d142 with SMTP id g12-20020a056a000b8c00b006347ba3d142mr34318787pfj.10.1683132785043;
        Wed, 03 May 2023 09:53:05 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id n11-20020a056a00212b00b0063f167b41bdsm22282285pfj.38.2023.05.03.09.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 09:53:04 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v3 0/8] fetch: introduce machine-parseable output
References: <cover.1681906948.git.ps@pks.im> <cover.1683113177.git.ps@pks.im>
        <xmqq1qjxuzrc.fsf@gitster.g>
Date:   Wed, 03 May 2023 09:53:04 -0700
In-Reply-To: <xmqq1qjxuzrc.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        03 May 2023 09:48:55 -0700")
Message-ID: <xmqqwn1ptkzz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> this is the third version of my patch series to introduce a
>> machine-parseable output for git-fetch(1).
>
> Which base did you pick to build these 8 patches?  It seems that 6/8
> is not happy when the series is attempted to be applied on top of
> many recent tips of 'master' that I tried (including 667fcf4e15 that
> the previous iteration was queued on top of in my tree).

OK, I found e9dffbc7 (Merge branch 'ps/fetch-ref-update-reporting',
2023-04-06).  I can manage from here.

Thanks.
