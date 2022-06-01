Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C2ACCA473
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 20:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiFAUpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 16:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiFAUpX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 16:45:23 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50144262AC3
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 13:32:26 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id s6so4595619lfo.13
        for <git@vger.kernel.org>; Wed, 01 Jun 2022 13:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=aNhgsenf7LTK6IuLj7uMC4zfGG6oEl1YOcQyf5ips2g=;
        b=bmyRB1n10/r60xkcw1+743xW3BGZVfEKkGYek4sG2H/8qDQ5OXrky45CAcZ3a8DUQs
         XkI7wAfXHjE1AAV8PP4UGddt+WgRijgmIyDwBGmjWetofat57SdTBJ06gyeuCNgiRPNI
         7E+dpbzhteS628r9ZkXiK+x1ZA8warooBrX+KfLSZgtk5wXN592mHoHlBsNbLiKwCStH
         xWuHJGT175DZ0C8swYECFX0onVwtjNEKiZpA14Mbzu/UZAwuEQQLJiTHPeTUOu0g7yMl
         CU35X4dTu4pTASn9vjrN1BRHREi2Des+KP7SeXnhjnsJQ6HNnL3r79voZATe7s2XGgmy
         w8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=aNhgsenf7LTK6IuLj7uMC4zfGG6oEl1YOcQyf5ips2g=;
        b=oXQoV2MN8LYMfsnqCEbvBq469H/qT/EdtMtPsNdaiThfCFvP0gQPAzaYDBUW/px0Fj
         A18F50DVfaD2R6pLFzDMkDYSRbYdFDJxxysN3OXOBBqVICberg4I2nl7j2Q5+4nJcJyW
         DW40qa4etVSoDuuVnPqOrKFuRS9j/42HeV14dH8Eo02py38sGTzMUdFsl7Bj4In5Mjbx
         EaF4EvlFi2cMJ1jqqrxzXvVa6Yx6g4/eyfQfmH1vDBhPQcswKCpLQseK9fk0B9A44hpg
         bBDjPIu+6wcU+Or22bFJFpKm8ucLS33gOZ6nxnoyz9/5heYybz2juoL0ukB4in0tCbKv
         rFOw==
X-Gm-Message-State: AOAM530B8kDvJw5R0DmYXxcIfjLspWK9K0vvndvjWlEwCez64LA4LOxX
        vPm1Rhmr0XbmxtyDOMm93Di1xh1xJpU=
X-Google-Smtp-Source: ABdhPJwfj2lT824r/4QSKIKtUv3D1LGzwY89y3ULzQcjMSg+Bwckue1wedrVIMm15CDjyrG2K1RsnQ==
X-Received: by 2002:a17:907:d8b:b0:707:75fa:5cec with SMTP id go11-20020a1709070d8b00b0070775fa5cecmr953175ejc.517.1654111312300;
        Wed, 01 Jun 2022 12:21:52 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id k16-20020a1709061c1000b00705cdfec71esm998624ejg.7.2022.06.01.12.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 12:21:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nwTue-001J5M-Qd;
        Wed, 01 Jun 2022 21:21:48 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        me@ttaylorr.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 1/2] remote: create fetch.credentialsInUrl config
Date:   Wed, 01 Jun 2022 21:19:54 +0200
References: <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com>
 <pull.1237.v3.git.1654046173.gitgitgadget@gmail.com>
 <083a918e9b1474eff0d51c4502b6d54de9b63764.1654046173.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <083a918e9b1474eff0d51c4502b6d54de9b63764.1654046173.git.gitgitgadget@gmail.com>
Message-ID: <220601.86v8tkyyt4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 01 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> +	for (int i = 0; i < remote->url_nr; i++)

I think we're trying to avoid that bit of C99 in general use until
Junio's canary graduates. See 6563706568b (CodingGuidelines: give
deadline for "for (int i = 0; ...", 2022-03-30).
