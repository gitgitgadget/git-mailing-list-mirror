Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66012ECAAA1
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 19:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbiJ0TtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 15:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbiJ0TtU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 15:49:20 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3414582D36
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 12:49:20 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n7so2683103plp.1
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 12:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4UWBAgLbKUSJQR94tzwMBWWbYXDWmY0yzZuQH71cCQ=;
        b=lnNRRlYt5nWgWXKwMXwHf7BjHvsfVT4rR9ZSM3D70rLnO0SyLG/wt1NTgCyqJa7cmk
         WSiOhiHvG762r4OhOfSJY2e4W/d+x3bdVB6LjB1+bx3TDBOHuHYfEODawehX7YgxijC2
         nTul3GQ3iOiiyBBZqD6b3mgKPZdIldGJLEUGzhWPW3rLMzWgTKZXVHa0nnRDmmuPxFg4
         2GpzNxo8qMcHvEpCN4ivsRwFQPoJDA0OvkQNVKdLVjgLSlf1MmCOQMk9yDjXoctmmGa/
         WGRWED0EcuDqkj3A9cjB8kdK6aGNVxhzmbIaUWCUhQYNlgXHEuILyBl3Oj4FcE6rfWqb
         yALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O4UWBAgLbKUSJQR94tzwMBWWbYXDWmY0yzZuQH71cCQ=;
        b=lYUh7xQrAKU/TAe8FX7AT2FQOpdlgEHBfAXKWB67OS27vKiACsfTVwfu18VXTM0OZj
         p+EULEVvVyE5vT8RAmQPOuz35yvOrq13sehlXAcvRgoL/sxOO11+oYauDmSZfrfiHJKS
         c5jcZd4cBVK6HSffWICg2+0WsIvoiHkj+EWDR6VL/rKJbQBScu2izvAhmrsfGBZpNm6f
         WUVxCTf2OOTvdWc/v8uk+vAsdwB4dU49OBV+TJCzSxOGzCBZhZPVuhfkXhJDShSDl2mU
         vFivWKF1vCXhF7SbbNRlymlxgbPlZMLlFFaqX4WXBzjg9A1RSPIRky+ERI7D6mrXmM/u
         o5Sg==
X-Gm-Message-State: ACrzQf1Fz+o8HJFc/AsOrubrpRd+vV44dtgDsUc23BE9Mju41VUcN8YF
        rKlgJOhvh7dHGsfb+3PrcPzNaxu5Bs8=
X-Google-Smtp-Source: AMsMyM5CN2BXBCG+Hy203vApuofLaKIuSOyLTQIvn89WqowRdROIH6v8t6Gn7XWPUWK4n2ScMU+3MA==
X-Received: by 2002:a17:902:d503:b0:185:457a:9325 with SMTP id b3-20020a170902d50300b00185457a9325mr51341156plg.140.1666900159645;
        Thu, 27 Oct 2022 12:49:19 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id f18-20020a63de12000000b0043954df3162sm1388128pgg.10.2022.10.27.12.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 12:49:19 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH 09/10] config API: add "string" version of
 *_value_multi(), fix segfaults
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
        <patch-09.10-bda9d504b89-20221026T151328Z-avarab@gmail.com>
Date:   Thu, 27 Oct 2022 12:49:18 -0700
In-Reply-To: <patch-09.10-bda9d504b89-20221026T151328Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 26 Oct
 2022 17:35:22
        +0200")
Message-ID: <xmqq4jvpkpxd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Fix numerous and mostly long-standing segfaults in consumers of
> the *_config_*value_multi() API. As discussed in the preceding commit
> an empty key in the config syntax yields a "NULL" string, which these
> users would give to strcmp() (or similar), resulting in segfaults.

Sounds like a good idea.

I would have called them _nonbool(), not _string(), especially
because we are not going to have other variants like _int(), though.


