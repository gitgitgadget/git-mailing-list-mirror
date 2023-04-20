Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FABCC77B72
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 19:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjDTTZh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 15:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjDTTZe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 15:25:34 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B01A196
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 12:25:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1a68d61579bso12305395ad.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 12:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682018732; x=1684610732;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrKjCLmEM6pnU4u3qwGlo8ctKeynutL9fcmMTejnWm0=;
        b=IjmgGKDL+eAU1EuyJ0OlKdx6IzE7euEZtT/gL0fCj8mwU1L7Yofc7gfi7oy6Ag9hGP
         dR+EzmblCR2+kU8MwLpJzx6VRkW6+LulzQPXEESSOjzPaVf743Vjvxcl9SlymHVw59TE
         kMK9dwJX7d8IaJ4HwzvV7VrcKKUyQ04hXH7ALDPNJhtLk3JVf2HPOmNaFWv/s0OM/8R4
         3XRMnfKNu6aNZj/aHg29Sf9oyrUnuNBfg2K76CfRJIIL0qewQRwXb/McG/bbqF4uxqg+
         uvk+lU/QHwCqmPSyyzKADD9BlAqzUFTyXAIrtpiZviUmh7FMiJnBNquClTwoMPovxsqg
         KycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682018732; x=1684610732;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZrKjCLmEM6pnU4u3qwGlo8ctKeynutL9fcmMTejnWm0=;
        b=FjuyyxdeQIlI97wcSoFWi6OANm6TNGD5Gq0g6FIlqG4ckeLbmqVk1Qo3ZHM7IfdT0u
         IahqwZDJqOW42nkkKvFwKXed5gPTGfP0byGAoebOtenqc4tH0mXURBiec0jqbvPc0hnG
         xEaGMx5J76ZY54VwNASHWAZ0hWPbbhgbzte5F7SkeSUkwmXqSYM71Z48Csk00LYGOfEn
         0RxPV4yvrYJGNzA7SZDvyKs83KM2Nkvxb4TEFJZNnUklnBQUmFGJJ8F5x4K1PSubA1qy
         MgBbS9FI+aH32eYL5zagy+AkfhOKAvihdMsRmZy4qodFFwlebA7ThtB1QA7OYvvPcyCk
         Ja2w==
X-Gm-Message-State: AAQBX9eSJMKXQoPj9/eeQ4eEm+KTxyPtH1lZNWwjHykMW58z8QfTUbCl
        NU6zvfhNxaPy7uKZTxH9ubszapP3e6U=
X-Google-Smtp-Source: AKy350a0kIBanO9BAwZu2liS/kUbCDZQ7LtBYnFwnKmnri5DxLoq0fMdCCeT5v86D1AuvfEHKRjVvw==
X-Received: by 2002:a17:902:d2c4:b0:1a6:91f0:f806 with SMTP id n4-20020a170902d2c400b001a691f0f806mr2677669plc.58.1682018731731;
        Thu, 20 Apr 2023 12:25:31 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b001a239325f1csm1484838plb.100.2023.04.20.12.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 12:25:31 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robin Jarry" <robin@jarry.cc>
Cc:     <git@vger.kernel.org>, "Phillip Wood" <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Tim Culverhouse" <tim@timculverhouse.com>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Michael Strawbridge" <michael.strawbridge@amd.com>
Subject: Re: [PATCH v5] send-email: export patch counters in validate
 environment
References: <20230414152843.659667-1-robin@jarry.cc>
        <20230414155249.667180-1-robin@jarry.cc>
        <CS1TOE1MCMH0.2OMA9UHSDG7RC@ringo>
Date:   Thu, 20 Apr 2023 12:25:31 -0700
In-Reply-To: <CS1TOE1MCMH0.2OMA9UHSDG7RC@ringo> (Robin Jarry's message of
        "Thu, 20 Apr 2023 21:16:05 +0200")
Message-ID: <xmqqttxaz784.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robin Jarry" <robin@jarry.cc> writes:

> I had an idea after sending v5. Instead of leaving TODO placeholders, it
> would be nicer to introduce other git config sendemail.validate* options
> specific to this hook template so that users can directly use it without
> any modifications simply by setting options in their local clone:
>
>     git config sendemail.validatePatchCmd 'tools/checkpatch.sh'
>     git config sendemail.validateSeriesCmd 'make tests lint'
>
> And reuse these commands if defined in the hook template.

I do not think it is worth it, as they have to write the scripts or
copy them from elsewhere, *and* need to make the configuration
variables, *and* make the sample hook into a real one with such an
approach.

After all, it is merely a sample.  There is a value in keeping it
simple so that users can learn what the structure should look like.
Then users will come up with something much better suited for their
own use case themselves.

Thanks.
