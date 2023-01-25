Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC1DC54EAA
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 16:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbjAYQja (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 11:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbjAYQj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 11:39:29 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58050F74D
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 08:39:28 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d3so18378769plr.10
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 08:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vb76Nm2jXDfNrB6c12gJwvoyU0h++l2sGclLcZEEP44=;
        b=QGZXK37pYyKg92koTCiEqcCCij5Ma65GHb7/mrZ4ZtBuhgRLU7CQSYs7lsbiMzv55O
         /1Ab/HOJeUiAIKECLF4u8aVqdtfvNup7EQsjg3AirIHVpoDOlyRYUwfqqonmojjOpkqp
         uT/ngUAL/gUBe5FNSjZuOogw0pUd01iKNgBPMEjCuWi36Z1omUYorEKf19+VI0V1JJN7
         K+rPLsR1vcQBVV+x5mHRb1df2QtVn4QYGcFcHrpfejYaM2g3XHekYSEonXCtxHPYokdC
         qfDJhZALVd5vl0xOEkW9ldqCfZiUHEUogaitFswCSBgKB2NgUNf8Q34lfviO5DqCnyCe
         pjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vb76Nm2jXDfNrB6c12gJwvoyU0h++l2sGclLcZEEP44=;
        b=AsF5nZJ213xAJWtYD67HiUxs5Fz8UnppORyEgaSntJpinmTR1QUTfxg4RCIGNDw6rD
         2Uk6u6w96X6xudP2vcVrRCHAwo64G+9Ewj2ee+XQz4zB0rs/4gsVMNKZi9uXVFr7kWpm
         BrIh/HsEEdiuNGxKeHEZ6zoUNmA5vDDbjVQ/xh0tQYqiO1ycy1cPfNHbRqUN42WbILLV
         +Jrzu6OPKaNv2JaipAsSl4qsbP6p2xme+0DxwYoV5YVhl2h/Qu4V+4LkmcKeV9/uEAeC
         efUrRFsZwr75RPRglYwBT3v4Tydv3/dhZfdQYydcSEhEZFIdP0Mo+ZwaegHBicpw5sq5
         Xs5Q==
X-Gm-Message-State: AFqh2kr4KoNUS3RMZEUiXqFxFkXbMXbUMizXvRWkcGXOLrkNauiSFmoo
        Hrc9hnSdo1ATJGboGH2jkgg=
X-Google-Smtp-Source: AMrXdXuLxfHpEARafWvxV0OIlLe/zJTp04ap/9x8uHE6ghjHw3yTVh7uIWkRF4ylHLMWpgJGT/YCqQ==
X-Received: by 2002:a17:90b:3141:b0:22a:270:6f39 with SMTP id ip1-20020a17090b314100b0022a02706f39mr22764415pjb.27.1674664767721;
        Wed, 25 Jan 2023 08:39:27 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id g20-20020a17090a579400b00218a7808ec9sm1854026pji.8.2023.01.25.08.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 08:39:27 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 00/10] rebase: fix several code/testing/documentation
 issues around flag incompatibilities
References: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
        <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
Date:   Wed, 25 Jan 2023 08:39:26 -0800
In-Reply-To: <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Wed, 25 Jan 2023 04:03:44
        +0000")
Message-ID: <xmqqa626fu0x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v4:
>
>  * Pulled out the changes regarding incompatibility detection for
>    --[no-]reapply-cherry-picks into a separate patch. Phillip helped a lot
>    with understanding the behavior, suggesting changes, and getting the
>    wording right, and I think it deserves its own patch with its own
>    explanation.

Hmph, does this replace the previous round that has already been in
'next' for two days?  I do not mind reverting the merge and requeuing
it, but just wanted ot make sure before doing anything.

Thanks.
