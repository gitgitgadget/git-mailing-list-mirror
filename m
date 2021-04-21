Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BA2C43461
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 07:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 057716102A
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 07:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbhDUHBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 03:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbhDUHBc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 03:01:32 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B5AC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 00:00:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cq11so4387047edb.0
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 00:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=MoTOTOaHe7SnyvS6So1NPCvyIHn4mhODGG/MBKtE/4U=;
        b=OrG55RWIL4i+qnZCiy9ikakWbiij5ggLl5zlXAiAdYKA+weI8zn8+bYnRZUAFhihDQ
         a3Oxh1RNCtngMLSjHnUaV/BQTVtpvR+iPzuwOQ5tQpZrtAfZp7oXrm1grCbSCDhET9Hj
         HUd892g4/GcaDGUdglYZJdsEw8TcwVYaELZW9sL+iSHsap55N1t1zsb963oYLNSKobCM
         QIq/JZzd9lsR3Bdo7iLszY5lZzYIpzKGvvgLclzZTIPX7uJe5M7NgHBw5+UFvZF+e1QW
         CafplzbFsZmB7YugpW8jhRNEMBwisPRYf7HDSlIfUaoW2qhzbamTYNj7gJ50L5ita55/
         yDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=MoTOTOaHe7SnyvS6So1NPCvyIHn4mhODGG/MBKtE/4U=;
        b=poYpaZM1MqAUkEQjGkf+ibe8UVYMnCDVm1O2xP35m3WgbNXWDfwf4yQOQYCkL1ddqh
         WisCGeNVTKUzGvfe6guxguh6Ba05RxWnmvQIN1N0QEXPn7obYJ5bAEVPVV9hgMgVWMtY
         4VoEc/saDKgjT6FQBBGgJSQln5sjEjYEtZUsPFjrT/tHbecicanRl3EAamBD3f9jJzUm
         P/pfTtUqWsB4DOIPW5h3fJXcUt3c+fel1lvsVl2ZZU9Pa6el3wb997CyBS5sBLLnX03d
         PmjltEXsEnVL5H8wcA/Y3q9Bnln/1IgUdALCjOUOnyo0D5MWuWUW/Qd27Lo6/ZHf7cfv
         F/3Q==
X-Gm-Message-State: AOAM530q6I4BPEVHvL80eoCFjbVerWNPa8TkJq0iW8CeNOeadUd09q2O
        OYfPerAgqqxS684hOu5/BCmAspa74J9s9Q==
X-Google-Smtp-Source: ABdhPJy1us31VlzI2SeQ0DZckOAlusdXeUe4ns9YJQpjLMerN91SbtWR0FTw+iDx+QpK5u769kb5qA==
X-Received: by 2002:a05:6402:382:: with SMTP id o2mr30358566edv.370.1618988457914;
        Wed, 21 Apr 2021 00:00:57 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id z17sm1911169edx.36.2021.04.21.00.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 00:00:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 15/18] t7900: mark pack-refs tests as REFFILES
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <2b3021c4ba626033cde3b28dda7e5a83b85be2b1.1618829583.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <2b3021c4ba626033cde3b28dda7e5a83b85be2b1.1618829583.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Apr 2021 09:00:57 +0200
Message-ID: <87k0ow3yvq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 19 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t7900-maintenance.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 2412d8c5c006..6f2f55a6c51d 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -343,7 +343,7 @@ test_expect_success 'maintenance.incremental-repack.auto' '
>  	test_subcommand git multi-pack-index write --no-progress <trace-B
>  '
>  
> -test_expect_success 'pack-refs task' '
> +test_expect_success REFFILES 'pack-refs task' '
>  	for n in $(test_seq 1 5)
>  	do
>  		git branch -f to-pack/$n HEAD || return 1

Re [1] maybe this is ok/fine for now, but I think we should really split
out the "is specific to file" part more narrowly (not just here, but in
general).

E.g. I assume that "pack-refs" is simply redundant under reftable, no?

So should this (which the test you're skipping later runs):

    git maintenance run --task=pack-refs

Silently skip, warn, exit with zero or non-zero, some combination
thereof?

Should the current behavior documented in
Documentation/git-maintenance.txt change with your series under reftable
etc?

1. https://lore.kernel.org/git/87sg3k40mc.fsf@evledraar.gmail.com/
