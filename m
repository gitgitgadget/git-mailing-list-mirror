Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629BCC4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 05:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiLAFUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 00:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLAFUD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 00:20:03 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103219792B
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 21:20:03 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 82so759453pgc.0
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 21:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5ikuewFcm5DhvwR12Z01ouqQhA6ac9b5AaVlcEs4qo=;
        b=cC08v4vLyY7z07K0P2RmPDo//wt5//2lBRzMz5DCZP87mbxFEEnFONeXeiEHF8SJug
         MIY0YuSP+9AGAnPmPdx5WSAqiPsl+URGjLPy0C1JlZM84da8tqS8azoVJcQdZPYDX8hm
         gwE7MfPOi6V6ypZ8v+PzQOQV8Tw7ebsDNF735M+qCfYq6ZKx/OyNeg8An2sXgyu+QkTa
         A6zI9GGrr2N8lvVHsC17VbCRIth7pqbztGWpKD+ntDgxYCgy5NlyjWsvZmuyFEi/rJeX
         oK8DGVeQAks7ZmJeEVNrVIIowUubXNePTEOwOPO4iDwwAoYFy98PcaRaew7cvtl7HOhT
         eXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K5ikuewFcm5DhvwR12Z01ouqQhA6ac9b5AaVlcEs4qo=;
        b=xmS3jbM2w9uSAQFtqokZ7eB//vfosyQk+x+gw5o1iiH/VvkB/ekA0m14k3M6HPu0w8
         26I8mTBa5jK2Ib0W44GTCBZvcfyuutmr6B6vJaEon92udP/Oi8E0qEbR7YNX0K9BH/YT
         Kf7YT9oLobhgudz4DIDleqd003LPXAw5uAqr5aY49gPwkHrWZpuz3iTVjTLK2SAr5Hci
         FDk0Bwj8R8zfixwmMYjC4R6YnFIRKMoXs1ovtUCM0wnQEIoAWNx1gyMf4ZDUd0IfDatk
         Y0e/p3dqyLffTpyySYpswbwZzuUMzWWRNztxDoV75HNken2sLISiXZIwoLd5metJu0gq
         aMpA==
X-Gm-Message-State: ANoB5plKKCckw2WoxzqQwbVER544HKtQkHYxgDkDdFTWTc9sZ7hyBazs
        iOq8M1C+1E2iWmn9j2onud4=
X-Google-Smtp-Source: AA0mqf7aQogiQ7xadmlsVY2tH5hPUHyqN7A8EH/odehPUOqfxChQnWbUrKZ1GdzIfwilqZFyVLpjJA==
X-Received: by 2002:a05:6a00:c5:b0:56b:a4f6:e030 with SMTP id e5-20020a056a0000c500b0056ba4f6e030mr47772742pfj.85.1669872002385;
        Wed, 30 Nov 2022 21:20:02 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u64-20020a626043000000b005751f455e0esm2250959pfb.120.2022.11.30.21.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 21:20:01 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: ab/remove--super-prefix and -rc0 (was What's cooking in git.git
 (Nov 2022, #07; Tue, 29))
References: <xmqqsfi22j67.fsf@gitster.g>
        <kl6lsfi1d1tf.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqilix150o.fsf@gitster.g>
        <kl6lh6ygqphu.fsf@chooglen-macbookpro.roam.corp.google.com>
        <221130.864jugi59l.gmgdl@evledraar.gmail.com>
Date:   Thu, 01 Dec 2022 14:20:01 +0900
In-Reply-To: <221130.864jugi59l.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 30 Nov 2022 20:43:10 +0100")
Message-ID: <xmqq8rjru2da.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> For my part I was waiting to see what Junio would do with
> "ab/submodule-no-abspath", which is already in "next".

I have no strong opinion on it myself, but have been carrying the
"leaning negative" label from Taylor, so the default action would be
to eject when 'next' rewinds.


