Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4F1C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 11:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D0D611B0
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 11:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhJTLlR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 07:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJTLlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 07:41:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54E2C06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 04:39:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w14so23945549edv.11
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 04:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=CxDTHmotPEKdMaMLCCEvZOpdvyysox1fJ7L59YPCjZk=;
        b=EtikXxYRSKBo9EfQjZGP+ikmg8h+MPVYglFzf84+L7hOzZ6oWxFOXOGVWU3f5vJm6q
         RHlC7K2VWUz/ihfXJbDgUUsBxMRD0XwUtlplsOxzOXqOiTUDRD7+bAH20JtCJNsV4Wex
         vMKa4baCQBkmRIDLCPg4W/3TpY92bRKqnWkI7PGdmWXGLMx1YQV5V2drsjutIMD5EhAV
         5yKiebCkskOWGOlnNsxcngM44R/PlfsdRgYG0faHryqYk5t13LNuUvkUrgSx4tFQTuJY
         gffVXT2LvSHuFMhuortY1rpcTpNjxw02hV3TO3PlAdYS0Yyb5isxsBob7xA94n+nP1K9
         9Xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=CxDTHmotPEKdMaMLCCEvZOpdvyysox1fJ7L59YPCjZk=;
        b=7Ab7B1p3lBePBJcpzaxnn/WH4dkb6PA+V8PZB7keSmHw3nuuTSRUfX/y7ha52HrrGW
         cS1qdsgTTlqJjI4BuYLW5BwdiTNoU4B/9g9OYC3VPyDCOC45uJ253M3HgUd1jJDqu+32
         5fLQqqYmJXDTyqYHkkfAq1p5sBuaWIH6z1N5M6PrQBysQQl8UgiJQMp5hX9BA1GcuyTL
         XIkdldSqYTWhYrmv+shPTOM2P+v1AR3SgTJAeB3YdUTNu5mQhYJ/xIN9llc8e3q67pu+
         +cSHPMubIyTI6o/fOQG5P4Br84P1fQdeMnbiuD+PArjCTzO5wusazsHE+15W73vPNAar
         psKg==
X-Gm-Message-State: AOAM533VWnnnvvf/C8roTKvjvUdr01NaehBRC+IUBOSE23PmShw47Zx4
        e4hFdLtZCdhyIVZgmJHex3JtgEfcO0Nyog==
X-Google-Smtp-Source: ABdhPJyYI9wvSiGjC5pMT/j+MV5DOcflVt10PqVjxtnDR7NXRgJe+VcB6OPHq2rckf0n/J0nw66BfQ==
X-Received: by 2002:a17:906:c009:: with SMTP id e9mr45522432ejz.509.1634729938430;
        Wed, 20 Oct 2021 04:38:58 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p26sm1028567edu.57.2021.10.20.04.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 04:38:58 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1md9vt-000gpH-LG;
        Wed, 20 Oct 2021 13:38:57 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/config-based-hooks-2
Date:   Wed, 20 Oct 2021 13:37:49 +0200
References: <xmqq1r4hv7bv.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqq1r4hv7bv.fsf@gitster.g>
Message-ID: <211020.86czo0ncxa.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 18 2021, Junio C Hamano wrote:

> * ab/config-based-hooks-2 (2021-10-15) 14 commits
>  - run-command: remove old run_hook_{le,ve}() hook API
>  - receive-pack: convert push-to-checkout hook to hook.h
>  - read-cache: convert post-index-change to use hook.h
>  - commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
>  - git-p4: use 'git hook' to run hooks
>  - send-email: use 'git hook run' for 'sendemail-validate'
>  - git hook run: add an --ignore-missing flag
>  - merge: convert post-merge to use hook.h
>  - hooks: convert 'post-checkout' hook to hook library
>  - am: convert applypatch to use hook.h
>  - rebase: convert pre-rebase to use hook.h
>  - gc: use hook library for pre-auto-gc hook
>  - hook: add 'run' subcommand
>  - Merge branch 'ab/config-based-hooks-1' into ab/config-based-hooks-2
>
>  More "config-based hooks".
>
>  Breaks t2400.

Re-rolled with a fix for that per
https://lore.kernel.org/git/cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com/;
sorry about the breakage.

