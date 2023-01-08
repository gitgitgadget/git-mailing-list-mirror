Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56EBC53210
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 07:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjAHHNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 02:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjAHHNs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 02:13:48 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA547186E3
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 23:13:47 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso6130989pjo.3
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 23:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hb1c6/0KAqZQ9w1Y/K0UXdtRw05P9LFktQjV/tTR/m4=;
        b=prn/DJG4pqUGY4Q1ZCAwb4dMy95Xxe0wgpn2ngwI3+C2d0QZ9YfS/j/TYz4leK1BNu
         QaEJ+Ov/VGhFfER9FqOAXq0rRZB17Bl3Oc6u7Sw2i+ij4BNlyhoqhmKXUTNkeooDBjZ+
         edeFz3Qo3MNk1u7wgnfViUKGsF4VTse/eGy5VxZdGa9hy8czusC+VnLu7GNrRW3F1ntW
         Sgj0Vq6RhgU+crwwNXMSbKlC40tzRwfOZB1Ul5ncayuKkX+YPIuZhhqavPdzAwAJNLWJ
         uj4wgv/VspqX+89rU/tyhAJWQgjE3TbNdvjQbzA3m/d/rnzCEbHKex48hcawL1AMkWNc
         ixOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hb1c6/0KAqZQ9w1Y/K0UXdtRw05P9LFktQjV/tTR/m4=;
        b=qTD+ZznR1o+UmNDH8BHtpJv3AQ9PCYnkTbKHJJ0C4yA6DiHkOShHQAtybxV7E6QBxq
         Ifa+NDgovRh9Yk8v4NkaTByLTVTuPPoQYUiMlMsMvq9Po1b6GVmmyfknbGw25Od5eB57
         31JyNe3Z9dyqy3ZGxQl3HYuFuiHa0ud7zV1a11eJ9qgl+MxMq6g2gYpPe6Zvi5mILmjZ
         42k7p7HyCH3QYlPOVMTe/eX0Wg3OGTF5vkBRxl3Ire8NIm83dUug5oBCAMKrEcuas1Fm
         XdohFPw6DsGD7qRWNwQ4EntYeAnfB58yVBSMEP59jQidHZsaeqY9F2EpTVGwQdcQKPir
         04Bw==
X-Gm-Message-State: AFqh2kr3L6UpJtXhTZlqtGtnHTrRxZg5cwK8D4dAOfpPuFthivvkhcAe
        mS6HhOtwEZvPiNgb7J6mZJ+ItdBx4omNbw==
X-Google-Smtp-Source: AMrXdXsbO3fwQuH6eg1X0POfK82AqoLKzAOW+qw7aB26Jdxb19EZqAUXCE2jtWp27tVxR+GJScN0GA==
X-Received: by 2002:a05:6a20:8f1c:b0:a9:d06b:ef2 with SMTP id b28-20020a056a208f1c00b000a9d06b0ef2mr90975400pzk.36.1673162027077;
        Sat, 07 Jan 2023 23:13:47 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id k36-20020a635a64000000b0048988ed9e4bsm3101143pgm.19.2023.01.07.23.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 23:13:46 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v7 2/4] worktree add: refactor opt exclusion tests
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
        <20221104213401.17393-1-jacobabel@nullpo.dev>
        <20221110233137.10414-1-jacobabel@nullpo.dev>
        <20221212014003.20290-1-jacobabel@nullpo.dev>
        <20221220023637.29042-1-jacobabel@nullpo.dev>
        <20221228061539.13740-1-jacobabel@nullpo.dev>
        <20230107045757.30037-1-jacobabel@nullpo.dev>
        <20230107045757.30037-3-jacobabel@nullpo.dev>
Date:   Sun, 08 Jan 2023 16:13:46 +0900
In-Reply-To: <20230107045757.30037-3-jacobabel@nullpo.dev> (Jacob Abel's
        message of "Sat, 07 Jan 2023 04:59:28 +0000")
Message-ID: <xmqq7cxxzefp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Abel <jacobabel@nullpo.dev> writes:

> +test_wt_add_excl () {
> +	local opts="$*" &&
> +	test_expect_success "'worktree add' with '$opts' has mutually exclusive options" '
> +		test_must_fail git worktree add $opts 2>actual &&
> +		grep -P "fatal:( options)? .* cannot be used together" actual
> +	'
> +}

Of course, "grep -P" is non-portable and CI jobs are easily broken.
Isn't -E (ERE) sufficient here?


