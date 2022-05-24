Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF825C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 08:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiEXIAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 04:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiEXIAO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 04:00:14 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5738B098
        for <git@vger.kernel.org>; Tue, 24 May 2022 01:00:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g12so22012151edq.4
        for <git@vger.kernel.org>; Tue, 24 May 2022 01:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Iso4gUD7pzcjh6Gxr2j06RDVyCQrh1RXjoeZq7u3VFc=;
        b=TIOAMnTUkeRUaVzDDM98U8rMORK2KGLsxTqzoQVruT7UKnUm6CouWGIWm++HFdCuOj
         EyN1EXXI8tSrGo+eAPZ36gS9yYp213t2gwvSppGJ4JhhCOisRfog6ueo6vFEm72KYRhu
         1yXM5y2h2A3AopzcS93LCQHGaSqJymV8pz4K+ulFKiOO9k0yFHqsb8PwbM4K/zKdKgUW
         dE/SU1vy+e3/LWHQ5RLtUtXZ2jsr0M/M8dY6i93H3zXoD2sMD79WONDzkTfhbyXsuENy
         TVHnm3tIUpWJihC2PKqDe5jAzdsuyN1L09ZS38xkSNWw9yp7PFIGpVPrXZwFGwg20qlf
         vjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Iso4gUD7pzcjh6Gxr2j06RDVyCQrh1RXjoeZq7u3VFc=;
        b=uaTngH44A3CZylmW/tFVAzfuGUCbym+1XNr+u79PIRxTbgk4y9t52LG8Y6Wbj9cesR
         6CC6DnrEjBvbU3KuJM2DCCj8Jsp8BhWAXGw6t+o1cKhIb3lwaTQBw1y1MK1/OBSL6qtt
         tfQiMeLiQSjcavwy0I2wJgxmM4ks6wB3bzqCJPqtVXh4b3An6dS4NFg4UAbZqxQqIqe0
         xgZcnGbXH0q5zZ4pJAJw+ZLg4vNEu8on9Gpiwp5MvTbstCEqjy091QeS8ACxFW2I8RGi
         NgrzUGG87Hlunv6LLuhAsmqe3V+JSZTftCzXrAsdDItX0+CI4whbPeyS6F8Hjc98i2Hr
         n7gg==
X-Gm-Message-State: AOAM533siufyySfkHDSrUK2ASf/zbKL51yHuh/6P8/sDWudulwlYAxp0
        uXOhdm3mLP1+MWIrBfw32AdZirIHXNPUmQ==
X-Google-Smtp-Source: ABdhPJzQkuwUl/EdHym3bR6Cu3OTFzqnJsjpbv9yNBfhMBI2skz5AYZAvOqwgPpkg6miyN/pxw4PgQ==
X-Received: by 2002:a50:d7cc:0:b0:42b:4d05:ac4a with SMTP id m12-20020a50d7cc000000b0042b4d05ac4amr14001278edj.294.1653379210903;
        Tue, 24 May 2022 01:00:10 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id gx13-20020a1709068a4d00b006f39ffe23fdsm7046762ejc.0.2022.05.24.01.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 01:00:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntPSb-0038ku-PL;
        Tue, 24 May 2022 10:00:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/4] http.c: avoid danging pointer to local variable
 `finished`
Date:   Tue, 24 May 2022 09:58:51 +0200
References: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
 <4a4e0aa0a49a54eea88f9c2d8e1db6a697012718.1653351786.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <4a4e0aa0a49a54eea88f9c2d8e1db6a697012718.1653351786.git.gitgitgadget@gmail.com>
Message-ID: <220524.86fskzxsvq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 24 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> [...]
> Let's drop that local variable and introduce a new flag in the slot that
> is used to indicate that even while the slot is no longer in use, it is
> still reserved until further notice. It is the responsibility of
> `run_active_slot()` to clear that flag once it is done with that slot.
>
> Initial-patch-by: Junio C Hamano <gitster@pobox.com>

Don't you mean by me?
I.e. https://lore.kernel.org/git/patch-1.1-1cec367e805-20220126T212921Z-avarab@gmail.com/

This seems to be derived from that, or perhaps you just came up with
something similar independently. Junio then came up with the smaller
https://lore.kernel.org/git/xmqq8rv2nggn.fsf@gitster.g/
