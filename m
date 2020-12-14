Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D620C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 14:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE0A2054F
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 14:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395296AbgLNOY7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 09:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgLNOYr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 09:24:47 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CC8C0613CF
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 06:24:07 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id t23so3957839oov.4
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 06:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=hk/KVFMIeLtUioPZdQ8GMk7oNqbFAhP4KOKURPLDf3Q=;
        b=vY1AnDCf7q9MOvt/xM/mIJQSHHXCqIDN7gBDyOdHQ03gP1KS8qlYED3tKCPhatFpjB
         4LFFzBT3OqIDs+gKFQJENCtkzdXHVYo5c+Dqt3GCVDbG9ZTTi8cF7t4prMPLjpa29CBs
         wL3dABOhX61heCs8Bw1ubXPEJJbg98i5bP6QfkjBogZqVSX/9r6P4ecr/NUdpGYGJTC6
         ixiR0SWN8reYeF09ff836HCSR5dUHuSBE40vd6LB8cXYUO3Uik8HLQWgqjkHWe4bAVSI
         BdDwYub2NOO/be9IPjIockQ4gtNu/iw1dAJMvEg83mLIocQnvWls6msoLl4LR4/tEBu0
         cSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=hk/KVFMIeLtUioPZdQ8GMk7oNqbFAhP4KOKURPLDf3Q=;
        b=Ya1mN7usV/0O8WCwiwQcI5581G+POinwXNk4d6Z6eGyVd/exhLMRWwDRLuYnDJUZNp
         AKcg/ie7VfVcrdvdMh8M0MhG3DMGOPp9gzz4rs6lPwDw1s/yLdTxPaPlOpdMflijw2sZ
         AbL2UN8cIpQu1ES6mquMIGvqYf1czmg1kzuOinfbcCNT4/gwqt6ahkz4JHP0Cqn//8kU
         wR2vcHpbqIzECvn5lUvEWXPhZ/dwJrtb1ZVRFu0iKRNY0PklY3/P79Ta/S1gzkt0zgcc
         1NUXdk3qe+CElVd/+OBNr9JKVFLeflc1nMWwrPIYazPnKwNIFTHbOfFsM6wU3KnBI+EF
         gZuw==
X-Gm-Message-State: AOAM530ck1/Cl0Zaa3dMHwDCclERlm+CF4MOWww7WPPi0CLeUdagjt88
        jrqTomBgN7sJY3nRxBBIELA=
X-Google-Smtp-Source: ABdhPJylfOstgjZ84jC0pXIfDAMG1dTVIXeVYSX17eUQ+VWQ31xq9yzaftu4HcEb0jz728d1hv9DPQ==
X-Received: by 2002:a4a:e1b5:: with SMTP id 21mr19448643ooy.64.1607955846765;
        Mon, 14 Dec 2020 06:24:06 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 30sm4328370oth.7.2020.12.14.06.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 06:24:06 -0800 (PST)
Date:   Mon, 14 Dec 2020 08:24:04 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <5fd77584dda74_d1ec120827@natae.notmuch>
In-Reply-To: <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
References: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
 <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
Subject: RE: [PATCH v3 00/20] fundamentals of merge-ort implementation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget wrote:
> This is actually v5 of this series, and is being sent due to review comments
> from a different series, namely en/merge-ort-3[1].
> 
> I have rerolls of en/merge-ort-2 and en/merge-ort-3 already prepared, but
> since gitgitgadget will not allow me to send a series dependent on a
> not-published-by-Junio series, I cannot yet send them. You will need to
> temporarily drop them, and I'll resend after you publish the updated version
> of this series. I do not like this solution, and I was tempted to just push
> the updates into en/merge-ort-3, but since this series was still hanging in
> 'seen' awaiting feedback and a lot of the suggestions were for things from
> this series, I decided to go this route anyway...

You could send it the old-fashioned way.

-- 
Felipe Contreras
