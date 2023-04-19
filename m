Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B52C77B73
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 16:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjDSQOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 12:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjDSQOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 12:14:16 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD449031
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 09:14:09 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b50a02bffso45770b3a.2
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 09:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681920849; x=1684512849;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DrAYzGvUk1ynI2BuMzaGSYHdA3THfr3+0DeJM2Ye0Zo=;
        b=MkQITGYjOtqRg766sAT3j2Y6Ix/ojVoB8ktGyhwTxjK6JGpj1CU7oNecdv7lsIbQ/q
         tbMs1eZI2mIt1b/qXChyA6vaFKta1+ijGljYBaIFjXcCpASob1TMOnPgCb7DaNRFoEkC
         mN3q6QllXJgfugtv9YE/EK8FCLTCvOnqg995JDzz64xuhlZKlHv5Z8nNVdDYAwrl9eNq
         3NQvMI4LPotgjR9LSsIRGZiA+kbZgoRxqpDVWqec5lhn/aZHDIQMUJc72O/ESU3O/9Qv
         GAThjls5BOxnk2tbpFAc3ztVH5IzXmbjQbbLwV4mD4zVojdfXYy81rrQO8wk7np3YdzK
         2RvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681920849; x=1684512849;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DrAYzGvUk1ynI2BuMzaGSYHdA3THfr3+0DeJM2Ye0Zo=;
        b=jwaqMh1viG+ZcpQE5Yw/abtN8vj8It1ZZxiKfkPj0RDxbctJq5Hn0+J4aqpw2c2e8B
         KWRuymJnLhacSocI9mD4sBGJEP0bgOd0fR0YvDMk05xzyytTP//FM+Muoa3PLvnfhCqW
         5vO2YSH+b2SqCUa4SZKN/pUtaRglJh0Q/G7+DOPvycgMYv1+3DQ9vzKakH2pDMLGPM2U
         RFW021IDzHaeLh+nyHf70RUNK3b5rnXCjKsZvVZ9vB2qgkj1VDxxU9NA+OT27DF+hZSi
         8QE+OzqtYfpPDnK7hbEW/vRHjcCqXm5KcOWfBUxU0w9VGik5+blTBTYONoPRqyLtwZee
         mPhQ==
X-Gm-Message-State: AAQBX9dQfZl0UQ6hVoyPHKtdaKQtESFTlwYaTXOzUKmdhl2cx0Ca4yeq
        PbZerFY4t5A3JY9ohyjLYTQ=
X-Google-Smtp-Source: AKy350YjVyr8thOv5Hb0MIJZ+bokXaO9c9jyZjEcczClNzXqdRXPNUOhPRH4R+sjxk9CJQuxgt1d3g==
X-Received: by 2002:a17:902:e5c1:b0:1a8:1f4:2d3b with SMTP id u1-20020a170902e5c100b001a801f42d3bmr6624031plf.48.1681920849043;
        Wed, 19 Apr 2023 09:14:09 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902bd0800b001a656784229sm11603609pls.211.2023.04.19.09.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 09:14:08 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Samuel Ferencik <sferencik@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2] config: introduce an Operating System-specific
 `includeIf` condition
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
        <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com>
        <969a4399-a6db-7c72-f96c-8bbe5f6208d4@iee.email>
        <xmqqk03jcwxz.fsf@gitster.g>
        <CABwTEiRz+-+Zdx3Ed7O09Ch8GoXH-SnmJyc-vFOdF-hk_uO-yA@mail.gmail.com>
        <xmqq7cuamjmu.fsf@gitster.g>
        <67a2d12c-6250-c4ee-dd26-fd8ecc71b8bc@gmx.de>
Date:   Wed, 19 Apr 2023 09:14:08 -0700
In-Reply-To: <67a2d12c-6250-c4ee-dd26-fd8ecc71b8bc@gmx.de> (Johannes
        Schindelin's message of "Wed, 19 Apr 2023 14:22:50 +0200 (CEST)")
Message-ID: <xmqqy1mn97e7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The original report (which this patch tries to address) asks for a way to
> have a user-wide ("global") Git configuration that can be shared across
> machines and that allows for adapting to the various environments.
> ...
> So as long as Git offers ways to discern between the mentioned
> environments by including environment-specific configuration files, we
> solve the problem.

Perhaps 

    [includeIf "ifExists:/path/to/foo-credential-manager.exe"]
	path = /path/to/config/needed/for/using/foo-credential-manager

is being called for?  "os" being "LiNuX" does not tell much about
the environment differences the end users would care about, like
what desktop environment is in use, which leads to the availability
and default choice of GUI tools, to help them auto-configure.

