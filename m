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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFE0C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1001661006
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhETPpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 11:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhETPpl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 11:45:41 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4BFC061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:44:18 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y7so2444655eda.2
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ZO6jiFaPlAcbiJNOwrRUJNb3zbHBpzxoE6zo4u5vJ90=;
        b=JGPD58VKMwbjJH1VfGXz6tMUXAeX68V9ZHeXu2Li/Bczq4KEf5kPhjPDicFH0IhXl7
         jKkcVDkrZyCcGJ/4niiaeBYvGbTSHynJo7BCmO+vzT2bG7sKk08wMdJcsjn5qzX3D2uS
         2ZzGx8316DqBVSRg2cDU94P0O5dGMIzJNCydYT/H3QOEuZORpV4BWjK/tJIjaWQ+0NNx
         a4f2R459juOclAlWfkmf7v3oTLl6pboGV7MntFgjqgNw+GixhyyNI/2L/81jPKl4PT9V
         0a84uUhSQs5B9NLe1mXY2LvIx2V87ZGOhjUjk7PkT2YIILMSMaRnbHx6vsi07lUyFxl9
         gvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ZO6jiFaPlAcbiJNOwrRUJNb3zbHBpzxoE6zo4u5vJ90=;
        b=UHh9bT7JDpZu65gfSCURfUsS2ssUCGGxX5+V7XuIq001MnmHEWgwYcgfIhe6vTYqpl
         RjxANPGypmkfQRAiRpVD+R77T0tAy211m7yacBIvbWquA333pt7EDPDSRP0MGFQ91FKe
         U/h5yAURliTmlfuIO3KNRiIGznsD9m378qxSCSaANLY82EfOz7mnfy/RfG73pSlNrA3X
         +Z+97CajodY5eVQDfJGU5s6oXnEGBZ8R73fu3BPGgj/ehuK1beL+9vxX+2/1FxU2IAB6
         lAOTJNsrpVy4LBxCLTTE+22lhnfRIAeJKQSG47gBEthUcTWe/d9fszUCCbAK9HfJesuR
         dqOw==
X-Gm-Message-State: AOAM531W+Uy9mE5IrSTLSNRzIbqLTdzDd6CgC/sf0Iz3Ja5v4dJrM7TN
        Z572Jk2OxrjvpmrUL7Paw3B59ytb0t/bGw==
X-Google-Smtp-Source: ABdhPJyqr+DR8GtjqgLus3h/ZR+Unexl6eCMjClyuyPYU7yvcxrvV747jHFOw52snzWNeo0qTkexWw==
X-Received: by 2002:aa7:ca0d:: with SMTP id y13mr5781956eds.307.1621525456989;
        Thu, 20 May 2021 08:44:16 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id z4sm1760345edc.1.2021.05.20.08.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:44:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 20/21] t4202: mark bogus head hash test with REFFILES
Date:   Thu, 20 May 2021 17:43:16 +0200
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
 <a33cdfda74ff55fbc8242d3486e1fd5a26ad4c00.1619519903.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <a33cdfda74ff55fbc8242d3486e1fd5a26ad4c00.1619519903.git.gitgitgadget@gmail.com>
Message-ID: <87eee1pfzk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 27 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> In reftable, hashes are correctly formed by design
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t4202-log.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index a8c5a00d012d..3f969b01508c 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -1834,7 +1834,7 @@ test_expect_success 'log --graph --no-walk is forbidden' '
>  	test_must_fail git log --graph --no-walk
>  '
>  
> -test_expect_success 'log diagnoses bogus HEAD hash' '
> +test_expect_success REFFILES 'log diagnoses bogus HEAD hash' '
>  	git init empty &&
>  	test_must_fail git -C empty log 2>stderr &&
>  	test_i18ngrep does.not.have.any.commits stderr &&

Okey, they're correctly formed by design, but the first test here is
just checking what happens when we do a "git log" on a repo with no
commits. What does that have to do with reflog's guarantees that we have
a valid-looking SHA in some entry in its database?

Surely we also want to test for the same thing, the ref backend doesn't
change that we have no commits or refs yet, no?
