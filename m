Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2D1C4332F
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 23:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiL0XRc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 18:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiL0XRa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 18:17:30 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7193B4A3
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 15:17:29 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so14521230pjd.0
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 15:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXQ1Mn0O68QosIe82PcCmmBhOMDgscjTyj89YhKrVzs=;
        b=o8H8qCVT3z2TzBYiM8YasMPdaRptjR8WeDVeigrTpHl6/RlYtYbrSFzn8hLDldnyLf
         Ge+iI2vqujrPBAZgloO7wElZvSuUQiRbHBn22qr0vozkepXRLrBw6QmeXGw+sxgKpxw5
         VPRKJhaADPnVeKD5/0BYZrNijIJ2Ju6BKFFWil5sY2ezRcD11wPP0TBPcck2+13PkoIf
         f0sxznV5OgE3PJ4HBSL4VSpJ6Gq0W18jmgksjgtdZ8sz3BWlG53cDHalERxUZ1+J/VuL
         /E/peK29Sb49Jbqfvar3MqdXY3RkDtZJxoXuM1mJTJlrNC3UwLq/8rFsFIwB9MGRtxYj
         YoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XXQ1Mn0O68QosIe82PcCmmBhOMDgscjTyj89YhKrVzs=;
        b=MuCLima6lbnz5UkZb2yCugKhI7qw3yrJR3OeFpPGen3M6UV9ufN3NLAR6kd/O5TxQa
         q2UKqTXr061pitbhGxZk3M40QONpw4nfZqiwlAbUCYi4neZbuCMpceQ049O7jGT+LKmx
         FeZjIzY+XgnxYZvaTcU2MFKRW8MrqHxQh18wllWD9Vg75AZMr+jLrE6eN0U0OrFj9Ev8
         PEDBzel0Tz4QpFf/jCPNZGI1Z9wh2l07hbJIQ845KTX/RS2TVsC//9Pzy7Qjtbrl6aO9
         bGvdOunjm6S+F1STDy4NNE9w7a4t16qttOxo0eFGfN1m6CZIdkBF5sa2twbb/XyVNP4O
         5+MA==
X-Gm-Message-State: AFqh2koXvcjE9ddFBnJtYtn0xA1ZdA67yIPEuLOKTUmq17SWvnieDHqC
        sf8PdTR+QFLiAQO72xXM2KI=
X-Google-Smtp-Source: AMrXdXu+bILiwzakvo2QRRxoRIOsd+laWei1B2ofQqQXmkNDnS1EAzdr2dBREl5iqbUKkArmUrzOyg==
X-Received: by 2002:a17:902:e411:b0:18c:cde:fdda with SMTP id m17-20020a170902e41100b0018c0cdefddamr25423791ple.37.1672183049141;
        Tue, 27 Dec 2022 15:17:29 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902e89100b00189ac5a2340sm9643081plg.124.2022.12.27.15.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 15:17:28 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 6/6] tests: don't lose misc "git" exit codes
References: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
        <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
        <patch-v4-6.6-94df7a1764e-20221219T101240Z-avarab@gmail.com>
        <6efe13ea-8782-2337-1626-9687e2219680@dunelm.org.uk>
Date:   Wed, 28 Dec 2022 08:17:28 +0900
In-Reply-To: <6efe13ea-8782-2337-1626-9687e2219680@dunelm.org.uk> (Phillip
        Wood's message of "Tue, 27 Dec 2022 16:46:59 +0000")
Message-ID: <xmqqo7roqvw7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> -	test -z "$(git diff file)"
>> ...
>> +	git diff file >out &&
>> +	test_must_be_empty out
>
> "git diff --exit-code file" would suffice here, we don't need to
> redirect the output and check that it is empty.

Yes, but the test is trying to be faithful to not just the intent
but also the implementation of the original, I think.
