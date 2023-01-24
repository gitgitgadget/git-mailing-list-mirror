Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31063C54E94
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 20:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjAXUlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 15:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjAXUlT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 15:41:19 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298424C0C0
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 12:41:18 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso19910792pjg.2
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 12:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqWio9hAdTec7v+pWBW28Yl13Vn/yS63NFZVeS9tAQ4=;
        b=AKFjfcHG+kEtciqykPoUnENLQofZbSTUoetec7qPZbNW1YsE4G2MyTMjtszUg3XEP/
         wECqncJ+rr/ThwRyo8VYJFGDs7Ornto3zwpWV50vzzCsx8srs/3ObJGzzYgqxjgy+7vu
         jByzF5SHcrLJDO/cO/lFxkxNv4O3/W60UXsksqZVXybGTZo5kdB2A7hodgGbaNBZwVce
         4/SGRpeTFMYrVlO8xsB5+SzaDQe8p1cjifUJ874X+akYEliRrkrnwrtO6fra/yKLD/cq
         CfFcqXHkd0qujQfVAzG4R4Ls8AB2NCbK9oovYTCsBAulRRjkY0EDmzD3IqvG+07eAwak
         sCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MqWio9hAdTec7v+pWBW28Yl13Vn/yS63NFZVeS9tAQ4=;
        b=TtfmQu1qT7mWDy8cp+LBc0ajzeQyD+X7RtY4B3WOzS2m5a3ErbMW7HyHF/lI6525MP
         FeiwMyPaUfoLh7bB/ycnVhODppoCss9JCcNlc5OFx7tU2EioOV2P8OKTFWHsyTeFyobf
         f1Py5U/htCZGxYDKZfb4GysBNP+43Oa9/GHeig90zI69Slp5i30SJ30GfTlfNnoyA5DP
         7CivGnwfIcPodTex2nDTSXiJs7LzsuUbMiXsb6GUgsHIBHXJ41iev3iXy49V/y5q81fU
         bmhUvVpXUKdzLw6Ytp/whueG7gwxi+UMtx+O19wofFHjBxDWOPwM7P25V5BNr6Q/YhjW
         wieQ==
X-Gm-Message-State: AFqh2kroBeZzqcNvN8RwKdJQDuyNBlyLEpvAZSg6dpDMBYZmjFKG5b97
        19FK7/GvoQxqC8LefutcF0g=
X-Google-Smtp-Source: AMrXdXvh+xKWTXW/zj9qknvWLbmem6Piw3X2PMwiesxNEPA1vM6xnvp8AXeVLnsk1e8debai4W5k3w==
X-Received: by 2002:a17:902:9b8b:b0:189:d8fb:152d with SMTP id y11-20020a1709029b8b00b00189d8fb152dmr29446207plp.25.1674592877582;
        Tue, 24 Jan 2023 12:41:17 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p20-20020a637f54000000b004788780dd8esm1784024pgn.63.2023.01.24.12.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 12:41:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com
Subject: Re: [PATCH v2.5 02/11] bundle: verify using connected()
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
        <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <b3828725bc8f8887b9b4777a0e3d84224a427f31.1674487310.git.gitgitgadget@gmail.com>
        <xmqqsfg1m8l6.fsf@gitster.g>
        <eae85534-89c9-6eff-69d5-7d4b2be85fb6@github.com>
        <xmqqilgxm2ky.fsf@gitster.g> <xmqqtu0glw81.fsf@gitster.g>
        <771a2993-85bd-0831-0977-24204f84e206@github.com>
        <ecc6b167-f5c4-48ce-3973-461d1659ed40@github.com>
        <xmqqfsbzhm7h.fsf@gitster.g>
        <bad5d998-b34a-15dd-4f9d-9bf1cb74dda0@github.com>
Date:   Tue, 24 Jan 2023 12:41:16 -0800
In-Reply-To: <bad5d998-b34a-15dd-4f9d-9bf1cb74dda0@github.com> (Derrick
        Stolee's message of "Tue, 24 Jan 2023 13:46:02 -0500")
Message-ID: <xmqqr0vjfyxf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> I do not see the need to say "even" here.  In what other situation
>> do we make connectivity checks, and is there a need to be more
>> strict than others when checking fetched packfiles?
>
> I suppose that I was implying that fetches are the more common
> operation, and the scrutiny applied to an arbitrary pack-file from
> a remote is probably higher there. However, who knows where a
> bundle came from, so the scrutiny should be the same.

Ah, I see that is where that "even" came from.  And yes, I agree
that unbundling and fetch should be suspicious of their input to the
same degree.
