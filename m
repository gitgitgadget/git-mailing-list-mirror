Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4A7C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 12:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbiESMmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 08:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237981AbiESMl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 08:41:58 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5487BA98C
        for <git@vger.kernel.org>; Thu, 19 May 2022 05:41:56 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n13so7817838ejv.1
        for <git@vger.kernel.org>; Thu, 19 May 2022 05:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=MWXIRD+obaigG4iDAp/66Bu/XwEJxRmB02zNt+f6C04=;
        b=VNjEGb/r7lQQB48UuCSYuLltBcwHxnuglgBIgw1NDR1kqkNYL7b8mb07aMGnEwk290
         XlwqxLGFmbFqU5WhlPgtrYdH4WT9XCb4FGo9FezR4lkG+TPEMY79SQJCAt3oMBQMT8Vs
         3TPe/6VVqla6XfFL/UT98ihifeDxgXZmXZWURFb6huSxcrk5sUfcp4Q6XAqRqh8Hn8pc
         AfzT5bAeQjXqiGnsNwNy3lBvYkQgKE0GK7A5aYm8PVeiz8rYtrP2iW/0orgYEMW0Vw29
         tLQ67yz8To0s3yzcdVANbP5shL3eaRPJtqbkkyUGsYrTPdJy5EftgP/sRPETEa0dwFGw
         pgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=MWXIRD+obaigG4iDAp/66Bu/XwEJxRmB02zNt+f6C04=;
        b=I8gBn+1IPAmZJE7kvPRMc9tFOV5UEvhg2yhJd9IOGfZJE3mmJNEUcu7abwLjioQPit
         5f73vWJcjYjM4XkzixV40gDBhFi9c7awYj/e4bCfVhVRglsefo36GrCjM+POdkljnohW
         qBVbrXiHyCTSGbeHpetCZBjt6v6FlUD1fnT8IUdEvqkqpVbmiGwm8qdyZ3MwvC4wCYFK
         dhDYojKlvEoN92BE33VbzoFTtMOogvf8jTlS3MfeQDX8/OoYCcTInwSKAY5o5wuvI79t
         z5J+auR6JTggXLLimAnhGWb9OZRw1kfSXGpjySV8kRO/jsF/snnON0b1o1fYECkeg2x0
         ylZw==
X-Gm-Message-State: AOAM531w5pnJVVeR50o2elVUeAg5RjVF0rpvsBj7YmzF6cabcTSqVNlG
        MlD/t5fmIIVX+Rg6RU8Sj2E=
X-Google-Smtp-Source: ABdhPJwaVThletMhnj0ENxs8ogzxawAil+qOcwn+YqDeg7sEco4FRLVPmyVHUJMPiMMOW4H/NTuDvQ==
X-Received: by 2002:a17:907:720f:b0:6f8:5c31:4027 with SMTP id dr15-20020a170907720f00b006f85c314027mr4123184ejc.284.1652964115280;
        Thu, 19 May 2022 05:41:55 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 28-20020a170906015c00b006f3ef214da8sm2109030ejh.14.2022.05.19.05.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 05:41:54 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nrfTV-0027vh-LL;
        Thu, 19 May 2022 14:41:53 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v4 00/17] cruft packs
Date:   Thu, 19 May 2022 13:54:41 +0200
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1652915424.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <cover.1652915424.git.me@ttaylorr.com>
Message-ID: <220519.86ee0p4ru6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 18 2022, Taylor Blau wrote:

> Here is another reroll of my series to implement "cruft packs", which is based
> on the v2.36 tree, and incorporates feedback from the discussion we had about
> mixed-version GCs with cruft packs in [1].
>
> The changes here are limited to:
>
>   - a cautionary note in Documentation/technical/cruft-packs.txt
>     describing the potential interaction between pruning GCs across pre-
>     and post-cruft pack versions of Git, as discussed towards the bottom
>     of [2]
>
>   - updating the `finalize_hashfile()` calls for writing `.mtimes` files
>     to indicate that they are `FSYNC_COMPONENT_PACK_METADATA`, since the
>     original version of this series predates the fine-grained fsync
>     configuration in 2.36.
>
> As always, a range-diff is below. Thanks in advance for taking another
> look!

I left some minor & nit-y comments on this v4, but overall I think this
looks really good with not much to add.
