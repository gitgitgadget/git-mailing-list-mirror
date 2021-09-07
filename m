Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4693C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEF8060F92
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbhIGMjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245607AbhIGMju (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:39:50 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5300BC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 05:38:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u14so19332766ejf.13
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 05:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=pu+Jy0y6NB3FUxV4r5eJze6R1XNVydc5isdb1SSCGI4=;
        b=M6pi16ATWjQWvFUzgCxzC3vVjIgWgV0CrNqukpe2m62WLghr9Gq6K2sRKra8kUbklG
         tgA2Qz9qFtGaK02Ox+VUDwIZmk1gFgOaVwXVbQd2VZDD7xxJBcj5hQNsm9IbwK5QNtIg
         VU2SpxsP+lRBBfkGnY9byQeBDdes6J6Syj4xj0B+sazXNtr46VetVQZ4vgTON330LJV8
         rmXjfTH157BcUD69LhkdUS7DsP/YSn1CtGsETf/EWM3QxxQ6XBD5R5PEIK0qhNtu+vzB
         9Fxvx4AMKmyFlE4W/mHCUi1LRmjTXlq5bZHQIZ+u1JBTGaULfLpMOqUaaFK5IZs2SlLI
         27LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=pu+Jy0y6NB3FUxV4r5eJze6R1XNVydc5isdb1SSCGI4=;
        b=GKckILsYnW4OrZRlLXpW4w/YCwndugp5I6Gn+DE+utAIc6P6+sskWPM/110yqvllR9
         T9W8/FSW5qMtxhaP3MhKeyNrtcf+xROKQen/ALQNZv4TSdxQdDr819cRxbeLM1yf8L9b
         sQ5xfvHGZ1gUVq3CFRPhH7PpyecPMqXnE8QW7edE+qjUsvY792OBKNoZ2R9Py6y/IvEq
         Q4uJS9HQAehpfJq9rE2pVGW2f1CVWKvwaiziG5Z/ZDW7PEpAXRl8TbZniqftX/ZAc9tS
         WVdBbNCl75a3aXxHjn30S7f51BrsEtwkkP8jXzuV/3ycIpKScc5DQOXt2ULhf2Ut1MDm
         5S6g==
X-Gm-Message-State: AOAM5315ekYHsS+7/em7byaSytLNZm5ZLHtwWgxIXxYwfrFQ8RCtdma7
        hqnp39aabks7LTNSdyFVDcjeV8ITkhogwQ==
X-Google-Smtp-Source: ABdhPJxfHQz43XFx5TPSJ4+yq3sed5Z9Y3fZ2KMf36MeBtyn9LTfie/7a0tHt/gxMYz2psb1WpAg5A==
X-Received: by 2002:a17:906:4346:: with SMTP id z6mr18214991ejm.403.1631018322721;
        Tue, 07 Sep 2021 05:38:42 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g19sm5498361eje.121.2021.09.07.05.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:38:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        emilyshaffer@google.com, gitster@pobox.com, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH 02/13] submodule--helper: get remote names from any
 repository
Date:   Tue, 07 Sep 2021 14:37:51 +0200
References: <20210907115932.36068-1-raykar.ath@gmail.com>
 <20210907115932.36068-3-raykar.ath@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210907115932.36068-3-raykar.ath@gmail.com>
Message-ID: <871r60muge.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Atharva Raykar wrote:

> `get_default_remote()` retrieves the name of a remote by resolving the
> refs from of the current repository's ref store.
>
> Thus in order to use it for retrieving the remote name of a submodule,
> we have to start a new subprocess which runs from the submodule
> directory.
>
> Let's instead introduce a function called `repo_get_default_remote()`
> which takes any repository object and retrieves the remote accordingly.
>
> `get_default_remote()` is then defined as a call to
> `repo_get_default_remote()` with 'the_repository' passed to it.

I'd find this easier to follow if this were just squashed into the next
commit. Both are rather small, but following the context of first adding
a function, then using it, instead of just adding it, changing the old
users etc. is harder than just having it in one commit.
