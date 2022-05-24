Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289FCC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 10:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbiEXKsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 06:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiEXKsE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 06:48:04 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E61560059
        for <git@vger.kernel.org>; Tue, 24 May 2022 03:48:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id jx22so21023242ejb.12
        for <git@vger.kernel.org>; Tue, 24 May 2022 03:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=F4TSqMGcMjHYZ/NEnZQNEM3skGOGif2Deo3Yv0db53Y=;
        b=OfWC700ZfCIQ8PCYw6Imhptmc1XuxZju3Q8J5Q2OdKEc2PU5pH8AWhrEo7KdWt38K4
         KIuriET6SNc1L4UksY+7XSCzc7dB00lKQ86JtMjY7GGwGVKfqsTqnsoWMYkRPc1Vh9/B
         Six+ivkAgYeJIYfjPRq3ia2X2KqqKrgvMM/DgFQAj3aG01sw7imfhzzPcD254Zxfbg86
         0JQ9dO9pxcsmPF+7No5UC6eosMym80etjLr0S7BaYH4W6FN1tZpgdZLuv8Ue5Z7YKIMw
         1P1L1L/Or8dfgQ0duwfldmoRs4Zkj9nfZrfUxlOO9tusnpToB1jpIASJHqmFz3l/BEtu
         xmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=F4TSqMGcMjHYZ/NEnZQNEM3skGOGif2Deo3Yv0db53Y=;
        b=AuGe0hsmyp47Heb/YcveL+D9+kjhO2jLLscctIUAvw+Uw8StEtQ0Ro8KQr5R9m/0WX
         rxzqIGjp8WiTwQT02cvCMqGV1etJk82b/8XwOgPtDssPrOQQwtgqRRZRSOAc5zWb+R9I
         YuzisALE95YuRGz5108JOwO8+6P4bz7u8MBFOyFX7ZNo9ZTnWb3fKzDS9wJ5KXwdSfeU
         JhKvkKLVS4PvtQsu3K5igQu280RV9PRIfn1prjYS2tGBa21I8ePg9gRnrRCG21Tcnb4+
         RDqPsjy0nPhy9sfxOEPoCDyywuYhmSd7PD+0r1aC8244ZlthGTiKAW/2/FsbW/MHIotM
         gX7Q==
X-Gm-Message-State: AOAM533ATmIHaXtUIQYRN+qb7gHHyJE7HoLCw4uWaRHwZIdB+O5wL1Gm
        CPQ1A28n9zK1Lof2tuGsrkObWSzm9g3HLQ==
X-Google-Smtp-Source: ABdhPJz1pU/w3758UxMsO7HFvVs0fZmCW7x7tigYRCncE3K/zVBnS9Eg5HFBCPQhOj1nJpTdUDZqjQ==
X-Received: by 2002:a17:906:c209:b0:6fe:a3d5:c5a4 with SMTP id d9-20020a170906c20900b006fea3d5c5a4mr19294894ejz.759.1653389282267;
        Tue, 24 May 2022 03:48:02 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id m15-20020a056402430f00b0042b607daf7dsm3442370edc.45.2022.05.24.03.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 03:48:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntS53-003Ee8-4x;
        Tue, 24 May 2022 12:48:01 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 08/12] ci(github): skip the logs of the successful
 test cases
Date:   Tue, 24 May 2022 12:47:41 +0200
References: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
 <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
 <d3db5252fb8601f59c48fcac0120e1e2bcc33e03.1653171536.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <d3db5252fb8601f59c48fcac0120e1e2bcc33e03.1653171536.git.gitgitgadget@gmail.com>
Message-ID: <220524.86pmk3w6ji.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, May 21 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> [...]
> Co-authored-by: Victoria Dye <vdye@github.com>

Missing SOB here for Victoria.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
