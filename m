Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B43C433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B78A60FF2
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237904AbhJFKTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 06:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhJFKTK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 06:19:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24EFC061749
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 03:17:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id dj4so7914959edb.5
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 03:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=DkgcEdZzqtvf5V3WnErzoKqePH0wa5b0peMTPneNHS4=;
        b=oGM5Ic7DFDOuTp7OCBgJWb6DmFAzxVgCVog/NWiWAhjABr1asedtkpbI3ismIjEnbX
         mRDVWSA+ssOVO51hOV3cQmxpy4DtucJk+U5zJvnG20uaqSflSft2ZtwhqnDtB5SVrFMJ
         9ADaD06usL1QPp3ziQt2jxyMTZdQ2RXfxB4gWcHNyfc7onFEvgIDQIfAv1agQBeCOf3y
         v41scfcQgVIPfVmjgwkCWPVXrdUog0rkEa3Ghlmi00uRfQo2gR2LYITymFxMwKgpJ8c2
         0CtXqIqvxewHXo1Z4h/a7c6O2+lbAv43M5SiJSrJRfXj9wH4v80Z+ChkPtzHsEFp+Kep
         Zo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=DkgcEdZzqtvf5V3WnErzoKqePH0wa5b0peMTPneNHS4=;
        b=EEQQiVAoyavjwTu7ZsDsnTqkqFbnRyuF2GXNvzlr5rfa5Bok4MGaT4GrxLlYp0fLYM
         epCz4wvdsnzDMJVDI9S6c7HwDOA7DeM6+iJirwCvZV2SQUba1J/dpiB520EYguf9yryo
         GEmPNmK0/j5mKf4KYaZjNNEcI//liZp06dwbbR6nv5aIpydkI12X6D9Dd20Iwf+VTDs2
         iONz78dg9JH2ml2I/YEI/jOCZePec0gWifeX3uufcf/vMOAXi1965CE8C/lzHNA19lGc
         rFJEhHhp3TTw033h/IQzqwWzDgXPy6stuiIDZLZMA1fYnTXHsPXo+q/UQZcwfZZWCTSN
         4z2g==
X-Gm-Message-State: AOAM532h8zuMVP4IrwhuZdkd7pdhRvICpO/BY2V+WWQIUTZGQtggtTvG
        I6w5XUe8BkNFIZCGGc6anxJc1R6WgYSh8w==
X-Google-Smtp-Source: ABdhPJxdPTudjMP7TBkSRNccT7F5HaEkYrjaXWg20b8Vanpa77+mJrVdP8GeWIS8eGs5/4FNKYhO4w==
X-Received: by 2002:a50:e085:: with SMTP id f5mr33063635edl.9.1633515437301;
        Wed, 06 Oct 2021 03:17:17 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n6sm9961272eds.10.2021.10.06.03.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 03:17:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>
Subject: ab/make-sparse-for-real
Date:   Wed, 06 Oct 2021 12:14:55 +0200
References: <xmqqo884tkxd.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqo884tkxd.fsf@gitster.g>
Message-ID: <87mtnmihjo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 04 2021, Junio C Hamano wrote:

> * ab/make-sparse-for-real (2021-09-22) 1 commit
>  - Makefile: make the "sparse" target non-.PHONY
>
>  Prevent "make sparse" from running for the source files that
>  haven't been modified.
>
>  Will merge to 'next'?

The concern in earlier rounds was breaking existing users, but in the
v4[1] the "incremental" is a new target, and with the Makefile template
the result is, I think, easy to read & worth it. So hopefully it can
proceed.

1. https://lore.kernel.org/git/patch-v4-1.1-f31fa3e8282-20210928T014023Z-avarab@gmail.com/
