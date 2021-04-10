Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28593C43462
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 08:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6FFC611AF
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 08:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhDJIb4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 04:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbhDJIbz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 04:31:55 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF86C061762
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 01:31:40 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x4so9191847edd.2
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 01:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=JzX7jo1/Frm7Klza50IAZS4OYS7sgMWHLvZ42DGlFCY=;
        b=ZEjUhjHY2SzOjE/Aw3QSggIKJkqRvbN0uUpZeryJt5vB8jzT3HXeYwwGeORhyqArMH
         XbJed2W63CA+VdJr155m/UEIWs0mZehHiOqyv1FSsZCs5scTAFRqy3HI4+EMUqsDggQE
         Xw1ZJUp066VfDzHzeMsIcqs0CN5bYFXO+5I8VipU5xtibdMjgO9qAOmSkIKN+w1YQ5qm
         l+F0slo9qpyKUQTPHZEj72xZFL0xT1LcPcqo57lNRxt3JFJe5nek4RZyD4xKh4hQ4EIo
         0ALE75P7I5KKKeCCm8ImumprR4L9JXG5aeqynQDOIdZwF/ZDQw6C1jo0UVCkfhlw3JdM
         CRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=JzX7jo1/Frm7Klza50IAZS4OYS7sgMWHLvZ42DGlFCY=;
        b=inYcF8WfQR28W0Anm3kdYi6vrPAj5f2zK8ZVZeRmjad7Ok6SfTLKIp/1HpOHlWgECF
         pjgYeGuhsveHGFBQAp6WGfXZSsHvC+6HMaxEQpobksW9asSZJOHTDGGbRsEXmh1hzIg0
         eTjZQRqSlWRkOsPdczivKMELqY46iyILtreLlpPT08pG1eiSPn/fwOKs5womq3unwvqj
         cDHZ3vQY5KUdPxBwAlhFz+pdMlkF7NeeXl/EU2wTN4y0thxJ4GfRFTceaKBamxMui7ZU
         74ycWUJU3CbPRIz2kcdwis4cO9kMKRD2o5J1GPo5lcGj5LFk3D+cRW2k/zzml8wbPk4X
         wnyQ==
X-Gm-Message-State: AOAM531c0ZoH4LuxyNKc5k2ox8wDkEXzMGO4xzfbCDjkAFlWyTzWB0Bp
        pUKkvZGL3/7y290IYgDzDsXqrKcnQKAldw==
X-Google-Smtp-Source: ABdhPJxRNUR2gLfYULNWz4osD88ybNdIVnPeXQpPFiBzy5Hb/sMdzoAWXiQYrvKTlMFsFm2xq2zHug==
X-Received: by 2002:aa7:d14a:: with SMTP id r10mr10842935edo.385.1618043498365;
        Sat, 10 Apr 2021 01:31:38 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id nd36sm2315105ejc.21.2021.04.10.01.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 01:31:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Albert Cui via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Albert Cui <albertqcui@gmail.com>
Subject: Re: [PATCH] fetch: show progress for packfile uri downloads
References: <pull.907.git.1616007794513.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <pull.907.git.1616007794513.gitgitgadget@gmail.com>
Date:   Sat, 10 Apr 2021 10:31:37 +0200
Message-ID: <877dlah76e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 17 2021, Albert Cui via GitGitGadget wrote:

> From: Albert Cui <albertqcui@gmail.com>
> [...]
> @@ -875,6 +876,8 @@ test_expect_success 'part of packfile response provided as URI' '
>  	test -f hfound &&
>  	test -f h2found &&
>  
> +	test_i18ngrep "Downloading packs" progress &&

This can just be "grep"
