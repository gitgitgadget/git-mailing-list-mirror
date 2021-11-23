Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E81C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 13:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhKWNbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 08:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhKWNbK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 08:31:10 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE61C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 05:28:02 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id y12so92124909eda.12
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 05:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=2IxGog++glsz3t20TicpS+aY4oQXPM5+EE7reGEIF8M=;
        b=ocR/KzKclHdEOPUzDK3Xv06Uxfg2OPqfErW/tGgJlxnownjbtSuKmkaieNG23Wj7+0
         9MWl8Z/WWE/WzgcxCoOt5weKJe3ACShhyKWBMr8bTj6Jwt8NkY0vMbrMdv6yWSBZTEjj
         nQA5ncBC2WvRcyqzJ/b05f1OVNuYETKp9g+YKDyfY2DBvLshXccEdGgD8pIxwmWRI8Qs
         lqp0Zwpa/8KviQ7i9iSv3RQ+ULYKSuHjlA4wo6hRySnaj2xiwZc+1KE6JAuBgBh2wtem
         xbrET87IVb1xZdrxixP/cQLn91YFdTG028k0G8GOdUE5LIJmSPA+XKq2YUDM3uLtRlca
         CMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=2IxGog++glsz3t20TicpS+aY4oQXPM5+EE7reGEIF8M=;
        b=QhmCi9dgZRS2Sizf9A9HKu7qYPakgRXh5AIi6IPoNjkrzbCxJCqrAAxd7zt3hc4RNk
         wigV7cIqjRe9agH75OxM+FaTs+4/WxWwCL517z5skCCbnFuHST68sc86F7F82MpzI9xT
         XdrsuEfY2mjEYE8zjZmw5dDjRv/Kv7wL0eyH5peEScFhQmnqAzwUDQ66aaJ+iqXlJrI+
         MbPgCTMT7Mb3yocP5u1O8zlRT2rz7G6JlQk6jQA4Gld3eDTW3OTiwNvLbyr9vMay6IlB
         pUG+9opY/L9Lw8dxj7AUFjew9o8iH1tFgkbya5thLbjZs9XrqTIPYid4yv3OkLxgjgdG
         oGAQ==
X-Gm-Message-State: AOAM533VRCRixR1gQuRluCnF8qpqhiO3mpBgw4mb976z3jlnbLNlSCX8
        5PttlpVLVpsMwmA1nRabTMo=
X-Google-Smtp-Source: ABdhPJz1OgA7gVz8ipQhTCmvkEtIkk2VvAhBFi/gyjFFCXlBQo5JMY63RP29wHnG/DvIyHS12pP6iA==
X-Received: by 2002:a17:906:8794:: with SMTP id za20mr7557123ejb.11.1637674080588;
        Tue, 23 Nov 2021 05:28:00 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gb42sm601535ejc.49.2021.11.23.05.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 05:27:59 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpVq3-001NiU-7b;
        Tue, 23 Nov 2021 14:27:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: ab/mark-leak-free-tests-even-more (was: What's cooking in git.git
 (Nov 2021, #05; Fri, 19))
Date:   Tue, 23 Nov 2021 14:22:16 +0100
References: <xmqqa6hznvz1.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqa6hznvz1.fsf@gitster.g>
Message-ID: <211123.861r37uhls.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 19 2021, Junio C Hamano wrote:

> * ab/mark-leak-free-tests-even-more (2021-11-01) 15 commits
>  - leak tests: mark some fast-import tests as passing with SANITIZE=leak
>  - leak tests: mark some config tests as passing with SANITIZE=leak
>  - leak tests: mark some status tests as passing with SANITIZE=leak
>  - leak tests: mark some clone tests as passing with SANITIZE=leak
>  - leak tests: mark some add tests as passing with SANITIZE=leak
>  - leak tests: mark some diff tests as passing with SANITIZE=leak
>  - leak tests: mark some apply tests as passing with SANITIZE=leak
>  - leak tests: mark some notes tests as passing with SANITIZE=leak
>  - leak tests: mark some update-index tests as passing with SANITIZE=leak
>  - leak tests: mark some rev-parse tests as passing with SANITIZE=leak
>  - leak tests: mark some rev-list tests as passing with SANITIZE=leak
>  - leak tests: mark some misc tests as passing with SANITIZE=leak
>  - leak tests: mark most gettext tests as passing with SANITIZE=leak
>  - leak tests: mark "sort" test as passing SANITIZE=leak
>  - leak tests: mark a read-tree test as passing SANITIZE=leak
>
>  More tests are marked as leak-free.
>
>  Will merge to 'next'?

FWIW Elijah reviewed it and acked merging it to "next" in response to
the previous What's Cooking:

    https://lore.kernel.org/git/CABPp-BES7SX06i3+AZS2gxkGdbS6nHy5r00E_WhMaSpZ6PdjrA@mail.gmail.com/

I also think it's ready, and along with ab/checkout-branch-info-leakfix
(marked for 'next', yay).

Together those two form a good basis for follow-ing up and fixing some
other "big leaks". I'll be doing the big one of "struct rev_info" soon
after these land.

